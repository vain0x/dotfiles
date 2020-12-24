#!/bin/pwsh

echo "TRACE: 開始 $PSCommandPath"

$dotfiles = (git rev-parse --show-toplevel)

# ------------------------------------------------
# dotfiles リポジトリの設定
# ------------------------------------------------

if ((git remote get-url origin).startsWith('https')) {
    git remote set-url origin 'git@github.com:vain0x/dotfiles'

    echo 'TRACE: origin の URL を変更しました'
}

# ------------------------------------------------
# $HOME/bin
# ------------------------------------------------

$homeBin = "$env:UserProfile\bin"
if (!(test-path "$homeBin")) {
    mkdir -force $homeBin
}

# パスを通す。
if (!$env:Path.contains($homeBin)) {
    $env:Path = "$homeBin;$env:Path"
    [System.Environment]::SetEnvironmentVariable('Path', $env:Path, [EnvironmentVariableTarget]::User)

    echo 'TRACE: $HOME/bin にパスを通しました'
}

# ------------------------------------------------
# bash の設定ファイルの配置
# ------------------------------------------------

function installBashConfig($src, $dest) {
    if (!(test-path $dest)) {
        echo "test -r '$src' && . '$src'" >$dest
    }
}

installBashConfig "$dotfiles/config/.bash_aliases" "$env:UserProfile/.bash_aliases"
installBashConfig "$dotfiles/config/.bash_profile" "$env:UserProfile/.bash_profile"
installBashConfig "$dotfiles/config/.bashrc" "$env:UserProfile/.bashrc"

# ------------------------------------------------
# pwsh の設定ファイルの配置
# ------------------------------------------------

$pwshProfile1 = "$env:UserProfile/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
$pwshProfile2 = "$env:UserProfile/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"

foreach ($profileName in @($pwshProfile1, $pwshProfile2)) {
    if (!(test-Path $profileName)) {
        echo ". '$dotfiles/config/pwsh6_profile.ps1'" >$profileName
    }
}

# ------------------------------------------------
# Git の設定ファイルの配置
# ------------------------------------------------

if (!(test-path "$env:UserProfile/.gitconfig")) {
    $gitConfig1 = "$dotfiles/vendor/gitalias/gitalias.txt"
    $gitConfig2 = "$dotfiles/config/.gitconfig"

    echo "[include]`n`tpath = `"$gitConfig1`"`n`tpath = `"$gitConfig2`"`n`n`t[core]`n`texcludesfile = `"$dotfiles/config/.gitignore`"" >"$env:UserProfile/.gitconfig"
}

echo "TRACE: 終了 $PSCommandPath"
