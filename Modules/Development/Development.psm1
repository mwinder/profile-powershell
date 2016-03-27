
function Set-VisualStudioConfiguration
{
    ## Start with 'Web Development (Code Only)'

    if (!$dte) {
        throw "Script must be run in VS Package Manager Console"
    }

    ## Commands
    $dte.Commands.Item("File.Close").Bindings = "Global::Ctrl+W"                        # Needs assigning
    $dte.Commands.Item("File.CloseAllButThis").Bindings = "Global::Ctrl+Shift+W"
    $dte.Commands.Item("Edit.NavigateTo").Bindings = "Global::Ctrl+P"
    $dte.Commands.Item("Edit.SelectCurrentWord").Bindings = "Global::Ctrl+D"
    $dte.Commands.Item("Build.BuildSelection").Bindings = "Global::Ctrl+B"
    $dte.Commands.Item("Build.BuildSolution").Bindings = "Global::Ctrl+Shift+B"
    $dte.Commands.Item("View.SolutionExplorer").Bindings = "Global::Ctrl+\"             # Needs assigning
    $dte.Commands.Item("View.PackageManagerConsole").Bindings = "Global::Ctrl+Alt+C"
    $dte.Commands.Item("SQL.TSqlEditorExecuteQuery").Bindings = "Microsoft SQL Server Data Tools, T-SQL Editor::F5"

    ## Settings
    ($dte.Properties("Environment", "Startup") | where {$_.Name -eq "OnStartUp" } ).Value = 4

    ($dte.Properties("Environment", "ProjectsAndSolution") | where { $_.Name -eq "ProjectsLocation" } ).Value = $env:userprofile + "\Source"
    ($dte.Properties("Environment", "ProjectsAndSolution") | where { $_.Name -eq "TrackFileSelectionInExplorer" } ).Value = $true
    ($dte.Properties("Environment", "ProjectsAndSolution") | where { $_.Name -eq "ShowOutputWindowBeforeBuild" } ).Value = $true

    ($dte.Properties("FontsAndColors", "TextEditor") | where { $_.Name -eq "FontSize" }).Value = 11

    ($dte.Properties("TextEditor", "AllLanguages") | where {$_.Name -eq "ShowLineNumbers" } ).Value = $true
}

function Invoke-Build($projects = @("*.sln","*.csproj"))
{
    Get-ChildItem $projects -Recurse | foreach ($_) {
        Write-Host "----"
        Write-Host "## Building: $_ ##"
        MSBuild $_ /verbosity:minimal /nologo
        Write-Host "## Finished: $_ ##"
    }
}

function Remove-BuildFiles
{
    Get-ChildItem .\ -Include bin,obj -Recurse | foreach ($_) { Remove-Item $_.fullname -Force -Recurse }
}

function Reset-VisualStudio2015UserData
{
    & "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv" /ResetUserData
}

function Set-DefaultGitIgnores
{
"bin/
obj/
*.user
*.suo" | Out-File -encoding utf8 .gitignore
}