$theme = Join-Path $HOME ".config\ohmyposh\theme\nchos.omp.json"
if (Test-Path $theme) {
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}

