## Flow Chart
![Migration Flow](../image/flow-diagram-ado2gh.png)

 
## Prerequisites

Install GitHub CLI using the below link <br>                   
  <p align="left">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;https://github.com/cli/cli
  </p>

		
Authenticate GitHub 
- gh auth login --hostname github.com
 
Install ADO2GH CLI extension by running the below command
- gh extension install github/gh-ado2gh


## Defining Personal Access Token Scopes

#### Azure DevOps Personal Access Token

The ADO_PAT token is used to authenticate with Azure DevOps and perform operations on repositories, pipelines, Azure Boards, Service connections and projects.

To generate the Azure DevOps inventory report, a PAT with full access or elevated administrator privileges is mandatory. This is a one-time requirement used solely for inventory generation.

**Recommended PAT Scopes for Migration:**
- `Analytics: Read`
- `Build: Read`
- `Code: Full` (required for disabling ADO repositories)
- `GitHub Connections: Read & Manage`
- `Graph: Read`
- `Identity: Read`
- `Pipeline Resources: Use`
- `User Profile: Read`
- `Project and Team: Read`
- `Release: Read`
- `Security: Manage`
- `Service Connections: Read & Query`
- `Work Items: Read`

**Creating the Token:**
1. Navigate to Azure DevOps: `https://dev.azure.com/{your-org}`
2. Click on **User Settings** (top-right) → **Personal Access Tokens**
3. Click **+ New Token**
4. Set an expiration date (consider your migration timeline)
5. Select **Full Access** for inventory report generation or specific scopes listed above
6. Click **Create** and **copy the token immediately**

**Security Best Practice:** PAT tokens function much like passwords, so they must be handled and stored with extreme caution. 
Never commit PAT tokens to version control. Always store them securely using a password manager, environment variable, or a secret management tool (such as Azure Key Vault or GitHub Secrets).

#### GitHub Personal Access Token

The GH_PAT token authenticates with GitHub Enterprise and is required for organization-level operations.

**Required Scopes:**
- `repo`        - Full control of private repositories
- `workflow`    - Update GitHub Actions workflows
- `admin:org`   - Full control of organizations and teams
- `user:read`   - Read user profile data
- `user:email`  - Access user email addresses
- `delete_repo` - Delete repositories (optional, for rollback scenarios)

**Creating the Token:**
1. Navigate to GitHub Settings: `https://github.com/settings/tokens`
2. Click **Generate new token** → **Generate new token (classic)**
3. Give it a descriptive name (e.g., "ADO Migration Tool")
4. Set an expiration (consider your migration timeline)
5. Select all the scopes listed above
6. Click **Generate token** and **copy it immediately**


## Pre-Migration

*Set PAT Tokens*
In Bash
- export ADO_PAT = "your-ado-pat-token"
- export GH_PAT = "your-github-pat-token"
	    
*In PowerShell*
- $env:ADO_PAT = "your-ado-pat-token"
- $env:GH_PAT = "your-github-pat-token"

### Generate Inventory Report
Execute the command below
- gh ado2gh inventory-report --ado-org "your-ado-org"

### Update Inventory Report <br>

Update the inventory report to add three columns to capture names of organization, repository name, and repository visibility at the target SCM (GitHub). The preferred names of the headers of the columns are below: <br>
- github_org
- github_repo
- gh_repo_visibility
	
### Migration Readiness check

Please execute the scripts from Public/Bash (or) Public/Powershell folder based on your OS
- for powershell proceed with ./1_migration_readiness_check.ps1
- for bash proceed with ./1_migration_readiness_check.sh


## Migration
Please execute the scripts from Public/Bash (or) Public/Powershell folder based on your OS
- for powershell proceed with ./2_migration.ps1
- for bash proceed with ./2_migration.sh

    
### Migration Status Check
    
*Check Migration Status by Migration ID*
  * gh ado2gh wait-for-migration <migration-id>

*Install the Migrations Monitor extenstion using GitHub Extension (gh-migration-monitor)*
  * gh extension install mona-actions/gh-migration-monitor
  
*Launch the Monitor*
  * gh migration-monitor --organization "{github-org}" --github-token "your-github-pat-token"
  
  
### User Identity Mapping (Mannequins)

*Generate Mannequin CSV for Organization:*
   * gh ado2gh generate-mannequin-csv --github-org "{github-org}"
   
*Reclaims mannequins*
   * mapping them to the correct GitHub users. (Update the Mannequin CSV with Target User)
   * gh ado2gh reclaim-mannequin --github-org "{github-org}" --csv $CSV_FILE --skip-invitation

## Post-Migration
*Please execute below scripts from Public/Bash (or) Public/Powershell folder based on your OS to validate ADO branches,commits,PRs*
   * ./3_post_migration_validation.ps1
   * ./3_post_migration_validation.sh
   

## Integration

#### Pipeline Rewiring 
*Below steps need to be performed for Azure DevOps pipeline (supports only YAML) rewiring*

- Use the Azure DevOps PAT with full access 
- Install the  App called ‘Azure Pipelines’ from Github Marketplace.
- Navigate to the app: Organization --> Settings --> Third-party Access --> GitHub Apps -- >Azure Pipelines 
- Configure Azure Pipelines to select the right set of repositories 
- Navigate to the service connection section in the Azure DevOps Project and create the new service connection.
- Project Settings --> Pipelines --> Service Connections --> New Service connection --> GitHub --> OAuth Configuration --> Azure Pipelines --> Authorize --> Security --> Grant access permission to all pipelines (check box) --> Save
Run the command below to rewire the pipelines to GitHub
	   <div style="max-height:30px; overflow:auto;">
       <pre>
       <code>
         gh ado2gh rewire-pipeline --ado-org $ADO_ORG_NAME --ado-team-project $ADO_PROJECT_NAME --ado-pipeline $ADO_PIPELINE_NAME --github-org $GITHUB_ORG_NAME --github-repo $GITHUB_REPO_NAME --service-connection-id $SERVICE_CONNECTION_ID   
	    </code>
		</pre></div>
		 

#### Azure Boards Integration 
*Below steps need to be performed for Azure DevOps Boards integration:*

- ADO PAT token should have the Full access
- GH_PAT Token should have only following scopes 
    * admin:repo hook full
    * user:email
    * read:user
    * repo full

*Steps to install the Azure Boards GitHub apps:*
- Install the App called “Azure Boards” from GitHub marketplace.
- Navigate to the app: Organization --> Settings --> Third-party Access --> GitHub Apps -- >Azure Boards 
- Configure Azure Boards to select the right repositories 
Run the below command to integrate ADO Boards.
    <div style="max-height:30px; overflow:auto;">
    <pre>
    <code>
      gh ado2gh integrate-boards --ado-org $ADO_ORG_NAME --ado-team-project $ADO_PROJECT_NAME --github-org $GH_ORG_NAME --github-repo $GH_REPO_NAME
    </code>
	</pre></div>

	
  

 
