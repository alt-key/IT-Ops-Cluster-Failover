#this script will backup a SharePoint site. Enter the URL and full backup location path when prompted. 



#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Please Enter Site Collection URL to Backup”
$backup = Read-Host “Please Enter Full Backup Location File Path. Ex: E:\Backups\Site.cmp”



Backup-SPSite -Identity $url -Path $backup 


 