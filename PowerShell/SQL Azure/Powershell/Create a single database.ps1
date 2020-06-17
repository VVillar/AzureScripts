#Parameters for SQL Azure Server
$serverName="srv-vvillardemo"
$subscriptionId = '<subscriptionid>'
$location="East US"
$cred = $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList 'sqladmindemo', $(ConvertTo-SecureString -String 'p@$$w0rddemo' -AsPlainText -Force))
$resourceGroup = "rg-vvillar"

#Parameters for Firewall rules
$fwRuleName = "AllowedIps"
$startIpAddress = "0.0.0.0"
$endIpAddress = "255.255.255.255"

#Parameters for Azure SQL Database
$dbName="db-demo01"
$dbSize="S0"

#Connect to the Azure subscription
Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionId

#Create a resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

#Create the server
New-AzSqlServer -ServerName $serverName -Location $location -ResourceGroupName $resourceGroup -SqlAdministratorCredentials $cred

#Create the database
New-AzSqlDatabase -DatabaseName $dbName -ResourceGroupName $resourceGroup -ServerName $serverName -RequestedServiceObjectiveName $dbSize

#Enable firewall IP Addresses (All IP addresses just for testing/tutorial purposes)
New-AzureRmSqlServerFirewallRule -FirewallRuleName $fwRuleName -StartIpAddress $startIpAddress -EndIpAddress $endIpAddress -ResourceGroupName $resourceGroup -ServerName $serverName

#Get server name (FQDN) to connect
Get-AzSqlServer -ServerName $serverName -ResourceGroupName $resourceGroup | Select-Object FullyQualifiedDomainName
