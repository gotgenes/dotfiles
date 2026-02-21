# Global Agent Instructions

## Session Retrospective

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user switch to the **Retrospective** agent (via Tab) to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can switch to the Retrospective agent (Tab) to review this session for any improvements to the agent configuration."

Do not switch to the Retrospective agent automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).

## OpenCode / Claude Path Compatibility

OpenCode has a Claude Code compatibility layer that translates `.opencode/` paths to `.claude/` (or `.Claude/`) when constructing the system prompt sent to Claude models.
This means the model's system prompt will reference paths like `.Claude/agents/` and `~/.config/Claude/AGENTS.md`, even though the actual files live in `.opencode/` and `~/.config/opencode/`.

To ensure filesystem access works regardless of which path convention the model uses, projects should create a `.claude -> .opencode` symlink in the project root and commit it to git.
Always treat `.opencode/` as the canonical path.
Never create a real `.claude/` directory alongside the symlink.
