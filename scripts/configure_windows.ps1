#!/bin/powershell

# ファイルへのシンボリックリンクを作る。(ln -sbf と同様。管理者権限を要する。)
function linkFile($referant, $name) {
    $parent = [system.io.path]::getDirectoryName($name)

    # 親ディレクトリを作る。
    new-item $parent -force -itemType directory

    # バックアップする。
    if (test-path $name) {
        $backup = $name + ".backup"

        if (test-path $backup) {
            remove-item -force $backup
        }

        move-item $name -destination $backup
    }

    new-item $name -value $referant -itemType symbolicLink
}

# ================================================

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
# ~/bin
# ------------------------------------------------

# ~/bin を作成する。
$homeBin = "$env:UserProfile\bin"
if (!(test-path "$homeBin")) {
    mkdir -force $homeBin
}

# パスを通す。
if (!$env:Path.contains($homeBin)) {
    $env:Path = "$homeBin;$env:Path"
    [System.Environment]::SetEnvironmentVariable('Path', $env:Path, [EnvironmentVariableTarget]::User)

    echo 'TRACE: ~/bin にパスを通しました'
}

# ------------------------------------------------
# bash の設定ファイルの配置
# ------------------------------------------------

linkFile "$dotfiles/config/.bash_aliases" "$env:UserProfile/.bash_aliases"
linkFile "$dotfiles/config/.bash_profile" "$env:UserProfile/.bash_profile"
linkFile "$dotfiles/config/.bashrc" "$env:UserProfile/.bashrc"

# ------------------------------------------------
# pwsh の設定ファイルの配置
# ------------------------------------------------

linkFile "$dotfiles/config/pwsh6_profile.ps1" "$env:UserProfile/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
linkFile "$dotfiles/config/pwsh6_profile.ps1" "$env:UserProfile/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"

# ------------------------------------------------
# Git の設定ファイルの配置
# ------------------------------------------------

linkFile "$dotfiles/config/.gitconfig" "$env:UserProfile/.gitconfig"
linkFile "$dotfiles/config/.gitignore" "$env:UserProfile/.gitignore"
linkFile "$dotfiles/vendor/gitalias/gitalias.txt" "$env:UserProfile/.gitalias.txt"

echo "TRACE: 終了 $PSCommandPath"
