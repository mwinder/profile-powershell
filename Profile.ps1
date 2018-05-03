
function User-Path
{
    ".\node_modules\.bin" | `

    Include "$env:userprofile\AppData\Local\Programs\Sysinternals" | `

    Include "$env:userprofile\AppData\Roaming\npm" | `

    Include "$env:programdata\Chocolatey\bin" | `

    Include "$env:programfiles\dotnet" | `                                              ## dotnet
    Include "$env:programfiles\Git\bin" | Include "$env:programfiles\Git\usr\bin" | `   ## Git
    Include "$env:programfiles\nodejs" | `                                              ## Node JS
    Include "$env:programfiles\Microsoft SQL Server\130\Tools\Binn" | `                 ## SQL Server
    Include "$env:programfiles\Microsoft VS Code" | `                                   ## Visual Studio Code
    Include "$env:programfiles\Sublime Text 3" | `                                      ## Sublime Text
    Include "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin" | `
    Include "C:\Program Files (x86)\Microsoft SDKs\F#\10.1\Framework\v4.0"
}

function System-Path
{
    Include "$env:systemroot\system32" | `
    Include "$env:systemroot" | `
    Include "$env:systemroot\System32\Wbem" | `
    Include "$env:systemroot\System32\WindowsPowerShell\v1.0"
}

function prompt
{
    Write-Host
    Write-Host "$(User-Name)@$(Host-Name)" -NoNewline -ForegroundColor Green
    Write-Host " $(User-Location)" -NoNewline
    Write-Host
    return "$ "
}

# Set-Home
# Set-ProcessPath

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
           [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}



### PRIVATE ###

function User-Name { [Environment]::Username }

function Host-Name { [Environment]::MachineName }

function User-Location { $(Get-Location).Path.Replace($env:userprofile, "~") }

function Include([string]$target)
{
    $path = Get-Item $target -ErrorAction SilentlyContinue
    if (-not $path) {
        return $input
    }
    return "$input;$path"
}