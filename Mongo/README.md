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

### Description
getMongoData.js
---------------

`getMongoData.js` is a utility for gathering information about how a running
MongoDB deployment has been configured and for gathering statistics about its
databases, collections, indexes, and shards.

For sample output, see [getMongoData.log](sample/getMongoData.log).

### Usage

To execute on a locally-running `mongod` or `mongos` on the default port (27017)
without authentication, run:

    mongo --quiet --norc getMongoData.js > getMongoData-output.json

To execute on a remote `mongod` or `mongos` with authentication (see the next
section for the minimum required permissions), run:

    mongo HOST:PORT/admin -u ADMIN_USER -p ADMIN_PASSWORD --quiet --norc getMongoData.js > getMongoData-output.json

If `ADMIN_PASSWORD` is omitted, the shell will prompt for the password.

To have the output be in a more human-readable (non-JSON format), modify the above
commands to include the following `--eval` option, as demonstrated for the local
execution:

    mongo --eval "var _printJSON=false;" getMongoData.js > getMongoData-output.log

To have a `mongos` for a sharded cluster output full details of chunk
distribution across shards, include `var _printChunkDetails=true` in the
`--eval` option:

    mongo --quiet --norc --eval "var _printChunkDetails=true; var _ref = 'Support Case NNNNN'" getMongoData.js > getMongoData-output.json

### More Details

`getMongoData.js` is JavaScript script which must be run using the `mongo` shell
against either a `mongod` or a `mongos`.

Minimum required permissions (see [MongoDB Built-In Roles](https://docs.mongodb.com/manual/reference/built-in-roles)):
* A database user with the `backup`, `readAnyDatabase`, and `clusterMonitor` roles. These are essentially read-only roles except the [backup](https://docs.mongodb.com/manual/reference/built-in-roles/#backup-and-restoration-roles) role allows writes to two MongoDB system collections - `admin.mms.backup` and `config.settings`. The `backup` role is necessary in order for the script to output the number of database users and user-defined roles configured.
* A root/admin database user may be used as well.

Example command for creating a database user with the minimum required permissions:

```
db.getSiblingDB("admin").createUser({
    user: "ADMIN_USER",
    pwd: "ADMIN_PASSWORD",
    roles: [ "backup", "readAnyDatabase", "clusterMonitor" ]
  })
```

The most notable methods, commands, and aggregations that this script runs are listed below.

**Server Process Config & Stats**
* [serverStatus](https://docs.mongodb.com/manual/reference/command/serverStatus)
* [hostInfo](https://docs.mongodb.com/manual/reference/command/hostInfo)
* [getCmdLineOpts](https://docs.mongodb.com/manual/reference/command/getCmdLineOpts)
* [buildInfo](https://docs.mongodb.com/manual/reference/command/buildInfo)
* [getParameter](https://docs.mongodb.com/manual/reference/command/getParameter/)

**Replica Set Config & Stats**
* [rs.conf()](https://docs.mongodb.com/manual/reference/method/rs.conf/)
* [rs.status()](https://docs.mongodb.com/manual/reference/method/rs.status/)
* [db.getReplicationInfo()](https://docs.mongodb.com/manual/reference/method/db.getReplicationInfo)
* [db.printSecondaryReplicationInfo()](https://docs.mongodb.com/manual/reference/method/db.printSecondaryReplicationInfo)

**Database Users and User-Defined Roles (the count only)**
* [db.system.users.count()](https://docs.mongodb.com/manual/reference/system-users-collection/) in the "admin" database
* [db.system.roles.count()](https://docs.mongodb.com/manual/reference/system-roles-collection/) in the "admin" databases

**Database, Collection, and Index Config & Stats**
* [listDatabases](https://docs.mongodb.com/manual/reference/command/listDatabases/)
* [db.getCollectionNames()](https://docs.mongodb.com/manual/reference/method/db.getCollectionNames/)
* [db.stats()](https://docs.mongodb.com/manual/reference/method/db.stats/)
* [db.getProfilingStatus()](https://docs.mongodb.com/manual/reference/method/db.getProfilingStatus/)
* [db.collection.stats()](https://docs.mongodb.com/manual/reference/method/db.collection.stats/)
* [db.collection.getShardDistribution()](https://docs.mongodb.com/manual/reference/method/db.collection.getShardDistribution/)
* [db.collection.getIndexes()](https://docs.mongodb.com/manual/reference/method/db.collection.getIndexes/)
* [$indexStats](https://docs.mongodb.com/manual/reference/operator/aggregation/indexStats/)

**Sharding Config & Stats**
* Queries and aggregations on various collections in the MongoDB [config database](https://docs.mongodb.com/manual/reference/config-database/), including the "version", "settings", "routers", "shards", "databases", "chunks", and "tags" collections.

**Queryable Encryption (QE) Config**
* [db.getCollectionInfos()](https://docs.mongodb.com/manual/reference/method/db.getCollectionInfos/)
* Performs queries and aggregations on QE collections and auxiliary collections in all databases. The output is an
array of objects, each containing information about a queryable encrypted collection.

### Additional Notes
* This script should take on the order of seconds to run.
* If your deployment has more than 2500 collections, this script will by default fail.

