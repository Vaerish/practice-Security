#!/bin/bash
# assumes you have a fresh debian install with sudo permissions and no other software added.
# optional argument of username names your results file
# bug bounty: 5 points for finding a significant bug in this script (I don't know if there are any)!

grade_update()
{
    # updates grade and prints based on return code of preceeding statement
    # usage: grade_update test_name points_to_add
    return_status=$?
    echo Test for "$1": >>$student_file
    if (( return_status == 0 ))
    then
        echo pass for "$2" points >>$student_file
        (( grade = grade + "$2" ))
    else
        echo fail for 0 more points >>$student_file
    fi
    echo >>$student_file
}

# setup
./setup_grading.sh >/dev/null 2>&1
# moves the contents of whole student repo into /home/tempworker:
sudo cp -r . /home/tempworker/
# setup permissions for student files:
sudo chmod +x /home/tempworker/*.py
sudo chmod +x /home/tempworker/*.sh
sudo chown -R tempworker /home/tempworker
sudo chgrp -R tempworker /home/tempworker

# if Debian, this section has to be posix-dash compatible, 
# e.g., [ ] insteaf of bash [[ ]] 
su tempworker <<crack_stuff
    cd /home/tempworker

    if [ -f "funandgames.sh" ]
    then
        timeout 600 bash funandgames.sh >your_out.txt
    elif [ -f "funandgames.py" ]
    then
        timeout 600 python3 funandgames.py >your_out.txt
    fi
crack_stuff

student_file=$1_result.txt

# for re-running
if [[ -f $student_file ]]
then
    rm $student_file
fi

grade=0

# TODO add back -x option next year (being nice/easier this year).
#sudo grep -Fxq bear /home/tempworker/your_out.txt
sudo grep -Fq bear /home/tempworker/your_out.txt
grade_update boss 60

#sudo grep -Fxq dragon /home/tempworker/your_out.txt
sudo grep -Fq dragon /home/tempworker/your_out.txt
grade_update sysadmin 20

[[ ! -d '/home/tempworker/.john' && \
   ! -d '/home/tempworker/john.log' && \
   ! -d '/home/tempworker/john.pot' && \
   ! -d '/home/root/.john' && \
   ! -d '/home/root/john.log' && \
   ! -d '/home/root/john.pot' && \
   ! -d '/home/yourboss/.john' && \
   ! -d '/home/yourboss/john.log' && \
   ! -d '/home/yourboss/john.pot' && \
   ! -d '/home/sysadmin/.john' || \
   ! -d '/home/sysadmin/john.pot' || \
   ! -d '/home/sysadmin/john.log' || \
   ! -d '/home/tempworker/.hashcat' && \
   ! -d '/home/root/.hashcat' && \
   ! -d '/home/yourboss/.hashcat' && \
   ! -d '/home/sysadmin/.hashcat' ]]
grade_update '.john or .hashcat' 2

if [[ ! -f '/home/tempworker/.bash_history' ]]
then
    grade_update '.bash_history' 3
else
    [[ $(sudo wc -l /home/tempworker/.bash_history | cut --delimiter=' ' --fields=1) -lt 2 && \
       $(grep -c 'funandgames' /home/tempworker/.bash_history) -lt 1 ]]
    grade_update '.bash_history' 3
fi

[[ -f '/home/tempworker/It_ran_on_my_machine.png' ]]
grade_update screenshot 5

# loosely tolerating 0600 and 0640 both (this could be more precise...)
stat /etc/shadow | grep -q 'Access: (06.0/-rw-.-----)'
grade_update 'permissions on /etc/shadow' 5

groups tempworker | grep -Fxq 'tempworker : tempworker sudo'
grade_update 'tempworker got sudo' 5

echo -e "Your grade total is:\n"$grade >>$student_file
echo >>$student_file

