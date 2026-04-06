$theme = Join-Path $HOME ".config\ohmyposh\theme\Aquaposh.omp.json"
if (Test-Path $theme) {
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}


function re {
    $env:Path = 
        [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
        [System.Environment]::GetEnvironmentVariable("Path","User")
}
