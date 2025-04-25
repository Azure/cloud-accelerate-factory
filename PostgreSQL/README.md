# Steps To-Do:<br />

**OS Support**<br />
This script is compatible with the following operating systems:<br />
Windows 10 or later<br />
Linux RHEL v7 or later , Ubuntu v14 or later<br />

**Pre-requisites**<br />
Execute below prior running Powershell scripts<br />
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy bypass

***Windows***<br />
Powershell -   https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4<br /> 
PostgreSQL Client - https://www.postgresql.org/download/windows/ <br />
Azure CLI (Only for Single Server) - https://aka.ms/installazurecliwindows )<br /> 
AWS CLI (Only for AWS Server) - https://awscli.amazonaws.com/AWSCLIV2.msi <br />

***Linux***<br />
Powershell - https://learn.microsoft.com/en-us/powershell/scripting/install/install-rhel?view=powershell-7.4<br /> 
PostgreSQL Client - https://www.postgresql.org/download/linux/ <br />
Azure CLI (Only for Single Server) - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux/<br /> 
AWS CLI (Only for AWS Server) - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

**Add PATH in Enviornment Variables**<br />
***Windows***<br />
Azure CLI  ( e.g. C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin )<br />
PostgreSQL Client ( e.g.  C:\Program Files\PostgreSQL\bin )<br />
AWS CLI (e.g. C:\Program Files\Amazon\AWSCLIV2\)<br />

***Linux***<br />
Azure CLI  ( e.g. /usr/bin/az )<br />
PostgreSQL Client ( e.g. /usr/bin/psql )<br />
   
## Step1. Azure CLI Info Gathering (Only for Azure Database for PostgreSQL Single Servers)
1. Open the Input file `Azure_Subscription.csv` (Provide the Tenant ID & Subscription ID, add Multiple rows for Multiple Subscriptions)  
2. Execute `powershell.exe .\CMF-PostgreSQL-CLI-Windows.ps1` (Windows)
3. Execute `pwsh ./CMF-PostgreSQL-CLI-Linux.ps1` (Linux)
4. Once the execution completed, you can check the output & Logs folder.

**Note**:- Script support Multiple Subscription within single tenant. If you have multiple Tenent, follow each steps for individual Tenant.<br />
	
## Step2. AWS CLI Info Gathering (Only for AWS Servers)
1. Open the Input file `AWS_Subscription.csv` (Provide the AWSAccessKeyID, AWSSecretAccessKey, Region, DefaultOutputFormat, SessionToken add Multiple rows)  
2. Execute `powershell.exe .\CMF-AWS-RDS-CLI.ps1` & `powershell.exe .\CMF-AWS-VM-CLI.ps1` (Windows)
3. Execute `pwsh ./CMF-AWS-RDS-CLI.ps1` & `pwsh ./CMF-AWS-VM-CLI.ps1` (Linux)
4. Once the execution completed, you can check the output & Logs folder.

## Step3. Update CMF_PostgreSQL_Server_Input_file.csv (For All Servers)
 "**Host_Name**","Resource_Group","**Port**","VCore","Auth_Type","**User_ID**","**Password**","**DB_Name**","Tenant","Subscription_ID","**Approval_Status**","**SSL_Mode**"

**Note:-**<br />
. Highlighted are **Mandatory Fields**<br />
. Update Mandatory fields manually in case of Azure VM / On-premises / Other Cloud Servers <br />
. If a **Password** is not provided, this requires interactive console input of the password for each server. <br />

## Step4. PostgreSQL Server Info Gathering (For All Servers)
1. Execute `powershell.exe .\CMF-PostgreSQL-Windows.ps1` ( Windows )
2. Execute `pwsh ./CMF-PostgreSQL-Linux.ps1` ( Linux )
4. Once the execution completed, you can check the output & Logs folder.

**Note**:-<br /> 
    Choose option - 1. Perform PostgreSQL server Information gathering, to extract Server and DB level information.<br />
    This data will be used for assessment.<br />
    Option 2 - Perform Detailed Information gathering.(Optional)<br />

## Step5. Azure CLI Info Gathering (Only for Flexi servers Resiliency & Post-Migration)
1. Open the Input file `Azure_Subscription.csv` (Provide the Tenant ID & Subscription ID, add Multiple rows for Multiple Subscriptions)
2. Execute `powershell.exe .\CMF-PostgreSQL-FlexiCLI-Windows.ps1` (Windows)
3. Execute `pwsh ./CMF-PostgreSQL-FlexiCLI-Linux.ps1` (Linux)
4. Once the execution completed, you can check the Output/Flexi folder.

## Step6. Azure VM/On-premises Servers (Only for On-Premises / Azure VM / Other Cloud Servers)
. Refer document `CMF-ON-Prem_Server_Info_gather.docx` from the zip folder and update details and share document.<br />

id | sku.name | fullyQualifiedDomainName | sku.capacity | sku.storage | sku.tier | version | logname | region | location | ha |read_replica | environment | server_type | migration_path | approved

**Note**:- <br />
Update CMF_PostgreSQL_Server_List.csv file as per above format and ensure “logname” matching with "logfilename".<br />
sku.name = instance-type<br />
sku.capacity = Cores<br />
sku.storage = Memory<br />
logname = logfilename <br />
sku.tier = GCP_CloudSQL_Enterprise, Azure_VM, GCP_VM, Onprem_VM, K8s_Cluster_Node<br />

## Step7. Zip and share output, log folders (For All Servers) 
Kindly follow the execution instructions mentioned in attached documents. 
If there is/are any queries, please let us know, we will connect and check.

**Disclaimer:**
These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). 
These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, 
it is recommended to review and test them in a non-production environment before deploying them in a production environment.
It is important to note that these scripts should be modified with consultation of Microsoft.
