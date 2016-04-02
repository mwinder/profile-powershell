
function Install-VisualStudio
{
    choco install --confirm visualstudio2015community --notsilent
}

function Install-Chocolatey
{
    (New-Object Net.WebClient).DownloadString("https://chocolatey.org/install.ps1") | iex
    choco feature enable -name=allowGlobalConfirmation
}

function Install-PackageFromChocolatey($package, [switch]$interactive = $false)
{
    $command = "choco install $package --confirm"
    if ($interactive) {
        $command += " --notsilent"
    }
    $command | iex
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

### Profile ###

function Install-ProfileAtom($repository = "https://github.com/mwinder/profile-atom.git")
{
    git clone $repository "$env:userprofile\.atom"
}

function Install-ProfileEmacs($repository = "https://github.com/mwinder/profile-emacs.git")
{
    git clone $repository "$env:userprofile\.emacs.d"
}

function Install-ProfileSublime($repository = "https://github.com/mwinder/profile-sublime.git")
{
    git clone $repository "$env:appdata\Sublime Text 3"
}

function Install-ProfileVsCode($repository = "https://github.com/mwinder/profile-vscode.git")
{
    git clone $repository "$env:appdata\Code"
}

function Install-ProfilePrograms($repository = "https://github.com/mwinder/profile-programs.git")
{
    Install-FromGitRepository $repository "$env:localappdata\Programs"
}
