# Automation_Project
Bash script for installing apache2 and archiving log files and copying them to s3 bucket

# Pre-requisites 
There are two variables in the script 

```
myname="yadu" // Change this variable value to your name before running the script

s3BucketName="upgrad-yadu" // Change this variable value to the name of the s3 bucket that you have created

```
## Tasks performed by bash script


The script in this directory is used for the following tasks:

1. Check if apache2 is installed or not ,if not install apache2 
2. Check if apache2 is running ,if not run the apache2 service 
3. Check if apache2 is enabled to run on reboot,if not enable
4. Create an archive of apache2 log files
5. Copy the log tar file to s3 bucket

## How to run the script?

After cloning this repository to your desired location go inside repository

```
cd Automation_Project
```

Then run the script as follows

```
sudo ./automation.sh
```
or 

```
sudo su

./automation.sh
```