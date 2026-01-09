**Oracle Info Gathering Automation (OSS DB MigrationFactory)**

**1\. Overview**

This automation collects **Oracle database metadata** for**migration and assessment purposes**.

The solution uses:

*   **PowerShell** for orchestration
    

*   **Oracle SQL\*Plus** for database connectivity
    

*   A **read-only SQL script** to gather Oracle configuration, sizing, and feature usage metadata
    

The script supports **multiple Oracle databases**,controlled via a **CSV input file**, and produces:

*   Per-database logs
    

*   Per-database result files

*   **Disclaimer:**
These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). 
These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, 
it is recommended to review and test them in a non-production environment before deploying them in a production environment.
It is important to note that these scripts should be modified with consultation of Microsoft.
    

*   A consolidated execution summary
    

 **The solution isread-only and non-intrusive.**

**2\. Supported Operating Systems**

**Windows**

*   Windows 10 or later
    

**Linux**

*   RHEL v7 or later
    

*   Ubuntu v14 or later
    

**3\. PowerShell Prerequisites**

**Execution Policy (Mandatory)**

Run once per user before executing the script:

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicyBypass

**4\. Software Requirements**

**4.1 PowerShell**

**OS**

**Requirement**

Windows

PowerShell 7.x

Linux

PowerShell 7.x (pwsh)

**Installation**

*   Windows [https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows)
    

*   Linux [https://learn.microsoft.com/en-us/powershell/scripting/install/install-rhel](https://learn.microsoft.com/en-us/powershell/scripting/install/install-rhel)
    

**4.2 Oracle Client (SQL\*Plus) – Mandatory**

The script **requires SQL\*Plus** and will not run withoutit.

**OS**

**Requirement**

Windows

Oracle Instant Client (SQL\*Plus)

Linux

Oracle Instant Client (SQL\*Plus)

**Download**[https://www.oracle.com/database/technologies/instant-client.html](https://www.oracle.com/database/technologies/instant-client.html)

**4.3 PATH Configuration**

**Windows**

Add the following to **Environment Variables → PATH**:

C:\\oracle\\instantclient\_21\_x

C:\\Program Files\\PowerShell\\7\\

Verify:

sqlplus -v

pwsh -v

**Linux**

Ensure binaries are accessible:

which sqlplus

which pwsh

Typical paths:

/usr/bin/sqlplus

/usr/bin/pwsh

**5\. Script Components**

**Component**

**Description**

Oracle\_Info\_Gathering\_Automation.ps1

Main PowerShell automation

ora\_db\_gather.sql

Oracle read-only assessment SQL

Factory\_Oracle\_Server\_Input\_file.csv

Input database list

LOG/

Execution logs

RESULT/

SQL output per database

**6\. Input CSV File**

**File Name**

Factory\_Oracle\_Server\_Input\_file.csv

**Required Columns**

"Host\_Name","User\_ID","Password","Port","Service\_Name","Approval\_Status"

**Column Description**

**Column**

**Description**

Host\_Name

Oracle DB hostname or IP

User\_ID

Oracle username

Password

Optional (prompted if empty)

Port

Optional (default: 1521)

Service\_Name

Oracle service name

Approval\_Status

Must be YES to execute

**Notes**

*   Only rows with Approval\_Status = YES are processed
    

*   Multiple databases are supported
    

*   Passwords are **never logged**
    

**7\. Oracle Database User Prerequisites (SQL Script)**

The SQL script queries:

*   DBA views
    

*   Dynamic performance views (V$, GV$)
    

*   SYS-owned tables
    

The Oracle user must be **read-only** but **highlyprivileged**.

**7.1 Recommended User Model**

**Best Practice (Recommended):**

*   Dedicated assessment user
    

*   Read-only
    

*   Catalog access
    

**7.2 Minimum Required Privileges**

**Mandatory Roles (Simplest & Recommended)**

GRANT CREATE SESSION TO oracle\_dbuser;

GRANT SELECT\_CATALOG\_ROLE TO oracle\_dbuser;

GRANT SELECT ON sys.aux\_stats$ TO oracle\_dbuser;

**7.3 Dynamic Performance Views Access (V$ / GV$)**

Required for:

*   Instance metadata
    

*   Memory sizing
    

*   RAC detection
    

*   Redo and performance statistics
    

*   Exadata detection
    

GRANT SELECT ON v\_$instance        TO oracle\_dbuser;

GRANT SELECT ON v\_$database        TO oracle\_dbuser;

GRANT SELECT ON v\_$parameter       TO oracle\_dbuser;

GRANT SELECT ON v\_$sgainfo         TO oracle\_dbuser;

GRANT SELECT ON v\_$system\_event    TO oracle\_dbuser;

GRANT SELECT ON v\_$log             TO oracle\_dbuser;

GRANT SELECT ON v\_$log\_history     TO oracle\_dbuser;

GRANT SELECT ON v\_$restore\_point   TO oracle\_dbuser;

GRANT SELECT ON v\_$cell\_state      TO oracle\_dbuser;

GRANT SELECT ON v\_$pdbs            TO oracle\_dbuser;

GRANT SELECT ON gv\_$instance       TO oracle\_dbuser;

Oracle internally maps V$ → V\_$.Grants must be issued on V\_$ objects.

**7.4 DBA Views Queried by the SQL**

Non-exhaustive list:

*   DBA\_OBJECTS
    

*   DBA\_SEGMENTS
    

*   DBA\_DATA\_FILES
    

*   DBA\_FREE\_SPACE
    

*   DBA\_TABLESPACES
    

*   DBA\_LOBS
    

*   DBA\_SERVICES
    

*   DBA\_SQL\_PROFILES
    

*   DBA\_SQL\_PLAN\_BASELINES
    

*   DBA\_SQL\_PATCHES
    

*   DBA\_DIRECTORIES
    

*   DBA\_DB\_LINKS
    

*   DBA\_AUDIT\_POLICIES
    

*   DBA\_PROFILES
    

*   ALL\_SOURCE
    

SELECT\_CATALOG\_ROLE covers all required access.

**7.5 RAC, Exadata & CDB Notes**

**Feature**

**Requirement**

RAC

Access to GV$ views

**8\. Security & Compliance**

*   SQL is **100% read-only**
    

*   No DDL or DML
    

*   No data modification
    

*   No application or user data extracted
    

*   Passwords handled securely via SecureString
    

*   No credentials written to logs
    

This access model is standard for:

*   Migration assessments
    

*   Capacity planning
    

*   Readiness analysis
    

**9\. Execution Steps**

**Windows**

powershell.exe .\\Oracle\_Info\_Gathering\_Automation.ps1

**Linux**

pwsh ./Oracle\_Info\_Gathering\_Automation.ps1

**10\. Runtime Prompts**

The script interactively prompts for:

*   SQL script path
    

*   LOG directory
    

*   RESULT directory
    

*   CSV input file
    

*   Password (if not provided)
    

**11\. Output Structure**

**Result Files**

RESULT/result\_\_\_.txt

**Log Files**

LOG/exec\_\_\_.log

**Summary**

LOG/summary\_.txt

**12\. Exit Codes**

**Code**

**Meaning**

0

All databases executed successfully

1

One or more failures

**13\. information:**

These scripts are provided **as-is** for Oracleinformation gathering and migration assessment purposes only.

They:

*   Do not collect sensitive data
    

*   Do not modify databases
    

It is strongly recommended to:

*   Review SQL scripts
    

*   Test in non-production environments
    

*   Use least-privilege accounts
    

*   Run with customer and security approval

**Disclaimer:**
These scripts are intended for use of Info Gather Assessment utility and do not interact with the user databases or gather any sensitive information (e.g passwords, PI data etc.). 
These scripts are provided as-is to merely capture metadata information ONLY. While every effort has been made to ensure that accuracy and reliability of the scripts, 
it is recommended to review and test them in a non-production environment before deploying them in a production environment.
It is important to note that these scripts should be modified with consultation of Microsoft.
