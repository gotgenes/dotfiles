# Global Agent Instructions

## Approach

### Simplicity

> "For each desired change, make the change easy (warning: this may be hard), then make the easy change."
> — Kent Beck

Prefer the simplest viable option.
When presenting architectural options, evaluate them through the lens of [YAGNI](https://martinfowler.com/bliki/Yagni.html) and [evolutionary architecture](https://www.thoughtworks.com/insights/books/building-evolutionary-architectures) — can we start simple and evolve later without significant rework?
Highlight the operational costs of complexity (deploy time, debugging surface area, number of moving parts) alongside the functional benefits.

### Continuous Improvement

Single-loop learning asks "are we doing this correctly?" — double-loop learning asks "are we doing the correct thing?"
Agents should operate at both levels: execute well within the current approach, but also question whether the approach itself is still right.

Concrete expectations:

- **Challenge assumptions.** Don't just work within the current patterns and conventions — question whether they still serve the goal. If a practice feels like cargo-culting or a previous decision hasn't aged well, say so.
- **Surface process improvements.** When you notice friction, inefficiency, or a pattern that could be improved — in the codebase, tooling, or agent configuration itself — flag it rather than silently working around it.
- **Explain reasoning.** Articulate _why_ you chose an approach, not just what you did. Making mental models visible allows them to be examined and refined.
- **Feed retrospectives.** Actively collect observations during the session — what went well, what was harder than expected, what could be improved — so the `/retro` review has substantive material to work with.

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

## Workflow Commands

Global custom commands are available to streamline agent transitions.
When suggesting a handoff to another agent, mention the relevant command if one exists.

- `/tdd <context>` — Switch to the TDD agent and begin outside-in implementation. Pass the plan, issue, or task description as arguments.
- `/retro` — Switch to the Retrospective agent for end-of-session review.

Projects may define additional commands (e.g., `/pm-start`, `/plan`, `/pm-verify`) in `.opencode/commands/`.

## Session Retrospective

Retrospectives are the primary mechanism for closing the continuous improvement loop — they turn session observations into durable changes to agent configuration, workflows, and conventions.

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user run `/retro`, or switch to the **Retrospective** agent via Tab, to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can run `/retro` to review this session for improvements to the agent configuration."

Do not switch to the Retrospective agent automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).

## GitHub Authentication

This system may have multiple GitHub users authenticated via `gh auth`.
A wrapper script at `~/.local/bin/gh` automatically selects the correct account when the `GH_USER` environment variable is set (typically by a per-directory `mise.toml`).

When running `gh` commands that interact with a repository, the wrapper handles authentication automatically if `GH_USER` is configured for the current directory.
If `GH_USER` is not set, the default active account is used.

If you encounter authentication errors or need to verify the current account, run `gh auth status`.
