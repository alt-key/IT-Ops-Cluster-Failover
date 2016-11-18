#This will Export the Library from the specified SharePoint site onto the SharePoint Server


#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Please Enter Site URL Where We Will Export The Doc Library. Do not include the Doc Library in the URL.”

$dclibry = Read-Host “Please Enter Name of Document Library as shown in the URL. Ex:Project Documents”

$backup = Read-Host “Please Enter Full Backup Location File Path and save the backup as cmp. Ex: E:\Backups\Site.cmp”


Export-SPWeb -Identity $url -path $backup -ItemUrl $dclibry -IncludeUserSecurity -NoFileCompression -includeversions "All" -Verbose