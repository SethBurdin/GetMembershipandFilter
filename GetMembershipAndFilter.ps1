$List=$null
$group=$null
$getmembervar=$null
$filteredresults=$null

[System.Collections.ArrayList]$List = @()
$input= get-content ingestion.csv
$output="results.txt"


foreach($_ in $input) {

$arrline= $_.split(",")
$group= $_.
$getmembervar=(Get-DistributionGroupMember -identity $group ).PrimarySmtpAddress
$List.Add($group)
$filteredresults= $getmembervar | where {_.PrimarySmtpAddress -match "@filter1" -or "@filter2"}
$List.Add($filteredresults)

##variable sanitation 
$group=$null
$filteredresults=$null


$List -join "," | tee-object -filepath $output

}

write-output $List | fl
