# Set-ExecutionPolicy RemoteSigned -- run this before executing this script

function Main
{
    Install-Chocolatey
    "========================"
    Install-Git
    "========================"
    Install-PowershellProfile
    "========================"
}

function Install-Chocolatey
{
    [Environment]::SetEnvironmentVariable("ChocolateyInstall", "$env:systemdrive\Vendor\chocolatey", "User")
    [Environment]::SetEnvironmentVariable("ChocolateyBinRoot", "$env:systemdrive\Vendor", "User")
    [Environment]::SetEnvironmentVariable("chocolatey_bin_root", "Vendor", "User")

    $env:ChocolateyInstall = [Environment]::GetEnvironmentVariable("ChocolateyInstall", "User")
    $env:ChocolateyBinRoot = [Environment]::GetEnvironmentVariable("ChocolateyBinRoot", "User")
    $env:chocolatey_bin_root = [Environment]::GetEnvironmentVariable("chocolatey_bin_root", "User")

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