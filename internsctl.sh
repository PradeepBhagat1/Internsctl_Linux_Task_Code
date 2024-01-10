#!/bin/bash

# Function to display command manual
display_manual() {
    echo "MANUAL: internsctl"
    echo "DESCRIPTION:"
    echo "  Custom Linux command 'internsctl' v0.1.0 for various system operations."
    echo "USAGE:"
    echo "  internsctl [command] [options] [arguments]"
    echo "COMMANDS:"
    echo "  cpu getinfo        : Get CPU information"
    echo "  memory getinfo     : Get memory information"
    echo "  user create <name> : Create a new user"
    echo "  user list          : List regular users"
    echo "  user list --sudo-only : List users with sudo permissions"
    echo "  file getinfo <file>: Get file information"
    echo "OPTIONS:"
    echo "  --help             : Display usage information"
    echo "  --version          : Display command version"
    echo "FILE INFO OPTIONS:"
    echo "  --size, -s         : Print file size"
    echo "  --permissions, -p  : Print file permissions"
    echo "  --owner, -o        : Print file owner"
    echo "  --last-modified, -m: Print last modified time"
}

# Function to display command version
display_version() {
    echo "internsctl v0.1.0"
}

# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free
}

# Function to create a new user
create_user() {
    if [[ ! -z "$1" ]]; then
        sudo useradd "$1"
        sudo passwd "$1"
    else
        echo "Usage: internsctl user create <username>"
    fi
}

# Function to list regular users or sudo users
list_users() {
    if [[ "$1" == "--sudo-only" ]]; then
        getent group sudo | cut -d: -f4 | tr ',' '\n'
    else
        awk -F: '$3 >= 1000 && $3 != 65534 { print $1 }' /etc/passwd
    fi
}

# Function to get file information
get_file_info() {
    filename="$1"
    echo "File: $filename"
    stat_output=$(stat -c "Access: %A\nSize(B): %s\nOwner: %U\nModify: %y" "$filename")
    echo "$stat_output"
}

# Function to get specific file information based on options
get_specific_file_info() {
    filename="$2"
    option="$1"

    case "$option" in
        "--size" | "-s")
            stat -c "%s" "$filename"
            ;;
        "--permissions" | "-p")
            stat -c "%A" "$filename"
            ;;
        "--owner" | "-o")
            stat -c "%U" "$filename"
            ;;
        "--last-modified" | "-m")
            stat -c "%y" "$filename"
            ;;
        *)
            echo "Invalid option! Usage: internsctl file getinfo [options] <file-name>"
            ;;
    esac
}

# Main logic to handle commands and options
if [[ "$1" == "--help" ]]; then
    display_manual
elif [[ "$1" == "--version" ]]; then
    display_version
elif [[ "$1" == "cpu" && "$2" == "getinfo" ]]; then
    get_cpu_info
elif [[ "$1" == "memory" && "$2" == "getinfo" ]]; then
    get_memory_info
elif [[ "$1" == "user" && "$2" == "create" ]]; then
    create_user "$3"
elif [[ "$1" == "user" && "$2" == "list" ]]; then
    list_users "$3"
elif [[ "$1" == "file" && "$2" == "getinfo" && ! -z "$3" ]]; then
    if [[ "$3" == "--size" || "$3" == "-s" || "$3" == "--permissions" || "$3" == "-p" || "$3" == "--owner" || "$3" == "-o" || "$3" == "--last-modified" || "$3" == "-m" ]]; then
        get_specific_file_info "$3" "$4"
    else
        get_file_info "$3"
    fi
else
    echo "Invalid command or options. Please refer to the documentation."
fi
