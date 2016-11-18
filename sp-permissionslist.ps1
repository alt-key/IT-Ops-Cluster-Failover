#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Please Enter Site Collection URL”

#Define the URL of the application of which the library resides.
$SPsiteCollection = New-Object Microsoft.SharePoint.SPSite($url)


foreach($web in $SPsiteCollection.AllWebs)   
{  
format-list 
Get-SPUser -Web $web.url -Limit ALL |
select UserLogin, 
@{name=”Site”;expression={$web.url}},
@{name=”Explicit given roles”;expression={$_.Roles}}, 
@{name=”Roles given via groups”;expression={$_.Groups | %{$_.Roles}}},
Groups | format-list >> "E:\Admin\SharePoint_Reports\SP-Site-Permissions $(get-date -f yyyy-MM-dd).txt"

}

#clear variable
$SPsiteCollection.dispose()