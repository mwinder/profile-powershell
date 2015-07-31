
function New-Machine
{
    Install-SublimeProfile

    Set-GitConfiguration

    choco install --confirm 7zip
    choco install --confirm cmder
    choco install --confirm gitextensions
    choco install --confirm nodejs
    choco install --confirm sublimetext3
    choco install --confirm sysinternals
    choco install --confirm winmerge

    Install-PsGet
    Install-Module posh-git
    Install-Module posh-npm
}

function Install-SublimeProfile($sublime_profile = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $sublime_profile "$env:appdata\Sublime Text 3"
}

function Set-GitConfiguration
{
    git config --global user.name "Matthew Winder"
    git config --global user.email "@mwinder"
    git config --global core.editor "subl"
    git config --global core.autocrlf false
    git config --global push.default "simple"
    git config --global credential.helper "wincred"
    git config --global ghfw.disableverification true
}

function Install-PsGet
{
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

function Install-NpmPackages
{
    npm install -g gulp
    npm install -g serve
}

function Install-ModuleFromGit($url)
{
    Push-Location
    Set-Location $env:userprofile\Documents\WindowsPowershell\Modules
    git clone $url
    Pop-Location
}


### Utility settings functions ###

function Hide-OneDrive
{
    Set-ItemProperty "HKCU:\Software\Classes\CLSID\{8E74D236-7F35-4720-B138-1FED0B85EA75}\ShellFolder" -Name Attributes -Value 0
}