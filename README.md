# MalScan
 Quickly and effectively detect malware on a Linux machine using chkrootkit, rkhunter, LMD, Lynis and ClamAV. <br/>
 This is not a definitive scan but will give you a general snapshot. Run full scans as per your Policy. <br/>
 Sends a Combined Malware Report to a single, user defined email. Scans entire drive so can take a long time! <br/>
 BASH scripts written by Nathan Jones nathan.jones@arcadeusops.com as part of on-prem Ubuntu 22.04 server setups. <br/>
 Use cron to run malscan.h regularly. <br/>

# Malware Forensics
Don’t kill a suspicious process until you have investigated what it is doing. <br/>
If you kill a suspicious process out of panic, then you can lose and destroy a lot of useful information. <br/>
<br/>
netstat -nalp                           for unusual processes and open ports <br/>
ls -al /proc/5805                       for suspicious process ID. Here 5805 is the example <br/>
cp /proc/<PID>/exe /tmp/recovered_bin   to recover any deleted binary <br/>
strings /proc/<PID>/environ             explore process environment <br/>
cat /proc/<PID>/stack                   investigate Linux malware stack <br/>
ls -al /proc/<PID>/fd                   show malware open file descriptors <br/>
cat /proc/<PID>/maps                    investigate malware process maps <br/>
cat /proc/<PID>/status                  get the PID status <br/>

# USAGE
To install :- <br/>
git clone https://github.com/ArcadeusOPS/MalScan.git <br/>
<br/>
To start malware scanning  <br/>
./malscan.sh <br/>

# License
MIT License 
Copyright (c) ArcadeusOPS

# TODO
Collate Reports into a single JSON or HTML document. Suggestions to info@arcadeusops.com.

# Bugs
Send issues to info@arcadeusops.com stating nature of issue. A screenshot will help too. Thanks.

# CPD
Part of EC-Council ECE/CPD Credits
