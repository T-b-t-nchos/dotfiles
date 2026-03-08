#!/usr/bin/env bash

Force=false
Yes=false

#-----------------------------------------------------------------------------------------------#

Destination="$Destination"
parentDir="$(dirname "$Destination")"
if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(eval echo "~$SUDO_USER")
else
    USER_HOME="$HOME"
fi

#-----------------------------------------------------------------------------------------------#

Main-Function() {
    clear

    Ensure-Administrator

    if [ "$Yes" != true ]; then
        Confirm-Execution
    else
        Warn "Check skipped."
    fi

    echo

    #-------------------------------------------------------
    # Download Font
    Install-AptPackage curl
    Download-font
    echo

    #-------------------------------------------------------
    # Download Winget (Windows only)

    # PowerShell original:
    # if (Get-Command winget -ErrorAction SilentlyContinue) {
    #     Done "winget is installed"
    #     winget --version
    # } 
    # else {
    #     Info "Download winget..."
    #     ...
    # }

    #-------------------------------------------------------
    # Install...

    Run-command "sudo apt update"

    # Google.JapaneseIME


    Install-AptPackage git
    Install-AptPackage gh
    
    Info "Installing lazygit..."
    export LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit ; sudo install lazygit /usr/local/bin
    
    Info "Installing nvm..."
    Run-command "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash"
    Install-AptPackage python3
    Install-AptPackage python3-pip
    # DenoLand.Deno ... npm
    Install-AptPackage build-essential

    Info "Installing neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo mkdir -p /opt
    sudo rm -rf /opt/nvim-linux-x86_64
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    grep -qxF 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' ~/.profile || \
    echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.profile
    source ~/.profile
    
    Info "Installing wezterm..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt update
    sudo apt install wezterm-nightly

    Info "Installing ohmyposh..."
    Run-command "curl -s https://ohmyposh.dev/install.sh | bash -s"
    export PATH="$PATH:$USER_HOME/.local/bin"

    Install-AptPackage gpg

    Reload-Env

    echo

    #-------------------------------------------------------
    # dot-config...

    DocumentsPath="$USER_HOME/Documents"

    New-RelativeSymlink ".config/nvim" "$USER_HOME/.config/nvim"
    New-RelativeSymlink ".config/wezterm" "$USER_HOME/.config/wezterm"
    New-RelativeSymlink ".config/ohmyposh" "$USER_HOME/.config/ohmyposh"
    New-RelativeSymlink ".config/lazygit" "$USER_HOME/.config/lazygit"

    # Windows only paths

    # New-RelativeSymlink `
    #     -RelativeSource ".config\Google Japanese Input\config1.db" `
    #     -Destination (Join-Path $HOME "\AppData\LocalLow\Google\Google Japanese Input\config1.db")

    Reload-Env

    echo

    #-------------------------------------------------------
    # Other commands

    Run-command "gh extension install yusukebe/gh-markdown-preview"

    Run-command "export NVM_DIR=\"$USER_HOME/.nvm\""
    Run-command "[ -s \"$NVM_DIR/nvm.sh\" ] && . \"$NVM_DIR/nvm.sh\""
    Run-command "[ -s \"$NVM_DIR/bash_completion\" ] && . \"$NVM_DIR/bash_completion\""
    Run-command "nvm install node"
    Run-command "npm install -g @antfu/ni mdpv tree-sitter-cli deno"

    Reload-Env

    echo

    #-------------------------------------------------------

    Info "Done."
    echo "Press Enter to exit...."
    read
}

#-----------------------------------------------------------------------------------------------#

Ensure-Administrator() {

    if [ "$EUID" -eq 0 ]; then
        return
    fi

    Warn "This script is not running with administrator privileges."
    read -p "Restart as administrator? (Y/N) " choice

    if [[ ! "$choice" =~ ^[Yy]$ ]]; then
        Info "Continuing without elevation."
        return
    fi

    scriptPath="$(realpath "$0")"

    if [ ! -f "$scriptPath" ]; then
        Error "Script path could not be resolved."
        exit 1
    fi

    Info "Restarting with administrator privileges..."

    sudo -E bash "$scriptPath" "$@"

    exit
}

function Confirm-Execution {


banner='
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

'

    Info "$banner"

echo
read -p "Continue? (Y/N) " response

if [[ ! "$response" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi
}

#-----------------------------------------------------------------------------------------------#

Download-font() {

    fontDir="$USER_HOME/.local/share/fonts"

    mkdir -p "$fontDir"

    # PowerShell original download
    # https://github.com/yuru7/moralerspace/releases/download/v2.0.0/

    base="https://github.com/yuru7/moralerspace/releases/download/v2.0.0/"
    files=(
        "Moralerspace_v2.0.0.zip"
        "MoralerspaceHW_v2.0.0.zip"
    )

    tmp="/tmp/ms"

    rm -rf "$tmp"
    mkdir -p "$tmp"

    for f in "${files[@]}"; do
        zip="$tmp/$f"
        url="$base$f"

        Info "Downloading $f ..."
        curl -L -f -o "$zip" "$url"

        unzip -o "$zip" -d "$tmp"
    done

    find "$tmp" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp {} "$fontDir" \;

    fc-cache -f

    Done "Installed Moralerspace."
}

#-----------------------------------------------------------------------------------------------#

Install-AptPackage() {

    pkg="$1"

    if dpkg -s "$pkg" >/dev/null 2>&1; then
        Done "Already installed: $pkg"
        return
    fi

    Info "Installing $pkg ..."

    sudo apt-get install -y "$pkg"

    if [ $? -ne 0 ]; then
        Error "Installation failed: $pkg"
    else
        Done "Installed $pkg"
    fi
}

#-----------------------------------------------------------------------------------------------#

New-RelativeSymlink() {

    RelativeSource="$1"
    Destination="$2"

    scriptRoot="$(cd "$(dirname "$0")" && pwd)"
    sourcePath="$scriptRoot/$RelativeSource"

    if [ ! -e "$sourcePath" ]; then
        Error "Source not found: $sourcePath"
        return
    fi

    parentDir="$(dirname "$Destination")"
    mkdir -p "$parentDir"

    if [ -e "$Destination" ]; then
        Warn "Target already exists: $Destination"
        return
    fi

    ln -s "$sourcePath" "$Destination"

    Done "Created $sourcePath -> $Destination"
}

#-----------------------------------------------------------------------------------------------#

Run-command() {
    Info "$1"
    eval "$1"
    echo
}

Reload-Env() {
    export PATH="$PATH:$USER_HOME/.local/bin"
}

#-----------------------------------------------------------------------------------------------#

Done()  { echo -e "\e[32m$1\e[0m"; }
Warn()  { echo -e "\e[33m$1\e[0m"; }
Error() { echo -e "\e[31m$1\e[0m"; }
Info()  { echo -e "\e[36m$1\e[0m"; }

#-----------------------------------------------------------------------------------------------#

Main-Function
