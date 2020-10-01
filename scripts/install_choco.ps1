#!/bin/pwsh
# EXAMPLE: pwsh -c ./scripts/install_choco.ps1
# [Chocolatey Software | Installing Chocolatey](https://chocolatey.org/install)

if ($(where.exe -q choco; $?)) {
    echo 'INFO: インストール済みなので何もしません choco'
    exit 0
}

# ------------------------------------------------
# 管理者権限を取得する。
# ------------------------------------------------

function escalate($command) {
    if (!$(test-path '.escalate-lock')) {
        new-item '.escalate-lock'
        start-process 'powershell' -argumentList @('/c', $command) -verb 'runas'
        exit 0
    }

    remove-item '.escalate-lock'
}

escalate './scripts/install_choco.ps1'

# ------------------------------------------------
# choco
# ------------------------------------------------

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco -?



choco install -y `
    delta `
    dotnetcore-sdk `
    fd `
    firefox `
    git `
    googlechrome `
    nodejs `
    peco `
    pwsh `
    ripgrep `
    rust `
    thunderbird `
    vcbuildtools 2015.4 `
    visualstudio2019community `
    vscode `
    yarn

# missed exa, rust-analyzer, ham, hsp, 7za
# path to hsp3_home, hsp3_root
# install ginger, knowbug
