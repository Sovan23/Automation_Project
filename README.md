# Automation_Project
Pre-Req - Spin up a Debain based EC2 instance and install Apache2
  Updatinge package details and the package list at the start of the script.
  Installing apache2 package if it is not already installed.
  Ensuring that the apache2 service is running and enabling on reboot.
Back up file .tar archive of apache2 access logs and error logs present in the /var/log/apache2/ directory in the remote instance and push it to TMP dir.
In order to distinguish the logs, name of tar archive should have unique format:  <your _name>-httpd-logs-<timestamp>.tar
Script running the AWS CLI command and copy the archive to the s3 bucket.
