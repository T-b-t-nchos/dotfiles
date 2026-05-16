Read in other language: [Japanese](./README.ja.md)

# Nchos's Dotfiles...

## Description
Repository containing my dotfiles.

## Important Note
- These dotfiles are for my (T-b-t-nchos) personal use.
That's why it's not recommended to run these scripts on production machines.
- Please understand that neither I nor any contributor is responsible for
any damage or loss caused by using the contents of this repository.

## Setup

### Windows

#### Requirements
- Git on Windows

#### Usage
```pwsh
cd ~
git clone https://github.com/T-b-t-nchos/dotfiles
cd dotfiles
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\WinSetup.ps1
```

### Ubuntu(Debian)

#### Requirements
- Git
- sudo
- apt

#### Usage
```bash
sudo apt update
sudo apt install git
git clone https://github.com/T-b-t-nchos/dotfiles
cd dotfiles
chmod +x UbuntuSetup.sh
./UbuntuSetup.sh
```

## Used components
- TODO...
