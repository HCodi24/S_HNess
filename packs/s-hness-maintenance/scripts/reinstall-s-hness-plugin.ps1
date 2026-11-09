[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern('^[a-z0-9][a-z0-9-]*$')]
    [string[]]$PluginName,

    [ValidateNotNullOrEmpty()]
    [string]$CanonicalRoot = $(if ($env:S_HNESS_ROOT) { $env:S_HNESS_ROOT } else { 'C:\GitHub\S_HNess' })
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Invoke-CheckedCommand {
    param(
        [Parameter(Mandatory)][string]$Executable,
        [Parameter(Mandatory)][string[]]$Arguments,
        [Parameter(Mandatory)][string]$FailureMessage
    )

    $commandOutput = & $Executable @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) {
        $detail = ($commandOutput | Out-String).Trim()
        throw "$FailureMessage Exit code: $LASTEXITCODE. $detail"
    }
    foreach ($line in $commandOutput) {
        Write-Verbose $line
    }
    return $commandOutput
}

function Assert-DirectChildPath {
    param(
        [Parameter(Mandatory)][string]$ParentPath,
        [Parameter(Mandatory)][string]$CandidatePath
    )

    $candidateParent = [System.IO.Path]::GetDirectoryName($CandidatePath)
    if (-not $candidateParent.Equals($ParentPath, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Unsafe plugin path outside expected parent: $CandidatePath"
    }
}

$canonicalRootPath = (Resolve-Path -LiteralPath $CanonicalRoot).Path
foreach ($marker in @('AGENTS.md', 'README.md', 'packs')) {
    if (-not (Test-Path -LiteralPath (Join-Path $canonicalRootPath $marker))) {
        throw "Canonical root is missing required marker '$marker': $canonicalRootPath"
    }
}

$userProfilePath = [Environment]::GetFolderPath('UserProfile')
$pluginParentPath = (Resolve-Path -LiteralPath (Join-Path $userProfilePath 'plugins')).Path
$marketplacePath = Join-Path $userProfilePath '.agents\plugins\marketplace.json'
$helperRootPath = Join-Path $userProfilePath '.codex\skills\.system\plugin-creator\scripts'
$readMarketplacePath = Join-Path $helperRootPath 'read_marketplace_name.py'
$updateCachebusterPath = Join-Path $helperRootPath 'update_plugin_cachebuster.py'
$validatePluginPath = Join-Path $helperRootPath 'validate_plugin.py'

foreach ($requiredFile in @($marketplacePath, $readMarketplacePath, $updateCachebusterPath, $validatePluginPath)) {
    if (-not (Test-Path -LiteralPath $requiredFile -PathType Leaf)) {
        throw "Missing reinstall prerequisite: $requiredFile"
    }
}

$pythonPath = (Get-Command python -ErrorAction Stop).Source
$codexPath = (Get-Command codex -ErrorAction Stop).Source
$marketplaceNameOutput = Invoke-CheckedCommand -Executable $pythonPath -Arguments @($readMarketplacePath) -FailureMessage 'Could not read the personal marketplace name.'
$marketplaceName = (($marketplaceNameOutput | Out-String).Trim())
if ($marketplaceName -notmatch '^[A-Za-z0-9_-]+$') {
    throw "Invalid marketplace name returned by helper: $marketplaceName"
}

$marketplace = Get-Content -Raw -Encoding UTF8 -LiteralPath $marketplacePath | ConvertFrom-Json
$requestedPluginNames = @($PluginName | Select-Object -Unique)
$results = foreach ($requestedPluginName in $requestedPluginNames) {
    $sourcePathCandidate = [System.IO.Path]::GetFullPath(
        (Join-Path (Join-Path $canonicalRootPath 'packs') $requestedPluginName)
    )
    $expectedPacksPrefix = (Join-Path $canonicalRootPath 'packs').TrimEnd('\') + '\'
    if (-not $sourcePathCandidate.StartsWith($expectedPacksPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Plugin source is outside canonical packs: $sourcePathCandidate"
    }
    $sourcePath = (Resolve-Path -LiteralPath $sourcePathCandidate).Path
    $sourceManifestPath = Join-Path $sourcePath '.codex-plugin\plugin.json'
    if (-not (Test-Path -LiteralPath $sourceManifestPath -PathType Leaf)) {
        throw "Plugin source is missing its manifest: $sourceManifestPath"
    }
    $sourceManifest = Get-Content -Raw -Encoding UTF8 -LiteralPath $sourceManifestPath | ConvertFrom-Json
    if ($sourceManifest.name -ne $requestedPluginName) {
        throw "Plugin name does not match source manifest: $requestedPluginName"
    }

    $marketplaceEntry = @($marketplace.plugins | Where-Object { $_.name -eq $requestedPluginName })
    if ($marketplaceEntry.Count -ne 1) {
        throw "Expected exactly one personal marketplace entry for '$requestedPluginName'."
    }
    $expectedMarketplaceSource = "./plugins/$requestedPluginName"
    if (
        $marketplaceEntry[0].source.source -ne 'local' -or
        $marketplaceEntry[0].source.path -ne $expectedMarketplaceSource
    ) {
        throw "Marketplace entry does not point to expected local source: $expectedMarketplaceSource"
    }

    $activePathCandidate = [System.IO.Path]::GetFullPath((Join-Path $pluginParentPath $requestedPluginName))
    Assert-DirectChildPath -ParentPath $pluginParentPath -CandidatePath $activePathCandidate
    $activePath = (Resolve-Path -LiteralPath $activePathCandidate).Path

    Invoke-CheckedCommand -Executable $pythonPath -Arguments @($validatePluginPath, $sourcePath) -FailureMessage "Canonical plugin validation failed for '$requestedPluginName'." | Out-Null

    $operationDescription = "stage, validate, back up, replace, and register '$requestedPluginName@$marketplaceName'"
    if (-not $PSCmdlet.ShouldProcess($activePath, $operationDescription)) {
        [pscustomobject]@{
            PluginName = $requestedPluginName
            Marketplace = $marketplaceName
            SourcePath = $sourcePath
            ActivePath = $activePath
            BackupPolicy = 'retained'
            Status = 'planned'
        }
        continue
    }

    $operationToken = (Get-Date).ToUniversalTime().ToString('yyyyMMddHHmmssfff')
    $stagePath = [System.IO.Path]::GetFullPath((Join-Path $pluginParentPath ".$requestedPluginName-stage-$operationToken"))
    $backupPath = [System.IO.Path]::GetFullPath((Join-Path $pluginParentPath ".$requestedPluginName-backup-$operationToken"))
    $failedPath = [System.IO.Path]::GetFullPath((Join-Path $pluginParentPath ".$requestedPluginName-failed-$operationToken"))
    foreach ($candidatePath in @($stagePath, $backupPath, $failedPath)) {
        Assert-DirectChildPath -ParentPath $pluginParentPath -CandidatePath $candidatePath
        if (Test-Path -LiteralPath $candidatePath) {
            throw "Operation path already exists: $candidatePath"
        }
    }

    Write-Verbose "Staging '$sourcePath' at '$stagePath'."
    New-Item -ItemType Directory -Path $stagePath | Out-Null
    Get-ChildItem -LiteralPath $sourcePath -Force |
        Copy-Item -Destination $stagePath -Recurse -Force

    Invoke-CheckedCommand -Executable $pythonPath -Arguments @($updateCachebusterPath, $stagePath) -FailureMessage "Cachebuster update failed for '$requestedPluginName'." | Out-Null
    Invoke-CheckedCommand -Executable $pythonPath -Arguments @($validatePluginPath, $stagePath) -FailureMessage "Staged plugin validation failed for '$requestedPluginName'." | Out-Null

    $stageManifest = Get-Content -Raw -Encoding UTF8 -LiteralPath (
        Join-Path $stagePath '.codex-plugin\plugin.json'
    ) | ConvertFrom-Json
    $swapped = $false

    try {
        Write-Verbose "Moving active plugin '$activePath' to backup '$backupPath'."
        Move-Item -LiteralPath $activePath -Destination $backupPath
        Write-Verbose "Moving staged plugin '$stagePath' to active target '$activePath'."
        Move-Item -LiteralPath $stagePath -Destination $activePath
        $swapped = $true

        Invoke-CheckedCommand -Executable $codexPath -Arguments @('plugin', 'add', "$requestedPluginName@$marketplaceName") -FailureMessage "Codex reinstall failed for '$requestedPluginName'." | Out-Null

        $pluginListOutput = Invoke-CheckedCommand -Executable $codexPath -Arguments @('plugin', 'list') -FailureMessage 'Could not verify Codex plugin state.'
        $pluginListText = ($pluginListOutput | Out-String)
        if (
            -not $pluginListText.Contains("$requestedPluginName@$marketplaceName") -or
            -not $pluginListText.Contains($stageManifest.version)
        ) {
            throw "Codex plugin list does not show '$requestedPluginName' at version '$($stageManifest.version)'."
        }

        $activeManifest = Get-Content -Raw -Encoding UTF8 -LiteralPath (
            Join-Path $activePath '.codex-plugin\plugin.json'
        ) | ConvertFrom-Json
        if ($activeManifest.version -ne $stageManifest.version) {
            throw "Active version does not match staged version for '$requestedPluginName'."
        }

        $cachePath = Join-Path $userProfilePath (
            ".codex\plugins\cache\$marketplaceName\$requestedPluginName\$($activeManifest.version)"
        )
        $cachePath = (Resolve-Path -LiteralPath $cachePath).Path
        Invoke-CheckedCommand -Executable $pythonPath -Arguments @($validatePluginPath, $activePath) -FailureMessage "Active plugin validation failed for '$requestedPluginName'." | Out-Null
        Invoke-CheckedCommand -Executable $pythonPath -Arguments @($validatePluginPath, $cachePath) -FailureMessage "Installed cache validation failed for '$requestedPluginName'." | Out-Null
        $cacheManifest = Get-Content -Raw -Encoding UTF8 -LiteralPath (
            Join-Path $cachePath '.codex-plugin\plugin.json'
        ) | ConvertFrom-Json
        if ($cacheManifest.version -ne $activeManifest.version) {
            throw "Installed cache version does not match active version for '$requestedPluginName'."
        }
    }
    catch {
        $reinstallError = $_
        Write-Verbose "Reinstall failed; restoring '$backupPath' to '$activePath'."
        if ($swapped -and (Test-Path -LiteralPath $activePath)) {
            Move-Item -LiteralPath $activePath -Destination $failedPath
        }
        if (Test-Path -LiteralPath $backupPath) {
            Move-Item -LiteralPath $backupPath -Destination $activePath
            try {
                Invoke-CheckedCommand -Executable $codexPath -Arguments @('plugin', 'add', "$requestedPluginName@$marketplaceName") -FailureMessage "Codex rollback registration failed for '$requestedPluginName'." | Out-Null
            }
            catch {
                throw "Reinstall and rollback registration failed. Original: $reinstallError Rollback: $_"
            }
        }
        throw "Reinstall failed; previous active source was restored. Original: $reinstallError"
    }

    [pscustomobject]@{
        PluginName = $requestedPluginName
        Marketplace = $marketplaceName
        Version = $activeManifest.version
        SourcePath = $sourcePath
        ActivePath = $activePath
        CachePath = $cachePath
        BackupPath = $backupPath
        Status = 'verified'
    }
}

$results
