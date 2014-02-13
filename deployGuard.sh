#!/bin/bash

#
# author: ijse

# export PATH=$PATH:/usr/local/bin
# whoami >> $log_file 2>&1
# env >> $log_file 2>&1

# Run by crontab
# Works in $dist_folder
dist_folder="/home/webadmin/anthCraft-dist"

# Auto deploy when $flag_file dosen't exist
# Create $flag_file after deploy
flag_file = "/home/webadmin/deploy_bin/delete_me_if_you_want_deploy.log"

# Write logs to $log_file
log_file="/home/webadmin/deploy_bin/anthcraft_deploy.log"

cwd_path=`pwd`

# deploy ways
function deploy_anthCraft() {
	# Create deploy log file

	cd $dist_folder

	echo >> $log_file 2>&1
	echo Date: `date` >> $log_file 2>&1
	echo ===================================== >> $log_file 2>&1
	echo = Pull from Repo >> $log_file 2>&1
	echo ===================================== >> $log_file 2>&1
	echo
	git pull --force >> $log_file 2>&1
	git checkout --force >> $log_file 2>&1

	echo
	echo ===================================== >> $log_file 2>&1
	echo = Install dependencies >> $log_file 2>&1
	echo ===================================== >> $log_file 2>&1
	echo
	/usr/local/bin/npm cache clean >> $log_file 2>&1
	/usr/local/bin/npm install --production >> $log_file 2>&1
	/usr/local/bin/npm update anthpack >> $log_file 2>&1
	# /usr/local/bin/npm update >> $log_file 2>&1

	echo ==================================== >> $log_file 2>&1
	echo = Result >> $log_file 2>&1
	echo ==================================== >> $log_file 2>&1
	echo "Deploy successful! restart service..." >> $log_file 2>&1
	echo >> $log_file 2>&1
	echo >> $log_file 2>&1

	/usr/local/bin/pm2 flush >> $log_file 2>&1

	# pm2 restart all
	NODE_ENV=production /usr/local/bin/pm2 kill all >> $log_file 2>&1
	NODE_ENV=production /usr/local/bin/pm2 start server.js -i max -e $dist_folder/logs/pm2-err.log -o $dist_folder/logs/pm2-out.log >> $log_file 2>&1

	echo "All done!" >> $log_file 2>&1
	echo "*************************************************" >> $log_file 2>&1

	cd $cwd_path
}

if [ ! -e $log_file ]; then
	deploy_anthCraft
	# echo > $flag_file
fi
