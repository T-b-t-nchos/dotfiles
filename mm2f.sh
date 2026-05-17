#!/usr/bin/env bash

# Multi package Manager packages To a File
# Usage: mm2f.sh [packages.yml]
# Requirements:
# - bash (For running the script)
# - sudo (For running as root)
# - wget (For installing yq)

YAML="${1:-./packages.yml}"


# yq install
if command -v yq >/dev/null 2>&1; then
    echo -e "\033[0;32mAlready installed: yq\033[0m"
else
    echo -e "\033[0;36mInstalling yq ...\033[0m"

    if ! sudo wget -qO /usr/local/bin/yq \
        https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64; then
        echo -e "\033[1;31mDownload failed: yq\033[0m"
        exit 1
    fi

    if ! sudo chmod +x /usr/local/bin/yq; then
        echo -e "\033[1;31mPermission set failed: yq\033[0m"
        exit 1
    fi

    echo -e "\033[0;32mInstalled yq\033[0m"
fi


if [ ! -f "$YAML" ]; then
    echo -e "\033[1;31mYAML not found: $YAML\033[0m"
    exit 1
fi

DEFAULT_PRIORITY=("apt" "pacman")

get_default_command() {
    case "$1" in
        apt) echo "sudo apt install -y {id}" ;;
        pacman) echo "sudo pacman -S --noconfirm {id}" ;;
    esac
}

mapfile -t priority < <(yq -r '.options.linux.priority[]?' "$YAML")
[ ${#priority[@]} -eq 0 ] && priority=("${DEFAULT_PRIORITY[@]}")

available_priority=()
for pm in "${priority[@]}"; do
    check_pm=$pm
    if command -v "$check_pm" >/dev/null 2>&1; then
        available_priority+=("$pm")
    fi
done
if [ ${#available_priority[@]} -eq 0 ]; then
    echo -e "\033[1;31mNo available package managers found.\033[0m"
    echo -e "\033[1;31mConfigured priority: ${priority[*]}\033[0m"
    exit 1
fi

len=$(yq '.packages | length' "$YAML")

for ((i=0; i<len; i++)); do
    name=$(yq -r ".packages[$i].name" "$YAML")

    selected_pm=""
    id=""

    for pm in "${available_priority[@]}"; do
        val=$(yq -r ".packages[$i].$pm" "$YAML")
        if [ -n "$val" ] && [ "$val" != "null" ]; then
            selected_pm="$pm"
            id="$val"
            break
        fi
    done

    if [ -z "$selected_pm" ]; then
        echo -e "\033[1;33mSkipped: $name\033[0m"
        continue
    fi

    installed=0
    case "$selected_pm" in
        apt)
            dpkg -s "$id" >/dev/null 2>&1 && installed=1
            ;;
        pacman)
            pacman -Qi "$id" >/dev/null 2>&1 && installed=1
            ;;
    esac

    if [ "$installed" -eq 1 ]; then
        echo -e "\033[0;32mAlready installed: $id\033[0m"
        continue
    fi

    template=$(yq -r ".options.linux.commands.$selected_pm" "$YAML")
    if [ -z "$template" ] || [ "$template" = "null" ]; then
        template=$(get_default_command "$selected_pm")
    fi

    cmd=${template//\{id\}/$id}

    echo -e "\033[0;36mInstalling $id ...\033[0m"

    if ! eval "$cmd"; then
        echo -e "\033[1;31mInstallation failed: $id\033[0m"
    else
        echo -e "\033[0;32mInstalled $id\033[0m"
    fi
done
