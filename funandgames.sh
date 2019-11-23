#!/bin/bash
TempWorker=correctbatteryhorsestaple99
TempWorkerHashed=$(grep "tempworker.*\n" /etc/shadow)
YourBoss=$(grep "yourboss.*\n" /etc/shadow)
echo $YourBoss
echo $TempWorkerHashed

