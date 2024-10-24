#!/bin/bash

# Check if a directory was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory> <command>"
    exit 1
fi

# Check if a command was provided
if [ -z "$2" ]; then
    echo "Usage: $0 <directory> <command>"
    exit 1
fi

# List top-level subdirectories and execute the command on each
for dir in "$1"/*/; do
    if [ -d "$dir" ]; then
        echo "Executing command in: $dir"
        # Execute the provided command
        "$2" "$dir"
    fi
done