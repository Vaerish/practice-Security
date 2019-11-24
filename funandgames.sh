#!/bin/bash
TempWorker=correctbatteryhorsestaple99
TempWorkerHashed=$(grep "tempworker.*\n" /etc/shadow)
YourBoss=$(grep "yourboss.*\n" /etc/shadow)
SysAdmin=$(grep "sysadmin.*\n" /etc/shadow)
echo $SysAdmin > SysPassword.txt
touch Decoded.txt
TempWorkerHashed=${TempWorkerHashed:0}
TempWorkerHashed=${TempWorkerHashed:0:-19}
YourBoss=${YourBoss:9:-19}
DecryptedSys=$( hashcat --force -m 1800 SysPassword.txt Decoded.txt /usr/share/dict/american-english-small > Decoded.txt)
DecryptedPassSys=$( python3 decodeSys.py)
#Finished up making it just the password section now we just need to figure out salt
SaltTemp=$YourBoss
#Then encode every word in dictionary with salt to find word
IsPassword=password
SaltTemp=${SaltTemp:3:8}

IsPassword=$(python3 fun.py correctbatteryhorsestaple99 g1VamdqE)
IsPassword=${IsPassword}

for j in $(cat /usr/share/dict/american-english-small)
do
	IsPassword=$j
	IsPassword=$(python3 fun.py $j $SaltTemp)
	if [ $IsPassword == $YourBoss ]; then
		echo $j
		break
	fi
done

#now I need to use john to break the sysadmins password
python3
echo $TempWorker
echo $DecryptedPassSys
	
