
function Main
{
    Install-Chocolatey
    choco install googlechrome
    choco install git --notsilent

    git clone https://github.com/mwinder/powershell-profile.git "~\Documents\WindowsPowershell"
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
    choco feature enable -name=allowGlobalConfirmation
}

Main