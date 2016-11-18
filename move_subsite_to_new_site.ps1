#this script will export a SharePoint site. Enter the URL and full backup location path when prompted. 
#this script includes user security, does not compress data. Verbose means all executions will read out to the user.
#All versions will be exported.



#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


#Get input from user
$sourceurl=Read-Host “Please Enter Subsite URL to Export”

#find out the subsite template 
$savetemplate = Get-SPWeb $sourceurl | Select-Object -Property WebTemplate, Configuration

#Let user see template
Write-Host "This is the subsite template: " $savetemplate

$sourcetemplate=Read-Host "From the subsite template, please enter the template code. Ex: STS#0"


$destinationsite=Read-Host “Please Enter NEW subsite URL to create the new subsite. Example: https://team.ksbe.edu/site/sitecollection/subsite”

$subsitename = Read-Host “Please Enter the NEW subsite Name. Example: IT Ops Project Page”

#make new subsite with the same template 
New-SPweb $destinationsite -Name $subsitename -Template $sourcetemplate

Write-Host "We will now export the subsite to a backup and then import that backup."
$backup = Read-Host “Please Enter a Full Backup Location File Path. Ex: E:\Backups\Site.cmp”


Export-SPWeb -Identity $sourceurl -Path $backup -IncludeUserSecurity -NoFileCompression -includeversions "All" -Verbose

Write-Host "We will now import the export."

Import-SPWeb $subsitename -Path $backup -Force

Write-Host "Script is complete. Please review the log in $backup \log"


 