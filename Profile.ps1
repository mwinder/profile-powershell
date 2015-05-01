
Import-Module Environment

function Local-Path
{
    ";.\node_modules\.bin"
}

function User-Path
{
    Add-Path "$env:userprofile\.gem\ruby\*\bin" | `
    Add-Path "$env:userprofile\.dnx\bin" | `
    Add-Path "$env:userprofile\AppData\Roaming\npm" | `
    Add-Path "$env:userprofile\Tools"
}

function Global-Path
{
    Add-Path "$env:systemroot\Microsoft.NET\Framework64\v4.0.30319" | `
    Add-Path "$env:programfiles\Microsoft SQL Server\120\Tools\Binn" | `
    Add-Path "$env:programfiles\Microsoft SQL Server\110\Tools\Binn" | `
    Add-Path "$env:programfiles\Microsoft SQL Server\100\Tools\Binn" | `
    Add-Path "$env:programfiles\nodejs" | `
    Add-Path "$env:programfiles\Sublime Text 3" | `
    Add-Path "$env:programfiles\TortoiseHg" | `
    Add-Path "$env:programfiles (x86)\Git\cmd" | Add-Path "$env:programfiles (x86)\Git\bin" | `
    Add-Path "$env:programdata\chocolatey\bin" | `
    Add-Path "$env:systemdrive\HashiCorp\Vagrant\bin" | `
    Add-Path "$env:systemdrive\HashiCorp\Packer" | `
    Add-Path "$env:systemdrive\Tools\go\bin" | `
    Add-Path "$env:systemdrive\Tools\python" | Add-Path "$env:systemdrive\Tools\python\scripts" | `
    Add-Path "$env:systemdrive\Tools\ruby*\bin" | `
    Add-Path "$env:systemdrive\Tools\sysinternals"
}

function System-Path
{
    Add-Path "$env:systemroot\system32" | `
    Add-Path "$env:systemroot" | `
    Add-Path "$env:systemroot\System32\Wbem" | `
    Add-Path "$env:systemroot\System32\WindowsPowerShell\v1.0"
}

function User-Name { [Environment]::Username }

function Host-Name { [Environment]::MachineName }

function User-Location { $(Get-Location).Path.Replace($env:userprofile, "~") }

function Write-Status
{
    if (Get-Command Write-VcsStatus -ErrorAction SilentlyContinue) { Write-VcsStatus }
}

function prompt
{
    Write-Host
    Write-Host "$(User-Name)@$(Host-Name)" -NoNewline -ForegroundColor Green
    Write-Host " $(User-Location)" -NoNewline
    Write-Status
    Write-Host
    return "$ "
}

Set-Home
Set-Location $env:userprofile
$env:path = "$(Local-Path);$env:path"
