#update the package details
sudo apt update -y
# Check if apache2 is installed
if [[ apache2 != $(dpkg --get-selections apache2 | awk '{print $1}') ]]; then
	#statements
	apt install apache2 -y
fi

# Ensures apache2 service is running
running=$(systemctl status apache2 | grep active | awk '{print $3}' | tr -d '()')
if [[ running != ${running} ]]; then
	#statements
	systemctl start apache2
fi

# Ensures apache2 Service is enabled 
enabled=$(systemctl is-enabled apache2 | grep "enabled")
if [[ enabled != ${enabled} ]]; then
	#statements
	systemctl enable apache2
fi

s3_bucket="upgradsovan"
timestamp=$(date '+%d%m%Y-%H%M%S')
myname='Sovan'
Backup_Dir="/tmp"
S3Bucket="upgradsovan"
SOURCE="var/log/apache2/*.log"
Filename=${myname}-httpd-logs-${timestamp}.tar.gz
tar -cf ${Filename} ${SOURCE} --exclude='var/log/apache2/*.zip' --exclude='var/log/apache2/*.tar'
mv ${Filename} ${Backup_Dir}
aws s3 \
cp /tmp/${Filename} \s3://${S3Bucket}/${Filename}


# copy logs to s3 bucket
if [[ -f ${Filename}.tar.gz ]]; then
	aws s3 cp /tmp/${Filename} \s3://${S3Bucket}/${Filename}
fi


docroot="/var/www/html"
# Check if inventory file exists
if [[ ! -f ${docroot}/inventory.html ]]; then
	echo -e 'Log Type\t-\tTime Created\t-\tType\t-\tSize' > ${docroot}/inventory.html
fi

# Inserting Logs into the file
if [[ -f ${docroot}/inventory.html ]]; then
	size=$(du -h /tmp/${name}-httpd-logs-${timestamp}.tar | awk '{print $1}')
	echo -e "httpd-logs\t-\t${timestamp}\t-\ttar\t-\t${size}" >> ${docroot}/inventory.html
fi

# Create a cron job that runs service every minutes/day
if [[ ! -f /etc/cron.d/automation ]]; then
	echo "* * * * * root /root/automation.sh" >> /etc/cron.d/automation
fi

