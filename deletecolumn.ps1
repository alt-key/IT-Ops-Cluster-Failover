
#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}

$sourceWebURL = "https://team.ksbe.edu/sites/ITD/CASS/BugTracking"
$sourceList = "Bugs"
$sourceField = "Category Test2"

$web = Get-SPWeb $sourceWebURL
$list = $web.Lists[$sourceList]
$field = $list.Fields[$sourceField]
$field.AllowDeletion = “true”
$field.Sealed = “false”
$field.Delete()
$list.Update()
$web.Dispose()