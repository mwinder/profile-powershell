
function New-BaseSystem
{
    Install-Chocolatey
    choco install --confirm 7zip
    choco install --confirm gitextensions --notsilent --ignoredependencies
    choco install --confirm kdiff3
    choco install --confirm nodejs
    choco install --confirm sublimetext3
    choco install --confirm sysinternals
    choco install --confirm visualstudio2015community --notsilent
    choco install --confirm winmerge --notsilent
    choco install --confirm winscp --notsilent

    Install-PsGet
    Install-Module posh-git
    Install-Module posh-npm
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
    choco feature enable -name=allowGlobalConfirmation
}

function Install-ChocolateyPackage($package, [switch]$interactive = $false)
{
    if ($interactive) {
        choco install $package --confirm --notsilent
    }
    else {
        choco install $package --confirm
    }
}

function Install-PsGet
{
    (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

function Install-ProgramsLocal($repository = "https://github.com/mwinder/programs-local.git")
{
    $target = "$env:localappdata\Programs"
    rm -Recurse -ErrorAction SilentlyContinue $target
    git clone $repository $target
}

### Profiles ###

function Install-AtomProfile($atom_profile = "https://github.com/mwinder/atom-profile.git")
{
    git clone $atom_profile "$env:userprofile\.atom"
}

function Install-EmacsProfile($emacs_profile = "https://github.com/mwinder/emacs-profile.git")
{
    git clone $emacs_profile "$env:userprofile\.emacs.d"
}

function Install-SublimeProfile($sublime_profile = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $sublime_profile "$env:appdata\Sublime Text 3"
}

function Install-VsCodeProfile($vscode_profile = "https://github.com/mwinder/vscode-profile.git")
{
    git clone $vscode_profile "$env:appdata\Code"
}
