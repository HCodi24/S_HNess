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

if ($manifestPaths.Count -eq 0) { $errors.Add('No plugin manifests found.') }
if ($skillPaths.Count -eq 0) { $errors.Add('No skills found.') }

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated $($manifestPaths.Count) plugin manifest(s) and $($skillPaths.Count) skill(s)."
