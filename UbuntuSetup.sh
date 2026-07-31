#!/usr/bin/env bash

Force=false
Yes=false
SkipFont=false
SkipPackMgr=false # Not implemented
SkipMM2F=false
SkipManualInstall=false
SkipSymlinks=false
SkipPATH=false # Not implemented
SkipOtherCommands=false

#-----------------------------------------------------------------------------------------------#
# Parse options (Ubuntu only)
show_help() {
    cat "$(dirname "$0")/docs/scriptHelp.txt"
}

while (($#)); do
    case "$1" in
        -Force)
            Force=true
            ;;
        -Yes)
            Yes=true
            ;;
        -SkipFont)
            SkipFont=true
            ;;
        -SkipPackMgr)
            SkipPackMgr=true
            ;;
        -SkipMM2F)
            SkipMM2F=true
            ;;
        -SkipManualInstall)
            SkipManualInstall=true
            ;;
        -SkipSymlinks)
            SkipSymlinks=true
            ;;
        -SkipPATH)
            SkipPATH=true
            ;;
        -SkipOtherCommands)
            SkipOtherCommands=true
            ;;
        -Help|-h|-\?|--help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            echo "Use -Help or --help for usage."
            exit 1
            ;;
    esac

    shift
done


#-----------------------------------------------------------------------------------------------#

Destination="$Destination"
parentDir="$(dirname"$Destination")"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -n "$SUDO_USER" ]; then
    targetUser="$SUDO_USER"
else
    targetUser="$HOME"
fi

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
    # Add .dotfiles_bashrc to source and .bashrc
    [ -f "$HOME/.dotfiles_bashrc" ] && . "$HOME/.dotfiles_bashrc"

    grep -qxF '[ -f "$HOME/.dotfiles_bashrc" ] && . "$HOME/.dotfiles_bashrc"' "$USER_HOME/.bashrc" || \
    echo '[ -f "$HOME/.dotfiles_bashrc" ] && . "$HOME/.dotfiles_bashrc"' >> "$USER_HOME/.bashrc"


    #-------------------------------------------------------
    # Download Font
    if [ -z "$SkipFont" ]; then
        Download-font
    else
        echo "Skipped: Font"
    fi

    #-------------------------------------------------------
    # Install package managers
    if [ -z "$SkipPackMgr" ]; then
        # Install-PackMgr
    else
        echo "Skipped: Install PackMgr"
    fi


    #-------------------------------------------------------
    # Install...

    if [ -z "$SkipMM2F" ]; then
        Install-withMM2F
    else
        echo "Skipped: Install with MM2F"
    fi

    if [ -z "$SkipManualInstall" ]; then
        Install-Manually
    else
        echo "Skipped: Install Manually"
    fi


    #-------------------------------------------------------
    # Symlinks
    if [ -z "$SkipSymlinks" ]; then
        local args=()
        if [ -n "$Force" ]; then
            args+=("-Force")
        fi
        Make-Symlinks "${args[@]}"
    else
        echo "Skipped: Symlinks"
    fi

    #-------------------------------------------------------
    # Add to PATH
    if [ -z "$SkipPATH" ]; then
        # Add-PATH
    else
        echo "Skipped: Add to PATH"
    fi

    #-------------------------------------------------------
    # Other commands
    if [ -z "$SkipOtherCommands" ]; then
        Run-OtherCommands
    else
        echo "Skipped: Other commands"
    fi

    #-------------------------------------------------------

    Info "Done. Please reboot your system."
    echo "Press Enter to exit...."
    read
}

#-----------------------------------------------------------------------------------------------#


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

Download-font() {
    Install-AptPackage curl
    Install-AptPackage unzip
    Install-AptPackage gpg

    fontDir="$USER_HOME/.local/share/fonts"

    mkdir -p "$fontDir"

    if fc-list | grep -i "Moralerspace" >/dev/null 2>&1; then
        Done "Fonts is already installed"
        return 0
    fi

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

    echo
}

Install-withMM2F() {
    Run-command "sudo apt update"

    sudo chmod +x "$script_dir/mm2f.sh"
    sudo "$script_dir/mm2f.sh" "$script_dir/packages.yml"
}

Install-Manually() {
    Info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit -D -t /usr/local/bin/

    # Set up fzf
    mkdir -p ~/.local/bin
    ln -s "$(which fdfind)" ~/.local/bin/fd

    Info "Installing nvm..."
    Run-command "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash"

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
    Run-command "sudo chown -R $targetUser:$targetUser ~/.cache/oh-my-posh"

    Info "Installing yazi..."
    YAZI_VERSION=$(curl -s "https://api.github.com/repos/sxyazi/yazi/releases/latest" \
        | grep -Po '"tag_name": *"\K[^"]*')
    ARCH=$(uname -m)
    case "$ARCH" in
        x86_64)   DEB_ARCH="x86_64-unknown-linux-gnu" ;;
        aarch64)  DEB_ARCH="aarch64-unknown-linux-gnu" ;;
        *)        echo "Unsupported architecture: $ARCH"; exit 1 ;;
    esac
    DEB_FILE="yazi-${DEB_ARCH}.deb"
    curl -Lo "$DEB_FILE" \
        "https://github.com/sxyazi/yazi/releases/download/${YAZI_VERSION}/${DEB_FILE}"
    sudo apt install -y "./${DEB_FILE}"

    Install-Zip \
        "sshhub" \
        "https://github.com/T-b-t-nchos/sshhub/releases/latest/download/sshhub_linux-x64.zip" \
        "$HOME/.bin/sshhub"
    chmod +x ~/.bin/sshhub/sshhub

    Info "Installing texlive..."
    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar -zxf install-tl-unx.tar.gz
    rm install-tl-unx.tar.gz
    cd "$(printf '%s\n' install-tl-* | sort | tail -n1)"
    sudo perl install-tl --profile=../.config/TeX-Live/unx.texlive.profile
    cd ..
    rm -rf install-tl-*

    echo
}

Make-Symlinks() {
    local Force=false

    while (($#)); do
        case "$1" in
            -Force|--force|-f)
                Force=true
                ;;
            *)
                echo "Unknown option: $1" >&2
                return 1
                ;;
        esac
        shift
    done

    DocumentsPath="$USER_HOME/Documents"

    New-RelativeSymlink ".config/nvim" "$USER_HOME/.config/nvim"
    New-RelativeSymlink ".config/wezterm" "$USER_HOME/.config/wezterm"
    New-RelativeSymlink ".config/ohmyposh" "$USER_HOME/.config/ohmyposh"
    New-RelativeSymlink ".config/lazygit" "$USER_HOME/.config/lazygit"
    New-RelativeSymlink ".config/yazi" "$USER_HOME/.config/yazi"
    New-RelativeSymlink ".config/.dotfiles_bashrc" "$USER_HOME/.dotfiles_bashrc"
    New-RelativeSymlink ".config/.latexmkrc" "$USER_HOME/.latexmkrc"

    # Windows only paths

    # New-RelativeSymlink `
    #     -RelativeSource ".config\Google Japanese Input\config1.db" `
    #     -Destination (Join-Path $HOME "\AppData\LocalLow\Google\Google Japanese Input\config1.db")

    Reload-Env

    echo
}

Run-OtherCommands() {
    Run-command "gh extension install yusukebe/gh-markdown-preview"

    Info "Setup node.js..."
    export NVM_DIR="$USER_HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    Run-command "nvm install node"
    Run-command "npm install -g @antfu/ni mdpv tree-sitter-cli deno @mermaid-js/mermaid-cli"


    Info "Setup TeX Live..."
    sudo "$(find /usr/local/texlive -type f -path '*/bin/*/tlmgr' | sort | tail -n1)" path add
    sudo tlmgr update --self --all
    sudo tlmgr install latexmk lualatex-math uplatex luatexja tlmgr info collection-langjapanese
    sudo tlmgr path add

    Reload-Env

    echo

    trap "kill $SUDO_KEEPALIVE_PID 2>/dev/null" EXIT
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

Install-Zip() {

    name="$1"
    url="$2"
    install_dir="$3"

    if [ -d "$install_dir" ]; then
        Done "Already installed: $name"
        return
    fi

    temp_file="/tmp/${name}-zip.zip"

    Info "Downloading $name ..."

    curl -L \
        --fail \
        --output "$temp_file" \
        "$url"

    if [ $? -ne 0 ] || [ ! -f "$temp_file" ]; then
        Error "Download failed: $name"
        rm -f "$temp_file"
        return
    fi

    Info "Installing $name ..."

    mkdir -p "$install_dir"

    unzip -q "$temp_file" -d "$install_dir"

    if [ $? -ne 0 ]; then
        Error "Installation failed: $name"
    else
        Done "Installed $name"
    fi

    rm -f "$temp_file"
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
    source ~/.dotfiles_bashrc
}

#-----------------------------------------------------------------------------------------------#

Done()  { echo -e "\e[32m$1\e[0m"; }
Warn()  { echo -e "\e[33m$1\e[0m"; }
Error() { echo -e "\e[31m$1\e[0m"; }
Info()  { echo -e "\e[36m$1\e[0m"; }

#-----------------------------------------------------------------------------------------------#

Main-Function
