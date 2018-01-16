
function User-Path
{
    ".\node_modules\.bin" | `

    Include "$env:userprofile\AppData\Roaming\npm" | `

    Include "$env:programdata\Chocolatey\bin" | `

    Include "$env:programfiles\dotnet" | `                                  ## dotnet
    Include "$env:programfiles\Git\bin" | `                                 ## Git
    Include "$env:programfiles\Git\usr\bin" | `
    Include "$env:programfiles\Java\jre1.8.0_*\bin" | `                     ## Java
    Include "$env:programfiles\nodejs" | `                                  ## Node JS
    Include "$env:programfiles\Microsoft SQL Server\130\Tools\Binn" | `     ## SQL Server
    Include "$env:programfiles\Microsoft SQL Server\120\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\110\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\100\Tools\Binn" | `
    Include "$env:programfiles\Microsoft VS Code" | `                       ## Visual Studio Code
    Include "$env:programfiles\Sublime Text 3"                              ## Sublime Text
}

function System-Path
{
    Include "$env:systemroot\system32" | `
    Include "$env:systemroot" | `
    Include "$env:systemroot\System32\Wbem" | `
    Include "$env:systemroot\System32\WindowsPowerShell\v1.0"
}

function Include([string]$target)
{
    $path = Get-Item $target -ErrorAction SilentlyContinue
    if (-not $path) {
        return $input
    }
    return "$input;$path"
}

function User-Name { [Environment]::Username }

function Host-Name { [Environment]::MachineName }

function User-Location { $(Get-Location).Path.Replace($env:userprofile, "~") }

function prompt
{
    Write-Host
    Write-Host "$(User-Name)@$(Host-Name)" -NoNewline -ForegroundColor Green
    Write-Host " $(User-Location)" -NoNewline
    Write-Host
    return "$ "
}

(Get-PSProvider 'FileSystem').Home = "$env:userprofile"

Set-Home
Set-Location $env:userprofile
Set-ProcessPath
