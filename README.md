# Stage
 Veuillez trouver les projets réalisés sous le framework SNSTER. 
 
 Please find the projects completed under the SNSTER framework.

 Please consult the sites below for a better understanding:
  https://github.com/flesueur/mi-lxc
  https://framagit.org/flesueur/snster

 Recap : 
  SNSTER (System and Network Simulator for hipsTERs, pronounced "senster") is a rapid prototyping framework for simulating computer infrastructures. It is based on the infrastructure-as-code principle: scripts programmatically         generate the target environment. The small memory footprint of LXC combined with differential images allows to run it on modest hardware such as standard laptops. SNSTER was originally a part of MI-LXC(v1). Since version 2, MI-LXC   uses SNSTER from this repository.

 how to use : 
   Download the milxc-snster-vm-2.1.0.ova oracle virtualbox file and import that.
   Customize the configuration depend on your hardware.
   
   Username: root or debian
              |         |
              |         |
   Password: root or debian
   
  Minimum requirements:
    - 4 GB RAM 
    - 60 GB free disk space.

  Within the 'vscode' folder, you'll find the VSCode workspace configuration. I highly recommend using VSCode. Download all the files from GitHub, place them in the root directory, and extract them.

  Example:
  For this example, I will use the 'OSPF' folder.

  The OSPF folder contains:
   A folder named RouterOSPF, which has subfolders and a group.yml file.
   A folder named Hosts, also with subfolders and a group.yml file.
   Additionally, there's a main.yml file.

 Each subfolder contains the configuration file for each host, commonly referred to as provision.sh . In group.yml , you can define each host's network configurations and utilize templates. The main.yml file allows you to    
 specify the OS to be used with LXC containers and to configure the LXC container bridge.

  Now, open the terminal and navigate to the OSPF folder. Here are the SNSTER commands:

  ------------------------------------------------------------------------------------------------------------------------------------------------
  
  create [name]: Creates the [name] container. By default, it creates all containers.

  root@milxc-snster-vm:~/OSPF# snster create

  or 

  root@milxc-snster-vm:~/OSPF# snster create RouterOSPF-R1
  
 ------------------------------------------------------------------------------------------------------------------------------------------------
 
  start :	Starts the created infrastructure
 
  root@milxc-snster-vm:~/OSPF# snster start
  
  ------------------------------------------------------------------------------------------------------------------------------------------------
  
  stop :	Stops the created infrastructure
 
  root@milxc-snster-vm:~/OSPF#  snster stop

  ------------------------------------------------------------------------------------------------------------------------------------------------
  
  attach [user@]<name> [command]: Attaches a terminal to <name> as [user] (defaults to root) and executes [command] (defaults to interactive shell).
 
  root@milxc-snster-vm:~/OSPF# snster attach  RouterOSPF-R1
 
  or 
 
  root@milxc-snster-vm:~/OSPF# snster attach debian@RouterOSPF-R1
 
 ------------------------------------------------------------------------------------------------------------------------------------------------
 
  display [user@]<name>: Displays a graphical desktop on <name> as [user] (defaults to debian).
 
  root@milxc-snster-vm:~/OSPF# snster display RouterOSPF-R1
 
  or
  
  root@milxc-snster-vm:~/OSPF# snster display root@RouterOSPF-R1
  
  ------------------------------------------------------------------------------------------------------------------------------------------------
  
  print :	Graphically displays the defined architecture
 
  root@milxc-snster-vm:~/OSPF# snster print 

 ------------------------------------------------------------------------------------------------------------------------------------------------
  
 renet :	Renets all the containers

 root@milxc-snster-vm:~/OSPF# snster renet

 ------------------------------------------------------------------------------------------------------------------------------------------------
 
 destroy [name] 	: Destroys the [name] container, defaults to destroy all containers

 root@milxc-snster-vm:~/OSPF# snster destroy RouterOSPF-R1

 ------------------------------------------------------------------------------------------------------------------------------------------------

 Note: For the "attach" ,  "display" and "destroy" commands, you must specify the group folder name followed by the host folder. 

  exemple : 

   root@milxc-snster-vm:~/OSPF# snster attach  RouterOSPF-R2
 
   RouterOSPF-R2
   R2 |------> Host folder name
   RouterOSPF |------------------> Groupe folder name
   

------------------------------------------------------------------------------------------------------------------------------------------------

 destroymaster : Destroys all the master containers

 root@milxc-snster-vm:~/OSPF# snster destroymasters 

 ------------------------------------------------------------------------------------------------------------------------------------------------
 
 updatemaster : Updates all the master containers

 root@milxc-snster-vm:~/OSPF# snster  updatemasters 
 
------------------------------------------------------------------------------------------------------------------------------------------------
 Note:

 For every modification made in provision.sh, you must destroy the old container and create a new one for the changes to take effect. Sometimes, it might take a while to attach to or display the container you wish to connect to. In such cases, stop the container and start it. Also, verify the iptables rules on the host machine within the VM and also verify the group.yml file.

 
  
