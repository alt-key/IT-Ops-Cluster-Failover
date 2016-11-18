#Original code from http://rahulrashu.blogspot.com/2012/08/powershell-script-to-list-of-documents.html
#Modifications by Aline Tran: variable name, reporting format, unique report name

[System.Reflection.Assembly]::Load(“Microsoft.SharePoint, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c”)

function CheckedOutItems()
{
    $url=Read-Host “Please Enter In Site Url”
    $site = New-Object Microsoft.SharePoint.SPSite($url)
    $webs = $site.AllWebs
    
    foreach($web in $webs)
    {
        $listCollections=$web.Lists
        foreach($list in $listCollections)
        {
            if($list.BaseType.ToString() -eq “DocumentLibrary”)
            {
                $dList=[Microsoft.SharePoint.SPDocumentLibrary]$list
                $items = $dList.Items
                $files = $dList.CheckedOutFiles
                foreach($file in $files)
                {
                    $doclibry = $file.DirName.Substring($web.ServerRelativeUrl.Length)
                    “Site:`t” + $web.Url + “`nDoc Library:`t” +  $doclibry + “`nFile Name:`t” + $file.LeafName + “`nChecked Out By:`t” + $file.CheckedOutBy.Name + “`nLast Modified:`t” + $file.TimeLastModified.ToString() + “`n `n”   >> "E:\Admin\SharePoint_Reports\SPSite_NoVersion $(get-date -f yyyy-MM-dd).csv"
                }
            }
        }
    $web.Dispose()
    }
$site.Dispose()
}

CheckedOutItems