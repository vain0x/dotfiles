#!/bin/bash
# ログインシェルで実行される。

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"
export PATH

export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH

# test -r ~/.profile && . ~/.profile

test -r ~/.bashrc && . ~/.bashrc
