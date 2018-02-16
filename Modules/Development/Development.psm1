
function Set-VisualStudioConfiguration
{
    ## Start with 'Web Development (Code Only)'

    if (!$dte) {
        throw "Script must be run in VS Package Manager Console"
    }

    ## Commands
    $dte.Commands.Item("File.Close").Bindings = "Global::Ctrl+W"                        # Needs assigning
    $dte.Commands.Item("File.CloseAllButThis").Bindings = "Global::Ctrl+Shift+W"
    $dte.Commands.Item("Edit.MoveSelectedLinesUp").Bindings = "Text Editor::Ctrl+Shift+Up Arrow"
    $dte.Commands.Item("Edit.MoveSelectedLinesDown").Bindings = "Text Editor::Ctrl+Shift+Down Arrow"
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

function Set-GitConfig
{
    git config --global user.name "Matthew Winder"
    git config --global user.useConfigOnly true
    git config --global core.autocrlf true
    git config --global core.editor "subl -w --multiinstance"
    git config --global push.default "simple"
    git config --global ghfw.disableverification true
}

function Set-GitIgnoreVisualStudio
{
".vs/
bin/
obj/
packages/
*.user
*.suo" | Out-File -encoding utf8 .gitignore
}

## Build ##

function Invoke-Build($projects = @("*.sln","*.csproj"))
{
    Get-ChildItem $projects -Recurse | foreach ($_) {
        Write-Host "----"
        Write-Host "## Building: $_ ##"
        MSBuild $_ /verbosity:minimal /nologo
        Write-Host "## Finished: $_ ##"
    }
}

function Remove-BuildArtifacts
{
    Get-ChildItem .\ -Include bin,obj -Recurse | foreach ($_) { Remove-Item $_.fullname -Force -Recurse }
}
