## Multi package Manager packages To a file
## Usage: mm2f.ps1 [packages.yml] 
## Requires: winget, choco, scoop

param(
    [string]$Path = ".\packages.yml"
)

if (!(Test-Path $Path)) {
    Write-Host "YAML not found: $Path" -ForegroundColor Red
    exit 1
}

if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
    Install-Module powershell-yaml -Scope CurrentUser -Force
}
Import-Module powershell-yaml

$conf = Get-Content $Path -Raw | ConvertFrom-Yaml

$priority = "winget","choco","win-scoop","scoop"

foreach ($p in $conf.packages) {
    $pm = $priority | Where-Object { $p.$_ } | Select-Object -First 1

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
            choco list --local-only --exact $id 1>$null 2>$null
            if ($LASTEXITCODE -eq 0) { $installed = $true }
        }
        { $_ -in @("scoop", "win-scoop") } {
            $out = scoop list $id 2>$null
            if ($out -match "^\s*$id\s") { $installed = $true }
        }
    }

    if ($installed) {
        Write-Host "Already installed: $id" -ForegroundColor Green
        continue
    }

    Write-Host "Installing $id ..." -ForegroundColor Cyan

    switch ($pm) {
        "winget" {
            winget install --id $id -e --accept-package-agreements --accept-source-agreements
        }
        "choco" {
            choco install $id -y
        }
        { $_ -in @("scoop", "win-scoop") } {
            scoop install $id
        }
    }

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Installation failed: $id" -ForegroundColor Red
    } else {
        Write-Host "Installed $id" -ForegroundColor Green
    }
}
