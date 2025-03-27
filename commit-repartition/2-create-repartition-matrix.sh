#!/bin/bash

FOLDER="$1"

if [[ -z "$FOLDER" ]]; then
  echo "Usage: $0 <folder>"
  exit 1
fi

input="$FOLDER/commit_count_per_month.csv"
output="$FOLDER/repartition-matrix.csv"
tmp="$FOLDER/tmp-matrix.csv"

awk -F, '
NR > 1 {
    key = $1 "," $3
    data[key] = $2
    authors[$3] = 1
    dates[$1] = 1
}
END {
    # Prepare sorted lists
    n = 0
    for (a in authors) {
        author_list[n++] = a
    }
    m = 0
    for (d in dates) {
        date_list[m++] = d
    }

    # Print header
    printf "date"
    for (i = 0; i < n; i++) {
        printf ",%s", author_list[i]
    }
    print ""

    # Print data rows
    for (i = 0; i < m; i++) {
        d = date_list[i]
        printf "%s", d
        for (j = 0; j < n; j++) {
            a = author_list[j]
            key = d "," a
            printf ",%s", (key in data ? data[key] : "")
        }
        print ""
    }
}
' "$input" > "$tmp"

# Separate header and sort the body
(head -n 1 "$tmp" && tail -n +2 "$tmp" | sort) > "$output"
rm "$tmp"
