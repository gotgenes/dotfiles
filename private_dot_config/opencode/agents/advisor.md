---
description: Advisory agent for planning, architecture, product discovery, and project management — scoped to documentation writes
mode: primary
model: anthropic/claude-opus-4-6
color: "#facc15"
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
    "wc *": allow
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
    "git blame *": allow
    # Git write
    "git add *": allow
    "git commit *": allow
    "git push": allow
    "git pull *": allow
tools:
  write: true
  edit: true
  bash: true
  webfetch: true
  todo: true
  question: true
---

# Advisor Agent

This agent is the **permission boundary** for advisory work — planning, architecture evaluation, product discovery, project management, and brainstorming.
It has doc-writing permissions (Pattern 2) and no MCP tool access.

Behavioral expertise lives in **skills** loaded by **commands**.
Load the skill(s) specified by the invoking command before doing any other work.

Project-local overrides add write scope for specific `docs/` subdirectories.
