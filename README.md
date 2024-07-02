**User and Group Management Script**

This script automates the creation of users and groups on a Linux system. It reads user and group information from a specified input file, creates the necessary users and groups if they do not already exist, assigns the users to their respective groups, and sets random passwords for the users. The script also logs all operations and securely stores user passwords.

**Prerequisites**

The script should be run with root or sudo privileges to create users and groups and set passwords.

______________________________________________________________________________________________________________________________________________________________________________________________________________
**Script Details**

Argument Check

The script checks if exactly one argument (the input file) is provided. If not, it displays an error message and exits.
______________________________________________________________________________________________________________________________________________________________________________________________________________
**Directory and File Setup**

Creates the /var/secure directory if it doesn't exist.

Creates or updates permissions for the password file /var/secure/user_passwords.txt.

Creates the /var/log directory if it doesn't exist.

Creates or updates permissions for the log file /var/secure/user_management.log.
_____________________________________________________________________________________________________________________________________________________________________________________________________________
**Processing the Input File**

Reads the input file line by line.

Splits each line into username and groups based on the ; delimiter.

Trims whitespace from username and groups.
______________________________________________________________________________________________________________________________________________________________________________________________________________
**User Creation**

Checks if the user already exists using id -u.

If the user does not exist, creates the user and logs the action.

Group Creation and Assignment

Splits the groups string into an array of individual group names.

For each group, checks if it exists using getent group.

If the group does not exist, creates the group and logs the action.

Adds the user to each group and logs the action.
______________________________________________________________________________________________________________________________________________________________________________________________________________
**Password Setting**

Generates a random password using openssl rand -base64 12.

Sets the user's password and logs the action.

Appends the username and password to the password file.

