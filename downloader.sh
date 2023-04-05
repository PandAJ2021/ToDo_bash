#!/bin/bash
Color_Off='\033[0m' 
Green='\033[0;32m' 
Cyan='\033[0;36m' 
file=./downloaded_files

read -p "Enter the link for download it : " link
read -p "What directory do you want to download it : " dir

if [ ! -f $file ];then
        touch $file
fi

wget -P $dir $link
if [ $? -eq 0 ];then 
	echo -e  "${Green}$link${Color_Off}" >> $file
	echo -e "${Green}downloaded in $dir$ at $(date)${Color_Off}" >> $file
	echo -e "${Cyan}====================================${Color_Off}" >> $file
fi

