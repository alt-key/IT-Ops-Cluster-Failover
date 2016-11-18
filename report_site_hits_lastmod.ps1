#Original from Jason Himmelstein of sharepointlonghorn.com on 07/18/2011
#Modified by Aline Tran - Target specific Web Application; Unique File Name Output; Display all sites; change data output

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#target specific web application; returns all sites
$webApp = Get-SPWebApplication https://team.ksbe.edu | %{$_.Sites} | Get-SPSite -Limit ALL


#output for report 
$webApp | fl Url, @{n="Primary SCA";e={($_.owner.name)}},
@{n="Secondary SCA"; e={($_.secondarycontact.name)}},
@{n="Hit Count"; e={[int]($_.usage.hits)}},
@{n="Space Used (MB)";e={[int]($_.Usage.Storage/1MB)}},
@{n="Created"; e={($_.rootweb.created.tolocaltime())}},
@{n="Last Modified";e={($_.LastContentModifiedDate.tolocaltime())}} >> "E:\Admin\SharePoint_Reports\SPSite_HitCount_Report $(get-date -f yyyy-MM-dd).txt"

#clear variables
if($parent) {$webApp.Dispose()}

