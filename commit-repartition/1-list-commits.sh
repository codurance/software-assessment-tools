#!/bin/bash

set -e

# Check if both repository and output directories are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <repository_directory> <output_directory>"
  exit 1
fi

repository_dir="$1"
output_dir=$2

echo "Checking output folder..."
mkdir -p "$output_dir"
absolute_output_dir="$(cd "$output_dir" && pwd)"

echo "Output will be written to: $absolute_output_dir"

echo "Checking out git repository $repository_dir..."
cd "$repository_dir" || exit 1

commits_csv="$absolute_output_dir/commits.csv"
count_csv="$absolute_output_dir/commit_count_per_month.csv"
temp_csv="$absolute_output_dir/temp.csv"

echo "Generating commits CSV..."
echo "hash,date,author" > "$commits_csv"
git log --pretty=format:'%H,%ad,%ae' --date=format:'%Y-%m-%d' >> "$commits_csv"

echo "Generating commit count per author..."
echo "date,commit count,author" > "$count_csv"
git log --pretty=format:'%ad,%ae' --date=format:'%Y-%m' | awk -F',' '{print $1}' | sort | uniq -c | awk '{print $2 "," $1}' > "$temp_csv"

echo "Calculating commit count per month per author..."
while IFS= read -r line; do
  month=$(echo "$line" | awk -F',' '{print $1}')
  commit_count=$(echo "$line" | awk -F',' '{print $2}')
  authors=$(grep "$month" "$commits_csv" | awk -F',' '{print $3}' | sort | uniq)
  while IFS= read -r author; do
    author_commit_count=$(grep "$month" "$commits_csv" | grep "$author" | wc -l | awk '{print $1}')
    echo "$month,$author_commit_count,$author" >> "$count_csv"
  done <<< "$authors"
done < "$temp_csv"

echo "Results are available in $count_csv"

rm "$temp_csv"
