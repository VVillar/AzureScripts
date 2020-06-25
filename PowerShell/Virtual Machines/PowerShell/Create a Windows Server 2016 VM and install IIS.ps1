#Create a resource group
New-AzResourceGroup -Name myResourceGroup -Location EastUS

#Create a virtual machine
New-AzVm `
    -ResourceGroupName "myResourceGroup" `
    -Name "myVM" `
    -Location "East US" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389

#Get the public IP address
Get-AzPublicIpAddress -ResourceGroupName "myResourceGroup" | Select-Object "IpAddress"

#Enter using remote desktop 
mstsc /v:publicIpAddress

#Install IIS in the Powershell inside the VM 
Install-WindowsFeature -name Web-Server -IncludeManagementTools





