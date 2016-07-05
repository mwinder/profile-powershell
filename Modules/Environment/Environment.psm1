
function Set-Home($path = $env:userprofile)
{
    $env:home = $path
    [Environment]::SetEnvironmentVariable("Home", $path, "User")

    # Ensure ~ resolves to userprofile folder (not %HOMEDRIVE%%HOMEPATH% for example)
    (Get-PSProvider FileSystem).Home = $path
}

function Set-ProcessPath()
{
    $env:path = "$(Get-UserPath);$(Get-SystemPath)"
}

function Set-UserPath($path = $(User-Path), [switch]$yes = $false)
{
    $current = $(Get-UserPath)
    if ($path -eq $current)
    {
        "Already up to date"
        return
    }
    if (-not $yes)
    {
        Display-Warning $current $path
        return
    }
    [Environment]::SetEnvironmentVariable("Path", $path, "User")
}

function Set-SystemPath($path = $(System-Path), [switch]$yes = $false)
{
    $current = $(Get-SystemPath)
    if ($path -eq $current)
    {
        "Already up to date"
        return
    }
    if (-not $yes)
    {
        Display-Warning $current $path
        return
    }
    [Environment]::SetEnvironmentVariable("Path", $path, "Machine")
}

function Display-Warning($current, $replacement)
{
    "Rerun with -yes to set path..."
    "## Current ##"
    $current.Split(";")
    ""
    "## Replacement ##"
    $replacement.Split(";")
}

function Get-ProcessPath([switch]$format = $false)
{
    $result = $env:path
    if ($format) { return $result.Split(";") }
    return $result
}

function Get-UserPath([switch]$format = $false)
{
    $result = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($format) { return $result.Split(";") }
    return $result
}

function Get-SystemPath([switch]$format = $false)
{
    $result = [Environment]::GetEnvironmentVariable("Path", "Machine")
    if ($format) { return $result.Split(";") }
    return $result
}

function Add-UserPath($value)
{
    Set-UserPath -path "$(Get-UserPath);$value" -yes
}

Export-ModuleMember -function Add-*, Get-*, Set-*