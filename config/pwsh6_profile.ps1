# pwsh (PowerShell)

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

# [タブ補完を有効にする](https://docs.microsoft.com/ja-jp/dotnet/core/tools/enable-tab-autocomplete#bash)
# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

# ------------------------------------------------
# Node.js
# ------------------------------------------------

function n() {
    npm run $args
}

# ------------------------------------------------
# その他
# ------------------------------------------------

function rm-rf() {
    Remove-Item -Recurse -Force $args
}
