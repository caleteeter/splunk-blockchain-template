
# Deploy ipfs network

Param(
 [string] $resourceGroupName,
 [String] $templateUri,
 [String] $baseUrl,
 [String] $location,
 [String] $vmAdminPasswd,
 [String] $deployVPN = "False",
 [int] $numNodes,
 [int] $memberId
)

$param = @{}
$param.Add("prefix","bld")
$param.Add("authType", "password")
$param.Add("adminUsername", "ipfsadmin")
$param.Add("adminPassword", $vmAdminPasswd)
$param.Add("adminSSHKey", $vmAdminPasswd)
$param.Add("memberId", $memberId)
$param.Add("nodeCount", $numNodes)
$param.Add("location", $location)
$param.Add("_artifactsLocation", $baseUrl + "/")
$param.Add("vpnGateway", [System.Convert]::ToBoolean($deployVPN))

#$param.Add("_artifactsLocationSasToken",$sasToken)
#$param.Add("vmStoragePerformance", "StandardSSD_LRS")
#$param.Add("vmSize", "StandardSSD_LRS")

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
New-AzureRmResourceGroupDeployment -Name $resourceGroupName -ResourceGroupName $resourceGroupName -TemplateParameterObject $param -TemplateUri $templateUri

