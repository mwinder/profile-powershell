
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
    choco install --confirm winscp --notsilents
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

function Install-FromGitRepository($repository, $target)
{
    rm $target -Recurse -ErrorAction SilentlyContinue
    git clone $repository $target
}

function Install-ProgramsLocal($repository = "https://github.com/mwinder/programs-local.git")
{
    Install-FromGitRepository $repository "$env:localappdata\Programs"
}

### Profiles ###

function Install-ProfileAtom($repository = "https://github.com/mwinder/atom-profile.git")
{
    git clone $repository "$env:userprofile\.atom"
}

function Install-ProfileEmacs($repository = "https://github.com/mwinder/emacs-profile.git")
{
    git clone $repository "$env:userprofile\.emacs.d"
}

function Install-ProfileSublime($repository = "https://github.com/mwinder/sublime-profile.git")
{
    git clone $repository "$env:appdata\Sublime Text 3"
}

function Install-ProfileVsCode($repository = "https://github.com/mwinder/vscode-profile.git")
{
    git clone $repository "$env:appdata\Code"
}
