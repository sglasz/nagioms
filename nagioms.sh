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

# CoMa [ check_name recurrence_time script_command_with_parameters process_pid timestamp ]

let n=0
declare -a CoMa
function init_script {
#let script_name script_recurrence script_command
while IFS= read -r line 
do      
	if [[ $line != \#* ]] #lines don't beginn with comments
	then
echo -en "\n"
	echo $n
	 
	echo $line | awk '{print $1}'
	echo $line | awk '{print $2}'
	echo $line | awk '{for(i=3;i<=NF;i++){printf "%s ", $i};}'
	CoMa[$n,0]=`echo $line | awk '{print $1}'`
	CoMa[$n,1]=`echo $line | awk '{print $2}'`
	CoMa[$n,2]=`echo $line | awk '{for(i=3;i<=NF;i++){printf "%s ", $i};}'`
	((n++))
	#echo $n
	fi
done <"$command_file"
}

echo ${CoMa[0,0]}
echo ${CoMa[1,0]}


function run_script {
	for ((i=0; i<n; i++))
	do
		for ((j=0; j<3; j++))
   		do
      		echo -ne "${CoMa[${i},${j}]}\t"
		echo -ne "\n" 	
		done
	
	done

}
init_script
#run_script
#echo ${CoMa[0,1]}                        


#function loop_scripts {
#}
#environment_variables
#init_scripts
#loop_scripts




