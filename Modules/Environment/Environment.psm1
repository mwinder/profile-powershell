
function Set-Home($value = $env:userprofile)
{
    $env:home = $value
    [Environment]::SetEnvironmentVariable("Home", $value, "User")

    # HACK: Required to ensure ~ resolves to userprofile folder (not %HOMEDRIVE%%HOMEPATH%)
    (Get-PSProvider FileSystem).Home = $value
}

function Set-UserPath($path = $(User-Path), [switch]$confirm = $false)
{
    $current = $(Get-UserPath)
    if ($path -eq $current)
    {
        "Already up to date"
        return
    }
    if (-not $confirm)
    {
        Display-Warning $current $path
        return
    }
    [Environment]::SetEnvironmentVariable("Path", $path, "User")
}

function Set-MachinePath($path = $(System-Path) + $(Global-Path), [switch]$confirm = $false)
{
    $current = $(Get-MachinePath)
    if ($path -eq $current)
    {
        "Already up to date"
        return
    }
    if (-not $confirm)
    {
        Display-Warning $current $path
        return
    }
    [Environment]::SetEnvironmentVariable("Path", $path, "Machine")
}

function Display-Warning($current, $replacement)
{
    "Rerun with -confirm to set path..."
    "## Current ##"
    $current.Split(";")
    ""
    "## Replacement ##"
    $replacement.Split(";")
}

function Get-UserPath([switch]$format = $false)
{
    $result = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($format) { return $result.Split(";") }
    return $result
}

function Get-MachinePath([switch]$format = $false)
{
    $result = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($format) { return $result.Split(";") }
    return $result
}

function Add-Path([string]$target)
{
    $path = Get-Item $target -ErrorAction SilentlyContinue
    if (-not $path) {
        return $input
    }
    return "$input;$path"
}

Export-ModuleMember -function Set-*, Get-*, Add-*