# pwsh (PowerShell)

# Change prompt. This looks like:
#       PS $PWD
#       >
# <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_prompts>
function prompt {
    $cwd = $(Get-Location).Path.Replace('\', '/')

    "`n`e[90mPS `e[01;34m$cwd`e[0m  `n" +
        "`e[01;32m" + ($(if ($NestedPromptLevel -ge 1) { '>>' }) + '> ') + "`e[0m"
}

# ------------------------------------------------
# Git
# ------------------------------------------------

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

# Create an empty file or update last-write time.
function touch($file) {
    $dir = [System.IO.Path]::GetDirectoryName($file)
    if ($dir -ne '' -and !(test-path $dir)) {
        mkdir -p $dir
    }

    if (test-path $file) {
        $t = [System.DateTime]::Now
        [System.IO.File]::SetLastAccessTime($file, $t)
        [System.IO.File]::SetLastWriteTime($file, $t)
    } else {
        new-item $file
    }
}

function rm-rf() {
    Remove-Item -Recurse -Force $args
}
