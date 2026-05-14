#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Version = '2.1.110'
$Model   = 'claude-opus-4-6[1m]'
$Root    = Join-Path $env:LOCALAPPDATA 'claude46'
$BinDir  = Join-Path $Root 'bin'

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Error 'Node.js is required. Install from https://nodejs.org/ (18+).'
    exit 1
}
$nodeVersion = (& node --version).TrimStart('v')
$nodeMajor   = [int]($nodeVersion.Split('.')[0])
if ($nodeMajor -lt 18) {
    Write-Error "Node.js 18+ required (found v$nodeVersion). Update from https://nodejs.org/."
    exit 1
}
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error 'npm is required and was not found on PATH.'
    exit 1
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Warning 'git not found on PATH. Claude Code needs Git for Windows on native Windows. Install from https://gitforwindows.org/ (or set CLAUDE_CODE_GIT_BASH_PATH if Git is installed in a nonstandard location).'
}

New-Item -ItemType Directory -Force -Path $Root, $BinDir | Out-Null

$pkgJson = Join-Path $Root 'package.json'
if (-not (Test-Path $pkgJson)) {
    '{"name":"claude46","private":true}' | Set-Content -Path $pkgJson -Encoding ASCII
}

Write-Host "Installing @anthropic-ai/claude-code@$Version into $Root ..."
& npm install --prefix $Root "@anthropic-ai/claude-code@$Version"
if ($LASTEXITCODE -ne 0) {
    Write-Error "npm install failed (exit $LASTEXITCODE)."
    exit 1
}

$wrapperPath = Join-Path $BinDir 'claude46.cmd'
$wrapperLines = @(
    '@echo off',
    'set "DISABLE_AUTOUPDATER=1"',
    'set "DISABLE_UPDATES=1"',
    "set `"ANTHROPIC_MODEL=$Model`"",
    'call "%~dp0..\node_modules\.bin\claude.cmd" %*'
)
Set-Content -Path $wrapperPath -Value $wrapperLines -Encoding ASCII

$userPath = [Environment]::GetEnvironmentVariable('PATH', 'User')
if ($null -eq $userPath) { $userPath = '' }
$normalizedTarget = $BinDir.TrimEnd('\')
$alreadyOnPath = $false
foreach ($entry in $userPath.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)) {
    $expanded = [Environment]::ExpandEnvironmentVariables($entry).Trim('"').TrimEnd('\')
    if ([string]::Equals($expanded, $normalizedTarget, [StringComparison]::OrdinalIgnoreCase)) {
        $alreadyOnPath = $true
        break
    }
}
if (-not $alreadyOnPath) {
    $newPath = if ($userPath) { "$userPath;$BinDir" } else { $BinDir }
    [Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
    Write-Host "Added $BinDir to user PATH."
} else {
    Write-Host "$BinDir already on user PATH."
}

Write-Host 'Installed claude46:'
& $wrapperPath --version
if ($LASTEXITCODE -ne 0) {
    Write-Error "claude46 --version failed (exit $LASTEXITCODE). Install may be incomplete."
    exit 1
}
Write-Host ''
Write-Host 'Start it with: claude46  (open a new terminal first so the PATH change takes effect)'
