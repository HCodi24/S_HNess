[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$harnessRoot = Split-Path -Parent $PSScriptRoot
$manifestPaths = Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'packs') -Filter plugin.json -File -Recurse
$skillPaths = Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'packs') -Filter SKILL.md -File -Recurse
$errors = [System.Collections.Generic.List[string]]::new()
$skillNames = @{}

foreach ($manifestPath in $manifestPaths) {
    try {
        $manifest = Get-Content -Raw -LiteralPath $manifestPath.FullName | ConvertFrom-Json
        if (-not $manifest.name -or -not $manifest.version -or -not $manifest.description -or -not $manifest.author.name) {
            $errors.Add("Manifest missing required metadata: $($manifestPath.FullName)")
        }
        if ($manifest.version -notmatch '^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?(?:\+[0-9A-Za-z.-]+)?$') {
            $errors.Add("Manifest version is not strict semver: $($manifestPath.FullName)")
        }
    }
    catch {
        $errors.Add("Invalid manifest JSON: $($manifestPath.FullName): $($_.Exception.Message)")
    }
}

$allowedPublicPlugins = @('s-hness-core', 's-hness-maintenance')
foreach ($manifestPath in $manifestPaths) {
    $manifest = Get-Content -Raw -LiteralPath $manifestPath.FullName -Encoding UTF8 | ConvertFrom-Json
    if ($manifest.name -notin $allowedPublicPlugins) {
        $errors.Add("Unexpected public plugin manifest: $($manifestPath.FullName)")
    }
}

$coreRoot = Join-Path $harnessRoot 'packs\s-hness-core'
$registryPath = Join-Path $coreRoot 'references\domain-capabilities.md'
if (-not (Test-Path -LiteralPath $registryPath -PathType Leaf)) {
    $errors.Add("Missing domain capability registry: $registryPath")
}

$expectedCapabilities = @{
    backend = @('be-api-design', 'be-data-design', 'be-service-design', 'be-security-reliability', 'be-verify')
    frontend = @('fe-architecture', 'fe-ui', 'fe-state-data', 'fe-quality', 'fe-verify')
    web = @('web-system-design', 'web-integration', 'web-deployment', 'web-verify')
    tools = @('tool-product-design', 'tool-interface-design', 'tool-integration-design', 'tool-packaging-design', 'tool-delivery-verify', 'ai-control-runtime')
}
foreach ($domain in $expectedCapabilities.Keys) {
    foreach ($capability in $expectedCapabilities[$domain]) {
        $capabilityPath = Join-Path $coreRoot "references\domain\$domain\skills\$capability\SKILL.md"
        if (-not (Test-Path -LiteralPath $capabilityPath -PathType Leaf)) {
            $errors.Add("Missing internal domain capability: $capabilityPath")
        }
    }
}
foreach ($skillPath in $skillPaths) {
    $content = Get-Content -Raw -LiteralPath $skillPath.FullName
    if ($content -match '\[TODO:|\bTODO\b') {
        $errors.Add("Unfinished placeholder: $($skillPath.FullName)")
    }
    if ($content -notmatch '(?ms)^---\s*\r?\nname:\s*([a-z0-9-]+)\s*\r?\ndescription:\s*.+?\r?\n---') {
        $errors.Add("Invalid skill frontmatter: $($skillPath.FullName)")
        continue
    }
    $skillName = $Matches[1]
    if ($skillNames.ContainsKey($skillName)) {
        $errors.Add("Duplicate skill name '$skillName': $($skillPath.FullName)")
    }
    else {
        $skillNames[$skillName] = $skillPath.FullName
    }

    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+\.md)\)')) {
        $target = Join-Path $skillPath.DirectoryName $match.Groups[1].Value
        if (-not (Test-Path -LiteralPath $target)) {
            $errors.Add("Broken Markdown link in $($skillPath.FullName): $($match.Groups[1].Value)")
        }
    }
}

$markdownPaths = Get-ChildItem -LiteralPath (Join-Path $harnessRoot 'packs') -Filter *.md -File -Recurse
foreach ($markdownPath in $markdownPaths) {
    $content = Get-Content -Raw -LiteralPath $markdownPath.FullName -Encoding UTF8
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+\.md)\)')) {
        $target = Join-Path $markdownPath.DirectoryName $match.Groups[1].Value
        if (-not (Test-Path -LiteralPath $target)) {
            $errors.Add("Broken Markdown link in $($markdownPath.FullName): $($match.Groups[1].Value)")
        }
    }
}
if ($manifestPaths.Count -eq 0) { $errors.Add('No plugin manifests found.') }
if ($skillPaths.Count -eq 0) { $errors.Add('No skills found.') }

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated $($manifestPaths.Count) plugin manifest(s) and $($skillPaths.Count) skill(s)."
