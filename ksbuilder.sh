#!/bin/bash
# Kickstart file Generator  
#Written By Joe Diolosa
#Last Edited By###########Date#####Version
#Joe Diolosa   sept 12 2017  1.0
#Joe Diolosa   sept 19 2017  2.0 added Disk, User, groups
## ----------------------------------
# Step #1: Define variables
# ----------------------------------
RED='\033[0;41;30m'
STD='\033[0;0;39m'
declare -a run_added_datavg=()
declare -a show_added_datavg=()
declare -a show_added_users=()
declare -a run_added_users=()
declare -a show_added_groups=()
# ----------------------------------
# Step #2: User defined function
# ----------------------------------
function pause (){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

#Function to get hostname and store it in variable
function get_host_name (){
	echo -n "Please enter the hostname: "
    read name
}
 
#Function to get IP and store it in variable 
function get_pip (){
	echo -n "Please enter the IP: "
	read PIP
}
 
#Function to get Secondary IP and store it in variable 
function get_sip (){
	echo -n "Please enter the Secondary IP: "
	read SIP
} 

#Function to get Primary Subnet Mask and store it in variable
function get_psubnet_mask () {
	echo -n "Please Enter Primary Subnet Mask: "
	read PSubnet	
}

#Function to get Primary Subnet Mask and store it in variable
function get_ssubnet_mask () {
	echo -n "Please Enter Secondary Subnet Mask: "
	read SSubnet	
}

#Function to get gateway and store it in a variable
function get_gateway () {
	echo -n "Please Enter The Gateway: "
	read Gateway
}

#Function to set city to KC or STL
function get_city () {
local choice
	read -p "Enter City [ kc or stl ] " choice
	case $choice in
		kc) city=kc ;;
		stl) city=stl ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && clear
	esac	

}

#function to get disk information for datavg.
function get_datavg_add () {
	echo -n "Enter Mountpoint: "
	read datavg_dir_loc
	echo -n "Enter Logical Volume Name: "
	read datavg_name
	echo -n "Enter size in MB: "
	read datavg_size_mb
	show_added_datavg+=("$datavg_dir_loc | $datavg_name | $datavg_size_mb")
	datavg_dir_loc2=$(echo "$datavg_dir_loc" | sed 's/\//\\\//g')
	run_added_datavg+=("/bin/sed -i \"/^volgroup datavg.*$/alogvol $datavg_dir_loc2 --fstype xfs --name=$datavg_name --vgname=datavg --size=$datavg_size_mb"\")
}

function get_group_add () {
	echo -n "Enter the GID: "
	read group_gid
	echo -n "Enter Group Name: "
	read group_name
	show_added_groups+=("$group_name $group_gid")
	run_added_groups+=("/bin/sed -i \"/^#Groups.*$/agroupadd -g $group_gid $group_name"\")

}

function get_user_add () {
	echo -n "Enter the Username: "
	read user_name
	echo -n "Enter User ID: "
	read user_uid
	echo -n "Enter the GID: "
	read user_gid
	echo -n "Enter User Group Name: "
	read user_group_name
	echo -n "Enter the Home Directory: "
	read user_home_dir
	echo -n "Enter the Shell (ie /bin/bash): "
	read user_shell
	echo -n "Enter full user name: "
	read user_gecos
	show_added_users+=("$user_name $user_id $user_gid $user_group_name $user_home_dir $user_passwd $user_shell $user_gecos")
	user_home_dir2=$(echo "$user_home_dir" | sed 's/\//\\\//g')
	run_added_users+=("/bin/sed -i \"/^#Users.*$/auseradd -u $user_gid -g \'$user_group_name\' -d \'$user_home_dir2\' -m -p \'$user_name\' -s \'$user_shell\' -c \'$user_gecos\' $user_name"\")
}

#Function to display Main Menu
function show_main_menus () {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " K I C K S T A R T  G E N E R A T O R"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. City :" $city
	echo "2. Network"
	echo "3. Disk" 
	echo "4. User Add"
	echo "5. Write"
	echo "6. Exit"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

#read main menu options
read_main_menus () {
	local main
	read -p "Enter choice [ 1 - 6 ] " main
	case $main in
		1) get_city
		   show_network_menus ;;
		2) show_network_menus 
			read_network_options ;;
		3) show_disk_menus
			read_disk_options ;;
		4) show_user_menus
			read_user_menus ;;
		5) Write_KS ;;
		6) exit 0 ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && clear
	esac 
}

#Function to display menus
function show_network_menus () {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " N E T W O R K  M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Set Host Name :" $name
	echo "2. Set Primary IP :" $PIP
	echo "3. Set Primary Subnet Mask :" $PSubnet
	echo "4. Set Gateway :" $Gateway 
	echo "5. Set Secondary IP :" $SIP
	echo "6. Set Secondary Subnet Mask :" $SSubnet
	echo "7. Back"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

# read input from the keyboard and take a action
function read_network_options(){
while true
do
	local choice
	read -p "Enter choice [ 1 - 7 ] " choice
	case $choice in
		1) get_host_name 
		   show_network_menus ;;
		2) get_pip 
		   show_network_menus ;;
		3) get_psubnet_mask 
		   show_network_menus ;;
		4) get_gateway
			show_network_menus ;;
		5) get_sip
			show_network_menus ;;
		6) get_ssubnet_mask 
		   show_network_menus ;;
		7) break ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2 && clear
	esac
done
}

#Function to display Disk menu
function show_disk_menus () {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " D I S K  M E N U"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Add Logical Volume to datavg"
        echo "2. Back"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		echo "Mountpoint lvname     size"
        printf '%s\n' "${show_added_datavg[@]}"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

#read imput from keyboard and take action
function read_disk_options () {
while true
do
        local main
        read -p "Enter choice [ 1 - 2 ] " main
        case $main in
                1) get_datavg_add
                   show_disk_menus ;;
                2) break ;;
				*) echo -e "${RED}Error...${STD}" && sleep 2 && clear
        esac
done
}

#function to display user add menu
function show_user_menus () {
	clear
		clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo " U S E R  A N D  G R O U P  M E N U"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Add Groups"
		echo "2. Add Users"
        echo "3. Back"
		echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		echo "Groups"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        printf '%s\n' "${show_added_groups[@]}"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
		echo "Users"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        printf '%s\n' "${show_added_users[@]}"
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
} 

#read imput from keyboard and take action
function read_user_menus () {
while true
do
        local main
        read -p "Enter choice [ 1 - 3 ] " main
        case $main in
                1) get_group_add
                   show_user_menus ;;
				2) get_user_add
				   show_user_menus ;;
                3) break ;;
                *) echo -e "${RED}Error...${STD}" && sleep 2 && clear
        esac
done
}

#Function to Write out Kickstart.  this will copy the file from svn rename it
#edit all of the variables
function Write_KS () {
	if [[ -z $city || -z $name || -z $PIP || -z $SIP || -z $PSubnet || -z $SSubnet || -z $Gateway ]]; then
		echo "Please Verify All variables are setup"
		pause
	fi 

	if [[ $city = "kc" ]]; then
		svn export http://svn.graybar.com/svn/UnixSA/linux/kickstart/KC_CIS-RHEL7.cfg /var/www/html/pub/$name.cfg
		
	elif [[ $city = "stl" ]]; then
		svn export http://svn.graybar.com/svn/UnixSA/linux/kickstart/STL_CIS-RHEL7.cfg /var/www/html/pub/$name.cfg
		mv ./STL_CIS-RHEL7.cfg ./$name.cfg
	fi
#Write network information to Named KS file
chmod 755 /var/www/html/pub/$name.cfg
sed -i "s/HostName/$name/g" /var/www/html/pub/$name.cfg
sed -i "s/10.0.X.Y/$PIP/g" /var/www/html/pub/$name.cfg
sed -i "s/10.0.30.X/$SIP/g" /var/www/html/pub/$name.cfg
sed -i "s/10.0.60.X/$SIP/g" /var/www/html/pub/$name.cfg
sed -i "s/255.255.25X.0/$PSubnet/g" /var/www/html/pub/$name.cfg
sed -i "s/255.255.25Y.0/$SSubnet/g" /var/www/html/pub/$name.cfg
sed -i "s/10.0.X.1/$Gateway/g" /var/www/html/pub/$name.cfg
#write disk info out
for (( i=$((${#run_added_datavg[@]} -1 )) ; i >= 0; i--))
	do
    	eval ${run_added_datavg[$i]}  /var/www/html/pub/$name.cfg
	done
#Write Group info out to file
for (( i=$((${#run_added_groups[@]} -1 )) ; i >= 0; i--))
	do
    	eval ${run_added_groups[$i]}  /var/www/html/pub/$name.cfg
	done
#Write User info out to file
for (( i=$((${#run_added_users[@]} -1 )) ; i >= 0; i--))
	do
     	eval ${run_added_users[$i]}  /var/www/html/pub/$name.cfg
	done
}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
	show_main_menus
	read_main_menus
done