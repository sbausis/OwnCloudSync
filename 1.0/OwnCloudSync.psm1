<# 
    .SYNOPSIS 
        
 
    .DESCRIPTION 
		
 
    .NOTES 
        Name: OwnCloudSync.psm1 
        Author: Baur Simon 
        Created: 19 Feb 2017 
        Version History 
            Version 1.0 -- 19 Feb 2017 
                -Initial Version 
#>
#region Private Functions

#endregion Private Functions

#region Public Functions

################################################################################

function OwnCloudSync($Server, $User, $Password, $RemoteFolder, $LocalFolder) {
	Try {
		#If (![System.IO.File]::Exists($File)) { Write-Warning "Local Folder does not exist ... $LocalFolder"; throw }
		If(!(Test-Path -Path $LocalFolder )){ New-Item -Force -ItemType directory -Path $LocalFolder }
		$OwnCloudCMD=$PSScriptRoot + "\OwnCloud\owncloudcmd.exe"
		$ServerURL = $Server + "/remote.php/webdav/" + $RemoteFolder
		cmd.exe /C $OwnCloudCMD --user $User --password $Password --trust --non-interactive $LocalFolder $ServerURL
	} Catch {
		Write-Warning "Failed to Sync OwnCloud Folder"
	}
}

function OwnCloudSync-WithCredentials($Server, $Cred, $RemoteFolder, $LocalFolder) {
	Try {
		#If (![System.IO.File]::Exists($File)) { Write-Warning "Local Folder does not exist ... $LocalFolder"; throw }
		If(!(Test-Path -Path $LocalFolder )){ New-Item -Force -ItemType directory -Path $LocalFolder }
		$OwnCloudCMD=$PSScriptRoot + "\OwnCloud\owncloudcmd.exe"
		$ServerURL = $Server + "/remote.php/webdav/" + $RemoteFolder
		cmd.exe /C $OwnCloudCMD --user ($Cred.Username) --password ($Cred.GetNetworkCredential().Password) --trust --non-interactive $LocalFolder $ServerURL
	} Catch {
		Write-Warning "Failed to Sync OwnCloud Folder"
	}
}

################################################################################

#endregion Public Functions

#region Aliases

#New-Alias -Name GetAvailableVersionsForRestore -Value Altaro-GetAvailableVersionsForRestore

#endregion Aliases

#region Export Module Members

Export-ModuleMember -Function OwnCloudSync
Export-ModuleMember -Function OwnCloudSync-WithCredentials

#Export-ModuleMember -Alias APIService

#endregion Export Module Members
