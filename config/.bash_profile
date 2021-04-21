#!/bin/bash
# ログインシェルで実行される。

PATH="$HOME/bin/node-v14.15.5-linux-x64/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"
PATH="$HOME/.local:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH

# test -r ~/.profile && . ~/.profile

test -r ~/.bashrc && . ~/.bashrc
