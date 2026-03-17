---
description: Planning and analysis agent — reviews code and suggests changes without making modifications
mode: primary
model: anthropic/claude-opus-4-6
permission:
  edit: deny
  bash:
    "*": ask
    "bat *": allow
    "cat *": allow
    "cut *": allow
    "dust *": allow
    "echo *": allow
    "eza *": allow
    "eza": allow
    "fd *": allow
    "grep *": allow
    "head *": allow
    "jq *": allow
    "ls": allow
    "ls *": allow
    "readlink *": allow
    "rg *": allow
    "sort *": allow
    "tail *": allow
    "git describe*": allow
    "git diff*": allow
    "git log*": allow
    "git show*": allow
    "git status*": allow
---
