#!/bin/bash

# This should be executed as root or sudo on your Kali or Debian VM, when internet is available.
# Internet will NOT be available during runtime, 
# nor will any packages besides base debian and the following be installed:

# Installs the needed tools (will be available on the grader)
sudo apt install john hashcat wamerican* expect python3-pexpect libpam-cracklib

# Creates tempworker's account and password
# correctbatteryhorsestaple99
sudo useradd tempworker --create-home --password '$6$g1VamdqE$RiEKGpb7gemh1Zt2JyVPq4Gzp/a2wTE5CPxNu97YaFfjS4wqbL2Nj1ousP2NWrUtjoVWw2nm8KdIcHzgzkw7R.'

# Creates yourboss's account and password
# short
sudo useradd yourboss --create-home --password '$6$lXb4rYiLvLe3miaV$2cQHcoD8HyGc7tKDrbyaJfMQiN548yy6OuCWyXP6PAiBJGq7EixN71mJzypzI2q0JzwkLrwGKghPWyaNjvovZ/'
sudo usermod --append --groups sudo yourboss

# Creates sysadmin's account and password
# simple
sudo useradd sysadmin --create-home --password '$6$zFTUNOKptiQz/Xv8$.KCQXCzoiIjAKX9Ayf3Ji8tx.ncBLhm.AfCvEKSBBfTL/3mt8vnY1Ako4ssMHoDl0C6VtnRpsMuxmodWp36sL1'
sudo usermod --append --groups sudo sysadmin

# break permissions on shadow file
sudo chmod a+rwx /etc/shadow

# NOTE: we'll give DIFFERENT passwords (still easy dictionary words) for grading; use the dictionary approach!

