
function Set-Home($value = $env:userprofile)
{
    $env:home = $value
    [Environment]::SetEnvironmentVariable("Home", $value, "User")

    # HACK: Required to ensure ~ resolves to userprofile folder (not %HOMEDRIVE%%HOMEPATH%)
    (Get-PSProvider FileSystem).Home = $value
}

function Set-ProcessPath()
{
    $env:path = "$(Get-SystemPath);$(Get-UserPath);$(Local-Path)"
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
    $result = [Environment]::GetEnvironmentVariable("Path", "Process")
    if ($format) { return $env:path.Split(";") }
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