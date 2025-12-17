#!/bin/bash

# Shell History Stats
# Analyzes your command history to show the top 10 most used commands.

echo "Top 10 Most Used Commands"
echo "-------------------------"

if [ -f ~/.bash_history ]; then
    HIST_FILE=~/.bash_history
elif [ -f ~/.zsh_history ]; then
    HIST_FILE=~/.zsh_history
else
    echo "Could not find history file."
    exit 1
fi

# logic: cat file | strip timestamps/meta | awk print command | sort | count | sort numeric reverse | head
awk '{print $1}' "$HIST_FILE" | sort | uniq -c | sort -nr | head -n 10
