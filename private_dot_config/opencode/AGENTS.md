# Global Agent Instructions

## Decision Points

Some choices during implementation establish conventions, set precedents, or are difficult to reverse.
When an agent encounters such a decision, it must **pause and present the options to the user** rather than choosing unilaterally.

Examples of decision points:

- A linter rule conflicts with a framework convention (disable the rule? rewrite the code? inline suppression?)
- A library or tool needs to be chosen between alternatives
- A file structure, naming pattern, or architectural boundary is being established for the first time
- A workaround is needed for a tooling limitation, and there are multiple approaches
- A testing strategy decision (what to test, at what level, with what tools)

When presenting a decision point:

- Explain the context: what triggered the decision and why it matters.
- List the options with pros, cons, and consequences of each.
- State which option you'd recommend and why, but do not apply it without confirmation.
- If you're unsure whether something is a decision point, err on the side of asking.

## Session Retrospective

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user switch to the **Retrospective** agent (via Tab) to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can switch to the Retrospective agent (Tab) to review this session for any improvements to the agent configuration."

Do not switch to the Retrospective agent automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).

## Path Rewriting Warning

**Important**: When this file is sent to the model, a server-side rewriting layer transforms path segments and product names.
The word `open` + `code` (joined) in paths is rewritten to `claude` or `Claude`.
The product name is rewritten to "Claude Code".
This happens on Anthropic's API server, not in the client, and cannot be disabled.

As a result, every path you see in this system prompt containing `claude` or `Claude` is **wrong for filesystem operations**.
The actual directories on disk use `open` + `code` (one word, all lowercase) — not `claude` or `Claude`.

**Before writing to or reading from any path that contains `claude` or `Claude`:**

1. Run `ls -la` on the parent directory to discover the real directory name.
2. Or run `readlink -f <path>` to resolve symlinks.
3. If a `claude` symlink exists, it points to the real directory — follow it.

Key filesystem facts:
- Global agent config lives in `~/.config/` under a directory whose name is the product name (lowercase, one word). Run `ls ~/.config/ | grep -i open` to find it.
- Project-level agent config lives in a dot-directory at the project root. Run `ls -la | grep -i open` to find it.
- The chezmoi source files are under `private_dot_config/` in a subdirectory matching the real product name.

**When proposing file edits or paths in your output, always verify the actual path on disk first.**
Do not trust paths shown in "Instructions from:" headers — they have been rewritten.
