# pwsh (PowerShell)

# Linux-like env and alias
new-alias which where.exe
new-alias grep rg
new-alias find fd

# GitBash の ~ を展開するときに必要。
$env:HOME = $env:UserProfile

# ------------------------------------------------
# UTF-8 を強制する
# ------------------------------------------------

chcp 65001

$OutputEncoding = New-Object System.Text.Utf8Encoding $False

$PSDefaultParameterValues['*:Encoding'] = "utf8"
$PSDefaultParameterValues['Out-File:Encoding'] = "utf8"

$env:LESSCHARSET = 'utf-8'

# ------------------------------------------------
# Git
# ------------------------------------------------

new-alias git-bash C:/Program` Files/Git/bin/bash.exe

# Git command
function g() {
    git $(if ($args.length -eq 0) { 's' } else { $args })
}

# ------------------------------------------------
# .NET
# ------------------------------------------------

new-alias nuget ./.nuget/nuget.exe
new-alias paket ./.paket/paket.exe
new-alias paket-boot ./.paket/paket.bootstrapper.exe

# ------------------------------------------------
# Node.js
# ------------------------------------------------

# new-alias n npm` run

# ------------------------------------------------
# その他
# ------------------------------------------------

# 環境変数を表示する。
function show-env() {
    ls env:
}

# パスを表示する。
function show-path() {
    [system.Linq.Enumerable]::distinct($env:PATH.split(@(';'))) | sort
}

function set-userEnv($name, $value) {
    [system.environment]::setEnvironmentVariable($name, $value, [environmentVariableTarget]::user)
}
