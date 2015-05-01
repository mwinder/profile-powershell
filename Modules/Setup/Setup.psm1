
function New-Machine
{
    Install-PsGet
    Install-SublimeProfile
    Install-Shortcuts

    Set-GitConfiguration

    choco install --confirm 7zip
    choco install --confirm cmder
    choco install --confirm gitextensions
    choco install --confirm nodejs
    choco install --confirm sublimetext3
    choco install --confirm sysinternals
    choco install --confirm winmerge

    Install-Module posh-git
    Install-Module posh-npm
}

function Install-PsGet
{
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

function Install-SublimeProfile($sublime_profile = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $sublime_profile "$env:appdata\Sublime Text 3"
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

function Set-DefaultGitIgnores
{
"bin/
obj/
*.user
*.suo" | Out-File -encoding utf8 .gitignore
}


### Utility settings functions ###

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