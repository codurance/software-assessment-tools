#!/bin/bash

# Function to generate 'commits_per_month.csv' and 'commits.csv' files
function generate_csv_files() {
    repo_folder=$1
    branch_name=$2

    # Change to the repository folder
    cd $repo_folder

    # Check if the branch exists
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
        # Generate 'commits.csv' file
        echo "date,month,hash,author,type,message" > commits.csv
        git log --pretty=format:'%cd,%cd,%H,%an,%s' --date=format:'%Y-%m-%d' --no-merges $branch_name | awk -F',' '{print $1","substr($2, 1, 7)","$3","$4",normal,"$5}' >> commits.csv
        git log --pretty=format:'%cd,%cd,%H,%an,%s' --date=format:'%Y-%m-%d' --merges $branch_name | awk -F',' '{print $1","substr($2, 1, 7)","$3","$4",merge,"$5}' >> commits.csv

        # Generate 'commits_per_month.csv' file
        echo "date,total commits,merge commits" > commits_per_month.csv
        awk -F',' 'NR > 1 { commits[$2] += 1; if ($5 == "merge") merge_commits[$2] += 1 } END { for (date in commits) print date "," commits[date] "," merge_commits[date] }' commits.csv >> commits_per_month.csv

        echo "CSV files 'commits_per_month.csv' and 'commits.csv' generated."
    else
        echo "Error: Branch '$branch_name' does not exist in the repository."
    fi
}

# Usage: ./generate_csv_files.sh /path/to/repo_folder your_branch_name
generate_csv_files $1 $2
