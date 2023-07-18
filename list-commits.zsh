#!/bin/zsh

# Check if the repository directory is provided as a parameter
if [ $# -ne 1 ]; then
  echo "Usage: $0 <repository_directory>"
  exit 1
fi

repository_dir=$1

# Change directory to the specified Git repository
cd "$repository_dir" || exit 1

# Output CSV header for commits.csv
echo "hash,date,author" > commits.csv

# Generate commits.csv with commit details (reordered columns and date without time)
git log --pretty=format:'%H,%ad,%ae' --date=format:'%Y-%m-%d' >> commits.csv

# Output CSV header for commit_count_per_month.csv
echo "date,commit count,author" > commit_count_per_month.csv

# Generate commit count per developer per month and append to commit_count_per_month.csv
git log --pretty=format:'%ad,%ae' --date=format:'%Y-%m' | awk -F',' '{print $1}' | sort | uniq -c | awk '{print $2 "," $1}' > temp.csv

# Process temp.csv to count commits per developer per month and append to commit_count_per_month.csv
while IFS= read -r line; do
  month=$(echo "$line" | awk -F',' '{print $1}')
  commit_count=$(echo "$line" | awk -F',' '{print $2}')
  authors=$(grep "$month" commits.csv | awk -F',' '{print $3}' | sort | uniq)
  while IFS= read -r author; do
    author_commit_count=$(grep "$month" commits.csv | grep "$author" | wc -l | awk '{print $1}')
    echo "$month,$author_commit_count,$author" >> commit_count_per_month.csv
  done <<< "$authors"
done < temp.csv

# Remove temp.csv
rm temp.csv
