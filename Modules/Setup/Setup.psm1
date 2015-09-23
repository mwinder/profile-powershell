
function New-Machine
{
    Install-Chocolatey
    choco install --confirm 7zip
    choco install --confirm gitextensions
    choco install --confirm kdiff3
    choco install --confirm nodejs
    choco install --confirm sublimetext3
    choco install --confirm sysinternals
    choco install --confirm winmerge

    Install-PsGet
    Install-Module posh-git
    Install-Module posh-npm

    Install-SublimeProfile
    Install-EmacsProfile
    Set-GitConfiguration
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
}

function Install-PsGet
{
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

function Install-SublimeProfile($sublime_profile = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $sublime_profile "$env:appdata\Sublime Text 3"
}

function Install-EmacsProfile($emacs_profile = "https://github.com/mwinder/emacs-profile.git")
{
    git clone $emacs_profile "$env:userprofile\.emacs.d"
}

function Install-VsCodeProfile($vscode_profile = "https://github.com/mwinder/vscode-profile.git")
{
    git clone $emacs_profile "$env:appdata\Code"
}

function Set-GitConfiguration
{
    git config --global user.name "Matthew Winder"
    git config --global user.email "@mwinder"
    git config --global core.autocrlf true
    git config --global core.editor "subl"
    git config --global push.default "simple"
    git config --global credential.helper "wincred"
    git config --global ghfw.disableverification true
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