$ohMyPoshTheme = Join-Path $HOME ".config\ohmyposh\theme\Aquaposh.omp.json"
$ohMyPoshCache = Join-Path $HOME ".cache\oh-my-posh\init.ps1"

if (
    (Test-Path -LiteralPath $ohMyPoshTheme) -and
    (
        -not (Test-Path -LiteralPath $ohMyPoshCache) -or
        (Get-Item -LiteralPath $ohMyPoshTheme).LastWriteTimeUtc -gt
        (Get-Item -LiteralPath $ohMyPoshCache).LastWriteTimeUtc
    )
) {
    $cacheDirectory = Split-Path $ohMyPoshCache -Parent

    if (-not (Test-Path -LiteralPath $cacheDirectory)) {
        New-Item -ItemType Directory -Path $cacheDirectory -Force | Out-Null
    }

    oh-my-posh init pwsh --config $ohMyPoshTheme | Set-Content -LiteralPath $ohMyPoshCache -Encoding utf8
}

if (Test-Path -LiteralPath $ohMyPoshCache) {
    . $ohMyPoshCache
}


Invoke-Expression (& { (zoxide init powershell | Out-String) })

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

function gitinit {
    git init
    git commit --allow-empty -m "Initial commit"
}

Remove-Item Alias:cd -Force -ErrorAction SilentlyContinue
function cd { z @args }
function cdd { cd @args }
