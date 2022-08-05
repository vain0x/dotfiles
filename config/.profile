#!/bin/sh
# ログインシェルで実行される。

PATH="$HOME/src/node-v16.13.1/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"
PATH="$HOME/.local:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/usr/bin:$PATH"
export PATH

# https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1

export VCPKG_DISABLE_METRICS=1

# test -n "$BASH_PROFILE" && test -r ~/.bash_profile && . ~/.bash_profile
test -n "$BASH_VERSION" && test -r ~/.bashrc && . ~/.bashrc
