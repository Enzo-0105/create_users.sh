#!/bin/bash
# Check if the correct number of arguments is passed
if [ $# -ne 1 ]; then
        echo "pass the required text"
        exit 1
fi

filename=$1
# Create necessary directories and files with appropriate permissions
mkdir -p /var/log
logfile="/var/log/user_management.log"
touch $logfile
chmod 644 $logfile

mkdir -p /var/secure
passwd="/var/secure/user_passwords.txt"
touch $passwd
chmod 600 $passwd

# Process the input file
while IFS=';' read -r user groups; do
    username=$(echo "$user" | xargs)
    groups=$(echo "$groups" | xargs)

    if id -u "$username"; then
        echo "User already exist......... skipping" | tee -a $logfile
    else
        useradd -m "$username"
        echo "user "$username" has been created" | tee -a $logfile
    fi

    IFS=',' read -r -a group_array<<< $groups
    for group in "${group_array[@]}"; do
        if ! getent group "$group" >/dev/null 2>&1; then
            groupadd "$group"
            echo "group "$group" has been created" | tee -a $logfile
        fi
        usermod -aG "$group" "$username"
        echo "user "$username" has been added to group "$group""
    done

    password=$(openssl rand -base64 12)
    echo "$username:$password" | chpasswd
    echo "Password set for user $username" | tee -a $LOGFILE
    echo "$username,$password" >> $passwd
done < "$filename"
