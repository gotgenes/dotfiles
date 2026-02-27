# Global Agent Instructions

## Approach

> "For each desired change, make the change easy (warning: this may be hard), then make the easy change."
> — Kent Beck

Prefer the simplest viable option.
When presenting architectural options, evaluate them through the lens of [YAGNI](https://martinfowler.com/bliki/Yagni.html) and [evolutionary architecture](https://www.thoughtworks.com/insights/books/building-evolutionary-architectures) — can we start simple and evolve later without significant rework?
Highlight the operational costs of complexity (deploy time, debugging surface area, number of moving parts) alongside the functional benefits.

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

## OpenCode Path Rewriting (Historical)

The default `opencode-anthropic-auth` plugin used to rewrite all occurrences of `opencode` to `Claude` in system prompts sent to Anthropic models.
This mangled directory paths, file names, and AGENTS.md content.
See [anomalyco/opencode#10567](https://github.com/anomalyco/opencode/issues/10567) for details.

This is fixed by using `@ex-machina/opencode-anthropic-auth` (configured in `opencode.json` and `package.json`), which removes the rewrite entirely.
If paths containing `opencode` appear as `Claude` in agent output, the fix is not active — check that the plugin is installed and configured correctly.

## GitHub Authentication

This system may have multiple GitHub users authenticated via `gh auth`.
A wrapper script at `~/.local/bin/gh` automatically selects the correct account when the `GH_USER` environment variable is set (typically by a per-directory `mise.toml`).

When running `gh` commands that interact with a repository, the wrapper handles authentication automatically if `GH_USER` is configured for the current directory.
If `GH_USER` is not set, the default active account is used.

If you encounter authentication errors or need to verify the current account, run `gh auth status`.
