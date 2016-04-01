1. Run `Set-ExecutionPolicy RemoteSigned`
2. Run in Powershell as Admin:
```
(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mwinder/profile-powershell/master/install.ps1") | iex
```
