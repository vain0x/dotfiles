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

./scripts/install-choco.ps1

# FIXME: choco コマンドを使う前に、一度 PowerShell を閉じて開きなおす必要があったかもしれない(?)
choco -?
```

## 管理者権限を要するスクリプト

```powershell
& './scripts/configure_windows.ps1'
& './scripts/install_fonts.ps1'

choco install -y `
    pwsh `
    delta `
    docker-desktop `
    dotnetcore-sdk `
    firefox `
    fd `
    filezilla `
    gpg4win `
    nodejs `
    ripgrep `
    rust `
    thunderbird `
    vcbuildtools 2015.4 `
    visualstudio2019community `
    vscode `
    yarn `
    7zip

# missed rust-analyzer, ham, hsp, 7za, ginger, knowbug
# path to hsp3_home, hsp3_root
```

## 管理者権限のいらないスクリプト

```sh
./scripts/install_7za
./scripts/install_hsp3
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

### その他

- Clementine
- Docker
- HSP3
- WSL
