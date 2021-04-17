$List=$null
$group=$null
$getmembervar=$null
$filteredresults=$null

[System.Collections.ArrayList]$List = @()
$input= get-content ingestion.csv
$output=results.txt


foreach($_ in $input) {

$arrline= $_.split(",")
$group= $_.[0]
$getmembervar=(Get-DistributionGroupMember -identity $group[0] ).PrimarySTMPAddress
$List.Add($group)
$filteredresults= $getmembervar | where {_.PrimarySTMPAddress -match "@filter1" -or "@filter2"}
$List.Add($filteredresults)

##variable sanitation 
$group=$null
$filteredresults=$null


$List -join "," | tee-object -filepath $output

}

write-output $List | fl
