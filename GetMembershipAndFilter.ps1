$List=$null
#$group=$null
$getmembervar=$null
$filteredresults=$null

[System.Collections.ArrayList]$List = @(
                                        Group = $List[0]
                                        AllMembers = @($List[1] | Out-String).Trim() 
                                        FilteredResult = @($List[2]  | Out-String).Trim()  
                                        )

$output="results.txt"


 foreach($_ in get-content ingestion.csv) {
write-output $_
<#
$arrline= $_.split(",")
$group= $arrline[0]
#>

$getmembervar=(Get-DistributionGroupMember -identity $_ ).PrimarySmtpAddress
$List.Add($_)
$filteredresults=$getmembervar  # | where {_.PrimarySmtpAddress -match "@filter1" -or "@filter2"}
$List.Add($filteredresults)
$List.Add($getmembervar)

<##variable sanitation 
#$group=$null
$filteredresults=$null
#>

<#
write-output "$List.$_" + "$List.$getmembervar" + "$List.$filteredresults"  
"$List.$_" + "$List.$getmembervar" + "$List.$filteredresults"  -join "," | out-file -filepath $output
$List[0] + $List[1] + $List[2]  -join "," | out-file -filepath longshot.txt
-join "," 
#>
$List | export-csv  test2.csv -NoTypeInformation
$List -join ","  | out-file -filepath $output

}
write-output $List | fl
