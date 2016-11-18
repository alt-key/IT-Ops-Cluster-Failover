#Visual upgrade from 2007 to 2010
#update site collection URL


#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


$site = Get-SPSite https://team.ksbe.edu/sites/PD
$site.VisualUpgradeWebs()