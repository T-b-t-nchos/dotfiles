param(
    [switch]$Force,
    [switch]$Yes
)

#-----------------------------------------------------------------------------------------------#

$ProgressPreference = 'SilentlyContinue'


$Destination = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
$parentDir = Split-Path -Parent $Destination

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
    # Add dotfiles_PowerShell_profile.ps1 to Microsoft.PowerShell_profile.ps1

    $DocumentsPath = [Environment]::GetFolderPath("MyDocuments")

    $ProfileDir = Join-Path $DocumentsPath "PowerShell"
    $ProfilePath = Join-Path $ProfileDir "Microsoft.PowerShell_profile.ps1"
    $DotfilesProfile = Join-Path $ProfileDir "dotfiles_PowerShell_profile.ps1"

    $Line = "if (Test-Path `"$DotfilesProfile`") { . `"$DotfilesProfile`" }"

    if (-not (Test-Path $ProfileDir)) {
        New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null
    }

    if (-not (Test-Path $ProfilePath)) {
        New-Item -ItemType File -Path $ProfilePath -Force | Out-Null
    }

    $Exists = Select-String -Path $ProfilePath -SimpleMatch $Line -Quiet

    if (-not $Exists) {
        Add-Content -Path $ProfilePath -Value $Line
    }

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
    # Download scoop
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Done "scoop is installed"
        scoop --version
        scoop update
    }
    else {
        Info "Download scoop..."
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        iex "& {$(irm https://get.scoop.sh)} -RunAsAdmin"
    }

    Write-Host

    #-------------------------------------------------------
    # Download chocolatey
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Done "Chocolatey already installed"
        choco --version
        choco upgrade chocolatey -y
    }
    else {
        Info "Download chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = 3072
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    Write-Host

    #-------------------------------------------------------
    # Install...

    & (Join-Path $PSScriptRoot 'mm2f.ps1') (Join-Path $PSScriptRoot 'packages.yml')

    Install-WingetPackage `
        -PackageId "Microsoft.VisualStudio.BuildTools" `
        -AdditionalArgs @(
            "--override"
            "--passive --config $parentDir\.config\.vsconfig"
        )
    Install-WithInstaller `
        -Name "WezTerm Nightly" `
        -Url "https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-setup.exe" `
        -InstallDir "C:\Program files\WezTerm"

    Install-Zip `
        -Name "sshhub" `
        -Url "https://github.com/T-b-t-nchos/sshhub/releases/latest/download/sshhub_win-x64.zip" `
        -InstallDir "$HOME\.bin\sshhub"

    Install-Zip `
        -Name "rapture" `
        -Url "https://www.knystudio.net/rapture-2.4.1.zip" `
        -InstallDir "$HOME\.bin\rapture"


    Info "Installing texlive..."
    Invoke-WebRequest `
        -Uri "https://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip" `
        -OutFile "install-tl.zip"
    Expand-Archive install-tl.zip
    Set-Location (Get-ChildItem .\install-tl\install-tl-* -Directory | Sort-Object Name | Select-Object -Last 1)
    .\install-tl-windows.bat --no-gui --profile="..\..\.config\TeX-Live\win.texlive.profile"
    Set-Location ..\..
    Remove-Item .\install-tl.zip
    Remove-Item .\install-tl -Force -Recurse


    Run-command "wsl --install"


    Reload-Env

    Write-Host

    #-------------------------------------------------------
    # dot-config...

    $DocumentsPath = [Environment]::GetFolderPath("MyDocuments")

    New-RelativeSymlink `
        -RelativeSource ".config\Google Japanese Input\config1.db" `
        -Destination (Join-Path $HOME "\AppData\LocalLow\Google\Google Japanese Input\config1.db") `
        -Force:$Force

    New-RelativeSymlink `
        -RelativeSource ".config\dotfiles_PowerShell_profile.ps1" `
        -Destination (Join-Path -Path $DocumentsPath -ChildPath "PowerShell\dotfiles_PowerShell_profile.ps1") `
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

    New-RelativeSymlink `
        -RelativeSource ".config\yazi" `
        -Destination (Join-Path $env:APPDATA "yazi\config") `
        -Force:$Force

    New-RelativeSymlink `
        -RelativeSource ".config\AutoHotkey" `
        -Destination ("~\.config\AutoHotkey") `
        -Force:$Force

    New-RelativeSymlink `
        -RelativeSource ".config\Rapture" `
        -Destination ("~\.config\Rapture") `
        -Force:$Force


    Reload-Env

    Write-Host

    #-------------------------------------------------------
    # Add to PATH

    Add-ToPath "C:\Program Files (x86)\GnuWin32\bin" -Scope Machine
    Add-ToPath "$HOME\.bin\sshhub" -Scope User
    Add-ToPath "$HOME\.bin\rapture" -Scope User

    Reload-Env

    Write-Host


    #-------------------------------------------------------
    # Other commands

    Run-command("gh extension install yusukebe/gh-markdown-preview")

    Run-command("nvm install latest")
    Run-command("npm install -g @antfu/ni mdpv tree-sitter-cli @mermaid-js/mermaid-cli")


    Info "Create AutoHotkey startup shortcut"
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut(
        "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\dotfiles_AHK.lnk"
    )
    $Shortcut.TargetPath = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"
    $Shortcut.Arguments  = "`"$HOME\.config\AutoHotkey\main.ahk`""
    $Shortcut.WorkingDirectory = "$HOME\.config\AutoHotkey"
    $Shortcut.IconLocation = "$env:ProgramFiles\AutoHotkey\v2\AutoHotkey64.exe"
    $Shortcut.Save()


    Info "Setup TeX Live..."
    tlmgr update --self --all
    tlmgr install lualatex-math
    tlmgr path add

    Reload-Env

    Write-Host

    #-------------------------------------------------------

    Info "Done."

    Info "TODO (If you are Nchos):"
    Info " - Add PC98NX font with https://github.com/T-b-t-nchos/PC9800-PC98NX-NF-eXtended "
    Info " - Connect to the NAS"
    Info " - Make symlink of C:\ScreenShot to NAS"
    Info "  -> e.g. New-Item -ItemType SymbolicLink -Path ""C:\ScreenShots"" -Target ""\path\to\ScreenShot\"""
    Info " - Sign in to github with gh auth login"

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
        [string]$PackageId,

        [string[]]$AdditionalArgs
    )

    winget list --id $PackageId -e 1>$null 2>$null
    if ($LASTEXITCODE -eq 0) {
        Done "Already installed: $PackageId"
        return
    }

    Info "Installing $PackageId ..."

    $baseArgs = @(
        "install"
        $PackageId
        "-e"
        "--accept-package-agreements"
        "--accept-source-agreements"
    )

    if ($AdditionalArgs) {
        $baseArgs += $AdditionalArgs
    }

    winget @baseArgs

    if ($LASTEXITCODE -ne 0) {
        Error "Installation failed: $PackageId"
    }
    else {
        Done "Installed $PackageId"
    }
}

function Install-ScoopPackage {
    param(
        [Parameter(Mandatory)]
        [string]$PackageName,

        [string[]]$AdditionalArgs
    )

    $listOutput = scoop list $PackageName 2>$null

    if ($listOutput -match "^\s*$PackageName\s") {
        Done "Already installed: $PackageName"
        return
    }

    Info "Installing $PackageName ..."

    $baseArgs = @(
        "install"
        $PackageName
    )

    if ($AdditionalArgs) {
        $baseArgs += $AdditionalArgs
    }

    scoop @baseArgs

    if ($LASTEXITCODE -ne 0) {
        Error "Installation failed: $PackageName"
    }
    else {
        Done "Installed $PackageName"
    }
}

function Install-ChocoPackage {
    param(
        [Parameter(Mandatory)]
        [string]$PackageId,

        [string[]]$AdditionalArgs
    )

    choco list --local-only --exact $PackageId 1>$null 2>$null
    if ($LASTEXITCODE -eq 0) {
        Done "Already installed: $PackageId"
        return
    }

    Info "Installing $PackageId ..."

    $baseArgs = @(
        "install"
        $PackageId
        "-y"
    )

    if ($AdditionalArgs) {
        $baseArgs += $AdditionalArgs
    }

    choco @baseArgs

    if ($LASTEXITCODE -ne 0) {
        Error "Installation failed: $PackageId"
    }
    else {
        Done "Installed $PackageId"
    }
}

function Install-WithInstaller {
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

function Install-Zip {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Url,

        [Parameter(Mandatory)]
        [string]$InstallDir
    )

    if (Test-Path $InstallDir) {
        Done "Already installed: $Name"
        return
    }

    $tempFile = Join-Path $env:TEMP "$($Name)-zip.zip"

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

        Expand-Archive $tempFile -DestinationPath $InstallDir -Force
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

function Add-ToPath {
    param(
        [Parameter(Mandatory)]
        [string]$PathToAdd,

        [ValidateSet("User", "Machine")]
        [string]$Scope = "User"
    )

    $PathToAdd = [System.IO.Path]::GetFullPath($PathToAdd).TrimEnd('\')

    $current = [Environment]::GetEnvironmentVariable("Path", $Scope)

    if ([string]::IsNullOrWhiteSpace($current)) {
        $new = $PathToAdd
    } else {
        $entries = $current -split ';' | ForEach-Object { $_.TrimEnd('\') }

        if ($entries -contains $PathToAdd) {
            Done "PATH already contains: $PathToAdd"
            return
        }

        $new = $current + ";" + $PathToAdd
    }

    [Environment]::SetEnvironmentVariable("Path", $new, $Scope)
    Done "Added to $Scope PATH: $PathToAdd"
}

function Reload-Env() {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
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
