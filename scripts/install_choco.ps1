#!/bin/pwsh
# 管理者権限で実行すること。
# [Chocolatey Software | Installing Chocolatey](https://chocolatey.org/install)

if ($(where.exe -q choco; $?)) {
    echo 'INFO: インストール済みなので何もしません choco'
    exit 0
}

# ------------------------------------------------
# choco
# ------------------------------------------------

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco -?
