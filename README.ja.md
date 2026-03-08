# Nchos's Dotfiles...

## 概要
私が使用しているdotfileのリポジトリです。  

## 注意事項
- 本dotfilesは私(T-b-t-nchos)が個人的に使用しているものです。  
そのため、本番環境でのスクリプトの実行やconfigの使用は推奨しません。
- 本リポジトリに掲載した内容を使用したことに対するいかなる損害、損失、  
またはそれに類するものに関して、私、及び貢献者は一切の責任を負わないものとし、  
このリポジトリに掲載した内容を使用するユーザーはそれを理解したものとします。  

## セットアップ
### Windows
#### 依存関係
- Git on Windows
#### 実行方法
```pwsh
cd ~
git clone https://github.com/T-b-t-nchos/dotfiles
cd dotfiles
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\WinSetup.ps1
``` 
### Ubuntu(Debian)
#### 依存関係
- Git
#### 実行方法
```bash
sudo apt update
sudo apt install git
git clone https://github.com/T-b-t-nchos/dotfiles
cd dotfiles
chmod +x UbuntuSetup.sh
./UbuntuSetup.sh
```

## 使用コンポーネント
- 準備中...
