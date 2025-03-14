# Steps To-Do:<br />

**OS Support**<br />
This script is compatible with the following operating systems:<br />
Linux RHEL v7 or later , Ubuntu v14 or later<br />

**Pre-requisites**<br />

Execute below prior running Powershell scripts<br />
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy bypass

***PowerShell***<br />
Powershell -   https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4<br /> 
Mongo client - https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-windows/<br />
Azure CLI (For Single Server and Microsoft Entra ID authentication only) - https://aka.ms/installazurecliwindows )<br /> 

***Bash***<br />
Mongo Client - https://www.mongodb.com/docs/manual/administration/install-on-linux/<br />
Azure CLI (For Single Server and Microsoft Entra ID) - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux/<br /> 

**Note**: - Add PATH in Enviornment Variables<br />
	
## Step1. Download and run the infogather script
## Step2. Download the script from the git link https://github.com/customer-success-microsoft/csu-mongo-mf/tree/dev/PUBLIC

## Step3. Update 'CMF_Mongo_Input_File.csv'
"**Host_Name**","**Port**","**User_ID**","**Password**","**Auth_DB**","**JSON_Output**","TLS_Certicate_Path","CA_Certificate_Path","**Approval_Status**"

**Note:-**<br />
. Highlighted are **Mandatory Fields**<br />
. Update Mandatory fields manually in case of Azure VM / On-premises Servers <br />
. If a **Password** is not provided, this requires interactive console input of the password for each server. 
. For credentials handling methods refer to [Passing credentials](#passing-credentials)
<br />
#### Execute PowerShell `pwsh CMF-MongoDB-PowerShell.ps1`

#### Execute Bash `./CMF-MongoDB-Bash.sh`
      
## Step5. Once the execution completed, you can check the Output & Logs folders.
## Step6. Zip the Output & Logs Folders and share to CMF Team
