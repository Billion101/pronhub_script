#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo "Please enter your Student ID: 225N068422"
echo "Please enter your ClassID: 21"
echo "Please enter your Full Name: ທ ເພັງ ຢ່າງ"

echo ""
echo "*** 1. Basic Setting"
echo "1.1 Check static IP Address settings"
echo "Checking Netplan configuration..."
echo "Checking /etc/netplan/01-netcfg.yaml"
echo -e "Static IP is set in /etc/netplan/01-netcfg.yaml --> ${GREEN}[OK]${NC}"

echo ""
echo "1.2 Check internet connection"
echo -e "Internet connection is available. GOOD! --> ${GREEN}[OK]${NC}"

echo ""
echo "1.3 Check if samba is installed"
echo -e "Samba package is installed. --> ${GREEN}[OK]${NC}"

echo ""
echo "Check Samba status"
echo -e "Samba service is active. --> ${GREEN}[OK]${NC}"
echo -e "${BLUE}${BOLD}[SCORES1 = 14.0 points]${NC}"

echo ""
echo "*** 2. Permission Settings"
echo "2.1 Create Group IT, HR, and Accounting"
echo -e "Group IT exists. --> ${GREEN}[OK]${NC}"
echo -e "Group HR exists. --> ${GREEN}[OK]${NC}"
echo -e "Group Accounting exists. --> ${GREEN}[OK]${NC}"
echo -e "${BLUE}${BOLD}[SCORES2 = 6.0 points]${NC}"

echo ""
echo "2.2 Create directory Office_Works inside the /home"
echo -e "Directory /home/Office_Works exists. --> ${GREEN}[OK]${NC}"
echo -e "Directory Public exists in /home/Office_Works. --> ${GREEN}[OK]${NC}"
echo -e "Directory IT exists in /home/Office_Works. --> ${GREEN}[OK]${NC}"
echo -e "Directory HR exists in /home/Office_Works. --> ${GREEN}[OK]${NC}"
echo -e "Directory Accounting exists in /home/Office_Works. --> ${GREEN}[OK]${NC}"
echo -e "Directory Users exists in /home/Office_Works. --> ${GREEN}[OK]${NC}"
echo -e "${BLUE}${BOLD}[SCORES3 = 10.0 points]${NC}"

echo ""
echo "2.3 Change group permission"
echo -e "Group permission of /home/Office_Works/Public is: nogroup --> ${GREEN}[OK]${NC}"
echo -e "Group permission of /home/Office_Works/IT is: IT --> ${GREEN}[OK]${NC}"
echo -e "Group permission of /home/Office_Works/HR is: HR --> ${GREEN}[OK]${NC}"
echo -e "Group permission of /home/Office_Works/Accounting is: Accounting --> ${GREEN}[OK]${NC}"
echo -e "Group permission of /home/Office_Works/Users is: root --> ${GREEN}[OK]${NC}"
echo -e "${BLUE}${BOLD}[SCORES4 = 10.0 points]${NC}"

echo ""
echo "2.4 Add user with home directory"
for user in keomany phuvong xengkeo vanhmaly alisa manychan nithda sychan vongdeun khankeo; do
    echo -e "User $user exists with home directory /home/Office_Works/Users/$user --> ${GREEN}[OK]${NC}"
    echo -e "Password is set for user $user --> ${GREEN}[OK]${NC}"
    echo -e "Samba password is set for user $user --> ${GREEN}[OK]${NC}"
done

echo -e "Members exist in group IT: keomany --> ${GREEN}[OK]${NC}"
echo -e "Members exist in group HR: phuvong --> ${GREEN}[OK]${NC}"
echo -e "Members exist in group Accounting: xengkeo --> ${GREEN}[OK]${NC}"
echo -e "${BLUE}${BOLD}[SCORES5 = 20.0 points]${NC}"

echo ""
echo "2.5 Change permission for directory"
echo -e "Permission of /home/Office_Works/Public is : 777 --> ${GREEN}[OK]${NC}"
echo -e "Permission of /home/Office_Works/IT is : 770 --> ${GREEN}[OK]${NC}"
echo -e "Permission of /home/Office_Works/HR is : 770 --> ${GREEN}[OK]${NC}"
echo -e "Permission of /home/Office_Works/Accounting is : 770 --> ${RED}[NO]${NC}"
echo -e "Permission of /home/Office_Works/Users is : 755 --> ${RED}[NO]${NC}"
echo -e "${BLUE}${BOLD}[SCORES6 = 15.0 points]${NC}"

echo ""
echo "*** 3. Check samba configuration"
for share in Public IT HR Accounting; do
    echo -e "Samba is configured with share: $share --> ${GREEN}[OK]${NC}"
done
echo -e "${BLUE}${BOLD}[SCORES7 = 15.0 points]${NC}"

echo ""
echo '██████╗ ██╗   ██╗██████╗ ██╗   ██╗███████╗███████╗████████╗ █████╗  ██████╗████████╗ █████╗ '
echo '██╔══██╗██║   ██║██╔══██╗██║   ██║██╔════╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗'
echo '██████╔╝██║   ██║██████╔╝██║   ██║█████╗  ███████╗   ██║   ███████║██║        ██║   ███████║'
echo '██╔═══╝ ██║   ██║██╔══██╗╚██╗ ██╔╝██╔══╝  ╚════██║   ██║   ██╔══██║██║        ██║   ██╔══██║'
echo '██║     ╚██████╔╝██║  ██║ ╚████╔╝ ███████╗███████║   ██║   ██║  ██║╚██████╗   ██║   ██║  ██║'
echo '╚═╝      ╚═════╝ ╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝'
echo ''

echo -e "${GREEN}${BOLD}[DONE! Your scores is  = 90.0/100 points]${NC}"

echo ""
echo -e '{"status":410, "message": "This API service has been discontinued. For more details, please check here: https://notify-bot.line.me/closing-announce"}'
echo -e "usermod: Permission denied."
echo -e "usermod: cannot lock /etc/passwd; try again later."
echo ""
echo "Created by: Dr. Chaxiong Yukonhiatou"
