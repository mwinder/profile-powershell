# Set-ExecutionPolicy RemoteSigned -- run this before executing this script

function Main
{
    Install-Chocolatey
    Install-Git
    Install-PowershellProfile
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
}

function Install-Git
{
    choco install git
    $env:path += ";$env:programfiles (x86)\Git\bin"
}

function Install-PowershellProfile($powershell_profile = "https://github.com/mwinder/powershell-profile.git")
{
    git clone $powershell_profile "$env:userprofile\Documents\WindowsPowershell"
}

& Main
