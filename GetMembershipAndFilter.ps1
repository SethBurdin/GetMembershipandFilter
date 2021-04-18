$filter1="taco"
$filter2="m@"



$List=$null

$GetMemb=$null

$filteredresults=$null
$Report=$null


[System.Collections.ArrayList]$List = @()

$output="Hopethishelps.csv"


foreach($_ in get-content ingestion.csv) {
Write-Progress -Activity "Searching in Group $_"

<#
$arrline= $_.split(",")
$group= $arrline[0]
#>
$List.Add($_)
$GetMemb=(Get-DistributionGroupMember -identity $_ ).PrimarySmtpAddress
Write-Progress -Activity "Applying the Filters for $_"
#write-output ($GetMemb | select-String -Pattern "$filter1" )
$filteredresults=$GetMemb | select-String -List $filter1, $filter2

#{$_.PrimarySmtpAddress -like "$filter1"-or "$filter2"} 
$List.Add($filteredresults)
$List.Add($GetMemb)



<# Playing around with it
write-output "$List.$_" + "$List.$GetMemb" + "$List.$filteredresults"  
"$List.$_" + "$List.$GetMemb" + "$List.$filteredresults"  -join "," | out-file -filepath $output
$List[0] + $List[1] + $List[2]  -join "," | out-file -filepath longshot.txt
-join "," 
#>

$Report = [PSCustomObject]@{
    Group     = $List[0]
    Members = $GetMemb -join ","
    TargetUserBase    = $filteredresults -join ","
}
##variable sanitation 
$List[0]=$null
$filteredresults=$null
$GetMemb=$null


#>

$Report  | export-csv $output -notype


}
write-output $Report 
