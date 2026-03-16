---
description: Planning and analysis agent — reviews code and suggests changes without making modifications
mode: primary
model: anthropic/claude-opus-4-6
permission:
  edit: deny
  bash:
    "*": ask
    "rg *": allow
    "fd *": allow
    "eza": allow
    "eza *": allow
    "bat *": allow
    "cat *": allow
    "echo *": allow
    "head *": allow
    "tail *": allow
    "cut *": allow
    "jq *": allow
    "dust *": allow
    "git log*": allow
    "git diff*": allow
    "git status*": allow
    "git show*": allow
---
