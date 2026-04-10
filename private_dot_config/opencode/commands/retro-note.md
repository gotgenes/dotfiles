---
description: Flag an observation for the session retrospective
---

The user wants to record a retrospective note. Add a todo item using the TodoWrite tool with the following conventions:

- **Content**: Prefix with `[retro]` followed by the user's observation: `[retro] $ARGUMENTS`
- **Status**: `pending` (must remain pending — the Retrospective agent will review it)
- **Priority**: `medium`

CRITICAL: First read the existing todo list, then write back ALL existing items plus the new `[retro]` item. The TodoWrite tool replaces the entire list — do not drop existing items.

Do not discuss or elaborate. Briefly confirm what was recorded, then immediately resume the prior workflow. Look at the conversation history to determine what the agent was doing before this interruption and continue that work directly — do not recommend a command or await further user input.
