# Oracle Info Gathering Automation (OSS DB Migration Factory)<br />

## Description<br />
This script is designed for Oracle database information gathering to support migration assessment, readiness analysis, and capacity planning.<br />
The scripts collect Oracle configuration and metadata only and execute read-only SQL queries.<br />
No DDL or DML operations are performed, and no databases are modified.<br />
No application or user data is collected, and passwords are never logged.<br />
The scripts are provided as-is and should be reviewed and tested in a non-production environment before execution.<br />

# Prerequisites:<br />

**OS Support**<br />
This script is compatible with the following operating systems:<br />
Windows 10 or later<br />
Linux RHEL v7 or later , Ubuntu v14 or later<br />

# Pre-requisites<br />
Execute the below command prior running PowerShell scripts:<br />
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass<br />

# Software Requirements<br />

**Windows**<br />
PowerShell 7.x – https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows<br />
Oracle Instant Client (SQL*Plus – Mandatory) – https://www.oracle.com/database/technologies/instant-client.html<br />

**Linux**<br />
PowerShell 7.x (pwsh) – https://learn.microsoft.com/en-us/powershell/scripting/install/install-rhel<br />
Oracle Instant Client (SQL*Plus – Mandatory) – https://www.oracle.com/database/technologies/instant-client.html<br />

# Add PATH in Environment Variables<br />

**Windows**<br />
Add the following paths to Environment Variables → PATH:<br />
Oracle Instant Client (e.g. C:\oracle\instantclient_21_x)<br />
PowerShell (e.g. C:\Program Files\PowerShell\7\)<br />
Verify installation:<br />
sqlplus -v<br />
pwsh -v<br />

**Linux**<br />
Ensure binaries are accessible:<br />
which sqlplus<br />
which pwsh<br />
Typical paths:<br />
/usr/bin/sqlplus<br />
/usr/bin/pwsh<br />

# Info Gather for Migration:<br />

## Steps To-Do<br />

**Step 1. Prepare Oracle Database User**<br />
Create or identify a dedicated read-only Oracle user with access to catalog and performance views.<br />
Minimum required privileges:<br />
GRANT CREATE SESSION TO oracle_dbuser;<br />
GRANT SELECT_CATALOG_ROLE TO oracle_dbuser;<br />
GRANT SELECT ON sys.aux_stats$ TO oracle_dbuser;<br />

Dynamic performance views access:<br />
GRANT SELECT ON v_$instance TO oracle_dbuser;<br />
GRANT SELECT ON v_$database TO oracle_dbuser;<br />
GRANT SELECT ON v_$parameter TO oracle_dbuser;<br />
GRANT SELECT ON v_$sgainfo TO oracle_dbuser;<br />
GRANT SELECT ON v_$system_event TO oracle_dbuser;<br />
GRANT SELECT ON v_$log TO oracle_dbuser;<br />
GRANT SELECT ON v_$log_history TO oracle_dbuser;<br />
GRANT SELECT ON v_$restore_point TO oracle_dbuser;<br />
GRANT SELECT ON v_$cell_state TO oracle_dbuser;<br />
GRANT SELECT ON v_$pdbs TO oracle_dbuser;<br />
GRANT SELECT ON gv_$instance TO oracle_dbuser;<br />

Note: Oracle internally maps V$ views to V_$. Grants must be applied on V_$ objects.<br />

**Step 2. Update Oracle Server Input File**<br />
Open the input file:<br />
Factory_Oracle_Server_Input_file.csv<br />

Update the file using the below format:<br />
"Host_Name","User_ID","Password","Port","Service_Name","Approval_Status"<br />

Notes:<br />
Highlighted fields are mandatory<br />
Approval_Status must be Yes for execution<br />
Multiple Oracle databases are supported<br />
Default port is 1521 if not specified<br />
If Password is not provided, interactive input will be required<br />
Passwords are never logged<br />

**Step 3. Oracle Server Info Gathering Execution**<br />

Windows:<br />
powershell.exe .\Oracle_Info_Gathering_Automation.ps1<br />

Linux:<br />
pwsh ./Oracle_Info_Gathering_Automation.ps1<br />

During execution, the script will prompt for:<br />
SQL script path<br />
LOG directory path<br />
RESULT directory path<br />
Input CSV file<br />
Password (if not provided)<br />

**Step 4. Review Output and Logs**<br />
Once execution is completed, review the following folders:<br />

Results:<br />
RESULT/result_<dbname>.txt<br />

Logs:<br />
LOG/exec_<dbname>.log<br />
LOG/summary_<timestamp>.txt<br />

**Step 5. Zip and Share Output**<br />
Zip and share the RESULT and LOG folders.<br />
Kindly follow the execution instructions mentioned above. If there are any queries, please let us know and we will connect to assist.<br />

# Exit Codes<br />

0 – All databases executed successfully<br />
1 – One or more database executions failed<br />


# Pre-Migration Cleanup (MSSQL)

## Description

This PowerShell script is designed to automate Microsoft SQL Server database migration preparation and validation tasks.

It supports:

-   Cleanup script generation (Foreign Keys, Triggers, Tables)
-   Pre-migration execution (Drop FK, Disable Triggers, Truncate Tables)
-   Post-migration execution (Enable FK, Enable Triggers)
-   Validation and reporting (TXT / HTML reports)
-   Database inventory (tables, row counts, FK, triggers)
-   Custom SQL execution

## Important note:
 
-   The script performs **destructive operations** (FK drop, table truncation).
-   It **modifies database structures and data**.
-   It must be **executed ONLY on non-production or controlled environments**.
-   Proper validation and backups are **not optional** — they are mandatory.

## Prerequisites

### OS Support

-   Windows 10 or later
-   Windows Server environments

### PowerShell Requirements

Run prior to execution:

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass

### Software Requirements

-   PowerShell 5+ or PowerShell 7+
-   SQL Server tools (`sqlcmd`)
-   SQL Server Management Objects (SMO)

### Access Requirements

-   Valid SQL Server hostname and instance name
-   Authentication:
-   Active Directory (Windows Auth)
-   OR SQL Authentication
-   Required privileges:
-   ALTER TABLE (FK operations)
-   ALTER TRIGGER
-   DELETE / TRUNCATE permissions
-   VIEW DEFINITION (for inventory)

 Weak permissions = partial execution = inconsistent state.

## Steps To-Do<br />

 **Step 1.Define Execution Inputs**<br />
execute the script using powershell command: 
 powershell.exe -File .\\Factory_Sql_Server_PreLoad_Cleanup.ps1
 
At runtime, you will provide:
-   SQL Server hostname (default: `localhost`)
-   Instance name (default: `MSSQLSERVER`)
-   Target databases:
-   List format: `db1 db2 db3`
-   Or `*` for all user databases

Authentication mode:

1 = SQL Authentication  
2 = Windows Authentication (Default)  
0 = Exit  

Working directory (mandatory):

Example:
C:\\DB-Migration\\Output

This directory will contain:

-   Generated scripts
-   Execution logs
-   Validation reports

### Main Menu
bellow are the available options: 

#### Generate Cleanup Scripts

11\. Drop Foreign Keys  
12. Disable Triggers  
13. Cleanup Tables (Truncate)

#### Run Pre-Migration

21\. Drop FK  
22. Disable Triggers  
23. Truncate Tables

#### Run Post-Migration

31\. Enable FK  
32. Enable Triggers

#### Other Operations

4\. Validate Logs  
5. Database Inventory  
6. Execute SQL Script  
0. Exit

 **Step 2.Review Output and Logs**<br />

### Generated Structure

<WorkingDir>
 ├── FK
 │    └── LOG
 ├── Triggers
 │    └── LOG
 ├── Tables
 │    └── LOG
 ├── DatabaseInventory.txt
 ├── DatabaseInventory.html
 ├── Validation Reports
 └── Custom SQL Logs

### Validation Reports (Option 4)
Report can be generated for pre-migration validation 
It includes:
-   FK dropped / recreated counts
-   Trigger status changes
-   Tables truncated
-   Row counts
-   Final FK state
Exports:
<DB>\_ValidationReport.txt  
<DB>\_ValidationReport.html

### Inventory Report (Option 5)

Includes:
-   Tables and row counts
-   Foreign keys
-   Trigger states

Exports:
DatabaseInventory.txt  
DatabaseInventory.html

 **Step 3.Archive and Validate Execution**<br />

Mandatory actions:
-   Backup the entire working directory
-   Store logs for audit and rollback analysis
-   Validate:
-   FK integrity
-   Trigger states
-   Data consistency

## Exit Codes
0 – Execution completed successfully  
1 – One or more operations failed

# Pre-Migration Cleanup (PostgreSQL)

## Description

This KornShell (KSH) script automates PostgreSQL database information collection, migration preparation and validation tasks.

It supports:
-   Database inventory (tables, row counts, FK, triggers, indexes)
-   SQL script generation (FK, triggers, truncate)
-   Pre-migration execution (Drop FK, Disable Triggers, Truncate Tables)
-   Post-migration execution (Enable FK, Enable Triggers)
-   Validation reporting (TXT / HTML)
-   Custom SQL execution

 ## Important notes:
-   The script performs **DDL and destructive operations** (FK drop, TRUNCATE).
-   It modifies **database structure and data**.
-   Must be executed **only in controlled or non-production environments**.
-   Logs and validation are **not optional safeguards — they are your only safety net**.

## Prerequisites

### OS Support
-   Linux (RHEL 7+, Ubuntu 14+)
-   Unix environments
-   macOS (with adaptations)

### Shell Requirements
-   KornShell (`ksh`) recommended
-   Bash may work but is **not guaranteed**

### Software Requirements
-   PostgreSQL client (`psql`) installed
-   `psql` must be accessible via PATH

Verify installation:
psql --version

### Access Requirements
-   PostgreSQL user with:
-   PostgreSQL host (default: `localhost`)
-   Port (default: `5432`)
-   Username / password
-   Access to target databases
-   SELECT on system catalogs
-   DDL privileges (if executing scripts):
-   ALTER TABLE
-   ALTER TRIGGER
-   TRUNCATE
-   
## Steps To-Do<br />
  
 **Step 1. Define Execution Inputs**<br />
 execute the script using ksh  command: 
 ksh Factory_Postgres_PreLoad_Cleanup.ksh
At runtime, you will provide:
-   Hostname
-   Port
-   Username / Password
-   Database selection:
-   Format: `db1 db2` or `db1,db2`
-   `*` for all databases

Working directory:
Example:
/home/user/output

If not provided, a default OS-based directory is used.
The script automatically creates:
-   FK/
-   TRIGGERS/
-   TABLES/
-   TRUNCATE/
-   INVENTORY/
-   VALIDATION/

 **Step 2. Define Execution Inputs**<br />

### Main Menu
#### Generate Cleanup Scripts
11\. Drop FK  
12. Disable Triggers  
13. Cleanup Tables (TRUNCATE)

#### Run Pre-Migration
21\. Drop FK  
22. Disable Triggers  
23. Cleanup Tables (TRUNCATE)

#### Run Post-Migration
31\. Create/Enable FK  
32. Enable Triggers

#### Other Operations
4\. Validate Pre/Post-Migration Log Files  
5. Databases Inventory  
6. Execute SQL Script  
0. Exit

 **Step 3. Review Output and Logs**<br />
### Generated Directory Structure

WORKDIR/
├── FK/
│   ├── DropFKs\_<db>.sql
│   ├── CreateFKs\_<db>.sql
│   └── LOG/
├── TRIGGERS/
│   ├── DisableTriggers\_<db>.sql
│   ├── EnableTriggers\_<db>.sql
│   └── LOG/
├── TRUNCATE/
│   ├── TruncateTables\_<db>.sql
│   ├── LOG/
│   └── SUMMARY/
├── TABLES/
│   └── LOG/
├── INVENTORY/
│   ├── TXT/
│   └── HTML/
└── VALIDATION/
    ├── ValidationReport.txt
    └── ValidationReport.html

### Validation Reports (Option 4)
Includes:
-   FK dropped vs recreated
-   Trigger states (enabled/disabled)
-   Tables truncated
-   Expected vs actual state comparison

### Inventory Reports (Option 5)
Includes:
-   Tables and row counts
-   Foreign keys
-   Triggers
-   Indexes and constraints

Useful for:
-   Migration planning
-   Capacity estimation
-   Audit baselines

### Execution Logs
Contain:
-   Errors
-   Execution summaries
-   Object-level details

 **Step 3. Archive and Validate Execution**<br />
Mandatory actions:
-   Backup WORKDIR
-   Store logs for audit
-   Validate:
-   FK integrity
-   Trigger states
-   Data presence
-   Table consistency


**Disclaimer:**
These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). 
These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, 
it is recommended to review and test them in a non-production environment before deploying them in a production environment.
It is important to note that these scripts should be modified with consultation of Microsoft.


