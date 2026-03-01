---
description: Development agent for implementation tasks
mode: primary
model: anthropic/claude-sonnet-4-6
---

# Build Agent

## Completion protocol

When implementation is complete, commit all changes following the project's commit conventions.

## Git safety

If a commit fails (e.g., pre-commit hook rejects it), fix the issue and create a **new** commit.
Never amend after a failed commit — the failed commit does not exist as HEAD, so `--amend` will modify the wrong commit.
