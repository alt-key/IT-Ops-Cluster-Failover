#this script will import a SharePoint site. Enter the URL and full backup location path when prompted. 
#this script includes user security, does not compress data and is a verbose copy.



#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Enter Site Collection URL to import backup into”
$backup = Read-Host “Please Enter Full Backup Location File Path to import. Ex: E:\Backups\Site.cmp”


Import-SPWeb -Identity $url -Path $backup -Force -IncludeUserSecurity -NoFileCompression

