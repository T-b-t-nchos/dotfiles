$theme = Join-Path $HOME ".config\ohmyposh\theme\Aquaposh.omp.json"
if (Test-Path $theme) {
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}

# Custom commands
function re {
    $env:Path = 
        [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
        [System.Environment]::GetEnvironmentVariable("Path","User")
}

function mkcd {
    param([string]$path)
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Force -Path $path
    }
    Set-Location $path
}
