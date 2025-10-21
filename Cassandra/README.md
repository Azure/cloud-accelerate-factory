
<!---------------------[  Description  ]------------------<recommended> section below------------------>

# csu-cassandra-mf

Steps To-Do:

### Support

Linux RHEL v7 or later , Ubuntu v14 or later


<!-----------------------[ Prerequisites  ]-----------------<optional> section below--------------------->
### Prerequisites




<!-----------------------[  Installing  ]-------------------<optional> section below------------------>
### Installing

Step1. Download the script
GIT Repo:  https://github.com/Azure/cloud-accelerate-factory/blob/dev/Cassandra/Info-Gather-Cassandra.zip

Step2. Unzip Info-Gather-cassandra.zip , cd ./csu-cassandra-mf/PUBLIC

Step3. Update 'Factory-Cassandra-input_File.csv'

    "Host_Name","DB_USER","DB_PASSWD"

Step4. Update the below parameters in 'Factory-Cassandra-infogatherfile.sh' script.

       CSV_FILE=""

       SQL_FILE=""

       OUTPUT_DIR=""

Note:-
. Highlighted are Mandatory Fields
. Update the mentioned parameters manually in infogatherfile.sh


Execute Bash :
            	chmod +x ./Factory-Cassandra-infogatherfile.sh
			 
		         sh Factory-Cassandra-infogatherfile.sh
		   
Step5. Once the execution completed, you can check the Output file in the path you have provided for logfile parameter.

Step6. Share that log file to Factory Team





