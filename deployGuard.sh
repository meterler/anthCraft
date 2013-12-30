#!/bin/bash

# author: ijse

deploy_file="/home/htdocs/deploy_bin/deploy_flag"
dist_folder="/home/htdocs/anthCraft-dist"
log_file="/home/htdocs/deploy_bin/anthcraft_deploy.log"

current_version="/home/htdocs/deploy_bin/anthcraft_ver"

cwd_path=`pwd`

ANTHCRAFT_DEPLOY_CODE=`cat $current_version`

# export PATH=$PATH:/usr/local/bin

# init flag
if [ -z $ANTHCRAFT_DEPLOY_CODE ]; then
  export ANTHCRAFT_DEPLOY_CODE=1
fi

# deploy ways
function deploy_anthCraft() {
 # Create deploy log file


 cd $dist_folder

 echo >> $log_file 2>&1
 echo Date: `date` >> $log_file 2>&1
 echo Version: $ANTHCRAFT_DEPLOY_CODE >> $log_file 2>&1
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
 /usr/local/bin/npm install --production >> $log_file 2>&1
 # /usr/local/bin/npm update >> $log_file 2>&1

 echo ==================================== >> $log_file 2>&1
 echo = Result >> $log_file 2>&1
 echo ==================================== >> $log_file 2>&1
 echo "Deploy successful!" >> $log_file 2>&1
 echo >> $log_file 2>&1
 echo >> $log_file 2>&1
 echo "*************************************************" >> $log_file 2>&1

 # whoami >> $log_file 2>&1
 # env >> $log_file 2>&1

 /usr/local/bin/pm2 flush >> $log_file 2>&1

 # pm2 restart all
 NODE_ENV=production /usr/local/bin/pm2 kill all >> $log_file 2>&1
 NODE_ENV=production /usr/local/bin/pm2 start server.js -i max -e $dist_folder/logs/pm2-err.log -o $dist_folder/logs/pm2-out.log >> $log_file 2>&1

 cd $cwd_path
}

deploy_code=`cat $deploy_file`

echo $deploy_code
echo $ANTHCRAFT_DEPLOY_CODE

if [ $deploy_code != $ANTHCRAFT_DEPLOY_CODE ]; then
  # export ANTHCRAFT_DEPLOY_CODE=$deploy_code
  echo $deploy_code > $current_version
  deploy_anthCraft
fi

