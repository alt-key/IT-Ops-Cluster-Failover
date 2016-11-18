
#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#remove list view threshold
$web = Get-SPWeb https://team.ksbe.edu/sites/ISO/
$list = $web.Lists["Nessus Items"] 
$list.enablethrottling = $false 
$list.update() 
Write-Host $list.enablethrottling