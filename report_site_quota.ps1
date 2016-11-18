#Original from Jason Himmelstein of sharepointlonghorn.com on 07/18/2011
#Modified by Aline Tran - Target specific Web Application; Unique File Name Output; Display all sites

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}

#variables used later for reporting
$t = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.quotatemplates 
$tFound = $false

#target specific web application; returns all sites
$webApp = Get-SPWebApplication https://team.ksbe.edu | %{$_.Sites} | Get-SPSite -Limit ALL

#output for report goes to c:\admin\reports...update path when in prod
$webApp | fl Url, @{n="Storage Used (MB)";e={[int]($_.Usage.Storage/1MB)}},
@{n="Warning Issued (MB)"; e={[int](($_.Quota).StorageWarningLevel/1MB)}},
@{n="Site Size Quota (MB)"; e={[int](($_.Quota).StorageMaximumLevel/1MB)}}, 
@{n="Quota Name"; e={ foreach($qt in $t){if($qt.QuotaId -eq [int](($_.Quota).QuotaID)){$qt.Name; $tFound = $true}} if($tFound -eq $false){"Custom Template"}$tFound=$false;}} >> "E:\Admin\SharePoint_Reports\SPSite_Quota_Report $(get-date -f yyyy-MM-dd).txt"

#clear variables
if($parent) {$webApp.Dispose(); $t.Dispose()}
