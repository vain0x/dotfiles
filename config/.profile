#!/bin/sh
# ログインシェルで実行される。

PATH="$HOME/bin/node-v14.15.5-linux-x64/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"
PATH="$HOME/.local:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/usr/bin:$PATH"
export PATH

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# test -n "$BASH_PROFILE" && test -r ~/.bash_profile && . ~/.bash_profile
test -n "$BASH_VERSION" && test -r ~/.bashrc && . ~/.bashrc
