Zabbix - Proxmox/OpenVZ
==============

Zabbix Template for monitoring cpu/memory of your Proxmox/OpenVZ Server  
This Template implements *low level discovery* to automatically discover all of your guest systems after you applied the template to a host


### Setup 

* Add the following to your **/etc/zabbix/zabbix_agentd.conf** file.

```
UserParameter=custom.pve.vzlist,/var/lib/zabbix/scripts/vzdiscover.sh
UserParameter=custom.vz.cpu[*],sudo /usr/sbin/vzlist -a -o laverage -H $1       | awk -F/ '{print $$1}'
UserParameter=custom.vz.cpu5[*],sudo /usr/sbin/vzlist -a -o laverage -H $1      | awk -F/ '{print $$2}'
UserParameter=custom.vz.cpu10[*],sudo /usr/sbin/vzlist -a -o laverage -H $1     | awk -F/ '{print $$3}'

UserParameter=custom.vz.usedmem[*],sudo /usr/sbin/vzlist -a -o physpages -H $1 | awk '{print $$1*4/1024}'
```
* Copy the file **vzdiscover.sh** to **/var/lib/zabbix/scripts/vzdiscover.sh** and make it executable
* Because vzlist could only executed as root, you need to add this line to your visudo list

```
zabbix ALL=NOPASSWD:/var/lib/zabbix/scripts/vzdiscover.sh,/usr/sbin/vzlist
```

* Import the template.xml File into your Zabbix
