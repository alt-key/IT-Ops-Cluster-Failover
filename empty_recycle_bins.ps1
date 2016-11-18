#This script will empty the end user and site collection recycle bins for the site collection and all subsites

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}

#Get input from user
$url=Read-Host “Please enter site collection URL”

#Define the URL of the application of which the library resides.
$siteCollection = New-Object Microsoft.SharePoint.SPSite($url)


#empty end user & site collection recycle bins
$siteCollection.RecycleBin.DeleteAll();

#clear variable
$siteCollection.Dispose(); 
