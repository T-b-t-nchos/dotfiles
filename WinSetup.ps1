param(
    [switch]$Force,
    [switch]$Yes
)

#-----------------------------------------------------------------------------------------------#

$ProgressPreference = 'SilentlyContinue'

#-----------------------------------------------------------------------------------------------#

function Main-Function {
    clear

    Ensure-Administrator| Out-Null
    
    if (-not $Yes) {
        Confirm-Execution
    }
    else {
        Warn "Check skipped."
    }
    
    Write-Host "" 
    
    #-------------------------------------------------------
    # Download Font
    Download-font -Force:$Force
    Write-Host

    #-------------------------------------------------------
    # Download Winget 
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Done "winget is installed"
        winget --version
    } 
    else {
        Info "Download winget..."

        $ProgressPreference = 'SilentlyContinue'

        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

        $asset = $release.assets | Where-Object { $_.name -like "*.msixbundle" }

        $path = "$env:TEMP\winget.msixbundle"
        Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $path

        Add-AppxPackage -Path $path

    }
    
    Write-Host

    #-------------------------------------------------------
    # Install...
    
    Install-WingetPackage Git.Git
    Install-WingetPackage GitHub.cli
    Install-WingetPackage JesseDuffield.lazygit
    Install-WingetPackage CoreyButler.NVMforWindows
    Install-WIngetPackage Python.Python.3.14
    Install-WingetPackage DenoLand.Deno
    Install-WingetPackage Microsoft.PowerShell
    Install-WingetPackage Neovim.Neovim
    Install-DirectPackage `
        -Name "WezTerm Nightly" `
        -Url "https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe" `
        -InstallDir "C:\Program files\WezTerm"
    Install-WingetPackage JanDeDobbeleer.OhMyPosh
    Install-WingetPackage MSYS2.MSYS2
    
    Write-Host

    #-------------------------------------------------------
    # dot-config...
    
    $DocumentsPath = [Environment]::GetFolderPath("MyDocuments")

    New-RelativeSymlink `
        -RelativeSource ".config\Microsoft.PowerShell_profile.ps1" `
        -Destination (Join-Path -Path $DocumentsPath -ChildPath "PowerShell\Microsoft.PowerShell_profile.ps1") `
        -Force:$Force
    

    New-RelativeSymlink `
        -RelativeSource ".config\nvim" `
        -Destination (Join-Path $env:LOCALAPPDATA "nvim") `
        -Force:$Force
    
    New-RelativeSymlink `
        -RelativeSource ".config\wezterm" `
        -Destination ("~\.config\wezterm") `
        -Force:$Force
    
    New-RelativeSymlink `
        -RelativeSource ".config\ohmyposh" `
        -Destination ("~\.config\ohmyposh") `
        -Force:$Force

    New-RelativeSymlink `
        -RelativeSource ".config\lazygit" `
        -Destination (Join-Path $env:APPDATA "jesseduffield\lazygit") `
        -Force:$Force
    

    Write-Host

    #-------------------------------------------------------
    # Other commands
    
    Run-command("gh extension install yusukebe/gh-markdown-preview")

    Run-command("nvm install latest")
    Run-command("npm install -g @antfu/ni mdpv tree-sitter-cli")


    Write-Host

    #-------------------------------------------------------

    Info "Done."
    Write-Host "Press Enter to exit...."
    Read-Host
}

#-----------------------------------------------------------------------------------------------#


function Ensure-Administrator {

    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal   = New-Object Security.Principal.WindowsPrincipal($currentUser)
    $isAdmin     = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if ($isAdmin) {
        # Done "Running with administrator privileges."
        return $true
    }

    Warn "This script is not running with administrator privileges."
    $choice = Read-Host "Restart as administrator? (Y/N)"

    if ($choice -notmatch '^[Yy]$') {
        Info "Continuing without elevation."
        return $false
    }

    $scriptPath = $PSCommandPath

    if (-not $scriptPath -or -not (Test-Path $scriptPath)) {
        Error "Script path could not be resolved. Run this as a .ps1 file."
        return $false
    }

    $paramList = @()

    foreach ($key in $PSBoundParameters.Keys) {
        if ($PSBoundParameters[$key] -is [switch]) {
            if ($PSBoundParameters[$key].IsPresent) {
                $paramList += "-$key"
            }
        }
        else {
            $paramList += "-$key `"$($PSBoundParameters[$key])`""
        }
    }

    $argString = $paramList -join ' '

    Info "Restarting with administrator privileges..."

    Start-Process `
        -FilePath (Get-Process -Id $PID).Path `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`" $argString" `
        -Verb RunAs

    exit
}


function Confirm-Execution {
$banner = @'
    ________      _____     __________________
    ___  __ \_______  /_    ___  __/__(_)__  /____________
    __  / / /  __ \  __/    __  /_ __  /__  /_  _ \_  ___/
    _  /_/ // /_/ / /_      _  __/ _  / _  / /  __/(__  )
    /_____/ \____/\__/      /_/    /_/  /_/  \___//____/  By Nchos

    ________    _____                     ________            _____        _____
    __  ___/______  /____  _________      __  ___/_______________(_)_________  /_
    _____ \_  _ \  __/  / / /__  __ \     _____ \_  ___/_  ___/_  /___  __ \  __/
    ____/ //  __/ /_ / /_/ /__  /_/ /     ____/ // /__ _  /   _  / __  /_/ / /_
    /____/ \___/\__/ \__,_/ _  .___/      /____/ \___/ /_/    /_/  _  .___/\__/
                            /_/                                    /_/


'@
    Write-Host $banner -ForegroundColor Cyan
    Write-Host ""
    $response = Read-Host "Continue? (Y/N)"
    if ($response -notmatch '^(?i)y$') {
        Write-Host "Aborted." -ForegroundColor Red
        exit 1
    }
}


function Download-Font {
    param(
        [switch]$Force
    )

    $fontDir = "$env:WINDIR\Fonts"

    $fontDirs = @(
        "$env:WINDIR\Fonts",
        "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
    )

    $exists = $false

    foreach ($dir in $fontDirs) {
        if (Test-Path $fontDirs) {
            if (Get-ChildItem $dir -Filter "*Moralerspace*HW*" -ErrorAction SilentlyContinue) {
                $exists = $true
            }
        }
    }

    if ($exists) {
        Done "Fonts is already installed"
        return
    }

    $base = "https://github.com/yuru7/moralerspace/releases/download/v2.0.0/"
    $files = @(
        "Moralerspace_v2.0.0.zip",
        "MoralerspaceHW_v2.0.0.zip"#,
        # "MoralerspaceJPDOC_v2.0.0.zip",
        # "MoralerspaceHWJPDOC_v2.0.0.zip"
    )

    $tmp = "$env:TEMP\ms"

    if (Test-Path $tmp) {
        Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
    }

    New-Item $tmp -ItemType Directory -Force | Out-Null

    foreach ($f in $files) {
        $zip = Join-Path $tmp $f
        $url = $base + $f

        Info "Downloading $f ..."
        & curl.exe -L -f -o $zip $url

        if (!(Test-Path $zip) -or ((Get-Item $zip).Length -lt 1000000)) {
            Error "Download failed: $f"
        }

        $extractDir = Join-Path $tmp ([IO.Path]::GetFileNameWithoutExtension($f))
        Expand-Archive $zip $extractDir -Force
    }

    $shell = New-Object -ComObject Shell.Application
    $fontsFolder = $shell.Namespace(0x14)

    Get-ChildItem $tmp -Recurse -Include *.ttf,*.otf | ForEach-Object {
        $flags = 0x10
        if ($Force) { $flags = 0x14 }

        $fontsFolder.CopyHere($_.FullName, $flags)
    }    

    Done "Installed Moralerspace."
}


function Install-WingetPackage {
    param(
        [Parameter(Mandatory)]
        [string]$PackageId
    )
    
    winget list --id $PackageId -e 1>$null 2>$null
    if ($LASTEXITCODE -eq 0) {
        Done "Already installed: $PackageId"
        return
    }

    Info "Installing $PackageId ..."

    winget install $PackageId -e `
        --accept-package-agreements `
        --accept-source-agreements

    if ($LASTEXITCODE -ne 0) {
        Error "Installation failed: $PackageId"
    }
    else {
        Done "Installed $PackageId"
    }
}


function Install-DirectPackage {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Url,

        [Parameter(Mandatory)]
        [string]$InstallDir,

        [string]$SilentArgs = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR=`"{!DIR}`""
    )

    if (Test-Path $InstallDir) {
        Done "Already installed: $Name"
        return
    }

    $tempFile = Join-Path $env:TEMP "$($Name)-installer.exe"

    try {
        Info "Downloading $Name ..."
        
        curl.exe -L `
            --fail `
            --output $tempFile `
            $Url

        if ($LASTEXITCODE -ne 0 -or !(Test-Path $tempFile)) {
            Error "Download failed: $Name"
            return
        }

        Info "Installing $Name ..."

        $resolvedArgs = $SilentArgs.Replace("{!DIR}", $InstallDir)

        $process = Start-Process $tempFile `
            -ArgumentList $resolvedArgs `
            -Wait `
            -PassThru `
            -Verb RunAs

        if ($process.ExitCode -ne 0) {
            Write-Host "ExitCode: $($process.ExitCode)"
            Error "Installation failed: $Name"
        }
        else {
            Done "Installed $Name"
        }
    }
    catch {
        Error "Installation failed: $Name"
    }
    finally {
        if (Test-Path $tempFile) {
            Remove-Item $tempFile -Force
        }
    }
}


function New-RelativeSymlink {
    param(
        [Parameter(Mandatory)]
        [string]$RelativeSource,

        [Parameter(Mandatory)]
        [string]$Destination,

        [switch]$Force
    )

    $scriptRoot = Split-Path -Parent $PSCommandPath
    $sourcePath = Join-Path $scriptRoot $RelativeSource

    if (-not (Test-Path $sourcePath)) {
        Error "Source not found: $sourcePath"
        return
    }

    $Destination = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

    $parentDir = Split-Path -Parent $Destination

    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    if (Test-Path $Destination) {
        if ($Force) {
            Remove-Item $Destination -Recurse -Force
        }
        else {
            Warn "Target already exists: $Destination (use -Force)"
            return
        }
    }

    try {
        New-Item -ItemType SymbolicLink -Path $Destination -Target $sourcePath -ErrorAction Stop | Out-Null
        Done "Created $sourcePath -> $Destination"
    }
    catch {
        Error "Failed to create symlink: $Destination"
    }
}

function Run-command($Cmd) {
    Info($Cmd)
    iex $Cmd
    Write-Host
}

function Color-func-Test{
    clear
    Confirm-Execution
    Write-Host
    Info "Nchos's"
    Done "dotfiles"
    Warn "with"
    Error "Install Script"
    Write-Host
    Write-Host
    Write-Host
    Info "---------------------------------------------------------------------------------------------------------------"
    Done "---------------------------------------------------------------------------------------------------------------"
    Warn "---------------------------------------------------------------------------------------------------------------"
    Error "---------------------------------------------------------------------------------------------------------------"
    Error "---------------------------------------------------------------------------------------------------------------"
    Warn "---------------------------------------------------------------------------------------------------------------"
    Done "---------------------------------------------------------------------------------------------------------------"
    Info "---------------------------------------------------------------------------------------------------------------"
    Read-Host
}

#-----------------------------------------------------------------------------------------------#

function Done($Text) { Write-Host $Text -ForegroundColor Green }
function Warn($Text) { Write-Host $Text -ForegroundColor Yellow }
function Error($Text) { Write-Host $Text -ForegroundColor Red }
function Info($Text) { Write-Host $Text -ForegroundColor Cyan }

#-----------------------------------------------------------------------------------------------#
Main-Function
