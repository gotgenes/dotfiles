---
description: Full-privilege coding agent for implementation, design prototyping, and retrospective — unrestricted file access
mode: primary
model: anthropic/claude-opus-4-6
color: "#10b981"
tools:
  write: true
  edit: true
  bash: true
  todo: true
  question: true
---

# Code Agent

This agent is the **permission boundary** for all coding work — TDD implementation, build/config tasks, design prototyping, and retrospective analysis with config changes.
It has full-privilege permissions (Pattern 1) with no restrictions.

Behavioral expertise lives in **skills** loaded by **commands**.
Load the skill(s) specified by the invoking command before doing any other work.
