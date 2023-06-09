#!/bin/bash

###### Text settings #########
NORMAL="\e[0m"
BOLD="\e[1m"
YELLOW="\e[32m" 
RED="\e[31m"
############# files ##########
file1=./current_tasks.txt
file2=./deleted_task.txt
file3=./completed_task.txt

########## functions #########
title() {
        echo $(clear)
	echo -e "${YELLOW}========================${NORMAL}"
        echo -e "${YELLOW}🐼️ $1${NORMAL} 🐼️"
        echo -e "${YELLOW}========================${NORMAL}"
}

search() {
	read -p "Enter part of your sentence: " sentence
	if [[ $(cat $1 | grep $sentence) ]];then
		cat $1 | grep "$setence"
	else
		echo -e "${RED}Panda can't find the task!${NORMAL}"
	fi
}

replace_task() {
	read -p "Enter the number of task: " number
	sed -n $number"p" $1 >> $2  #print base on line number
	if [ $(sed -n $number"p" $1) ];then
		echo "Done"
	else
		echo -e "${RED}Panda can't find the task!${NORMAL}";fi
	sed -i  $number"d" $1  #delete base on line number
}

add_task() {
	read -p "Enter the new task: " task
	echo $task >> $file1
}



show() {
        title $2
        if [ ! -f "$1" ];then
                touch $1;fi
        sed '/^$/d' $1 #remove additional lines.
        echo -e "${YELLOW}========================${NORMAL}"
        select opt in "back";do
                case $opt in
                "back") main_menu;esac
        done
}


Exit() {
	echo "Goodbye for now"
	exit 0

}
########### menus ###################


search_menu() {
	title "Find a task"
        PS3="Enter index: "
        options=(
                "Current tasks 🟩"
                "Completed tasks ✅"
                "Deleted tasks ❎️"
		"Back"
                )
        select opt in "${options[@]}";do
                case $opt in
                        "Current tasks 🟩")
			search $file1
                        ;;
                        "Completed tasks ✅")
			search $file3
                        ;;
                        "Deleted tasks ❎️")
			search $file2
                        ;;
                        "Back") main_menu;;
                        *)echo "Invalid option";; 
                esac
        done
}

show_tasks() {
        title "My tasks"
        if [ ! -f "$file1" ];then
                touch $file1;fi
        cat -n $file1
        echo -e "${YELLOW}========================${NORMAL}"
        PS3="Enter index: "
        select item in "Add a task 📌" "Delete a task ✂️" "Tick the task 🖊️" "Back";do
                case $item in
                        "Add a task 📌") add_task ;;
                        "Delete a task ✂️") replace_task $file1 $file2;;
                        "Tick the task 🖊️") replace_task $file1 $file3;;
                        "Back") main_menu;;
                        *)echo "Invalid option";;
                esac
        done
}


main_menu() {
	title "Welcome to Panda"
	options=(
		"Go to my tasks 📝️"
		"Tasks that done 📚️"
		"Tasks that deleted 🗑️"
		"Find a task 🔎"
		"Exit ☕"
	)

	PS3="Enter index: "
	select opt in "${options[@]}";do
		case $opt in
			"Go to my tasks 📝️")
			show_tasks
			;;
			"Tasks that done 📚️")
        		show $file3 "Tasks that done"
			;;
			"Tasks that deleted 🗑️") 
        		show $file2 "Tasks that deleted"
			;;
	                "Find a task 🔎")
			search_menu
			;;
                	"Exit ☕")
                	Exit
                	;;

			*)echo "Invalid option";;

		esac


	done
}

main_menu

