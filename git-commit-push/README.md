## Automation script to add, commit, and push changes

> Note: Currently this script assumes that you want to add all the new files created,
	and modified files to the staging, commit and then push to remote repo.
	Once the files are added to the staging, user is `not allowed to skip the committing` but prompted to 
	publish the committed changes.
	
- Please log a `issue` if you want me to add a `prompt to ask whether user 
	is sure to add all the files` to the staging and then move on to committing to push.
	
- Wanted to keep the script to be straight forward and don't want to ask 
	to many questions to the user.

## How to use the scripts

### To use this project, simply clone the project.

```
git clone https://github.cerner.com/pk043505/common-automation-scripts.git
```

> Note: `git bash` is required to run the scripts, tested in `win-10` with a latest version of git installed. 
	Not tested on `mac OS` and `unix distributions`. Please make sure your command line supports `bash` command processor to run these scripts. 
	
### Copy the script to the root folder where all of your git projects reside.
- for eg: If your git projects residing in `C:/git_projects` keep the script in `C:/git_projects` not inside the git project.

### Grant the executable permission to the script (Run in administrator mode)

- Go to the folder where script resides, execute the following
	```
	$chmod a+x git-commit-push.sh
	```

- Execute the script as follows in `git-bash`
	```
	$ sh git-commit-push.sh
	```

- Script also can be executed by `double cliking` on it, provided `git-bash` is selected as `default program` to open `.sh` files.

## This script supports the following features

> NOTE: This script assumes that the user has already cloned the project and created the 
	`feature branch` from `master` and added files or modified the files or added them to staging 

- Asks for user to enter the project name, (use tab to autocomplete)
	- prompts the user until a `folder` is selected.
	- If the selected folder is `not a git repository`; prompts the user to enter the correct
		git repository.

- Once the right git repository selected, checks whether the user curretly 
	in `master` branch, prompts the users to switch to the branch where they made the 
	changes to the project.
	- Never lets users to add or push changes to the `master` branch directly.
	- Prompts the user until the `correct branch` is selected.
	
- Once the branch is selected, looks for the following conditions in order to add, commit and push the changes
	- First checks for newly added files, then the modified files and then the files already added
		but forgot to commit and push 
	- Prompts the user to enter the commit message, if the `commit message` is 
		`less than 4 characters`, prompts the user again to enter the commit message.
		
- Once the commit message entered, shows the following statistics to the user
	- Shows the last 10 commits made to the current branch, in human readable form
		showing the commit hash, commit message, Date and time, author name.
	- Shows the files added or modified since the branch is made from master.

- Finally prompts the user to push the changes to the branch currently they are in,
	- User can make a choice `[yY/nN]` as their option to publish the changes.
	- If user enters any other char than the expected, prompts the user until the right selection made.
	- If user selects `y/Y`, asks for `user name` and `password` of the user to push the changes.
	- If user selects `n/N`, script exits.
	
	