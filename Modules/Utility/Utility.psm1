
function New-Junction([string]$name, [string]$target)
{
    if (-not (Test-Path $target)) {
        return
    }

    cmd /c mklink /j $name $target
}

function New-Shortcut([string]$name, [string]$target)
{
    if (-not (Test-Path $target)) {
        return
    }

    $shell = New-Object -comObject WScript.Shell
    $shortcut = $shell.CreateShortcut($name)
    $shortcut.TargetPath = $target
    $shortcut.Save()
}

function Which([string]$cmd)
{
    Get-Command -ErrorAction SilentlyContinue $cmd | Select -ExpandProperty Definition
}