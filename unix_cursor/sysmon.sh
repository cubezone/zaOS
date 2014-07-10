#!/bin/sh

# SYSTEM MONITOR shell script 1.0
# 2001.1.25  add *#HELPS 
# 2001.1.20  add *#SHELL 
# 2000.12 Created by Zhuxy, za_sonic@sina.com

# line begin with "*#" is internal parameter
# 按以下顺序填写、不要出现冲突项，缺项。
# now support: 
# *#SHELL  只执行shell 程序,没有窗口。(一般为 call vi).
# *#POSIT  窗口位置  y x high width
# *#CLIST  having datalist 
# *#HELPS  online help
# *#TITLE  windows caption
# *#CMDBT  command caption
# *#CMDSH  命令要执行的shell 参数

# Main Form 

if (test  "${1:-"sh"}" = "Mainh") ; then
	printf "*#POSIT 5 15 14 46\n" 
	printf "*#TITLE System Help\n"  
	printf " \n \n"  
	printf "           Sys   Adm   Ver 1.0 \n \n \n"  
	printf "             Author : zhuxy \n \n \n"  
	printf "                 2001.6  \n"  

fi

if (test  "${1:-"sh"}" = "Main") ; then
	printf "*#POSIT 0 0 24 78 \n"
	printf "*#HELPS \n"
	printf " \n \n \n \n"
	printf "         _____  __    __  _____       ___   _____       ___  ___  \n"
	printf "        /  ___/ \ \  / / /  ___/     /   | |  _  \     /   |/   | \n"
	printf "        | |___   \ \/ /  | |___     / /| | | | | |    / /|   /| | \n"
	printf "        \___  \   \  /   \___  \   / / | | | | | |   / / |__/ | | \n"
	printf "         ___| |   / /     ___| |  / /  | | | |_| |  / /       | | \n"
	printf "        /_____/  /_/     /_____/ /_/   |_| |_____/ /_/        |_| \n"
	printf "*#CMDBT Command  1 -- Parameter  2 -- Process  3 -- Log  4 -- File \n"
	printf "*#CMDSH Main  1  2  3  4\n"
	
fi

# 1 Para Monitor
#   1.1  ReLoad
#   1.2  DumpToFile

if (test  "${1:-"sh"}" = "1h") ; then
	printf "*#POSIT 5 10 13 56 \n"
	printf "*#TITLE Para System Help\n"
	printf " \n \n"
	printf " Command :  1   reload para from database.\n"
	printf "            2   dump para to file and view.\n"
	
fi

if (test  "${1:-"sh"}" = "1") ; then
	printf "*#POSIT 2 5 20 66 \n"
	printf "*#TITLE Para System\n"
	printf "*#CLIST\n"
	printf "*#HELPS\n"
	ls  
	printf "*#CMDBT Command    1 -- ReLoad    2 -- View\n"
	printf "*#CMDSH 1  1.1  1.2 \n"
	
fi

if (test  "${1:-"sh"}" = "1.1") ; then
	printf "*#SHELL BSTpara	\n"
	
fi

if (test  "${1:-"sh"}" = "1.2") ; then
	printf "*#SHELL BSTpara -d paratemp.dat; vi paratemp.dat ; rm paratemp.dat\n"
	
fi

# 2 Process Monitor
#   2.1  startup 
#   2.2  shutdown 

if (test  "${1:-"sh"}" = "2h") ; then
	printf "*#POSIT 5 15 13 46  \n"
	printf "*#TITLE Process System Help\n"
	printf " \n \n"
	printf " Command :  1   startup all process.\n"
	printf "            2   shutdown all process.\n"
	
fi

if (test  "${1:-"sh"}" = "2") ; then
	printf "*#POSIT 2 5 20 66  \n"
	printf "*#TITLE Running System\n"
	printf "*#CLIST\n"
	printf "*#HELPS\n"	
	printf " RUser    Pid    PPid STime       ETime    Process        \n"
	printf " --------------------------------------------------------------\n"
	ps -e  -o ruser -o pid -o ppid -o stime -o etime -o comm | grep "BST"
	printf "*#CMDBT Command    1 -- Startup     2 -- Shutdown    \n"
	printf "*#CMDSH 2  2.1 2.2  \n"
	
fi

if (test  "${1:-"sh"}" = "2.1") ; then
	printf "*#POSIT 4 15 13 46 \n"
        printf "*#TITLE Startup Information \n" 
        printf "*#CLIST \n"
        printf "Starting up infor\n"
        printf "---------------------------------------------------------------\n"
        BSTbill  
        BSTimport 
        BSTprepro
fi

if (test  "${1:-"sh"}" = "2.2") ; then
      echo "aa"
fi

# 3 Log  Monitor
#   3.1  Para 
#   3.2  Bill 
#   3.3  Import
#   3.4  Mon

if (test  "${1:-"sh"}" = "3h") ; then
	printf "*#POSIT 5 15 13 46 \n"
	printf "*#TITLE Log System Help\n"
	printf " \n \n"
	printf " Command :  1   view syspara.log.\n"
	printf "            2   view sysbill.log.\n"
	printf "            3   view sysimp.log.\n"
	printf "            4   view sysmon.log.\n"
	
fi

if (test  "${1:-"sh"}" = "3") ; then
	printf "*#POSIT 2 3 20 72\n" 
	printf "*#TITLE System Logs\n"
	printf "*#CLIST \n" 
	printf "*#HELPS \n"
	printf "System         Time                 Error Information \n"  
	printf "--------------------------------------------------------------\n"  
	printf "*#CMDBT Command  1 - Prep  2 - Bill  3 - Import  4 - Para  5 - Mon\n"  
	printf "*#CMDSH 3 3.1 3.2 3.3 3.4 3.5\n" 
	
fi

if (test  "${1:-"sh"}" = "3.1") ; then
	printf "*#SHELL vi sysprep.log\n"
	
fi

if (test  "${1:-"sh"}" = "3.2") ; then
	printf "*#SHELL vi sysbill.log\n"
	
fi

if (test  "${1:-"sh"}" = "3.3") ; then
	printf "*#SHELL vi sysimp.log\n"
	
fi

if (test  "${1:-"sh"}" = "3.4") ; then
	printf "*#SHELL vi syspara.log\n"
	
fi

if (test  "${1:-"sh"}" = "3.5") ; then
	printf "*#SHELL vi sysmon.log\n"
	
fi

if (test  "${1:-"sh"}" = "4") ; then
	printf "*#POSIT 1 3 22 72 \n" 
	printf "*#TITLE File List\n"
	printf "*#HELPS \n"
	printf "   \n \n \n"
	printf "*#CMDBT Command   1 -- PrePro   2 -- Bill  3 -- Import  4 -- ERROR\n"  
	printf "*#CMDSH 4 4.1 4.2 4.3 4.4 \n" 
	
fi

if (test  "${1:-"sh"}" = "4h") ; then
	printf "*#POSIT 5 15 13 46 \n"
	printf "*#TITLE File System Help\n"
	printf " \n \n"
	printf " \n       to be blank   \n"
	
fi

if (test  "${1:-"sh"}" = "4.1") ; then
	printf "*#POSIT 2 5 20 68  \n" 
	printf "*#TITLE PrePro File\n"
	printf " \n \n"
	printf "*#CMDBT Command   1 -- process   2 -- processed  \n"  
	printf "*#CMDSH 4.1 4.1.1 4.1.2  \n" 
fi

if (test  "${1:-"sh"}" = "4.1.1") ; then
	printf "*#POSIT 3 8 18 62  \n" 
	printf "*#TITLE Processing File\n"
	printf "*#CLIST\n"
	printf "-----------------------------------------------------\n"  
	ls /web/sybase/NFdata 
fi

if (test  "${1:-"sh"}" = "4.1.2") ; then
	printf "*#POSIT 3 8 18 62  \n" 
	printf "*#TITLE Processed File\n"
	printf "*#CLIST\n"
	printf "-----------------------------------------------------\n"  
fi

if (test  "${1:-"sh"}" = "4.2") ; then
	printf "*#POSIT 3 8 18 60  \n" 
	printf "*#TITLE ERROR File\n"
	printf "*#CLIST\n"
	printf "File name \n"  
	printf "-----------------------------------------------------\n"  
fi

if (test  "${1:-"sh"}" = "4.3") ; then
	printf "*#POSIT 3 8 18 60  \n" 
	printf "*#TITLE Import File\n"
	printf "*#CLIST\n"
	printf "File name \n"  
	printf "-----------------------------------------------------\n"  
fi

if (test  "${1:-"sh"}" = "4.4") ; then
	printf "*#POSIT 3 8 18 60  \n" 
	printf "*#TITLE ERROR File\n"
	printf "*#CLIST\n"
	printf "File name \n"  
	printf "-----------------------------------------------------\n"  
fi

