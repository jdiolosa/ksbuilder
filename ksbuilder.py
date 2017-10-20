import datavg
import os
import subprocess
import os
#Variables
city = ""
name = ""
pip = ""
psubnet = ""
gateway = ""
sip = ""
ssubnet = ""
datavg_mounts = ""
user_name = ""
user_uid = ""
user_gid = ""
user_group_name = ""
user_home_dir = ""
user_shell = ""
user_gecos = ""
group_gid = ""
group_name = ""
mounts = ""
datavg_mounts_li = []
datavg_Groups_li = []
datavg_Users_li = []
#functions
def cls():
    from subprocess import call
    from platform import system
    os = system()
    if os == 'Linux':
        call('clear', shell = True)
    elif os == 'Windows':
        call('cls', shell = True)

def askquestion(question):
    answer = raw_input(question)
    return answer

def run_command(command):
    n = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    (output, err) = n.communicate()

def show_main_menu():
    """Show the main Menu"""
    global city
    ans=True
    while ans:
        cls()
        print("K I C K S T A R T  G E N E R A T O R")
        print("\t1. City:  "+city )
        print("\t2. Network")
        print("\t3. Disk")
        print("\t4. User Add")
        print("\t5. Write")
        print("\t6.Exit/Quit")
        
        ans=raw_input("What would you like to do? ")
        if ans=="1":
            answer = askquestion("Please enter City [kc or stl]? : ")
            if answer in ['kc', 'stl']:
                city = answer
                #return city
                #print(city)
            else:
                print("Please make a valid choice")
        elif ans=="2":
            show_network_menu()
            print("\n Network")
        elif ans=="3":
            show_disk_menu()
            print("\n Disk")
        elif ans=="4":
            print("\n User Add") 
            show_user_menu()
        elif ans=="5":
            print("\n Write") 
            ans = None
        elif ans=="6":
            print("\n Goodbye")
            break
            ans = None
        else:
            print("\n Not Valid Choice Try again")

def show_network_menu():
    """Show the network Menu"""
    global name
    global pip
    global psubnet
    global gateway
    global sip
    global ssubnet
    ans=True
    while ans:
        cls()
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("N E T W O R K  M E N U")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("\t1. Hostname:  "+name )
        print("\t2. Set Primary IP: "+pip )
        print("\t3. Set Primary Subnet: "+psubnet )
        print("\t4. Set Gateway: "+gateway )
        print("\t5. Set Secondary IP: "+sip)
        print("\t6. Set Secondary Subnet Mask: "+ssubnet )
        print("\t7. Main Menu")
        
        ans=raw_input("What would you like to do? ")
        if ans=="1":
            name = askquestion("Please enter The Hostname: ")
            #print(name)
        elif ans=="2":
            pip = askquestion("Please Enter The Primary IP: ")
            #print(pip)
        elif ans=="3":
            psubnet = askquestion("Please enter the Primary Subnet: ")
            #print(psubnet)
        elif ans=="4":
            gateway = askquestion("Please Enter the Gateway: ")
            
            #print(gateway) 
        elif ans=="5":
            sip = askquestion("Please Enter the Secondary IP: ")
            
            #print(sip) 
        elif ans=="6":
            ssubnet = askquestion("Please Enter the Secondary Subnet Mask: ")
            #print(sip)
        elif ans=="7":
            break
        else:
            print("\n Not Valid Choice Try again")

def show_disk_menu():
    #global datavg_mounts_li = [] 
    global datavg_dir_loc
    global datavg_name
    #global datavg_size
    global mounts
    ans=True
    while ans:
        cls()
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("D I S K  M E N U")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("\t1. Add Logical Volume to datavg:  ")
        print("\t2. Main Menu: ")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        for i in datavg_mounts_li:
            print(i)
        #print(datavg_mounts_li)
        ans=raw_input("What would you like to do? ")
        if ans=="1":
            get_datavg_dir_loc = askquestion("Enter Mountpoint: ")
            get_datavg_name = askquestion("Enter Logical Volume Name: ")
            get_datavg_size = askquestion("Enter size in MB: ")
            datavg.Mounts = (get_datavg_dir_loc, get_datavg_name, get_datavg_size)
            datavg_mounts_li.append(datavg.Mounts)
            #print ("\n")
            #print(datavg_mounts_li)
            #print(datavg.Mounts)
        elif ans=="2":
            break
        else:
            print("\n Not Valid Choice Try again")


def show_user_menu():    
    #show_user = [] 
    global user_name
    global user_uid
    global user_gid
    global user_group_name
    global user_home_dir
    global user_shell
    global user_gecos
    global group_gid
    global group_name
    ans=True
    while ans:
        cls()
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("U S E R  A N D  G R O U P  M E N U")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("\t1. Add Groups:  ")
        print("\t2. Add Users: ")
        print("\t3. Main Menu: ")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("Added Groups")
        for groups in datavg_Groups_li:
            print(groups)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("Added Users")
        for users in datavg_Users_li:
            print(users)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        ans=raw_input("What would you like to do? ")
        if ans=="1":
            get_group_gid = askquestion("Enter the GID: ")
            get_group_name = askquestion("Enter the group name: ")
            datavg.Groups = (get_group_gid, get_group_name)
            datavg_Groups_li.append(datavg.Groups)
        elif ans=="2":
            get_user_name = askquestion("Enter the user name: ")
            get_user_uid = askquestion("Enter the user ID: ")
            get_user_gid = askquestion("Enter the GID: ")
            get_user_group_name = askquestion("Enter user group name: ")
            get_user_home_dir = askquestion("Enter the home directory: ")
            get_user_shell = askquestion("Enter the shell path: ")
            get_user_gecos = askquestion("Enter the full user name: ")
            datavg.Groups = (get_user_name, get_user_uid, get_user_gid, get_user_group_name, get_user_home_dir, get_user_shell, get_user_gecos)
            datavg_Groups_li.append(datavg.Groups)
            
        elif ans=="3":
            break
        else:
            print("\n Not Valid Choice Try again")        


def write_KS():
    if city or Hostname or pip or psubnet or gateway is None:
        print("Please Verify All minimum settings")

    elif city =="kc":
        run_command("svn export http://svn.graybar.com/svn/UnixSA/linux/kickstart/KC_CIS-RHEL7.cfg /var/www/html/pub/" + name + ".cfg")
        
        
    elif city =="stl":
         run_command("svn export http://svn.graybar.com/svn/UnixSA/linux/kickstart/STL_CIS-RHEL7.cfg /var/www/html/pub/"+ name+ ".cfg")    
        

    #write network information to named KS file
    #write network information to named KS file
    #run_command("chmod 755 /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/HostName/"+ name+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/10.0.X.Y/"+ pip+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/10.0.30.X/"+ sip+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/10.0.60.X/"+ sip+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/255.255.25X.0/"+ psubnet+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/255.255.25Y.0/"+ psubnet+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #run_command("sed -i s/10.0.X.1/" +gateway+ "/g /var/www/html/pub/"+ name+ ".cfg")
    #time.sleep(3)
    for i in datavg.datavg_mounts_li
        print(datavg_dir_loc)
        #, get_datavg_name, get_datavg_size)
        time.sleep(3)

#Main 
show_main_menu()