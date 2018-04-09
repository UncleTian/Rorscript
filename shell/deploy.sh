#!/bin/bash
#
start=`date +%s`
function dbupgrade {
	echo "Start dbupgrade"
	echo 
	./dbupgrade.sh 2>&1 tee –a dbupgrade.log
	echo 
	echo "dbupgrade complete!"
}
#
function restart {
	sudo /sbin/service markitclear stop
	declare -a arrary=("workflow.jar" "connectivity.jar" "dcl_app.jar" "recon_app.jar")
	for app1 in "${arrary[@]}"
	do
		pid=$(ps -ef | grep $app1 | grep -v grep | awk '{print $2}')
		if [[ -n $pid ]];
		then
			kill -9 $pid
			echo "killed $app1"
		fi
	done
	sudo /sbin/service markitclear start
}

function install_new {
	echo "Clean old dependencies..."
	echo 
	sudo yum clean all
	echo 
	echo "Start install $app, please waiting... "
	echo 
	sudo yum -y install $app > log-$branch-$revision-$today.log
}
#
#
echo "========================================>"
#
#
if [ $# -ne 2 ];
then
	echo "Use this script like: ./deploy.sh branch revision "
	exit 0
else
	branch=$1
	revision=$2
fi
#
#
remove=`sudo rpm -qa | grep markitclear-app`
if [ -n $remove ]; then
	echo "Remove old version : $remove"
	sudo rpm -e $remove
	echo "Done!"
fi
#
today=$(date +%F)
#
app=markitclear-app-$branch-$revision
#
#
for ((i = 0; i < 5; i ++))
do
	install_new 
	if tail -1 log-$branch-$revision-$today.log | grep 'Complete!'
	then
		echo "Install succeed!"
		break 
	fi 
done 

#
echo "------------------"
#
cd /lp_app/lp_live/
#
path=$(pwd)
echo $path
echo 
if [ ! -f dbupgrade.sh ]
then
	echo "install failure!"
	exit -1
fi 
#
read -r -t 60 -p "Do you want to run dbupgrade? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]];
then
	dbupgrade
elif [[ -z $response ]];
then
	dbupgrade
fi
#
echo 
#
./stormctl.sh configure
#
echo 
#
read -r -t 60 -p "Do you want to restart dev? [y/N] " response
response=${response,,}    # tolower
if [[ -z $response ]];
then
	restart
elif [[ "$response" =~ ^(yes|y)$ ]];
then
	restart
fi
#
y
#
end=`date +%s`
runtime=$((end-start))
echo "Done!"
echo "Total run time: $runtime seconds"

