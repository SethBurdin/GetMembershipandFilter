[System.Collections.ArrayList]$List = @()
$input= get-content ingestion.csv
$output=results.txt




foreach($_ in $input)
arrline= split ","
$group= $_.
$getmembervar=(Get-DistributionGroupMember -identity $_.ID).PrimarySTMPAddress
$List.Add(Group)
$filteredresults= $getmembervar | where {_.PrimarySTMPAddress -match "@filter1" -or "@filter2"}
$List.Add($filteredresults)

$List join ","