#!/bin/bash

# This should be executed as root or sudo on your Kali or Debian VM, when internet is available.
# Internet will NOT be available during runtime, 
# nor will any packages besides base debian and the following be installed:

# Installs the needed tools (will be available on the grader)
sudo apt install -y john hashcat wamerican* expect python3-pexpect libpam-cracklib whois

# Creates tempworker's account and password
# correctbatteryhorsestaple99
sudo useradd tempworker --create-home --password '$6$g1VamdqE$RiEKGpb7gemh1Zt2JyVPq4Gzp/a2wTE5CPxNu97YaFfjS4wqbL2Nj1ousP2NWrUtjoVWw2nm8KdIcHzgzkw7R.'

# Creates yourboss's account and password
# money
sudo useradd yourboss --create-home --password '$6$dbkKuKGS$XsniIqjOF39Kar2w3vZ8DuImkBihLJ0wR6skCAzwIFTDfbDdgQLYCyzRrcQeouT83didVrrOiXVYVARDpX88L/'
sudo usermod --append --groups sudo yourboss

# Creates sysadmin's account and password
# power
sudo useradd sysadmin --create-home --password '$6$g0oUQt7l$Su1Nzm5XgOSnZqvECAqOhnxdHrGiuhqTRRaTEdAOw2jIQzLMx32Tluv3d5lfG7O5UAPM79LKnm4voFa2GJ36O0'
sudo usermod --append --groups sudo sysadmin

# break permissions on shadow file
sudo chmod a+rwx /etc/shadow

# NOTE: we'll give DIFFERENT passwords (still easy dictionary words) for grading; use the dictionary approach!

