#!/bin/powershell
# 管理者権限で実行すること。

# Noto Fonts <https://www.google.com/get/noto/>
# Source Han Code JP <https://github.com/adobe-fonts/source-han-code-jp>

$notoSansCjkJpUri = 'https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip'
$sourceHanCodeJpUri = 'https://github.com/adobe-fonts/source-han-code-jp/archive/2.011R.zip'

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

installFontZip 'noto-sans-cjk-jp' $notoSansCjkJpUri
installFontZip 'source-han-code-jp' $sourceHanCodeJpUri

echo "TRACE: 終了 $PSCommandPath"
