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
# bear
sudo useradd yourboss --create-home --password '$6$f.lo6DhcRgGd9oxs$EvBzwuesXmGorax4qWwPOFWi9RhRwbd6SicbQTBo1thAm.vkz8ogEtuZlyuRLM7xcv6D8GYpKdlAUJ3AeZQz60'
sudo usermod --append --groups sudo yourboss

# Creates sysadmin's account and password
# dragon
sudo useradd sysadmin --create-home --password '$6$AhOS5aOcn6zAn99p$nO2z9CZ/C/cLIoXT9yU4A74wgPq11UKGme/dhnNPqCi67uPUH27gCiuf9nHVvvLImcZoXvsVw7W/RTHjgMe22.'
sudo usermod --append --groups sudo sysadmin

# break permissions on shadow file
sudo chmod a+rwx /etc/shadow

# NOTE: we'll give DIFFERENT passwords (still easy dictionary words) for grading; use the dictionary approach!

