---
description: Start TDD implementation from a plan or issue
agent: tdd
---

Implement the following using the outside-in TDD procedure defined in your system prompt.

$ARGUMENTS

Before starting:

1. If the arguments contain a file path (e.g., `docs/plans/foo.md`), read that file first — it is the implementation plan.
2. Read the project's AGENTS.md for commit message conventions and any project-specific test commands.
3. Confirm this task is appropriate for TDD. If it's configuration, documentation, or infrastructure wiring, flag that and suggest switching to the Build agent via `/build`. Call the `suggest_command` tool with the full `/build` command in addition to mentioning it in your text output.
4. Identify the acceptance test entry point and the first layer of implementation.

Begin with Phase 1 (acceptance test).
