
function Main
{
    Install-Chocolatey
    New-BaseSystem
    Install-ProfilePowershell
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
    choco feature enable -name=allowGlobalConfirmation
}

function New-BaseSystem
{
    choco install googlechrome

    choco install 7zip
    choco install sysinternals

    choco install sublimetext3

    choco install git --notsilent
    choco install gitextensions --notsilent
    choco install kdiff3 --notsilent
    choco install nodejs --notsilent
    choco install winmerge --notsilent
    choco install winscp --notsilent
}

function Install-ProfilePowershell($repository = "https://github.com/mwinder/powershell-profile.git")
{
    cd ~
    git clone $repository Documents\WindowsPowershell
}

Main
