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
    # Add .dotfiles_profile to source and .bashrc
    [ -f "$HOME/.dotfiles_profile" ] && . "$HOME/.dotfiles_profile"

    grep -qxF '[ -f "$HOME/.dotfiles_profile" ] && . "$HOME/.dotfiles_profile"' "$USER_HOME/.bashrc" || \
    echo '[ -f "$HOME/.dotfiles_profile" ] && . "$HOME/.dotfiles_profile"' >> "$USER_HOME/.bashrc"


    #-------------------------------------------------------
    # Download Font
    Install-AptPackage curl
    Install-AptPackage unzip
    Install-AptPackage gpg
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
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/

    Install-AptPackage fzf

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
    
    Info "Installing wezterm..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt update
    sudo apt install -y wezterm-nightly

    Info "Installing ohmyposh..."
    Run-command "curl -s https://ohmyposh.dev/install.sh | bash -s"


    Info "Installing Coderabbit CLI..."
    curl -fsSL https://cli.coderabbit.ai/install.sh | bash


    echo

    #-------------------------------------------------------
    # dot-config...

    DocumentsPath="$USER_HOME/Documents"

    New-RelativeSymlink ".config/nvim" "$USER_HOME/.config/nvim"
    New-RelativeSymlink ".config/wezterm" "$USER_HOME/.config/wezterm"
    New-RelativeSymlink ".config/ohmyposh" "$USER_HOME/.config/ohmyposh"
    New-RelativeSymlink ".config/lazygit" "$USER_HOME/.config/lazygit"
    New-RelativeSymlink ".config/.dotfiles_profile" "$USER_HOME/.dotfiles_profile"

    # Windows only paths

    # New-RelativeSymlink `
    #     -RelativeSource ".config\Google Japanese Input\config1.db" `
    #     -Destination (Join-Path $HOME "\AppData\LocalLow\Google\Google Japanese Input\config1.db")

    Reload-Env

    echo

    #-------------------------------------------------------
    # Other commands

    Run-command "gh extension install yusukebe/gh-markdown-preview"

    Info "Setup node.js..."
    export NVM_DIR="$USER_HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    Run-command "nvm install node"
    Run-command "npm install -g @antfu/ni mdpv tree-sitter-cli deno"

    Reload-Env

    echo

    trap "kill $SUDO_KEEPALIVE_PID 2>/dev/null" EXIT

    #-------------------------------------------------------

    Info "Done. Please reboot your system."
    echo "Press Enter to exit...."
    read
}

#-----------------------------------------------------------------------------------------------#

Ensure-Administrator() {

    if [ "$EUID" -eq 0 ]; then
        Error "This script can't running with administrator privileges."
        exit 1
    fi

    Warn "This script is not running with administrator privileges."
    read -p "Allow to run sudo -v ? (Y/N) " choice

    if [[ ! "$choice" =~ ^[Yy]$ ]]; then
        Info "Continuing without elevation."
        return
    fi

    scriptPath="$(realpath "$0")"

    if [ ! -f "$scriptPath" ]; then
        Error "Script path could not be resolved."
        exit 1
    fi

    Run-command "sudo -v"
    (while true; do sudo -n true; sleep 60; done) &
    SUDO_KEEPALIVE_PID=$!
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
    source ~/.bashrc
    source ~/.dotfiles_profile
}

#-----------------------------------------------------------------------------------------------#

Done()  { echo -e "\e[32m$1\e[0m"; }
Warn()  { echo -e "\e[33m$1\e[0m"; }
Error() { echo -e "\e[31m$1\e[0m"; }
Info()  { echo -e "\e[36m$1\e[0m"; }

#-----------------------------------------------------------------------------------------------#

Main-Function
