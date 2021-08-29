#!/bin/bash
myname="yadu"
s3BucketName="upgrad-yadu"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Updating packages.....>"
echo
apt update -y
echo

echo "Checking if apache2 is already installed---->"
echo
isInstalledPath=$(which apache2 | grep "apache2")
echo

if [[ $isInstalledPath == "/usr/sbin/apache2" ]];
then
	echo "apache2 is installed"
	echo
else
	echo "apache2 is not installed ,installing apache2......"
	apt install apache2 -y
	echo
fi
echo

isRunning=$(systemctl status apache2 | grep "active (running)" | cut -c 12-27)
echo

if [[ $isRunning == "active (running)" ]];
then
	echo "apache2 is running"
	echo
	service apache2 status
	echo
else
	echo "apache2 is not running"
	echo
	service apache2 status
	echo
	echo "starting apache2....."
	echo
	service apache2 start
	service apache2 status
	echo
fi

echo "Check if apache2 service is enabled on reboot....."
isEnabled=$(service apache2 status | grep "enabled" | cut -c 57-63)
echo
if [[ $isEnabled == "enabled" ]];
then
	echo "apache2 service is enabled on reboot."
	echo
	service apache2 status
	echo
else
	echo "apache2 service is not enabled on reboot,enabling now"
	update-rc.d apache2 defaults
	update-rc.d apache2 enable
	echo
	service apache2 status
	echo
fi

echo "archiving logs.....>"
echo

timestamp=$(date '+%d%m%Y-%H%M%S') 
cd /var/log/apache2
tar -czvf $myname-httpd-logs-$timestamp.tar *.log
echo
cd $SCRIPT_DIR
echo "moving log file tar to temp directory"
echo
mv /var/log/apache2/$myname-httpd-logs-$timestamp.tar /tmp

echo "copy log file tar from temp to s3 bucket"
echo
aws s3 cp /tmp/$myname-httpd-logs-$timestamp.tar s3://$s3BucketName/$myname-httpd-logs-$timestamp.tar
