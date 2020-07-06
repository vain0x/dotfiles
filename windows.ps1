#!/bin/powershell
# 管理者権限で実行すること。

& './scripts/configure_windows.ps1'
& './scripts/install_pwsh.ps1'
& './scripts/install_fonts.ps1'

echo 'OK'
pause
