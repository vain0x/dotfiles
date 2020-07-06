# Windows 用のメモ

初めからインストールされている、古いバージョンの PowerShell を **管理者権限で** 起動する。コマンド:

```ps1
set-executionPolicy remoteSigned
```

```ps1
$gitUri = 'https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/Git-2.27.0-64-bit.exe'
$dotfilesUri = 'https://github.com/vain0x/dotfiles'

$downloads = "$env:UserProfile\Downloads"
$repo = "$env:UserProfile\repo\local"
$dotfiles = "$repo\dotfiles"

mkdir -force $repo

function ensureRemove($path) {
    if (test-path $path) {
        remove-item -force -recurse $path
    }
}

# Git for Windows をインストールする。
$gitIsInstalled = $(where.exe /Q git; $?)
if (!$gitIsInstalled) {
    $gitExe = "$downloads\git-x64.exe"

    ensureRemove $gitExe

    (new-object net.webclient).downloadFile($gitUri, $gitExe)
    & $gitExe | out-null

    ensureRemove $gitExe
}

# dotfiles をダウンロードして、スクリプトを実行する。
if (!(test-path $dotfiles)) {
    git clone -b windows $dotfilesUri $dotfiles
}

start-process 'powershell' -argumentList @('-c', "$dotfiles\windows.ps1") -workingDirectory $dotfiles -verb 'runas'
```

## リンク

ブラウザ:

- [Firefox](https://www.mozilla.org/ja/firefox/new/)
- [Google Chrome](https://www.google.co.jp/chrome/)

エディタ:

- [Visual Studio Code](https://code.visualstudio.com/)
- [Visual Studio Community](https://visualstudio.microsoft.com/ja/free-developer-offers/)
- [Atom](https://atom.io)

VCS:

- [Git for Windows](https://gitforwindows.org/)

シェル:

- [pwsh](https://github.com/PowerShell/PowerShell/releases/latest)

フォント:

- [Source Han Code JP](https://github.com/adobe-fonts/source-han-code-jp/releases/latest)

### その他

- Clementine
- Docker
- HSP3
- WSL
