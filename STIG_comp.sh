#!/bin/bash
####################################
#Joshua A. King                    #
#13 December 2023                  #
#For IS 480                        #
#STIG Compliance Automation Script #
####################################

###########################################################################
#This script was designed to automate the diagnosis and remedy of several #
#CAT I and CAT II STIG compliance issues with Ubuntu 2020.04.6 per STIG   #
#guidelines for the same.                                                 #
###########################################################################

# Here we start our counters as we will be running several STIGs in this
#script and sending the final results to a .txt file to read
issues_found=0
issues_corrected=0

# We're going to check for blank or null passwords in grep's quiet mode to
#only return if a response was found by searching the
#/etc/pam.d/commonpassword folder for the nullok option, indicating that
#the null or blank password option is enabled. We then adjust the counter
#to reflect the finding.

#About this Rule: Group ID=V-251504,Rule ID=SV-251504r832977
#STIG ID=UBTU-20-010463, CAT I 

if grep -q nullok /etc/pam.d/common-password; then
    echo "Blank or null passwords are currently enabled on this system."
    issues_found=$((issues_found + 1))

#If the inquiry finds the nullok option, we inform the user of such and
#ask the user if they would like to fix this issue.

    read -p "Do you wish to correct this issue? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then

#If the user wishes to correct the issue, we use the sed command to remove
#instances of the nullok option in the folder, notify the user of the 
#action taken, and reflect the change in the counter.

        sudo sed -i '/nullok/d' /etc/pam.d/common-password
        echo "Blank or null passwords have been disabled."
        issues_corrected=$((issues_corrected + 1))

#If the user wishes not to make the changes, that action is repeated to
#the user and no change is made to the counter.

    else
        echo "No changes were made."
    fi

#If no nullok options are listed in the /etc/pam.d/common-password file
#no counters are changed and no actions were taken.

else
    echo "Blank or null passwords are not enabled on this system."
fi

#About this rule: Group ID=V-238326, Rule ID=SV-238326r877396
#STIG ID=UBTU-20-010405 , CAT I

#Next we're going to look to see if the telnet package is installed and 
#follow the same procedures to notify the user.

if dpkg -l | grep -q telnetd; then
    echo "The telnet package is currently installed on this system."
    issues_found=$((issues_found + 1))

#If the command found the telnet package, we're going to ask the user
#if they would like it removed and if so remove it.

    read -p "Do you wish to correct this issue? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        sudo apt-get remove telnetd
        echo "The telnet package has been removed."
        issues_corrected=$((issues_corrected + 1))
    else
        echo "No changes were made."
    fi

#If the telnet package was not found to be installed, no action is taken

else
    echo "The telnet package is not installed on this system."
fi

#About this rule: Group ID=V-238327 , Rule ID=SV-238327r654156
#STIG ID=UBTU-20-010406 CAT I

#Now we will check the OS to make sure the rsh-server package is not installed

if dpkg -l | grep -q rsh-server; then
    echo "The rsh-server package is currently installed on this system."
    issues_found=$((issues_found + 1))

#If the command found the rsh-server package, we're going to ask the user
#if they would like it removed and if so remove it.

    read -p "Do you wish to correct this issue? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        sudo apt-get remove rsh-server
        echo "The rsh-server package has been removed."
        issues_corrected=$((issues_corrected + 1))
    else
        echo "No changes were made."
    fi

#If the rsh-server package was not found to be installed, no action is taken

else
    echo "The rsh-server package is not installed on this system."
fi

##About this rule: Group ID=V-238199 , Rule ID=SV-238199r653772
#STIG ID=UBTU-20-010004 CAT II

#Now we are checking the system to make sure that a graphic user interface
#session lock.

#Since we know that the system should return true if the GUI lock is enabled, we'll just
#set the inquiry to its own variable and test it against the return.

gui_lock=$(sudo gsettings get org.gnome.desktop.screensaver lock-enabled)

if [[ "$gui_lock" != *true* ]]; then
    echo "This OS has no GUI lock enabled."
    issues_found=$((issues_found + 1))

#Asking the user if they'd like to correct the issue:

    read -p "Do you wish to correct this issue? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then

#Enabling the GUI screen lock feature.

        sudo gsettings set org.gnome.desktop.screensaver lock-enabled
	echo "The GUI lock has been enabled."
	issues_corrected=$((issues_corrected + 1))
    else
	echo "No changes were made."
    fi


#If the system already has this feature enabled:

else
    echo "The GUI lock is already enabled on this system."

#About this rule: Group ID=V-238371 , Rule ID=SV-238371r880913
#STIG ID=UBTU-20-010450 CAT II

#Now we will check the OS to make sure the AIDE package is installed.

#Notice we had to reverse how the 'if' statement was presented, as we're looking for an
#output as a positive result this time, not a finding.

if sudo dpkg -l | grep -q aide; then
    echo "The aide package is currently installed on this system."
    issues_found=$((issues_found + 1))


#If the aide package was found to be installed, no action is taken

else
    echo "The aide package is not installed on this system."
    issues_found=$((issues_found + 1))

#If the command did not find the aide package, we're going to ask the user
#if they would like it installed and if so install it.

    read -p "Do you wish to correct this issue? (y/n): " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        sudo apt install aide
        echo "The aide package has been installed."
        issues_corrected=$((issues_corrected + 1))
    else
        echo "No changes were made."
    fi

fi



#Now we're going to tally up our variables and write our findings to STIG_comp_2023.txt
echo "Issues found: $issues_found" > STIG_comp_2023.txt
echo "Issues corrected by user: $issues_corrected" >> STIG_comp_2023.txt
fi
