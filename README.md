Note: viewing this document in the Gitlab interface is nice.

![](https://regmedia.co.uk/2015/03/20/office_space.jpg)

# Story
You suspect your boss is embezzling money, and you would really like to obtain your boss's password to gather evidence.
What you do with it is up to you...
Luckily, the sysadmin (who has a sudo account) at your company set the DAC permissions incorrectly on the default Linux password management files.
After learning this, you made friends with a temp worker (to frame him in the event of being found out), and came to an arrangement: 
if the temp will help you get the bosses password, you will write a program that does his job for him, so he can just surf Facebook and Tinder at work all day.
The temp worker does not know how to work "the PuTTY", and he cannot type very fast either, so you can't expect him to type out your commands at the bash terminal.
You can teach him enough to execute a single script via the terminal however.
You job is to write this script, which you can give to your "friend" the temp worker, that he can execute for you, that does the following: 
* processes the password files, 
* cracks the password for the account "yourboss" and "sysadmin"
  outputs the passwords (and only the passwords) to the screen,
* fixes the permissions of the relevant password files to match the **Debian** defaults,
* clears the bash history,
* deletes any log or "dot" / config files created in the process of cracking the password,
* adds the temp worker to the sudo'ers group (for future mischief or framing him).

The user tempworker gave you his password so you can include it in the script: "correctbatteryhorsestaple99" (why he has a reasonably good password is a mystery to you...).
You can't just use the password at any physical terminal though, since someone might notice you at the temp's computer, and you don't want evidence that you logged onto his account with your computer (that's just part of the story, not something you have to do...).
You may also discover that the system administrator's (sysadmin) password is also ironically weak.
Your internet research has discovered the following links about how to perform your task (not all of these will be critical, depending on which tools and methods you choose):

# Your internet research
Sudo and passwords
* http://www.yourownlinux.com/2015/08/etc-shadow-file-format-in-linux-explained.html
* https://www.debian.org/doc/manuals/debian-handbook/sect.user-group-databases.en.html
* https://wiki.debian.org/sudo
* https://unix.stackexchange.com/questions/86748/how-to-properly-configure-sudoers-file-on-debian-wheezy
* https://www.debian.org/doc/manuals/debian-reference/ch04.en.html#_managing_account_and_password_information
* https://www.linuxquestions.org/questions/linux-general-1/execute-command-as-different-user-63197/

Bash and sudo
* https://stackoverflow.com/questions/11955298/use-sudo-with-password-as-parameter
* https://superuser.com/questions/67765/sudo-with-password-in-one-command-line
* https://www.slashroot.in/expect-command-tutorial-linux-example-usage (depending on distro, whether you can su from sub-shell; expect/pexpect should not be needed, unless you're on an old version of debian that restricts su/sudo to tty only. It's also a lot more complicated).

Executing system bash commands in python (if you choose that route):
* https://docs.python.org/3.5/library/subprocess.html#subprocess.run

Bash scripting (if you choose that route, you should learn some basics scripting techniques)
* http://www.linuxcommand.org/lc3_learning_the_shell.php
* http://www.linuxcommand.org/lc3_writing_shell_scripts.php

John and Hashcat (for brute forcing)
* https://www.samsclass.info/123/proj10/p12-hashcat.htm
* https://www.blackmoreops.com/2015/11/10/cracking-password-in-kali-linux-using-john-the-ripper/

Wordlists already in Debian or Kali (for your dictionary inputs):
* /usr/share/wordlists/ (Kali)
* /usr/share/john/password.lst (Both)
* /usr/share/dict/ (Debian)

# Overview
0. Choose whether you want to write:
    * a bash script that occasionally calls a python script for the crypt lib operation (easier), or 
    * a python script that makes repeated bash commands, that may also need to call a bash script in a complicated way (a little harder).
1. Get the password of yourboss using a from-scratch script and nothing other than basic crypto tools (NOT jonh, hashcat, etc.) (60 pts)
2. Get sysadmin's password by using John or Hashcat (NOT the from-scratch method).
   Hint 1: these are in the repos, so don't download them from some random website... (20 pts)
   Hint 2: if you use hashcat, and your host is Windows, turn OFF video acceleration. If you attemp to grab our video cards for acceleration, it will break your code (and you will lose points).
   Also, hashcat is much slower than john (on CPU anyway).
4. Give tempworker sudo ability (5 pts) - this is potentially harder in python with nested bash. (maybe a little tricky; read the links)
5. Fix permissions on the shadow file (debian secure defaults) (5 pts)
6. Clear your tracks, if you left any, like logfiles, history, etc. (5 pts)
7. Screenshot (details below) (5pts)

# Setup
In a fresh install of your Debian or Kali VM (updated to latest software via apt-get), 
run this to setup the assignment:

Check out the file: `setup.sh` in your repo.

# Hints
* Try all your commands at the regular bash command line first!
* You may need to make bash/system calls in python3; the best way to do this is subprocess.run
  I suggest you thoroughly read and understand subprocess.run, rather than just copy-pasting internet code...
* With bash as the main driver, occasionally calling python, it is easier (it's up to you).
* You will want to take and refresh VM snaphshots for testing your code repeatedly (IMPORTANT; don't test on a non-freshly broken VM).
* Any passwords for your script must be typed automatically within your script;
  we will NOT provide any keyboard input during grading running (don't expect we will provide any).
* Please don't spam us with tons of console output.
* You do not have to delete your own script...
* Do NOT assume you will have internet access during runtime (you will not).
* Your script can call other scripts (even other bash or scripts in your repo perhaps).
* Make sure to include all files you want included in the repo.
* Do NOT just take the hashes from the script above and crack those; this will get you a 0. You need to pull them from the shadow file.
* Do NOT assume that you will have anything other than base debian and the installed software listed above.
* If you suspect your john or hashcat may time-out, time them out yourself, so the rest of your script can execute (examples below about timeout syntax), so that if during grading, your hashcat or john times out, you don't lose points for the following stuff. Note: with appropriate arguments, these should take less than 1 minute or so.

# What to submit
* `funandgames.py` OR `funandgames.sh` (but not both)
* Screenshot of how you ran your script and the results produced by your script: 
`It_ran_on_my_machine.png` with LOWERCASE png :)
* Any other scripts you need.

# Running
We will run your script as follows (in the home directory of a random new tempworker we have created without sudo permissions):

At the bash command line (not sh, dash, zsh, but just bash):

Run as unprivileged tempworker (important; actually test this way, NOT as root or sudo!)

-- Refresh snapshot! (actually do this before testing your code)

`./code_to_break_vm_above.sh`

`$ whoami`

`tempworker`

`$ cd /home/tempworker/`

Copy your repo contents to `/home/tempworker/`

`$ pwd`

`/home/tempworker`

`$ timeout 300 python3 funandgames.py`

OR

`$ timeout 300 bash funandgames.sh`

Note: Putting a space before a command means it does not get entered into bash history, IF the environmental variable, HISTCONTROL=ignoreboth, as it is in Debian.

# Password output:
* You can check your program output by doing this (which is how we will run it)

    `$ timeout 300 python3 funandgames.py >myout.txt  # Put space before command`
    
    OR

    `$ timeout 300 bash funandgames.sh >myout.txt  # Put space before command`

    `$ diff myout.txt example-output.txt`

* Make sure you don't have differences with the diff above.
* No output other than the system changes themselves should be produced for the other assignment components (like the permissions changes).

