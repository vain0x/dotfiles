使わなかったスクリプト

```ps1
# 管理者権限を取得する。
function escalate($command) {
    if (!$(test-path '.escalate-lock')) {
        new-item '.escalate-lock'
        start-process 'powershell' -verb 'runas' -argumentList @('/c', $command)
        exit 0
    }

    remove-item '.escalate-lock'
}

escalate './win.ps1'
```

```ps1
$curlUri = 'https://curl.haxx.se/windows/dl-7.71.1/curl-7.71.1-win64-mingw.zip'
$appData = "$env:UserProfile\AppData\Roaming"
$curl = "$appData\curl\bin\curl.exe"

# curl をインストールする。
(new-object net.webclient).downloadFile($curlUri, "$downloads/curl.zip")
[system.io.compression.zipFile]::extractToDirectory("$downloads/curl.zip", "$downloads/curl")
move-item "$downloads/curl/curl-7.71.1-win64-mingw" "$appData/curl"

remove-item "$downloads/curl.zip"
remove-item -recurse "$downloads/curl"
```
