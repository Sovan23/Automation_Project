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


