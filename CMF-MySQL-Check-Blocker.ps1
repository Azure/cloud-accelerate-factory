### Linux :- pwsh CMF-MySQL-Check-Blocker.ps1 -ResourceGroup <resource-group>  -ServerName <server-name>
### Windows :- powershell.exe .\CMF-MySQL-Check-Blocker.ps1 -ResourceGroup <resource-group>  -ServerName <server-name>
param (
    [string]$ResourceGroup,
    [string]$ServerName
)

if (-not $ResourceGroup -or -not $ServerName) {
    Write-Host "Usage: .\script.ps1 -ResourceGroup <resource-group> -ServerName <server-name>"
    exit 1
}

# Commands for Azure (Assuming Azure CLI is installed)
Write-Host "********************************************************************************************"
Write-Host "Private endpoint connections listed for server $ServerName in resource group $ResourceGroup."
az network private-endpoint-connection list --type Microsoft.DBforMySQL/servers -g $ResourceGroup -n $ServerName
Write-Host "********************************************************************************************"
Write-Host "MySQL server keys listed for server $ServerName in resource group $ResourceGroup."
az mysql server key list -g $ResourceGroup -s $ServerName
Write-Host "********************************************************************************************"
Write-Host "Active Directory admins listed for server $ServerName in resource group $ResourceGroup."
az mysql server ad-admin list -g $ResourceGroup -s $ServerName
Write-Host "********************************************************************************************"
Write-Host "VNet rules listed for server $ServerName in resource group $ResourceGroup."
az mysql server vnet-rule list --resource-group $ResourceGroup --server-name $ServerName
Write-Host "********************************************************************************************"
Write-Host "Replicas listed for server $ServerName in resource group $ResourceGroup."
az mysql server replica list -g $ResourceGroup -s $ServerName
Write-Host "********************************************************************************************"
