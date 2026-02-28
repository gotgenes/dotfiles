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
- **Feed retrospectives.** When you notice something worth reviewing — what went well, what was harder than expected, what could be improved — flag it with `/retro-note <observation>`, or add a `[retro]`-prefixed todo item directly. The Retrospective agent treats these as must-address items. The user can also run `/retro-note` directly to record their own observations.

### No Broken Windows

Bug fixes always take priority over new features and enhancements.
Broken tooling, incorrect behavior, and regressions should be addressed before non-bug work.
This applies the [Broken Windows theory](https://en.wikipedia.org/wiki/Broken_windows_theory) to the codebase: small defects left unaddressed erode quality norms and compound over time.

When a project uses a prioritized backlog, rank bug fixes above all non-bug items.
When multiple bugs exist, rank them by impact (how much friction they cause per occurrence).
When there is no formal backlog, flag bugs immediately rather than working around them.

### Troubleshooting Third-Party Dependencies

When a bug is traced to a third-party dependency (GitHub Action, npm package, framework, etc.), check whether a newer version has already fixed the issue **before** designing a workaround.

Steps:

1. Identify the upstream issue (search the dependency's issue tracker).
2. Check recent releases and changelogs for a fix.
3. If a fix exists in a newer version, upgrade rather than work around.
4. If no fix exists, then design a workaround — and reference the upstream issue in a comment so the workaround can be removed when a fix ships.

Workarounds for already-fixed bugs add unnecessary complexity and miss the opportunity to pick up other improvements in the newer version.

### Verify Before Documenting

When troubleshooting, do not document a root cause until it has been verified.
If you change multiple variables at once (e.g., switch APIs _and_ add a permission), go back and test each variable independently before attributing the fix.

Specifically:

- Do not write "X doesn't work" in documentation or commit messages unless you have confirmed it after all other changes are in place.
- If a workaround was introduced before the real fix was found, remove the workaround and verify the simpler approach works.
- Prefer testing hypotheses over presenting decision points. If a quick test can resolve uncertainty, run the test first.

Incorrect root cause attribution creates misleading documentation that compounds over time.

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

## Manual Actions

When a task requires the user to perform a manual action (e.g., change a setting in a UI, approve a permission, create a resource that can't be automated), use the `question` tool to **gate on completion** rather than printing instructions and continuing.

This ensures the user sees the request (it blocks progress) and gives them structured options to respond.

Use this format:

- **Header**: `Manual action required` (distinguishes from decision-point questions)
- **Question**: Numbered steps the user needs to perform
- **Options** (always include all three):
  1. `Done` — "I've completed the steps above"
  2. `Need help` — "I'm stuck or something looks different than expected"
  3. `Something went wrong` — "I completed the steps but got an error or unexpected result"

If the user selects "Need help" or "Something went wrong", ask clarifying questions before retrying or adjusting the approach.

For **non-blocking** manual notes (things the user should do later but that don't gate current progress), mention them in the conversation output without using the `question` tool.

## Workflow Commands

Global custom commands are available to streamline agent transitions.
When suggesting a handoff to another agent, mention the relevant command if one exists.

- `/tdd <context>` — Switch to the TDD agent and begin outside-in implementation. Pass a plan file path, issue number, or task description as arguments.
- `/build <context>` — Switch to the Build agent for non-TDD implementation (config, infrastructure, tooling). Pass a plan file path, issue number, or task description as arguments.
- `/retro` — Switch to the Retrospective agent for end-of-session review.
- `/retro-note <observation>` — Flag an observation for the session retrospective without switching agents. The Retrospective agent treats these as must-address items.

Projects may define additional commands (e.g., `/pm-start`, `/plan`, `/pm-verify`) in `.opencode/commands/`.

## Session Retrospective

Retrospectives are the primary mechanism for closing the continuous improvement loop — they turn session observations into durable changes to agent configuration, workflows, and conventions.

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user run `/retro`, or switch to the **Retrospective** agent via Tab, to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can run `/retro` to review this session for improvements to the agent configuration."

Do not switch to the Retrospective agent automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).

## CLI Tools

This system has modern CLI tools installed via Homebrew.
Agents should prefer these over their traditional counterparts when running shell commands.

| Modern tool         | Replaces                    | Notes                                                  |
| ------------------- | --------------------------- | ------------------------------------------------------ |
| `fd`                | `find`                      | Simpler syntax, respects `.gitignore` by default       |
| `rg` (ripgrep)      | `grep`                      | Faster, respects `.gitignore`, better defaults         |
| `eza`               | `ls`                        | `--tree`, `--git`, `--icons` flags available           |
| `bat`               | `cat`                       | Syntax highlighting, line numbers, git integration     |
| `sd`                | `sed`                       | Simpler regex syntax (uses literal strings by default) |
| `dust`              | `du`                        | Visual, sorted disk usage                              |
| `procs`             | `ps`                        | Colored, searchable process listing                    |
| `jq`                | —                           | JSON filtering and transformation                      |
| `fzf`               | —                           | Fuzzy finder for interactive selection                 |
| `zoxide`            | `cd` (frequent dirs)        | Tracks frecency for fast directory jumping             |
| `tealdeer` (`tldr`) | `man` (for quick reference) | Community-maintained command cheat sheets              |
| `viddy`             | `watch`                     | Modern watch with diff highlighting                    |
| `tree`              | `ls -R`                     | Directory tree visualization                           |
| `broot`             | —                           | Interactive file tree and navigation                   |
| `lazygit`           | —                           | Terminal UI for git                                    |
| `git-delta`         | `diff`                      | Configured as git's default pager for diffs            |
| `shellcheck`        | —                           | Shell script static analysis                           |
| `codespell`         | —                           | Spell checker for source code                          |

Practical guidance:

- Use `fd` instead of `find` for locating files. Example: `fd '\.ts$'` instead of `find . -name '*.ts'`.
- Use `rg` instead of `grep` for searching file contents. Example: `rg 'TODO'` instead of `grep -r 'TODO' .`.
- Use `bat` instead of `cat` when showing file contents to the user (it adds syntax highlighting). For piping into other commands, plain `cat` is fine.
- Use `sd` instead of `sed` for simple find-and-replace. Example: `sd 'old' 'new' file.txt` instead of `sed -i '' 's/old/new/g' file.txt`.
- Use `dust` instead of `du` for disk usage analysis.
- Use `jq` for any JSON processing in shell pipelines.
- Use `eza` instead of `ls` when a richer listing is helpful (e.g., `eza -la --git`).

## GitHub Authentication

This system may have multiple GitHub users authenticated via `gh auth`.
A wrapper script at `~/.local/bin/gh` automatically selects the correct account when the `GH_USER` environment variable is set (typically by a per-directory `mise.toml`).

When running `gh` commands that interact with a repository, the wrapper handles authentication automatically if `GH_USER` is configured for the current directory.
If `GH_USER` is not set, the default active account is used.

If you encounter authentication errors or need to verify the current account, run `gh auth status`.
