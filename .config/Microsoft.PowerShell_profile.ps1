$theme = Join-Path $HOME ".config\ohmyposh\theme\nchos.omp.json"
if (Test-Path $theme) {
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}


$originalPrompt = (Get-Command prompt).ScriptBlock
$script:__firstPrompt = $true

function prompt {
    if (-not $script:__firstPrompt) {
        Write-Host ""
    }
    $script:__firstPrompt = $false
        & $originalPrompt
}

