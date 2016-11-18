#this script loops through all lists and libraries in a site and deletes all versions except for $versionstokeep most recent version (major or minor). 
#this script loops through subsites.

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}

#Get input from user
$url=Read-Host “Please Enter Site Collection URL”

#Define the URL of the application of which the library resides.
$SPsiteCollection = New-Object Microsoft.SharePoint.SPSite($url)

#Define the number of versions you wish to keep.
$versionsToKeep = 2;

#Loop through all Webs in the Site Collection  
foreach($SPweb in $SPsiteCollection.AllWebs)   
{  
  #loop through all lists and libraries in the site collection
  foreach ($SPlist in $SPweb.Lists)
  {
    #in the list or library, loop through items and delete extra versions
    foreach ($SPitem in $SPlist.Items)
    {
       $currentVersionsCount= $SPItem.Versions.count
       if($currentVersionsCount -gt $versionstoKeep)
          {
             for($i=$currentVersionsCount-1; $i -gt $versionstoKeep; $i--)
             {
                $SPItem.versions[$i].delete()
             }
          }
      }
   }
}

#clear variable
$SPsiteCollection.dispose()
 