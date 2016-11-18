#This script will get the SPUser object to rename and then move the old user account to the new one

#Add SharePoint Snapin if not using SharePoint's PowerShell Console
if ((Get-PSSnapin -Name Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue) -eq $null )
{
Add-PsSnapin Microsoft.SharePoint.PowerShell
}


$userA = Get-SPUser -web https://team.ksbe.edu -Identity "ksbe\pahilton"

Move-SPUser -Identity $userA -NewAlias "ksbe\pahilton"



