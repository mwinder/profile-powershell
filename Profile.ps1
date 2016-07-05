
function Local-Path
{
    ".\node_modules\.bin"
}

function User-Path
{
    Include "$env:userprofile\.gem\ruby\*\bin" | `
    Include "$env:userprofile\.dnx\bin" | `
    Include "$env:userprofile\AppData\Roaming\npm" | `
    Include "$env:localappdata\atom\bin" | `
    Include "$env:localappdata\Programs" | `
    Include "$env:localappdata\Programs\Python\Python27" | `

    Include "$env:programdata\Chocolatey\bin" | `

    Include "$env:programfiles\Git\bin" | `                                 ## Git
    Include "$env:programfiles\Git\usr\bin" | `
    Include "$env:programfiles\Java\jre1.8.0_*\bin" | `                     ## Java
    Include "$env:programfiles (x86)\MSBuild\14.0\Bin" | `                  ## MSBuild
    Include "$env:programfiles (x86)\MSBuild\12.0\Bin" | `
    Include "$env:programfiles\nodejs" | `                                  ## Node JS
    Include "$env:systemdrive\Tools\ruby*\bin" | `                          ## Ruby
    Include "$env:programfiles\Microsoft SQL Server\120\Tools\Binn" | `     ## SQL Server
    Include "$env:programfiles\Microsoft SQL Server\110\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\100\Tools\Binn" | `
    Include "$env:programfiles\Sublime Text 3" | `                          ## Sublime Text
    Include "$env:programfiles (x86)\Microsoft VS Code\bin"                 ## VS Code

    # Include "$env:systemdrive\HashiCorp\Vagrant\bin" | `
    # Include "$env:systemdrive\HashiCorp\Packer" | `
    # Include "$env:systemdrive\Tools\go\bin" | `
    # Include "$env:systemdrive\Tools\python" | Include "$env:systemdrive\Tools\python\scripts"
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

Set-Home
Set-Location $env:userprofile
Set-ProcessPath
