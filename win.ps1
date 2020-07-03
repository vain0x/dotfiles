#!/bin/pwsh
# シンボリックリンクを作るため、途中で管理者権限を求める。

# 昇格
if (!$(test-path .lock)) {
    new-item .lock
    start-process pwsh -argumentList @('/c', './win.ps1; pause') -verb runas
    return
}
remove-item .lock

# シンボリックリンクを生成する。
# 位置 $target にシンボリックリンクを生成して、それが $source を指す。(cp と同じ語順)
function link($source, $target) {
    $dir = ([System.IO.Path]::GetDirectoryName($target))
    $name = ([System.IO.Path]::GetFileName($target))

    if (!([System.IO.File]::Exists($source))) {
        throw "Link source file doesn't exist or is a directory: $source."
    }

    # 生成先のディレクトリがなければ作る。
    new-item $dir -force -itemType directory

    # バックアップする。(ln -b の挙動)
    if ([System.IO.File]::Exists($target)) {
        $backup = $target + ".orig"
        [System.IO.File]::Delete($backup)
        [System.IO.File]::Move($target, $backup)
    }

    new-item -path $dir -name $name -value $source -itemType symbolicLink
}

# ================================================

$dotfiles = (git rev-parse --show-toplevel)

# ------------------------------------------------
# pwsh
# ------------------------------------------------

link "$dotfiles/config/pwsh6_profile.ps1" $profile

# ------------------------------------------------
# Git
# ------------------------------------------------

link "$dotfiles/config/.gitconfig" "$env:UserProfile/.gitconfig"
link "$dotfiles/config/.gitignore" "$env:UserProfile/.gitignore"
link "$dotfiles/vendor/gitalias/gitalias.txt" "$env:UserProfile/.gitalias.txt"

