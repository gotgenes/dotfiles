---
description: Review this session for workflow and agent improvements
agent: retrospective
---

# Review Session

Review the current session and follow the procedure defined in your system prompt.

Arguments: `$ARGUMENTS`

## Gather context

If an issue number was provided as an argument (`#N` or plain `N`), this is a fresh-session retrospective — fetch the issue, set the session title, and look for existing stage entries in `docs/retro/`.
If no issue number was provided, this is a same-session retrospective — call `agent_attribution` and infer the issue from the session title.

## Synthesize and persist

1. Summarize what was accomplished.
2. Identify observations — what went well, what caused friction.
3. Persist retro notes via the `retro_stageNotes` tool with `stage: "Final Retrospective"` **before** proposing any changes.

## Propose improvements

1. Propose specific changes to AGENTS.md, agent definition files, or command files, ordered by impact.
2. Look for opportunities to **remove or condense** existing content — not just content to add.
3. Suggest new or modified commands, tools, plugins, subagents, or agents if session patterns warrant it.
4. Use the `question` tool to ask which changes (if any) to apply before editing any file.
5. After applying approved changes, append a `### Changes made` section to the retro notes file.

Focus on actionable improvements with exact proposed text, not vague suggestions.

## Commit

Commit the retro notes file and push:

```bash
git add docs/retro/ && git commit -m "docs: add retro notes for issue #N"
git push
```
