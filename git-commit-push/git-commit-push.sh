#!/bin/sh

# Author: Punith K
# Created Date: 2nd March 2019
# Description: Automation script to add, commit, and push changes to your
#	feature/fix branches created from master.

# Color codes used in this script
RED_COLOR='\e[31m'
GREEN_COLOR='\e[32m'
YELLOW_COLOR='\e[33m'
CYAN_COLOR='\e[36m'
COLOR_END_TAG='\e[0m'

# Constants
NOTHING_TO_COMMIT_MSG='nothing to commit, working tree clean'

# Function to read the project name from command line
function read_file_path()
{
	read -e -p "Please enter the project name (Tab to autocomplete):" path_name
}

# Function to switch the directory, only if it is a directory
function change_the_dir()
{
	# Prompt the user until the proper folder name specified
	while [[ ! -d $path_name ]]
	do
		read_file_path
	done

	# Checks if the entered path is a directory
	if [ -d $path_name ];
	then
		cd $path_name
	else 
		exit 1
	fi
}

# Function to read the commit message from command line
function read_commit_msg() {
	read -p "Enter the commit message: " commit_message
	
	while [ ${#commit_message} -lt 4 ]
	do 
		read -p "Lengh of the commit message should be greater than 4 chars, please enter the commit message again:" commit_message
	done
}

# Function to commit the code
function commit() {
	# Space must be preserved between brackets [ ]
	if [ ${#commit_message} -gt 4 ]; then
		echo -en "\n"
		git commit -m "$commit_message"
		echo -en "\n"
	else 
		echo -e "${YELLOW_COLOR}Message length should be greater than 4 chars${COLOR_END_TAG}"
	fi
}

# Function to perform git add and git status
function add_and_status()
{
	# sleep 2 - delay can be added to pause the script while adding the files
	git add .
	git status
}

# Function to perform read the commit message and commit the code
function read_and_commit()
{
	read_commit_msg
	commit
}

# Function to add the untracked and modified files to staging and then push to the branch
# with a prompt asking the user whether user really wants to push it or not.
# It also prints useful information like last 10 commits, 
# and files modified or created after the branch has been created.
function add_commit_push()
{
	BRANCH_NAME=`git branch | grep \* | cut -d ' ' -f2`
	
	if git status | grep -q "nothing added to commit but untracked files present";
	then
		add_and_status
		read_and_commit
	fi
		
	# Adds all changed files to staging
	if git status | grep -q "no changes added to commit"; then
		add_and_status
		read_and_commit
	fi

	# Checks whether the files have been added to staging already, and forgot to commit
	if git status | grep -q "Changes to be committed:"; then
		git status
		read_and_commit
	fi

	echo -en "\n"
	echo -e "${GREEN_COLOR}${NOTHING_TO_COMMIT_MSG}${COLOR_END_TAG}"
	echo -en "\n"

	# Shows the last 10 commits made to the current branch
	echo -e "${YELLOW_COLOR}Last 10 commits are:${COLOR_END_TAG}"
	git log -10 --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
	echo -en "\n"

	# Show the changes made in the last commit before push
	echo -e "${YELLOW_COLOR}Files changed since last branch point(master):${COLOR_END_TAG}"
	git diff --name-only master
	echo -en "\n"

	# If the changes were committed manually but forgot to push 
	if git status | grep -q "${NOTHING_TO_COMMIT_MSG}"; then 
		echo -e "${YELLOW_COLOR}You are currently in${COLOR_END_TAG} ${GREEN_COLOR}"$BRANCH_NAME"${COLOR_END_TAG}${YELLOW_COLOR} branch${COLOR_END_TAG}"
		echo -en "\n"
		read -e -p "Do you want to push your changes to the current branch [yY/nN]?:" yes_or_no
		
		while [[ ! $yes_or_no =~ [yYnN] ]]
		do
			read -e -p "Please enter your choice [yY/nN]:" yes_or_no
		done
		
		if [[ $yes_or_no =~ [yY] ]]; then 
			git push origin $BRANCH_NAME
		else
			echo -en "\n"
			echo -e "${RED_COLOR}Exiting... Happy Coding :)${COLOR_END_TAG}"
			exit 1
		fi
	fi
}

#### Execcution starts from here #####
read_file_path
change_the_dir

while [[ ! -d .git ]]
do
	echo -en "\n"
	echo -e "${RED_COLOR}fatal: Not a git repository (or any of the parent directories): .git${COLOR_END_TAG}"
	# Go back to the root folder where script resides, so that we can select the proper git repository
	cd ..
	echo -en "\n"
	read -e -p "Please enter the name of a git repository (Tab to autocomplete):" path_name
	change_the_dir
done

BRANCH_NAME=`git branch | grep \* | cut -d ' ' -f2`
echo -e -n "\n"
echo -e "${YELLOW_COLOR}You are currently in: ${COLOR_END_TAG}${CYAN_COLOR}"$(pwd | grep -o '[^/]*$')"${COLOR_END_TAG}${YELLOW_COLOR} ("$BRANCH_NAME")${COLOR_END_TAG}"

# If you want to push directly to 'master' branch, remove the if condition and 
# execute 'add_commit_push' function directly.
if [ $BRANCH_NAME == 'master' ];
then
	echo -e "${RED_COLOR}You are in master branch, not allowed to push directly, checkout to your branch${COLOR_END_TAG}"
	echo -en "\n"
	
	read -e -p "Enter your branch name to switch:" branch_to_switch
	branch_found=0
	
	while [[ $branch_found -eq 0 ]]
	do 
		is_branch_exist_msg=$(git checkout $branch_to_switch 2>&1)
		branch_found=$(expr match "$is_branch_exist_msg" '[^did not match any file(s) known to git.]')
		
		if [ $branch_found -eq 1 ]; 
		then 
			add_commit_push
		else
			echo $is_branch_exist_msg
			read -e -p "Enter the proper branch name to switch:" branch_to_switch
		fi
	done
else
	add_commit_push
fi
