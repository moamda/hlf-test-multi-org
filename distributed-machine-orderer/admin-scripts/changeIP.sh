#!/bin/bash

clear

# Define folder name
# Parent directory
parentFolder="../"
ipList="../../distributed-machine-orderer/admin-scripts/ip-list.txt"

# List of Operations.
echo " ---------------------------------- "
echo "|   Welcome to Modification Area   |"
echo "|----------------------------------|"
echo "| Select operation you want to use |"
echo "|                                  |"
echo "| [1] Change IP address            |"
echo "| [2] View IP address occurrences  |"
echo "| [3] Change PORT number           |"
echo " ---------------------------------- "

# Prompt the user for the operation number.
read -p "Enter the operation number: " operation
echo

case $operation in
1)
    # Display folder used,
    # Display (PWD) directory,
    # Display IP addresses found.
    echo -e "\e[0;33mSelected folder: $parentFolder"distributed-machine-orderer"\e[0m"
    echo -e "\e[0;33mCurrent directory of script: $(pwd)\e[0m"
    echo -e "\e[0;33mIP addresses found;\e[0m"

    # This line will display IP list of associated Organization
    ip_addresses=$(grep -rhoE '^[^#]*([0-9]{1,3}\.){3}[0-9]{1,3}' "$ipList" | sort -u)
    echo "$ip_addresses" | nl -n ln -s ' ' -w 2 -s ') '
    echo

    # Prompt the user to select the IP address to change
    read -p "Enter the number of the IP address to change: " ip_selection

    # Validate the user input
    if [[ $ip_selection -gt 0 && $ip_selection -le $(echo "$ip_addresses" | wc -l) ]]; then
        selected_ip=$(echo "$ip_addresses" | sed "${ip_selection}q;d")

        # Prompt the user for the new IP address
        read -p "Enter the new IP address for $selected_ip: " new_ip_address

        # Check if the input is a valid IP address
        if [[ ! $new_ip_address =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            echo -e "Invalid IP address format. Modification aborted." | sed -E 's/.*/\x1b[31m&\x1b[0m/'
        else
            # Display a confirmation message
            echo " ------------------------------------- "
            echo "| Confirmation                        |"
            echo "|-------------------------------------|"
            echo "| [1] Yes                             |"
            echo "| [2] No                              |"
            echo " ------------------------------------- "
            echo "Are you sure you want to change all occurrences of IP address $selected_ip to $new_ip_address?"
            read -p "Enter operation number: " confirmation

            # Check the user's response
            if [[ $confirmation == "1" || $confirmation == "yes" ]]; then
                # Perform the replacement using sed recursively on all files in the folder
                find "$parentFolder" -type f -exec sed -i "s/\b${selected_ip}\b/${new_ip_address}/g" {} +
                echo -e "\e[0;32mModification complete.\e[0m"
            else
                echo -e "Modification aborted." | sed -E 's/.*/\x1b[31m&\x1b[0m/'
            fi
        fi
    else
        echo -e "Invalid selection. Modification aborted." | sed -E 's/.*/\x1b[31m&\x1b[0m/'
    fi
    ;;
2)
    # Display IP address occurrences
    echo -e "\e[0;33mSelected folder: $parentFolder:\e[0m"
    echo -e "\e[0;33mCurrent directory: $(pwd)\nIP addresses found:\e[0m \e[0;32m - Disregard IP addresses with #, these are not included when modifying configuration: \e[0m"
    grep -rE --color=always '([0-9]{1,3}\.){3}[0-9]{1,3}' "$parentFolder" | sed -E 's/([^:]+):/\x1b[35m\1\x1b[0m:/; s/([0-9]{1,3}\.){3}[0-9]{1,3}/\x1b[31m&\x1b[0m/g'

    ;;
3)
    echo -e "Operation not available." | sed -E 's/.*/\x1b[31m&\x1b[0m/'
    ;;
*)
    echo -e "Invalid operation number." | sed -E 's/.*/\x1b[31m&\x1b[0m/'
    ;;
esac
