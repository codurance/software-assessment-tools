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

# The git branch -r --merged "$branch_name" command lists remote branches (-r)
# that have been merged into the specified branch ($branch_name). 

# The output is then piped (|) to the grep -v '\->' command, 
# which filters out any lines that contain the symbol ->. 

# Finally, the output is piped to awk '{gsub(/^[[:space:]]+|[[:space:]]+$/, ""); print}', 
# which removes leading and trailing whitespace from each line before printing the result. 

# The final output will be a list of remote branches that are merged into the specified branch, 
# excluding any branches with the -> symbol.

git branch -r --merged develop | grep -v '\->' | awk '{gsub(/^[[:space:]]+|[[:space:]]+$/, ""); print}'
