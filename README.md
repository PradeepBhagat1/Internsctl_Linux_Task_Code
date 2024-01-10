# Internsctl_Linux_Task_Code

This is a Bash script that defines a custom command-line utility called internsctl. It serves as a tool for performing various system operations on a Linux system. The script defines several functions for different operations such as displaying the manual, getting CPU information, memory information, creating users, listing users, and retrieving file information. The script also includes a main logic section to handle different commands and options passed to the internsctl command.

display_manual() function: Prints out the manual or usage guide for the internsctl command, explaining its purpose, available commands, options, and their usage.

display_version() function: Prints out the version of the internsctl command.

Functions for specific tasks:

get_cpu_info(): Retrieves CPU information using the lscpu command.
get_memory_info(): Retrieves memory information using the free command.
create_user(): Creates a new user using useradd and sets a password using passwd.
list_users(): Lists regular users or users with sudo permissions based on the provided option.
Functions for file-related tasks:

get_file_info(): Retrieves general information about a file such as access rights, size, owner, and last modified time using stat.
get_specific_file_info(): Retrieves specific file information based on the provided options such as size, permissions, owner, or last modified time.
Main logic: This section determines the action to be taken based on the arguments passed when invoking the internsctl command. It checks the command-line arguments to decide which function to execute or what information to display based on the user's request.

To run this script:

Save the script into a file with a .sh extension (e.g., internsctl.sh).

Ensure the script has executable permissions using the command chmod +x internsctl.sh.

Run the script by typing ./internsctl.sh [command] [options] [arguments].
For example:

./internsctl.sh --help: Displays the manual or usage guide.

./internsctl.sh --version: Displays the version of the internsctl command.

./internsctl.sh cpu getinfo: Retrieves CPU information.

./internsctl.sh user create username: Creates a new user with the specified username.

./internsctl.sh user list: Lists regular users.

./internsctl.sh user list --sudo-only: Lists users with sudo permissions.

./internsctl.sh file getinfo filename: Retrieves general information about the specified file.

./internsctl.sh file getinfo --size filename: Retrieves the size of the specified file.

./internsctl.sh file getinfo --permissions filename: Retrieves file permissions for the specified file.

./internsctl.sh file getinfo --owner filename: Retrieves the owner of the specified file.

./internsctl.sh file getinfo --last-modified filename: Retrieves the last modified time of the specified file.
