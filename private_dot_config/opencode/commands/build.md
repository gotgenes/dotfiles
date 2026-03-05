---
description: Start implementation from a plan or issue (non-TDD)
agent: build
---

# Build

Implement the following.

$ARGUMENTS

Before starting:

1. If the arguments contain a file path (e.g., `docs/plans/foo.md`), read that file first — it is the implementation plan.
2. Read the project's AGENTS.md for conventions, commit message format, and relevant commands.
3. Create a Todo list from the plan's task list or acceptance criteria to track progress.

Begin implementation.

When complete:

1. If a plan file was read from `docs/plans/`, delete it — plans are ephemeral artifacts that lose relevance once the work is done. Commit the deletion separately from the implementation.
2. Recommend handoff to the appropriate verification step (e.g., `/pm-verify #N`).
