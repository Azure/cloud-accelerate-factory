# Steps To-Do:<br />
**Support**<br />
- Windows 10 or later<br />
- Linux RHEL v7 or later , Ubuntu v14 or later<br />
- Powershell 7.x or later <br />
- MongoShell 2.x or later <br />

 **Pre-requisites**
- [MongoDB Shell](https://www.mongodb.com/try/download/shell)
- [PowerShell for windows](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5)
- [Git for Windows](https://git-scm.com/download/win)
- PowerShell Execution Policy for windows
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass

**Note**: - Add PATH in Enviornment Variables<br />
	
## Step1. Download the script 
#### GIT Repo: https://github.com/Azure/csu-migration-factory/blob/dev/Mongo
#### curl -L -o Info-Gather-Mongo.zip https://github.com/Azure/csu-migration-factory/raw/dev/Mongo/Info-Gather-Mongo.zip
## Step2. Unzip Info-Gather-Mongo.zip , cd ./csu-mongo-mf-main/PUBLIC
## Step3. Update 'Factory_Mongo_Input_File.csv'
"**Host_Name**","Port","User_ID","Password","**Auth_DB**","TLS_Certicate_Path","CA_Certificate_Path","**Approval_Status**" <br />

**Note:-**<br />
. Highlighted are **Mandatory Fields**<br />
. Update Mandatory fields manually in Factory_Mongo_Input_File.csv <br />
. Port must be empty for iMongoDB ATLAS Cluster mongodb.net SRV connection <br />
. If a **Password** value "**IN**" provided, this requires interactive console input of the password for each cluster's node. 
. Update TLS and CA Certificate Path location ( e.g. windows :- C:\ca.crt , linux : /tmp/ca.crt )
<br />

### Execute PowerShell : 
                	pwsh
                	.\Factory-MongoDB-Bash.sh
### Execute Bash : 
                	chmod +x ./Factory-MongoDB-Bash.sh
			./Factory-MongoDB-Bash.sh

## Step4. Once the execution completed, you can check the Output & Logs folders.
## Step5. Zip the Output & Logs Folders and share to Factory Team




MongoDB Info Gather Support Tools
=================================
### . Manual Execution
This scripts for gathering information about how a running
MongoDB deployment has been configured and for gathering statistics about its
databases, collections, indexes, and shards.

#### Usage
To execute on a locally-running `mongod` or `mongos` on the default port

    mongosh mongodb://HOST:PORT  -u ADMIN_USER -p ADMIN_PASSWORD --eval "var _printJSON=false;" **getMongoData.js** > ./Cluster_HOST_PORT_mm_dd_yyyy_hh_mm_ss.log
    mongosh mongodb://HOST:PORT  -u ADMIN_USER -p ADMIN_PASSWORD --eval "var _printJSON=false;" **CheckMongoDB.js** > ./Database_HOST_PORT_mm_dd_yyyy_hh_mm_ss.log
    mongosh mongodb://HOST:PORT  -u ADMIN_USER -p ADMIN_PASSWORD --eval "var _printJSON=false;" **Checksize.js** > ./DBSize_HOST_PORT_mm_dd_yyyy_hh_mm_ss.log

Reference :- https://github.com/mongodb/support-tools/tree/master/getMongoData 

### . Post Migration Validation 
This process uses two JavaScript scripts executed via mongosh on a MongoDB server to:
Count documents in collections (excluding system DBs), Fetch the database size on disk. Log the results to .log files for validation or reporting.

    mongosh mongodb://HOST:PORT  -u ADMIN_USER -p ADMIN_PASSWORD PostvalidationCount.js > ./CollCount_HOST_PORT_mm_dd_yyyy_hh_mm_ss.log
    mongosh mongodb://HOST:PORT  -u ADMIN_USER -p ADMIN_PASSWORD PostvalidationDbsize.js > ./TotDBSize_HOST_PORT_mm_dd_yyyy_hh_mm_ss.log

Note:- Compare the source and target files to see the diff if any.



### . mongoDB Backup Restore 
This script automates MongoDB backup and restore operations.It allows you to:
Perform a full dump and full restore of all databases and collections, or
Perform a partial dump and partial restore using a collections.txt file that lists specific collections to migrate

    1. Make the Script Executable
		chmod +x mongo-backup-restore.sh
    2. This allows you to run it like:
		./mongo-backup-restore.sh
    3. Prepare the collections.list File (for Partial restore Mode)
		vi collections.list  ( Add one collection per line in DB.collection format, for example: ) 
		sample_airbnb.listingsAndReviews
		sample_analytics.transactions
		sample_mflix.movies		
  		Save and exit.
     4. Give Proper Permissions to collections.list
		chmod 644 collections.list
     5. Check Dump Directory
		Make sure your dump directory exists:
		mkdir -p /datadrive/mongodum
     6. Run the Script	
		For full Backup      (Option 1):
		./mongo-backup-restore.sh "<clust_uri>" "<clust_dir>"
		For full Restore     (Option 2):
		./mongo-backup-restore.sh "<clust_uri>" "<clust_dir>"
        	For partial Backup   (Option 3):
		./mongo-backup-restore.sh "<clust_uri>" "<clust_dir>" collections.list 
        	For partial Restore  (Option 4):
		./mongo-backup-restore.sh "<clust_uri>" "<clust_dir>" collections.list 
       
		Choose Option & Confirm
		The script will show:
		1) Full Backup 
                2) Full Restore
		3) Partial Backup  (uses collection.list file)
		4) Partial Restore (uses collection.list file)
		Type 1 or 2 or 3 or 4.
		When prompted:
		**WARNING:** This script uses '--drop' and will DELETE collections before restoring.
		Are you sure you want to continue? (yes/no): Yes
     
     7. Monitor the Process
		Since nohup is used, jobs run in the background.
		Check jobs:
			jobs -l
		Or check running processes:
			ps -ef | grep mongorestore 
		View logs:
		tail -f /datadrive/full_restore.log
		tail -f /datadrive/restore_<DBNAME>_<COLLECTION>.log
	        **Note:-** Compare the source and target files to see the diff if any.

**Disclaimer:** These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, it is recommended to review and test them in a non-production environment before deploying them in a production environment. It is important to note that these scripts should be modified with consultation.
