#!/bin/bash

# Threshold for the maximum number of files allowed
max_files_threshold=30

# Check if the required arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <repository_directory> <branch_name>"
  exit 1
fi

repository_dir=$1
branch_name=$2

# Change directory to the specified Git repository
cd "$repository_dir" || exit 1

# Output CSV headers to respective files
echo "hash,date,files changed,author,message" > file_count_per_commit.csv
echo "hash,date,files changed,author,message" > file_count_per_commit_excluded.csv

# Loop through each commit on the specified branch (excluding merge commits)
git log "$branch_name" --no-merges --pretty=format:'%H,%ad,%an,"%s"' --date=format:'%Y-%m-%d' | while IFS=',' read -r hash date author message; do
  # Count the number of files changed in the commit
  files_changed=$(git diff-tree --no-commit-id --name-only -r "$hash" | wc -l | tr -d '[:space:]')

  # Check if the commit has more than the specified threshold of files changed
  if [ "$files_changed" -gt "$max_files_threshold" ]; then
    # Output the result to the excluded CSV file
    echo "$hash,$date,$files_changed,$author,$message" >> file_count_per_commit_excluded.csv
  else
    # Output the result to the regular CSV file
    echo "$hash,$date,$files_changed,$author,$message" >> file_count_per_commit.csv
  fi
done
