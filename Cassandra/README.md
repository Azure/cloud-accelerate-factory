
<!---------------------[  Description  ]------------------<recommended> section below------------------>

# csu-cassandra-mf

Steps To-Do:

Support

Windows 10 or later
Linux RHEL v7 or later , Ubuntu v14 or later


<!-----------------------[ Prerequisites  ]-----------------<optional> section below--------------------->
### Prerequisites

Git for Windows
PowerShell Execution Policy for windows

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
Note: - Add PATH in Enviornment Variables



<!-----------------------[  Installing  ]-------------------<optional> section below------------------>
### Installing

Step1. Download the script
GIT Repo: https://github.com/Azure/cloud-accelerate-factory/tree/dev/Cassandra

Step2. Unzip Info-Gather-cassandra.zip , cd ./csu-cassandra-mf/PUBLIC

Step3. Update 'infogatherfile.sh'

cassandrapath=""
password=""
logfile=""

Note:-
. Highlighted are Mandatory Fields
. Update the mentioned parameters manually in infogatherfile.sh


Execute Bash :
            	chmod +x ./infogatherfile.sh
			 
		         sh infogatherfile.sh
		   
Step4. Once the execution completed, you can check the Output file in the path you have provided for logfile parameter.

Step5. Share that log file to Factory Team
