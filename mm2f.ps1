## Multi package Manager packages To a File
## Usage: mm2f.ps1 [packages.yml] 
## Requires: winget, choco, scoop

param(
    [string]$Path = ".\packages.yml"
)

if (!(Test-Path $Path)) {
    Write-Host "YAML not found: $Path" -ForegroundColor Red
    exit 1
}

$conf = Get-Content $Path -Raw | ConvertFrom-Yaml

$priority = $conf.options.windows.priority
if (-not $priority) {
    $priority = @("winget","choco","winscoop","scoop")
}

$commands = $conf.options.windows.commands
if (-not $commands) {
    $commands = @{}
}

$defaultCommands = @{
    winget = 'winget install --id {id} -e --accept-package-agreements --accept-source-agreements'
    choco  = 'choco install {id} -y'
    winscoop = 'scoop install {id}'
    scoop  = 'scoop install {id}'
}

foreach ($p in $conf.packages) {
    $pm = $priority | Where-Object { $p.$_ } | Select-Object -First 1

    $pm = if ($pm -eq "winscoop") { "scoop" } else { $pm }

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
        "winscoop" {
            $out = scoop list $id 2>$null
            if ($out -match "^\s*$id\s") { $installed = $true }
        }
        "scoop" {
            $out = scoop list $id 2>$null
            if ($out -match "^\s*$id\s") { $installed = $true }
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
