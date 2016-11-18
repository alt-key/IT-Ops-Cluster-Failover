if((Get-PSSnapin | Where {$_.Name -eq "Microsoft.SharePoint.PowerShell"}) -eq $null)

{

    Add-PSSnapin Microsoft.SharePoint.PowerShell;

}


$web  = Get-SPWeb https://team.ksbe.edu/sites/SystemsLibrary/SystemSupport
$list = $web.Lists["Applications List"] 
$csvFile = "E:\Admin\SharePoint_Reports\SPSite_VersionHistory.csv" 

function GetFieldValue([Microsoft.SharePoint.SPField]$field, [Microsoft.SharePoint.SPListItemVersion]$currentVersion) 
{ 
    if(($field.Type -eq "User") -and ($currentVersion[$field.Title] -ne $null)) 
    { 
        $newUser = [Microsoft.SharePoint.SPFieldUser]$field; 
        $fieldStr = $newUser.GetFieldValueAsText($currentVersion[$field.Title]) 
        $fieldStr = "$($field.Title): $fieldStr" 
    } 
    elseif(($field.Type -eq "Lookup") -and ($currentVersion[$field.Title] -ne $null)) 
    { 
        $newLookup = [Microsoft.SharePoint.SPFieldLookup]$field; 
        $fieldStr = $newLookup.GetFieldValueAsText($currentVersion[$field.Title]) 
        $fieldStr = "$($field.Title): $fieldStr" 
    } 
    elseif(($field.Type -eq "ModStat") -and ($currentVersion[$field.Title] -ne $null)) 
    { 
        $newModStat = [Microsoft.SharePoint.SPFieldModStat]$field; 
        $fieldStr = $newModStat.GetFieldValueAsText($currentVersion[$field.Title]) 
        $fieldStr = "$($field.Title): $fieldStr" 
    } 
    else 
    {                             
        $fieldStr = "$($field.Title): $($currentVersion[$field.Title])" 
    } 
    return $fieldStr 
}      
 
#Create/overwrite csv file, add headers: 
Set-Content -Path $csvFile -Value ",No.,Modified,Modified By, Size, Comment`n" 
 
foreach($item in $list.Items) 
{ 
    $versions = $item.Versions 
    $versionStr = "$($item["Title"])`n" 
     
    for($i = 0; $i -lt $versions.Count; $i++) 
    { 
        $currentVersion = $versions[$i] 
        $checkInComment = $item.File.Versions[$item.File.Versions.Count - $i].CheckInComment 
        if($i -eq 0) 
        { 
            $fileSize = $item.File.Length 
        } 
        else 
        { 
            $fileSize = $item.File.Versions[$item.File.Versions.Count - $i].Size 
        } 
        if($fileSize -lt 1MB) 
        { 
            $fileSize = "{0:N1}" -f ($fileSize / 1KB) + " KB" 
        } 
        else 
        { 
            $fileSize = "{0:N1}" -f ($fileSize / 1MB) + " MB" 
        } 
        $modifiedTime = $web.RegionalSettings.TimeZone.UTCToLocalTime($currentVersion.Created) 
        # CSV formatting: escape double quotes allow quotations, new line and commas within cell. Do not use space between comma and double quote escapes due to csv formating. 
        $versionStr += ",$($currentVersion.VersionLabel),$($modifiedTime),""$($currentVersion.CreatedBy.User.DisplayName)"",""$($fileSize)"",""$($checkInComment)"",`n" 
 
        if($i -lt ($versions.Count - 1)) 
        { 
            # If more than one version: 
            $previousVersion = $versions[$i+1] 
            foreach($field in $currentVersion.Fields) 
            { 
                if(($field.ShowInVersionHistory -eq $true) -and ($currentVersion[$field.Title] -ne $previousVersion[$field.Title]) -and ($currentVersion[$field.Title] -ne "<div></div>")) 
                { 
                    $fieldStr = GetFieldValue $field $currentVersion 
                    $versionStr +=",,""$fieldStr""`n" 
                } 
            } 
        } 
        else 
        { 
            # If first version: 
            foreach($field in $currentVersion.Fields) 
            { 
                if(($field.ShowInVersionHistory -eq $true) -and ($currentVersion[$field.Title] -ne "<div></div>")) 
                { 
                    $fieldStr = GetFieldValue $field $currentVersion 
                    $versionStr +=",,""$fieldStr""`n" 
                } 
            } 
        } 
    } 
    #Append to file: 
    Add-Content -Path $csvFile -Value $versionStr 
} 
 
$web.Dispose() 