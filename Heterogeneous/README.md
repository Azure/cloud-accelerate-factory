
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
