#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#PARENT WEB
$parentWeb = “https://team.ksbe.edu/sites/lgimua2“;

#GET THE PARENT WEB
$web = Get-SPWeb $parentWeb

if($web) {
foreach($group in $web.SiteGroups){
if($group.Description -eq $null) {
Write-Host $group.Name
$group.Description = $group.Name
$group.Update()
}
}
}

#DISPOSE OF PARENT WEB
$web.Dispose()