
Import-Module Environment

Set-Alias emacs "$env:localappdata\Emacs\bin\runemacs"

function Local-Path
{
    ";.\node_modules\.bin"
}

function User-Path
{
    Include "$env:userprofile\.gem\ruby\*\bin" | `
    Include "$env:userprofile\.dnx\bin" | `
    Include "$env:userprofile\AppData\Roaming\npm" | `

    Include "$env:localappdata\Programs" | `

    Include "$env:programdata\Chocolatey\bin" | `

    Include "$env:programfiles\Git\bin" | `
    Include "$env:programfiles\Git\usr\bin" | `

    Include "$env:programfiles (x86)\MSBuild\14.0\Bin" | `
    Include "$env:programfiles (x86)\MSBuild\12.0\Bin" | `

    Include "$env:programfiles\nodejs" | `

    Include "$env:programfiles\Microsoft SQL Server\120\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\110\Tools\Binn" | `
    Include "$env:programfiles\Microsoft SQL Server\100\Tools\Binn" | `

    Include "$env:programfiles (x86)\Microsoft VS Code" | `

    Include "$env:programfiles\Sublime Text 3" | `

    Include "$env:systemdrive\Tools\ruby*\bin"

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
Set-ProcessPath
