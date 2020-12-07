#!/bin/bash  
  
# This variable tells the system there will be a delay of 5 seconds before exiting to menu  
DELAY=5  
	  
# This While loop cycles through the here document prompting the user to select an option  
while [[ "$REPLY" != 0 ]]; do  
	clear  
	cat <<-_EOF_  
	Please Select:  
	  
	1. Display Free Memory on Server  
	2. Display Free Storage Space on Server  
	3. Top 5 Processes Sorted by Memory Usage  
	4. Display Hostname, Up-time and IP  
	5. Test Internet Functionality  
	6. Display/Modify State of Services.  
	7. Exit  	  
	_EOF_  
	  
# The read command below prompts the user to input their selection  
	read -p "Enter your selection [1-7]>"  
	  
# The below IF statements use the result of the REPLY variable to determine the next decision step  
	if [[ "$REPLY" =~ ^[1-7]$ ]]; then  
	  
# The nested IF statements dictate which command will run based on user input  
# Choice 1 will  run the command to view the available free memory on the server  
	    if [[ "$REPLY" == 1 ]]; then  
	        echo "AMOUNT OF FREE MEMORY (RAM)"  
	        free -m  
	        sleep "$DELAY"  
	    fi  
# Choice 2 will run the command to display the storage space utilization on the server  
	    if [[ "$REPLY" == 2 ]]; then  
	        echo "STORAGE SPACE UTILIZATION"  
	        df  
	        sleep "$DELAY"  
	    fi  
# Choice 3 will displays the top 5 processes which utilze memory   
	    if [[ "$REPLY" == 3 ]]; then  
	        echo "TOP 5 PROCESSES UTILIZING MEMORY"  
	        ps aux --sort -rss | head -n 6  
	        sleep "$DELAY"  
	    fi  
# Choice 4 will display the server Hostname, Server Up-Time, and IP Address only   
	    if [[ "$REPLY" == 4 ]]; then  
	        echo "HOSTNAME:"  
	        hostname  
	        echo -e '\n'  
	        echo "UP-TIME:"  
	        uptime  
	        echo -e '\n'  
	        echo "IP ADDRESS:"  
	        hostname -I  
	        sleep "$DELAY"  
	    fi  
# Choice 5 will conduct a Internet Connectivity test using the wget command to  
# retrieve data via google.ca, then displaying if online or offline  
	    if [[ "$REPLY" == 5 ]]; then  
	        wget -q --spider http://google.ca  
	        if [ $? -eq 0 ]; then  
	            echo "CONNECTED"  
	        else  
	            echo "DISCONNECTED"  
	        fi  
	        sleep "$DELAY"  
	    fi  
# Choice 6 will first display a list of running services. Prompt will ask user to choose  
# 1-3 start, stop, restart services. After selection, script will display update to service  
# then revert to menu  
	    if [[ "$REPLY" == 6 ]]; then  
	        systemctl list-units --type=service --state=running  
	        cat <<-_EOF1_  
	        Please Select:  
	  
	        1. Stop Service  
	        2. Start Service  
	        3. Restart Service  
	  
	        _EOF1_  
	  
	        read -p "Enter Selection [1-3]>"  
# The following IF statements will run commands based on the prior user selection  
# Selections are stored in their own variable to call upon  
	        if [[ "$REPLY" == 1 ]]; then  
	            read -p "Type the service to stop [ex. vsftpd]:" userselect1  
	            sudo systemctl stop $userselect1  
	            sudo service $userselect1 status  
	            sleep "$DELAY"  
	        fi  
	        if [[ "$REPLY" == 2 ]]; then  
	            read -p "Type the service to start [ex. vsftpd]:" userselect2  
	            sudo systemctl start $userselect2  
	            sudo service $userselect2 status  
	            sleep "$DELAY"  
	        fi  
	        if [[ "$REPLY" == 3 ]]; then  
	            read -p "Type the service to restart [ex. vsftpd]:" userselect3  
	            sudo systemctl restart $userselect3  
	            sudo service $userselect3 status  
	            sleep "$DELAY"  
	        fi  
	    fi  
# Choice 7 will exit the script back to the command line  
	    if [[ "$REPLY" == 7 ]]; then  
	        echo "Exiting.."  
	        exit  
	    fi  
# If user chooses option not listed, they will be prompted with Invalid Response  
# and will be sent back to the script menu  
	    else  
	        echo "Invalid Reponse"  
	        sleep "$DELAY"  
	    fi  
done 
