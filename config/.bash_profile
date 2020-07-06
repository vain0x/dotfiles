# ログインシェルで実行される。

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
export PATH

# test -r ./.profile && . ./.profile

test -r ./.bashrc && . ./.bashrc
