#!/bin/bash

# Nagios scripts on oms 
# 
# commands: 
#  - <check_script_name> <check_interval[min]> <check_script with parameters> 
CONFIG_FILE="./nagioms.conf"
if [ -f $CONFIG_FILE ]; then
	echo "Initializing config"
	source $CONFIG_FILE
else
	echo "File $CONFIG_FILE does not exist."
	exit 123 
fi

function environment_variables {
echo "Print all configuration settings:"
cat $CONFIG_FILE
}

function init_scripts {
        n=0
	while IFS= read -r line 
	do      
		if [[ $line != \#* ]] #lines don't beginn with comments
 		then 
			script_name=`echo $line | awk '{print $1}'`
			script_recurrence=`echo $line | awk '{print $2}'`
			script_command=`echo $line | awk '{for(i=3;i<=NF;i++){printf "%s ", $i};}'`
			CoMa[$n,0]=$script_name
			CoMa[$n,1]=$script_recurrence
			CoMa[$n,2]=$script_command
			((n++))
		fi
	done <"$command_file"	


}

#environment_variables
init_scripts

