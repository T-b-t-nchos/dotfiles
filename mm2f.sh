#!/usr/bin/env bash


# Multi package Manager packages To a file
# Usage: mm2f.sh [packages.yml] 
# Requires: apt, scoop

YAML="${1:-./packages.yml}"

if [ ! -f "$YAML" ]; then
    echo -e "\033[1;31mYAML not found: $YAML\033[0m"
    exit 1
fi


# yq install (apt)
if dpkg -s yq >/dev/null 2>&1; then
    echo -e "\033[0;32mAlready installed: yq\033[0m"
else
    echo -e "\033[0;36mInstalling yq ...\033[0m"

    sudo apt-get update -y >/dev/null 2>&1
    sudo apt-get install -y yq

    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mInstallation failed: yq\033[0m"
    else
        echo -e "\033[0;32mInstalled yq\033[0m"
    fi
fi


len=$(yq '.packages | length' "$YAML")

for ((i=0; i<len; i++)); do
    name=$(yq -r ".packages[$i].name" "$YAML")

    apt=$(yq -r ".packages[$i].apt // empty" "$YAML")
    scoop=$(yq -r ".packages[$i].scoop // empty" "$YAML")

    if [ -n "$apt" ]; then
        id="$apt"
        pm="apt"
    elif [ -n "$scoop" ]; then
        id="$scoop"
        pm="scoop"
    else
        echo -e "\033[1;33mSkipped: $name\033[0m"
        continue
    fi

    installed=0

    if [ "$pm" = "apt" ]; then
        dpkg -s "$id" >/dev/null 2>&1 && installed=1
    else
        scoop list "$id" 2>/dev/null | grep -q "^$id" && installed=1
    fi

    if [ "$installed" -eq 1 ]; then
        echo -e "\033[0;32mAlready installed: $id\033[0m"
        continue
    fi

    echo -e "\033[0;36mInstalling $id ...\033[0m"

    if [ "$pm" = "apt" ]; then
        sudo apt-get install -y "$id"
    else
        scoop install "$id"
    fi

    if [ $? -ne 0 ]; then
        echo -e "\033[1;31mInstallation failed: $id\033[0m"
    else
        echo -e "\033[0;32mInstalled $id\033[0m"
    fi
done
