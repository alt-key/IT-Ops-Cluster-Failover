#this script will move a SharePoint site collection from source content database to destination content database.
#Enter the Site Collection URL, source content db and target content db


#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url= Read-Host “Please Enter Site Collection URL to Move”
$destination = Read-Host “Please Enter Destination Content Database. Ex: moss_team_content_sites_013”

Move-SPSite $url -DestinationDatabase $destination


 