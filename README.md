# EasyWarrantyCheck

## Synopsis

## Description
This module is a way to get Warranty details without API access to vendors
## Getting Started

### Prerequisites

### Installation

```powershell
$githubrepo  = "jayrodksmith/EasyWarrantyCheck"
$EasyWarrantyCheckrepo = "https://github.com/$githubrepo"
$releases = "https://api.github.com/repos/$githubrepo/releases"
$EasyWarrantyChecklatestversion = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name
$EasyWarrantyCheckExtractionPath = (Join-Path -Path "C:\Program Files\WindowsPowerShell\Modules\EasyWarrantyCheck" -ChildPath $EasyWarrantyChecklatestversion)
$EasyWarrantyCheckDownloadZip = ('{0}/archive/main.zip' -f $EasyWarrantyCheckrepo)
$EasyWarrantyCheckDownloadFile = ('{0}\EasyWarrantyCheck.zip' -f $ENV:Temp)
# Create the niaupdater folder if it doesn't exist 
    if (-not (Test-Path -Path $EasyWarrantyCheckExtractionPath)) {
        $null = New-Item -Path $EasyWarrantyCheckExtractionPath -ItemType Directory -Force
    } else {
        $null = Remove-Item -Recurse -Force -Path $EasyWarrantyCheckExtractionPath
        $null = New-Item -Path $EasyWarrantyCheckExtractionPath -ItemType Directory -Force
    }
Invoke-WebRequest -Uri $EasyWarrantyCheckDownloadZip -OutFile $EasyWarrantyCheckDownloadFile
Expand-Archive -Path $EasyWarrantyCheckDownloadFile -DestinationPath $EasyWarrantyCheckExtractionPath -Force
$extractedFolderPath = Join-Path -Path $EasyWarrantyCheckExtractionPath -ChildPath "EasyWarrantyCheck-Main"
# Move all files from the extracted folder to the root
Get-ChildItem -Path $extractedFolderPath | Move-Item -Destination $EasyWarrantyCheckExtractionPath
# Optional: Remove the empty extracted folder
Remove-Item -Path $extractedFolderPath -Force
Remove-Item -Path $EasyWarrantyCheckDownloadFile -Force
```

### Quick start
```powershell
Import-Module EasyWarrantyCheck

Get-Warranty
```
## Author
Jared Smith