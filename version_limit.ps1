#This script should check if major and minor version is enabled; if yes, then set a limit and update the list.
#This script executes on the entire site collection, so subsites will be affected.


#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$url=Read-Host “Please enter site collection URL”

  #Define the URL of the application of which the library resides.
  $SPsiteCollection = New-Object Microsoft.SharePoint.SPSite($url)

    #Loop through all Webs in the Site Collection  
    foreach($SPweb in $SPsiteCollection.AllWebs)   
    {  
        #Loop through all lists libraries in web
   	foreach ($SPlist in $SPweb.Lists)
       	{  
  	   #If versioning is enabled; excludes SPListTemplateType items with "catalog" such as master page gallery and list template gallery
	   if($SPlist.EnableVersioning -eq $true -and $SPlist.BaseTemplate -notmatch "Catalog")
           {
   	      #Write to screen what item is affected
	      write-host "Processing: " $SPlist.title 

                #Set the major version limit
		$SPlist.MajorVersionLimit = 2;

		  #if minor version is enabled
		  if($SPlist.EnableMinorVersions -eq $true) 
		  {
		    #set the minor version limit
		    $SPlist.MajorWithMinorVersionsLimit = 1; 

   # To Disable Versioning use: $SPlist.EnableVersioning=$false
   # To Enable Minorversion: $SPlist.EnableMinorVersions = $true;
   		
		 }
 	       #update list for changes to take affect	
               $SPlist.Update();
            }
         }  
     } 

$SPsiteCollection.dispose()
