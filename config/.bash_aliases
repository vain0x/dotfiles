# ログインシェルでないときに実行される。

alias n='npm run'

# プロンプトをこんな感じにする:
#    ~/repo/local/dotfiles
#    $
if test "$TERM" = "xterm-256color"
then
    PS1='\n\[\033[01;34m\]\w\[\033[00m\]\n\[\033[01;32m\]\$\[\033[00m\] '
else
    # QUESTION: これ以外に PS1 に改行文字を含める方法があったら教えてください。
    NEWLINE=$(echo -e \"\\n\")
    export NEWLINE

    PS1='${NEWLINE} ${PWD}${NEWLINE} $ '
fi

# cd の直後にディレクトリの概要を出力する。
cd() {
    builtin cd "$@" && x_workdir_summary
}

# mkdir + cd
mkcd() {
    test $# -gt 1 && mkdir -p "$@" && cd "$@"
}

# いまのディレクトリが Git リポジトリの作業ツリーか？
x_workdir_is_git_repo() {
    git rev-parse --is-inside-work-tree 1>/dev/null 2>/dev/null
}

# いまのディレクトリの概要を表示する。
x_workdir_summary() {
    # FIXME: ファイル数が多いとき困る。
    # ls -l --human-readable --almost-all | head -n 10

    x_workdir_is_git_repo && git s
}

# ./scripts 以下のスクリプトを実行する。
x() {
    SCRIPT="${1:-}"
    shift

    if test -z "$SCRIPT"
    then
        # 実行可能ファイルを列挙する。
        find ./scripts -maxdepth 1 -type f -executable -exec basename {} \;
    else
        "./scripts/$SCRIPT" "$@"
    fi
}

# git コマンドの略記
g() {
    if test $# -eq 0
    then
        git s
    else
        git "$@"
    fi
}

# npm でローカルにインストールしたコマンドを実行する。
# EXAMPLE: npx tsc -w
nx() {
    if test $# -eq 0
    then
        ls $(npm bin)
    else
        $(npm bin)/"$@"
    fi
}

# peco を使ってディレクトリを移動する。
# cdp() {
#     DIR="$(ls | peco --on-cancel error)" && test -d $DIR && cd $DIR
# }

x_workdir_summary
