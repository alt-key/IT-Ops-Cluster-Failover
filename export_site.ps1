#this script will export a SharePoint site. Enter the URL and full backup location path when prompted. 
#this script includes user security, does not compress data. Verbose means all executions will read out to the user.
#All versions will be exported.



#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Please Enter Site Collection URL to Export”
$backup = Read-Host “Please Enter Full Backup Location File Path. Ex: E:\Backups\Site.cmp”



Export-SPWeb -Identity $url -Path $backup -IncludeUserSecurity -NoFileCompression -includeversions "All" -Verbose


 