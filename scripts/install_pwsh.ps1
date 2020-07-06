#!/bin/powershell
# pwsh (新しいバージョンの PowerShell) をインストールする。

$pwshUri = 'https://github.com/PowerShell/PowerShell/releases/download/v6.2.3/PowerShell-6.2.3-win-x64.zip'

$appData = "$env:UserProfile\AppData\Roaming"
$downloads = "$env:UserProfile\Downloads"

function ensureRemove($path) {
    if (test-path $path) {
        remove-item -force -recurse $path
    }
}

function cleanUp() {
    ensureRemove "$downloads\pwsh-x64.zip"
    ensureRemove "$downloads\pwsh-x64"
}

echo "TRACE: 開始 $PSCommandPath"

if (!(test-path "$appData\pwsh-x64")) {
    cleanUp

    (new-object net.webclient).downloadFile($pwshUri, "$downloads\pwsh-x64.zip")
    expand-archive "$downloads\pwsh-x64.zip" -destination "$downloads\pwsh-x64"
    move-item "$downloads\pwsh-x64" -destination "$appData\pwsh-x64"

    cleanUp
    echo "TRACE: $appData\pwsh-x64 にインストールしました"
}

# パスを通す。
if (!$env:Path.contains("$appData\pwsh-x64")) {
    $env:Path = "$appData\pwsh-x64;$env:Path"
    [system.environment]::setEnvironmentVariable('Path', $env:Path, [environmentVariableTarget]::user)

    echo "TRACE: pwsh にパスを通しました"
}

echo "TRACE: 終了 $PSCommandPath"
