#This script will empty the end user and site collection recycle bins for the site collection and all subsites

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


$siteUrl = Read-Host "Enter Site URL"
 
$rootSite = New-Object Microsoft.SharePoint.SPSite($siteUrl)
$spWebApp = $rootSite.WebApplication
 
foreach($site in $spWebApp.Sites)
{
    foreach($siteAdmin in $site.RootWeb.SiteAdministrators)
    {
        Write-Host "$($siteAdmin.ParentWeb.Url) - $($siteAdmin.DisplayName)"
    }
    $site.Dispose()
}
$rootSite.Dispose()