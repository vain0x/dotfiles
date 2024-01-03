#!/bin/powershell
# 管理者権限で実行すること。

# JetBrains Mono <https://github.com/JetBrains/JetBrainsMono>
# Noto Fonts <https://www.google.com/get/noto/>

$jetBrainsMonoUri = 'https://github.com/JetBrains/JetBrainsMono/releases/download/v2.001/JetBrains.Mono.2.001.zip'
$notoSansCjkJpUri = 'https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip'

function ensureRemove($path) {
    if (test-path $path) {
        remove-item -force -recurse $path
    }
}

# hint: ファイル名につける適当な名前
function installFontZip($hint, $zipUri) {
    $downloads = "$env:UserProfile\Downloads"
    $workDir = "$downloads\install-font-$([guid]::newGuid())"
    $zipPath = "$workDir\$hint-$([guid]::newGuid()).zip"

    ensureRemove $workDir
    mkdir -force $workDir

    (new-object net.webclient).downloadFile($zipUri, $zipPath)
    expand-archive $zipPath -destination $workDir

    # 各ファイルを Fonts にコピーする。
    dir $workDir -filter '*.otf' -recurse | % {
        echo "TRACE: font found $($_.fullName)"

        $name = "C:\Windows\Fonts\$($_.name)"
        if (!(test-path $name)) {
            move-item $_.fullName -destination 'C:\Windows\Fonts'

            echo "TRACE: installed $name"
        }
    }

    ensureRemove $workDir
}

echo "TRACE: 開始 $PSCommandPath"

installFontZip 'jet-brains-mono' $jetBrainsMonoUri
installFontZip 'noto-sans-cjk-jp' $notoSansCjkJpUri

echo "TRACE: 終了 $PSCommandPath"
