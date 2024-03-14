function Test-BrowserSupport {
    <#
        .SYNOPSIS
        Function to check browser support
    
        .DESCRIPTION
        This function will check what browser we can use in the main script
    
        .EXAMPLE
        Test-BrowserSupport -Browser "Chrome"

        .PARAMETER Browser
        What browser to check if we can run
    
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
		[Parameter(Mandatory = $false)]
		[String]$Browser= $Seleniumdrivermode
	)
    
    # Check if Edge and Chrome Installed
        $chrome = Test-SoftwareInstalled -SoftwareName "Google Chrome"
        $edge = Test-SoftwareInstalled -SoftwareName "Microsoft Edge"
        $loggedInUsers = Get-LoggedInUser
        # Check if Edge can be used
        if($edge.installed -eq $true) {
            if (($loggedInUsers = Get-LoggedInUser) -eq $false) {
                Write-Host "No user logged in cannot run Edge without user logged in"
                $edgesupport = $false
            } else{
                $edgesupport = $true
            }
        }

    if ($Browser -eq "Edge") {
        if($edgesupport -eq $true){
            return $true
        } else {
            Write-Host "Microsoft Edge not installed, trying Chrome support"
            if($chrome.installed -eq $true) {
                Write-Host "Defaulting to Chrome support"
                Set-Variable Seleniumdrivermode -Value "Chrome" -Scope Global -Force
                return $true
            } else {
                Write-Host "Google Chrome not installed"
                return $false
            }
        }
    }

    if ($Browser -eq "Chrome"){
        if($chrome.installed -eq $true) {
            return $true
        } else {
            Write-Host "Google Chrome not installed trying Edge support"
            if($edgesupport -eq $true){
                Set-Variable Seleniumdrivermode -Value "Edge" -Scope Global -Force
                return $true
            } else {
                if (($loggedInUsers = Get-LoggedInUser) -eq $false) {
                    Write-Host "No user logged in cannot run Edge without user logged in"
                    return $false
            } else {
                Write-Host "Microsoft Edge not installed"
            }
        }
    }
}
}