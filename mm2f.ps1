## Multi package Manager packages To a File
## Usage: mm2f.ps1 [packages.yml]
## Requirements:
## - powershell 7 (For running the script)

param(
    [string]$Path = ".\packages.yml"
)

if (!(Test-Path $Path)) {
    Write-Host "YAML not found: $Path" -ForegroundColor Red
    exit 1
}

try {
    Install-Module -Name powershell-yaml -Force -Scope CurrentUser -ErrorAction Stop
} catch {
    Write-Host "Failed to install powershell-yaml: $_" -ForegroundColor Red
    exit 1
}
Import-Module powershell-yaml -ErrorAction Stop

$conf = Get-Content $Path -Raw | ConvertFrom-Yaml

$priority = $conf.options.windows.priority
if (-not $priority) {
    $priority = @("winget","choco","scoop")
}

$commands = $conf.options.windows.commands
if (-not $commands) {
    $commands = @{}
}

$defaultCommands = @{
    winget = 'winget install --id {id} -e --accept-package-agreements --accept-source-agreements'
    choco  = 'choco install {id} -y'
    scoop  = 'scoop install {id}'
}

$availablePriority = @()

foreach ($pm in $priority) {
    $checkPm = $pm

    if (Get-Command $checkPm -ErrorAction SilentlyContinue) {
        $availablePriority += $pm
    }
}

if ($availablePriority.Count -eq 0) {
    Write-Host "No available package managers found." -ForegroundColor Red
    Write-Host "Configured priority: $($priority -join ', ')" -ForegroundColor Red
    exit 1
}

foreach ($p in $conf.packages) {
    $pm = $availablePriority | Where-Object { $p.$_ } | Select-Object -First 1

    if (-not $pm) {
        Write-Host "Skipped: $($p.name)" -ForegroundColor Yellow
        continue
    }

    $id = $p.$pm

    $installed = $false
    switch ($pm) {
        "winget" {
            winget list --id $id -e 1>$null 2>$null
            if ($LASTEXITCODE -eq 0) { $installed = $true }
        }
        "choco" {
            choco list --exact $id 1>$null 2>$null
            if ($LASTEXITCODE -eq 0) { $installed = $true }
        }
        "scoop" {
            $out = scoop list $id 2>$null
            if ($out -match "^\s*$([regex]::Escape($id))\s") { $installed = $true }
        }
    }

    if ($installed) {
        Write-Host "Already installed: $id" -ForegroundColor Green
        continue
    }

    $template = $commands.$pm
    if (-not $template) {
        $template = $defaultCommands[$pm]
    }

    $cmd = $template -replace '\{id\}', $id

    Write-Host "Installing $id ..." -ForegroundColor Cyan
    Invoke-Expression $cmd

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Installation failed: $id" -ForegroundColor Red
    }
    else {
        Write-Host "Installed $id" -ForegroundColor Green
    }
}
