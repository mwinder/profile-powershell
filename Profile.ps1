
Import-Module Environment

Set-Alias code  "$env:localappdata\Code\bin\code"
Set-Alias emacs "$env:localappdata\Emacs\bin\runemacs"

function Local-Path
{
    ";.\node_modules\.bin"
}

function User-Path
{
    Include "$env:userprofile\.gem\ruby\*\bin" | `
    Include "$env:userprofile\.dnx\bin" | `
    Include "$env:localappdata\Programs" | `
    Include "$env:userprofile\AppData\Roaming\npm"
}

function Global-Path
{
    Include "$env:systemroot\Microsoft.NET\Framework64\v4.0.30319" | `
    Include "$env:programfiles\Microsoft SQL Server\120\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\110\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\100\Tools\Binn" | `
    Include "$env:programfiles\nodejs" | `
    Include "$env:programfiles\Sublime Text 3" | `
    Include "$env:programfiles\TortoiseHg" | `
    Include "$env:programfiles (x86)\Git\cmd" | Include "$env:programfiles (x86)\Git\bin" | `
    Include "$env:programdata\chocolatey\bin" | `
    Include "$env:systemdrive\HashiCorp\Vagrant\bin" | `
    Include "$env:systemdrive\HashiCorp\Packer" | `
    Include "$env:systemdrive\Tools\go\bin" | `
    Include "$env:systemdrive\Tools\python" | Include "$env:systemdrive\Tools\python\scripts" | `
    Include "$env:systemdrive\Tools\ruby*\bin" | `
    Include "$env:systemdrive\Tools\sysinternals"
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
