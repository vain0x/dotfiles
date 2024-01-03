#!/bin/sh
# ログインシェルで実行される。

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.dotnet/tools:$PATH"
PATH="$HOME/.local/share/npm/bin:$PATH"
export PATH

# <https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html>
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# <https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables>
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_NOLOGO=1
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true

export LESSHISTFILE="$HOME/.local/state/less/history"

# <https://github.com/npm/rfcs/issues/389#issuecomment-871656832>
export npm_config_userconfig="$HOME/.config/npm/config"
export npm_config_cache="$HOME/.cache/npm"
export npm_config_prefix="$HOME/.local/share/npm"

export NODE_REPL_HISTORY="$HOME/.local/state/node/repl_history"

export VCPKG_DISABLE_METRICS=1

# test -n "$BASH_PROFILE" && test -r ~/.bash_profile && . ~/.bash_profile
test -n "$BASH_VERSION" && test -r ~/.bashrc && . ~/.bashrc
