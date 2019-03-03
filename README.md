## Automation scripts to deal with day to day tasks

## How to use the scripts

- Currently I've posted them in my personal repo, if needed we can take it to a common repo where 
	everybody can clone, use and contribute to it.

### To use this project, simply clone the project.

```
git clone https://github.cerner.com/pk043505/common-automation-scripts.git
```

> Note: `git bash` is required to run the scripts, tested in `win-10` with a latest version of git installed. 
	Not tested on `mac OS` and `unix distributions`. Please make sure your command line supports `bash` command processor to run these scripts. 
	
> Note: Please read the `README.md` file available for each script in this repo.

## What's in this repo

### git-commit-push.sh - script to automate adding, commiting and pushing the changes to a single git repo.

- Add, commit, stats for a branch made from `master`, and publishing the changes in few key strokes.
	Has a proper error handling, doesn't allow the direct pushes to the `master` branch,
	prompts the user before doing any action.
	
- Script is tested for all possible scenarios, please contribute to help improve the script,
	I would have missed some critical pieces to add, please suggest and contribute.

- Documentation ![link](/git-commit-push/README.md)

## Work in progress

- Scanning all the projects in a folder for changes made for a feature/bug fix,
	interactively asking for custom commit message for all the projects, and publishing them
	all in one script.
	
- I'll be adding the scripts that I'm currently using to automate some simple daily tasks like, 
	clone, pulling the changes to `master` branch everyday. Use them if you think it helps in increasing the productivity.
	
- More to come, watch this repo.

## Contribution guide

- Open for contributions, please raise a issue or PR to the existing scripts for better
	performance and productivity.

# HAPPY CODING :)
	