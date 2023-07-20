#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 /path/to/repo_folder branch_name"
    exit 1
fi

repo_folder=$1
branch_name=$2

# Change to the repository folder
cd $repo_folder || exit 1

# git log: Display the commit history of the repository.
# --no-merges: Exclude merge commits from the log, showing only non-merge commits.
# --first-parent: Follow only the first parent of merge commits, presenting the commit history as a single branch.
# --format="%h (%s) %cd": Customize the output format for each commit. It displays the short hash, commit subject (in parentheses), and commit date.
# --date=format:'%Y-%m-%d': Set the date format for displaying commit dates as 'YYYY-MM-DD'.

git log --no-merges --first-parent --format="%h %s %cd" --date=format:'%Y-%m-%d' "$branch_name"
