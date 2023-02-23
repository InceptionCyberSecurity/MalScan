#!/bin/bash
# script to check linux system for Malware. Tested on Ubuntu 22.04
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
HOME=/
SHELL=/bin/bash

# install SMTP mail
sudo update
sudo apt install mailutils ssmtp epel-release clamd clamav clamav-daemon -y
# nano /etc/ssmtp/ssmtp.conf
# change email addresses to your Gmail account

echo " Make sure you have setup your outgoing mail server as per the instructions in malscan.sh "
echo " The instructions are in the comments. "
echo " "
read -p " What email do you want the results to be sent to ? " umail

# lynis
cd /opt/
wget https://downloads.cisofy.com/lynis/lynis-2.6.6.tar.gz
tar xvzf lynis-2.6.6.tar.gz
mv lynis /usr/local/
ln -s /usr/local/lynis/lynis /usr/local/bin/lynis
cd ..
lynis audit system | grep malware > lynis.txt

# Check rootkit
sudo apt install chkrootkit
sudo chkrootkit | grep "infected" > rootkit.txt

# rkhunter
sudo apt install rkhunter
yum install epel-release
yum install rkhunter
rkhunter -c | grep "infected" > rkhunt.txt

# clamav
sudo apt-get install clamav
freshclam
clamscan -r -i DIRECTORY | grep "infected" > clamav.txt

# Linux Malware Detect LMD https://www.tecmint.com/install-linux-malware-detect-lmd-in-rhel-centos-and-fedora/
# edit /usr/local/maldetect/conf.maldet to include your email and scan options
wget http://www.rfxn.com/downloads/maldetect-current.tar.gz
tar -xvf maldetect-current.tar.gz
ls -l | grep maldetect
cd maldetect-1.6.4/
ls
./install.sh
cd ..
maldet --scan-all /var/www/ > lmd.txt
#maldet --scan-all /var/www/*.zip
# maldet --report 021015-1051.3559
rm -rf /usr/local/maldetect/quarantine/* # remove quarantined files
# maldet --clean SCANID
# set crontab -e

# process txt files
cat lynis.txt clamav.txt rootkit.txt rkhunt.txt lmd.txt | sort > malrep.txt
# mail
mail -s "Malware Report" you@yourdomain.com $umail -a malrep.txt
