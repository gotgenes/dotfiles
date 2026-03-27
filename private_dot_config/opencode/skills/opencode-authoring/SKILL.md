---
name: opencode-authoring
description: Conventions for creating and maintaining OpenCode extension points — AGENTS.md content quality, agent definition structure, extension point selection, skill design, and subagent patterns
---

# OpenCode Authoring

Conventions and design principles for creating and maintaining OpenCode extension points: `AGENTS.md`, agent definitions, subagents, commands, tools, skills, plugins, and `opencode.json`.

Load this skill when creating, modifying, or reviewing any OpenCode configuration file.

## Extension Point Model

OpenCode provides seven extension points, each with a different cost/benefit profile.
Choose the lightest-weight mechanism that solves the problem.

| Extension point   | What it is                             | When to use it                                                                                       | Cost                                 |
| ----------------- | -------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------ |
| **AGENTS.md**     | Always-loaded context for all agents   | Conventions every agent needs on every task                                                          | Permanent context cost               |
| **Skill**         | Demand-loaded reference material       | Domain knowledge needed occasionally                                                                 | Context cost only when loaded        |
| **Command**       | Markdown file that triggers a prompt   | Workflow transitions, agent switching, repeatable operations                                         | Negligible (a few lines of Markdown) |
| **Tool**          | Bun script exposing a function         | Encoding project conventions into reusable operations                                                | Moderate (code to maintain)          |
| **Plugin**        | Bun script with OpenCode SDK access    | Tools that need to interact with the OpenCode server                                                 | Moderate (code + SDK dependency)     |
| **Subagent**      | Agent definition with `mode: subagent` | Focused verification tasks that benefit from fresh context                                           | Moderate (definition to maintain)    |
| **Primary agent** | Agent definition with `mode: primary`  | Fundamentally different role requiring distinct permissions, temperature, or behavioral instructions | High (full prompt to maintain)       |

### Selection hierarchy

When addressing a recurring need, prefer the options higher in this list:

1. **Command** — if the need is a repeatable prompt with context injection.
2. **Tool** — if the need is a reusable operation that encodes project conventions.
3. **Skill** — if the need is reference material that agents should load on demand.
4. **Subagent** — if the need is a focused task that benefits from fresh context and persistent domain expertise.
5. **Primary agent** — only when the role requires fundamentally different permissions, temperature, or behavioral instructions.

New primary agents are rarely needed.
Most needs are better served by commands, tools, or skills.

## AGENTS.md

### Scope

AGENTS.md contains information that helps agents work effectively.
It is not a README, design doc, or onboarding guide.

The scoping question differs by level:

- **Global** (`~/.config/opencode/AGENTS.md`): "Do all agents across all projects need this?"
- **Project** (`./AGENTS.md`): "Do multiple agents in this project need this?"

If the answer is no, the content belongs in a specific agent's definition file.

### Content gaps

- **Missing context** — Conventions, patterns, or architectural decisions that agents keep getting wrong or asking about.
- **Outdated information** — Project structure, tech stack, or tooling changes not yet reflected.
- **Ambiguity** — Instructions that are vague or could be interpreted in conflicting ways.
- **Missing commands** — Build, test, lint, or deploy commands that agents need but aren't documented.

### Content excess

- **Stale artifacts** — Ephemeral files (plans, scratch scripts) from closed issues that should have been deleted.
- **Unnecessary content** — Information that doesn't help agents make better decisions.
- **Redundancy** — Multiple sections saying the same thing in different words.
- **Diminishing returns** — Detailed guidance on something agents now handle correctly without prompting. Shorten to a brief reminder or remove.
- **Verbosity** — Multi-paragraph explanations that could be a sentence or two. Agents don't need persuasion — they need concise instructions.
- **Resolved issues** — Workarounds or known-issue notes for problems that have been fixed.

### Structure

Sections should be scannable.
Use headers to delineate concerns.
Keep each section focused on one topic.

### Balancing growth

When adding content, look for existing content that can be removed or condensed.
Not every addition requires a corresponding cut, but the search should be habitual.
A shorter, more focused AGENTS.md is more effective than a comprehensive one.
The goal is a stable or shrinking document, not unbounded accumulation.

## Agent Definitions

Agent definitions live in `.opencode/agents/` (project-level) or `~/.config/opencode/agents/` (global).
Each is a Markdown file with YAML frontmatter followed by the agent's system prompt.

### Prompt structure

Agent prompts should be structurally scannable.

Use Markdown headers to delineate distinct sections (background, instructions, tool guidance, output format) rather than one long flow of text.
Break long enumerated lists (more than ~5 items) into subsections with descriptive headers so each concern is independently scannable.
Prefer headers over nested bullet lists — nesting blurs the boundary between a parent concept and its children, and doesn't scale when a section grows.
Keep each section focused on one concern — if a section covers multiple unrelated topics, split it.

### Prompt content

Instructions should be clear, focused, and actionable.
They must not contradict AGENTS.md — if an agent needs to deviate from a global convention, document why in the agent's definition.

### Permission design

Apply least privilege: agents should have the permissions they need and no more.

#### Signals that permissions are too narrow

- Permission prompts that are always approved — these should be `allow`.
- Agents working around missing permissions (e.g., using `mcp_write` to delete a file because `git rm` is denied).

#### Signals that permissions are too broad

- Agents with `"*": allow` on bash when they only need specific commands.
- Write access to directories the agent never modifies.

### Tool access

Agents should have the tools they need, and only the tools they need.
Tool scoping in `opencode.json` controls which MCP tools each agent can access.
Disable tools globally, then re-enable per-agent as needed.

### Project-local override constraint

OpenCode's `loadAgent` unconditionally sets the agent prompt to the markdown body (`md.content.trim()`), and the merge logic uses `??` (not `||`), so any non-null string — including `""` and HTML comments — silently replaces the global agent's prompt.

**Workaround:** Project-local agent files that override only frontmatter (permissions, model, etc.) must also include the full global agent body, appending project-specific additions at the end.
Do not use empty bodies or HTML comments as "permissions-only overrides."

This is tracked at [opencode#3895](https://github.com/anomalyco/opencode/issues/3895).

## Subagents

Subagents are fresh-context agents dispatched by primary agents via the Task tool.
They run with specialized prompts, return concise findings, and do not pollute the parent agent's context.

### Custom definition vs. Task tool general

Use a **custom subagent definition** (`mode: subagent` in `.opencode/agents/`) when:

- The task recurs and benefits from persistent domain expertise baked into the definition.
- The domain context is substantial enough that repeating it in every dispatch prompt would be wasteful and fragile.
- Quality depends on encoded gotchas, examples, and prior art — not just a role description.

Use the **Task tool with `general` or `explore`** when:

- The task is self-contained and the input provides all necessary context (e.g., summarizing CI output).
- No persistent domain expertise is needed beyond what the dispatch prompt provides.

### Domain context depth

The critical success factor for custom subagents is **substantial domain context** — handcrafted examples, encoded gotchas, and references to prior art in the codebase.
Role descriptions alone ("you are an expert in X") produce poor results.
The breakthrough comes from doing the work yourself first, then encoding _why_ you did it a certain way into the subagent definition.

Source: [jprokay, "Finally Understanding Subagents"](https://jprokay.com/post/013-finally-understanding-subagents)

### Fresh context vs. skill injection

Skills inject into the parent agent's context, increasing context pressure.
Subagents get a fresh context window with focused attention.

Use skills when the _current_ agent needs reference material.
Use subagents when verification benefits from a _fresh perspective_ — the whole point is clean context with focused attention.

### Dispatch patterns

#### Judgment-based

The parent agent's definition includes an instruction to optionally dispatch the subagent at a specific workflow step.
The agent uses judgment about when this is warranted (not after every trivial change).

#### Command-triggered

A slash command instructs the current agent to dispatch the appropriate subagent with relevant context.
This gives the human explicit control over when reviews happen.

#### Automatic hooks

Dispatching on every step is noisy for trivial changes and hard to partially adopt.
Prefer judgment-based or command-triggered dispatch.

### Permissions

Subagents are read-only by default.
Grant limited bash access only when the subagent needs to run targeted tests or experiments to verify hypotheses.

Primary agents need `permission.task: true` (or `"allow"`) in `opencode.json` to dispatch subagents.

### MCP tool access

Subagents can use MCP tools (Playwright, Honeycomb, etc.) — they require only a per-agent entry in `opencode.json`.
MCP tools are loaded once for the entire OpenCode instance; the only gate is the permission system (`findLast()` matching).
Disable tools globally under the top-level `tools` key, then re-enable per-subagent under `agent.<name>.tools`, just like primary agents.

### Question tool support

Subagents can use the `question` tool — the parent session's UI aggregates question prompts from child sessions.
The Task tool does not disable the `question` tool in subagent sessions.
This enables subagents to gate on human confirmation (e.g., for manual-required AC verification).
Include `question: true` in the subagent's `tools` frontmatter.

### Long-running operations

Subagents can perform long-running operations (CI workflow monitoring, multi-step Playwright verification) without timeout issues.
The Task tool maintains the subagent session until it completes.
Use the `ci_find` and `ci_watch` custom tools for CI workflow monitoring — they handle polling with proper backoff.
Load the `ci-cd` skill in the subagent definition or instruct the subagent to load it before triggering workflows.

### Subagent drift

Subagent definitions that reference project conventions (ADRs, skills, codebase patterns) can drift as those conventions evolve.
Stale subagent content is worse than no subagent — it teaches the wrong convention with fresh-context confidence.
When conventions change, update the subagent definitions in the same commit or immediately after.

## Commands

Slash commands live in `.opencode/commands/` (project-level) or `~/.config/opencode/commands/` (global).
Each is a Markdown file with YAML frontmatter (`description`, `agent`) followed by prompt instructions.

### Frontmatter

- `description:` — A concise description shown in the command palette.
- `agent:` — If specified, the command switches to that agent when invoked. If omitted, the command runs in the current agent's context.

### Content conventions

Command files must start with a top-level heading after the frontmatter to satisfy markdownlint's MD041 rule.
Use `$ARGUMENTS` to inject whatever the user types after the command name.

### Design principle

Keep commands lean — they should be triggers with context injection, not full agent instructions.
Agent-switching commands (`agent:` in frontmatter) are for workflow transitions.
In-context commands (no `agent:`) are for lightweight, fire-and-forget operations.

## Tools

Custom tools live in `.opencode/tools/` and run in Bun (OpenCode's runtime).
They are available to all agents automatically and bypass agent-level bash permissions (they execute via `Bun.spawn()`, not the agent's bash permission layer).

### Implementation conventions

When invoking CLI commands from tools, use `Bun.spawn()` instead of `Bun.$` template literals if the command arguments are in an array.
`Bun.$` treats array interpolations as a single string rather than spreading them as separate arguments.

Files in `.opencode/tools/lib/` are not auto-discovered as tools — use `lib/` for shared constants and helpers.

### Hot reload limitations

OpenCode loads custom tools, commands, plugins, and MCP server configuration at session start.
Edits do **not** take effect until OpenCode is restarted.
When implementing or fixing tools, verify changes via direct CLI commands rather than invoking the tool in the same session.
This also applies to shared constants — if a session changes a constant that tools depend on, tools will use the stale value until restart.
Changes to `opencode.json` also require a restart.

## Skills

Skills live in `.opencode/skills/<name>/SKILL.md` (project-level) or `~/.config/opencode/skills/<name>/SKILL.md` (global).
They are demand-loaded reference material — agents load them via the `skill` tool when a task matches the skill's description.

### When to extract from AGENTS.md

Extract content into a skill when:

- It is reference material (tables, examples, conventions) needed only for specific tasks.
- It adds significant context cost when always loaded.
- Multiple agents might need it, but not on every task.

Good candidates: tool reference tables, language-specific conventions, workflow procedures that cross agent boundaries.

### When to inline back into AGENTS.md

Move content back to AGENTS.md when:

- Agents consistently load the skill on every task — the demand-loading overhead isn't justified.
- The content is behavioral instructions that must always be present, not reference material.

### Description quality

Skill descriptions must be specific enough for agents to know when to load them.
Vague descriptions lead to skills being ignored.

**Weak:** "Testing conventions"

**Strong:** "Vitest configuration, mock cleanup patterns, Page Object Model for E2E, DynamoDB Local setup, and test strategy layering"

### Behavioral instructions vs. reference material

Skills are for reference material — facts, conventions, examples, tables.
Behavioral instructions ("when you see X, do Y") belong in agent definitions, not skills.
If a skill contains behavioral instructions, consider whether they should be in the agent definition that loads the skill.

## Plugins

Plugins live in `.opencode/plugins/` and run in Bun.
Unlike custom tools, plugins receive a pre-connected OpenCode SDK `client`.

Use plugins when a tool needs to interact with the OpenCode server (e.g., setting session titles, reading session metadata).
For everything else, use custom tools — they are simpler and don't require the SDK dependency.

## opencode.json

`opencode.json` lives at the repository root and configures MCP servers, per-agent tool scoping, and agent-level permission overrides.
It is loaded at session start alongside the global `~/.config/opencode/opencode.json`.

### MCP server configuration

MCP servers are configured under the `mcp` key.
Tools from MCP servers are prefixed with the server name (e.g., `playwright_browser_navigate` from the `playwright` server).

### Per-agent tool scoping

Disable tools globally under the top-level `tools` key, then re-enable per-agent under `agent.<name>.tools`.
This keeps tools out of agents that don't need them.

### Permission overrides

Agent-level permission overrides (e.g., `permission.task` for subagent dispatch) are configured under `agent.<name>.permission`.

## Global file management (chezmoi)

Global OpenCode configuration files (`~/.config/opencode/`) are managed by chezmoi.
Edits to the deployed copies will be silently overwritten on the next `chezmoi apply`.

When modifying global files (agents, skills, commands, plugins, `opencode.json`):

1. **Edit the chezmoi source** — files live in `$(chezmoi source-path)/private_dot_config/opencode/`.
   Use `chezmoi source-path ~/.config/opencode/<path>` to find the exact source file.
1. **Deploy** — run `chezmoi apply` to sync changes to `~/.config/opencode/`.

Do not edit the deployed copies directly — they are not the source of truth.
