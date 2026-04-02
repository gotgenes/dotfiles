---
description: Planning and analysis agent — reviews code and suggests changes without making modifications
mode: primary
model: anthropic/claude-opus-4-6
permission:
  bash:
    "*": deny
    # Read utilities
    "rg *": allow
    "fd *": allow
    "bat *": allow
    "cat *": allow
    "eza *": allow
    "eza": allow
    "ls *": allow
    "ls": allow
    "head *": allow
    "tail *": allow
    "jq *": allow
    "cut *": allow
    "sort *": allow
    "grep *": allow
    "echo *": allow
    "readlink *": allow
    "dust *": allow
    # Git read
    "git status*": allow
    "git log*": allow
    "git diff*": allow
    "git show*": allow
    "git describe*": allow
    "git rev-parse *": allow
    # Git write
    "git add *": allow
    "git commit *": allow
    "git push": allow
    "git pull *": allow
---
