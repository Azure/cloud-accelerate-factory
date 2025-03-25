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

***Bash***<br />
Mongo Client - https://www.mongodb.com/docs/manual/administration/install-on-linux/<br />

**Note**: - Add PATH in Enviornment Variables<br />
	
## Step1. Download the script 
#### GIT Repo: https://github.com/Azure/csu-migration-factory/blob/dev/Mongo
#### curl -L -o Info-Gather-Mongo.zip https://github.com/Azure/csu-migration-factory/raw/dev/Mongo/Info-Gather-Mongo.zip
## Step2. Unzip Info-Gather-Mongo.zip , cd ./csu-mongo-mf-main/PUBLIC
## Step3. Update 'CMF_Mongo_Input_File.csv'
"**Host_Name**","**Port**","**User_ID**","**Password**","**Auth_DB**","TLS_Certicate_Path","CA_Certificate_Path","**Approval_Status**"<br />

"**Note:-**"<br />
. Highlighted are **Mandatory Fields**<br />
. Update Mandatory fields manually in CMF_Mongo_Input_File.csv <br />
. If a **Password** is not provided, this requires interactive console input of the password for each cluster's node. 
<br />
### Execute PowerShell : `pwsh CMF-MongoDB-PowerShell.ps1`
### Execute Bash : `./CMF-MongoDB-Bash.sh`
      
## Step5. Once the execution completed, you can check the Output & Logs folders.
## Step6. Zip the Output & Logs Folders and share to CMF Team

### Description
https://github.com/mongodb/support-tools/tree/master/getMongoData 

Disclaimer: These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, it is recommended to review and test them in a non-production environment before deploying them in a production environment. It is important to note that these scripts should be modified with consultation.
