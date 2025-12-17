#!/bin/bash

# Git Repo Auditor
# recursively finds git repositories and reports status:
# - Dirty (uncommitted changes)
# - Unpushed commits (Ahead)
# - Outdated (Behind)

ROOT_DIR=${1:-$(pwd)}

echo "Auditing Git Repositories in '$ROOT_DIR'..."
printf "%-40s %-10s %-10s %-10s\n" "Repository" "Dirty?" "Ahead" "Behind"
echo "-----------------------------------------------------------------------"

find "$ROOT_DIR" -name ".git" -type d | while read -r GIT_DIR; do
    REPO_DIR=$(dirname "$GIT_DIR")
    REPO_NAME=$(basename "$REPO_DIR")
    
    cd "$REPO_DIR" || continue
    
    # Check Dirty
    if [ -n "$(git status --porcelain)" ]; then
        DIRTY="YES"
    else
        DIRTY="-"
    fi
    
    # Check Ahead/Behind (requires remote)
    git fetch --quiet 2>/dev/null
    
    AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "N/A")
    BEHIND=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "N/A")
    
    # If N/A (no upstream), just show -
    [ "$AHEAD" == "N/A" ] && AHEAD="-"
    [ "$BEHIND" == "N/A" ] && BEHIND="-"
    
    # Print only if there's something to report (optional, but cleaner)
    # Removing this check to show ALL repos
    
    printf "%-40s %-10s %-10s %-10s\n" "$REPO_NAME" "$DIRTY" "$AHEAD" "$BEHIND"
done
