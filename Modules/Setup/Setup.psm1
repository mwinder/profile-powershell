
function New-Machine
{
    Install-PsGet
    Install-Module posh-git
    Install-Module posh-npm
    Install-SublimeProfile
    Install-Shortcuts

    Set-GitConfiguration

    choco install 7zip
    choco install cmder
    choco install gitextensions
    choco install nodejs.install
    choco install sublimetext3
    choco install sumatrapdf
    choco install sysinternals
    choco install virtualbox
    choco install winmerge
    choco install winscp
}

function Install-PsGet
{
    "Setting up PsGet..."
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    "========================"
}

function Install-Packages
{
    param(
        [switch]$core = $false,
        [switch]$dev = $false,
        [switch]$optional = $false,
        [switch]$git = $false,
        [switch]$mercurial = $false,
        [switch]$node = $false,
        [switch]$office = $false)

    # Suggested packages:
    #
    # choco install googlechrome
    # choco install skype
    # choco install VisualStudio2013Professional

    if ($core) {
        choco install 7zip
        choco install consolez
        choco install notepad2
        choco install putty.install
        choco install sublimetext3
        choco install sumatrapdf
        choco install sysinternals
        choco install winmerge
    }

    if ($dev) {
        choco install curl
        choco install fiddler4
        choco install hxd
        choco install ilspy
        choco install nuget.commandline
        choco install python
        choco install ruby
    }

    if ($optional) {
        choco install fastglacier
        choco install handbrake
        choco install truecrypt
        choco install vlc
        choco install winscp
    }

    if ($git) {
        choco install git
        choco install gitextensions
        Install-Module posh-git
    }

    if ($mercurial) {
        choco install tortoisehg
        Install-Module posh-hg
    }

    if ($node) {
        choco install nodejs.install
        Install-Module posh-npm
    }

    if ($office) {
        choco install libreoffice
    }
}

function Install-Shortcuts
{
    New-Shortcut "$env:userprofile\Links\Home.lnk"       "$env:userprofile"
    New-Shortcut "$env:userprofile\Links\Desktop.lnk"    "$env:userprofile\Desktop"
    New-Shortcut "$env:userprofile\Links\Source.lnk"     "$env:userprofile\Source"
    New-Shortcut "$env:userprofile\Links\Downloads.lnk"  "$env:userprofile\Downloads"
    New-Shortcut "$env:userprofile\Links\Powershell.lnk" "$env:userprofile\Documents\WindowsPowershell"
    New-Shortcut "$env:userprofile\Links\AppData.lnk"    "$env:userprofile\AppData"
    New-Shortcut "$env:userprofile\Links\Tools.lnk"      "$env:userprofile\Tools"
    "Done."
}

function Install-SublimeProfile($sublime_profile = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $sublime_profile "$env:appdata\Sublime Text 3"
}

function Install-ModuleFromGit($url)
{
    Push-Location
    Set-Location $env:userprofile\Documents\WindowsPowershell\Modules
    git clone $url
    Pop-Location
}

function Install-NpmPackages
{
    npm install -g gulp
    npm install -g serve
}

function Set-GitConfiguration
{
    git config --global user.name "Matthew Winder"
    git config --global user.email "@mwinder"
    git config --global core.editor subl
    git config --global core.autocrlf false
    git config --global push.default simple
}

function Set-ConfigPaths
{
    # IIS Express
    #New-Item         HKCU:\Software\Microsoft\IISExpress
    #Set-ItemProperty HKCU:\Software\Microsoft\IISExpress -Name CustomUserHome -Value $env:appdata\IISExpress
    # Fiddler
    Set-ItemProperty HKCU:\Software\Microsoft\Fiddler2   -Name UserPath       -Value $env:appdata\Fiddler
}

function Hide-OneDrive
{
    Set-ItemProperty "HKCU:\Software\Classes\CLSID\{8E74D236-7F35-4720-B138-1FED0B85EA75}\ShellFolder" -Name Attributes -Value 0
}
