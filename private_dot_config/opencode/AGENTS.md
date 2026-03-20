# Global Agent Instructions

This file contains **shared context that all agents need** across every project: approach, code design principles, decision protocols, and workflow conventions.
Operational guidance for a single agent belongs in that agent's definition file, not here.
When adding content, ask: "Do all agents across all projects need this?" If not, it belongs in a project-level `AGENTS.md` or a specific agent's definition file.

## Approach

### Simplicity

> "For each desired change, make the change easy (warning: this may be hard), then make the easy change."
> — Kent Beck

Prefer the simplest viable option.
When presenting architectural options, evaluate them through the lens of [YAGNI](https://martinfowler.com/bliki/Yagni.html) and [evolutionary architecture](https://www.thoughtworks.com/insights/books/building-evolutionary-architectures) — can we start simple and evolve later without significant rework?
Highlight the operational costs of complexity (deploy time, debugging surface area, number of moving parts) alongside the functional benefits.

### Thin Vertical Slices

Prefer delivering work in the thinnest end-to-end increment that produces user value and learning.
A vertical slice cuts through all layers — from what the user sees to what the system persists — rather than building layers horizontally one at a time.

This applies at every level: product work (what's the smallest thing that tests whether this opportunity is real?), architecture (does this approach allow incremental delivery or force big-bang integration?), and implementation (can this plan be structured as a sequence of working, deliverable slices?).

We don't fully understand what we want to build until we build it.
Thin slices shorten the distance between assumption and evidence.

### Explicit Is Better Than Implicit

Make interfaces reveal their intent.

- **Return values over side effects.** Functions and methods should return a meaningful result whenever possible. An explicit return value makes the function's purpose visible to callers and enables composition, testing, and reasoning about data flow. If a function only performs side effects, consider whether it can also return a result that describes what it did.
- **Decompose inputs at the interface boundary.** Accept meaningful components as distinct, named parameters rather than opaque compound values the function must parse internally. This makes the function's actual data requirements visible and pushes parsing to the caller, where context about the data's origin already exists.

Counterexample — an opaque compound input the function must parse:

```python
get_repo("https://github.com/gotgenes/getignore")
```

Preferred — discrete, named parameters that make data requirements explicit:

```python
get_repo(user_name="gotgenes", repository="getignore")
```

### Continuous Improvement

Single-loop learning asks "are we doing this correctly?" — double-loop learning asks "are we doing the correct thing?"
Agents should operate at both levels: execute well within the current approach, but also question whether the approach itself is still right.

#### Challenge assumptions

Don't just work within the current patterns and conventions — question whether they still serve the goal.
If a practice feels like cargo-culting or a previous decision hasn't aged well, say so.

#### Surface process improvements

When you notice friction, inefficiency, or a pattern that could be improved — in the codebase, tooling, or agent configuration itself — flag it rather than silently working around it.

#### Explain reasoning

Articulate _why_ you chose an approach, not just what you did.
Making mental models visible allows them to be examined and refined.

#### Feed retrospectives

When you notice something worth reviewing — what went well, what was harder than expected, what could be improved — flag it with `/retro-note <observation>`, or add a `[retro]`-prefixed todo item directly.
The Retrospective agent treats these as must-address items.
The user can also run `/retro-note` directly to record their own observations.

#### Preserving retro notes across TodoWrite calls

The `TodoWrite` tool replaces the entire todo list — it is not append-only.
Before calling `TodoWrite` for any reason (creating a fresh task list, updating progress, reorganizing priorities), read the existing todo list first and carry forward all uncompleted items prefixed with `[retro]`.
These are session-scoped observations flagged for the Retrospective agent and must survive across agent transitions and task list changes.

### No Broken Windows

Bug fixes always take priority over new features and enhancements.
Broken tooling, incorrect behavior, and regressions should be addressed before non-bug work.
This applies the [Broken Windows theory](https://en.wikipedia.org/wiki/Broken_windows_theory) to the codebase: small defects left unaddressed erode quality norms and compound over time.

In prioritized backlogs, rank bug fixes above all non-bug items, ordered by impact (friction per occurrence).
When there is no formal backlog, flag bugs immediately rather than working around them.

### Troubleshooting Third-Party Dependencies

When a bug is traced to a third-party dependency (GitHub Action, npm package, framework, etc.), check whether a newer version has already fixed the issue **before** designing a workaround.

1. Identify the upstream issue (search the dependency's issue tracker).
2. Check recent releases and changelogs for a fix.
3. If a fix exists in a newer version, upgrade rather than work around.
4. If no fix exists, then design a workaround — and reference the upstream issue in a comment so the workaround can be removed when a fix ships.

### Verify Before Documenting

Do not document a root cause, recommend a removal, or present a "simplification" until it has been tested.
If you change multiple variables at once, test each independently before attributing the fix.
If a quick test can resolve uncertainty, run the test before presenting a decision point.

### Question the Test Environment

When debugging a test failure — especially a flaky one — ask early: "Does this test environment resemble production?"
If the test runs against a dev server, mock, or emulator that behaves differently from the production runtime, the failure may be an artifact of the test environment, not a bug in the application.
Identify the differences between the test environment and production before investing in a fix.
A fix for a dev-server-only problem is a workaround, not a solution.

### Avoid Premature Convergence

As [John Cutler](https://cutlefish.substack.com/p/tbm-4852-premature-convergence) emphasizes, starting with a solution means starting with an untested assumption.
When given a solution rather than a goal, step back and clarify the objective before implementing.
Premature convergence — committing to an approach before the problem is well understood — leads to local optima and expensive rework.
(See also Cutler's [Balancing Divergence and Convergence](https://cutlefish.substack.com/p/tbm-2052-a-product-super-skill-balancing).)

#### Start from the objective

If a request specifies _how_ but not _why_, ask what outcome is desired before choosing an approach.
A well-understood goal is a prerequisite for a well-chosen solution.

#### Explore before committing

When multiple approaches could satisfy the objective, briefly outline the alternatives and their tradeoffs before investing in one.
Do not lock in the first viable path.

#### Recognize escalating friction

If an approach requires increasingly elaborate workarounds, treat that as a signal — not a challenge to power through.
Step back, revisit the alternatives, and propose a different path rather than accumulating complexity in service of a sunk cost.

#### Bias for action is not bias for commitment

Acting quickly to test assumptions and reduce uncertainty is healthy.
Acting quickly to lock in a plan before alternatives have been considered is premature convergence.
Favor fast experiments over early commitments.

## Code Design

### Self-Documenting Code

Code should be its own primary documentation.
Prefer names that reveal intent — for functions, methods, classes, variables, and modules — so the code reads clearly without supplementary explanation.

#### Names over comments

If a comment is needed to explain _what_ code does, treat that as a signal to extract a well-named function or rename the existing symbol.
Comments should explain _why_ — the reasoning, constraints, or non-obvious context behind a decision — not narrate the mechanics.

#### Scope-appropriate naming

Name length should correspond to scope.
Short names (`i`, `x`, `fn`) are fine for small scopes (loop counters, short lambdas, single-expression closures).
Wider scopes — exported functions, module-level variables, class names — warrant longer, descriptive names that reveal purpose.

#### Doc comments follow ecosystem conventions

Add documentation comments (JSDoc, GoDoc, Python docstrings, LuaLS annotations, etc.) where the language's tooling ecosystem expects them — typically on public/exported APIs.
Do not add doc comments purely for narration when the name and signature already convey usage, parameters, and return values.

### Code Organization and Proximity

Source files should read like a newspaper article: high-level intent at the top, progressively deeper detail as you read down.

#### Public API first

Exported functions, classes, and interfaces appear near the top of a file so readers can scan the module's surface without wading through implementation details.

#### Stepdown rule

Each function should be followed by the helpers it calls, at the next level of abstraction — caller first, then the helpers it depends on.
Related functions that collaborate or operate on the same data should also be grouped together rather than scattered through the file.

#### Helpers stay in the file

Private helper functions should remain in the same file as the code that uses them, when the language allows it.
This keeps related code together and reduces navigation burden.

#### Growing helpers signal a new layer

When private helpers accumulate to the point where they warrant their own tests, that is a design signal: extract them into a new module with its own public API.
Test only public interfaces — if something needs to be tested, it should _be_ a public interface, possibly of a lower-level module.

#### Defer to language conventions

When a language has idiomatic file layout conventions (e.g., Go's package structure, Python's module conventions), follow them.
The newspaper ordering is the default when no stronger convention applies.

### Directory Structure

Organize project directories by feature (domain concept), not by technical type.

#### Group by feature

A feature directory (e.g., `auth/`, `appointments/`, `checkout/`) contains everything that feature needs: schemas, UI components, data access, helpers, and tests.
This keeps related code close together, makes feature boundaries visible in the file tree, and allows a feature to be understood, modified, or removed without navigating across the entire project.

#### Avoid group by type

Directories like `schemas/`, `components/`, `repositories/`, `helpers/` scatter a single feature's code across the tree.
This makes it hard to see what a feature touches, encourages implicit coupling between unrelated features that share a directory, and forces every change to span multiple distant locations.

#### Shared code lives in explicit shared modules

When code is genuinely used across multiple features, extract it into a clearly named shared module (e.g., `shared/`, `lib/`, `common/`) rather than leaving it in one feature's directory.
The threshold for extraction is actual reuse, not speculative reuse.

#### Defer to framework conventions

Some frameworks prescribe a directory structure (e.g., Next.js `app/` routing, Rails `app/models/`).
When a framework convention conflicts with group-by-feature, follow the framework — but organize within those constraints by feature where possible (e.g., Next.js route groups, Rails namespaced modules).

### SOLID Principles

Follow the SOLID principles, with particular emphasis on Single Responsibility, Interface Segregation, and Dependency Inversion.

#### Single Responsibility (SRP)

Each function, class, and module should do one thing well.
When a unit of code has multiple reasons to change, split it.
This applies at every scale — a function that parses input _and_ processes it should be two functions; a module that handles both HTTP routing and business logic should be two modules.

#### Interface Segregation (ISP)

Prefer small, focused interfaces over large ones.
Clients should not be forced to depend on methods or properties they don't use.
When an interface grows, look for natural seams to split it into smaller, cohesive contracts.

#### Dependency Inversion (DIP)

This is critical and non-negotiable for testable design.
High-level modules should not depend on low-level modules; both should depend on abstractions.
Default to dependency injection for non-trivial dependencies — accept collaborators as parameters rather than constructing them internally.
DI is the mechanical foundation of test-driven development: without it, you cannot substitute test doubles, and without test doubles, you cannot test units in isolation.
When writing new code, design for injection from the start rather than retrofitting it later.

### Markdown

Always specify a language identifier immediately after the opening fence of a code block (e.g., `typescript`, `text`, `bash`).
Use `text` for plain-text output that has no specific syntax.
Most projects enforce this via markdownlint's MD040 rule.

## Decision Points

Some choices during implementation establish conventions, set precedents, or are difficult to reverse.
When an agent encounters such a decision, it must **pause and present the options to the user** rather than choosing unilaterally.

Examples of decision points:

- A linter rule conflicts with a framework convention (disable the rule? rewrite the code? inline suppression?)
- A library or tool needs to be chosen between alternatives
- A file structure, naming pattern, or architectural boundary is being established for the first time
- A workaround is needed for a tooling limitation, and there are multiple approaches
- A testing strategy decision (what to test, at what level, with what tools)
- An acceptance criterion prescribes a specific mechanism (e.g., "console traces") rather than a desired outcome (e.g., "traces are viewable locally") — the mechanism may have been chosen as the path of least resistance in a prior issue, not as a deliberate architectural choice

When presenting a decision point:

- Explain the context: what triggered the decision and why it matters.
- List the options with pros, cons, and consequences of each.
- State which option you'd recommend and why, but do not apply it without confirmation.
- If you're unsure whether something is a decision point, err on the side of asking.

## Manual Actions

When a task requires the user to perform a manual action (e.g., change a setting in a UI, approve a permission, create a resource that can't be automated), use the `question` tool to **gate on completion** rather than printing instructions and continuing.
This ensures the user sees the request (it blocks progress) and gives them structured options to respond.

### Blocking actions

Use the `question` tool with this format:

- **Header**: `Manual action required`
- **Question**: Numbered steps the user needs to perform
- **Options**: `Done` ("I've completed the steps above"), `Need help` ("I'm stuck or something looks different than expected"), `Something went wrong` ("I completed the steps but got an error or unexpected result")

If the user selects "Need help" or "Something went wrong", ask clarifying questions before retrying or adjusting the approach.

### Non-blocking notes

For things the user should do later but that don't gate current progress, mention them in the conversation output without using the `question` tool.

## Question Tool Usage

The `question` tool renders as a compact dialog widget — not a document viewer.
Keep question invocations lean and put supporting context in regular message output.

### Context before, not inside

Output all explanatory context (plan summaries, analysis results, step lists, follow-up notes) as regular message text **before** invoking the `question` tool.
The question text should be a concise prompt, and options should be short actionable choices.

**Bad** — context stuffed into the question widget:

```text
question(
  header: "Plan review",
  question: "The plan covers 12 implementation steps (outside-in TDD order):
    1. Install npm dependencies
    2. Install shadcn/ui components
    ... (10 more steps) ...
    All 8 ACs are covered.
    Follow-ups: Auto-sign-in after verify (new issue after #68).
    Ready to proceed?",
  options: [...]
)
```

**Good** — context in message output, question tool is concise:

```text
[message]
The plan covers 12 implementation steps. All 8 ACs are covered.
Follow-up: Auto-sign-in after verify (new issue after #68).

[question tool call]
question(
  header: "Plan review",
  question: "Ready to proceed?",
  options: [
    { label: "Looks good, proceed", description: "Approve and move to implementation" },
    { label: "I have changes", description: "I want to adjust something first" }
  ]
)
```

### One decision per question

Each question (or each question-option group within a multi-question invocation) should address **a single independent decision**.
Do not combine unrelated decisions into one question with combinatorial options like "I agree with all / I only want X / I want X and Y but not Z."

When multiple decisions are needed:

- **Preferred:** pass multiple question-option groups in a single `question` invocation (one group per decision).
- **Also acceptable:** invoke `question` multiple times sequentially, one decision per call.
- **Not acceptable:** one question with options that encode combinations of independent choices.

## Workflow Commands

Global custom commands are available to streamline agent transitions.
When suggesting a handoff to another agent, mention the relevant command if one exists.

- `/architect <context>` — Switch to the Architect agent for structured architectural evaluation. Pass an issue number, question, or topic as arguments.
- `/tdd <context>` — Switch to the TDD agent and begin outside-in implementation. Pass a plan file path, issue number, or task description as arguments.
- `/build <context>` — Switch to the Build agent for non-TDD implementation (config, infrastructure, tooling). Pass a plan file path, issue number, or task description as arguments.
- `/retro` — Switch to the Retrospective agent for end-of-session review.
- `/retro-note <observation>` — Flag an observation for the session retrospective without switching agents. The Retrospective agent treats these as must-address items.

Projects may define additional commands (e.g., `/pm-start`, `/plan`, `/pm-verify`) in `.opencode/commands/`.

### Suggesting Commands

When suggesting a slash command as a next step, mention the command in text output **and** call the `suggest_command` tool to copy it to the user's clipboard.

## Session Retrospective

Retrospectives are the primary mechanism for closing the continuous improvement loop — they turn session observations into durable changes to agent configuration, workflows, and conventions.

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user run `/retro`, or switch to the **Retrospective** agent via Tab, to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can run `/retro` to review this session for improvements to the agent configuration."
When suggesting `/retro`, also call `suggest_command("/retro")` to copy it to the user's clipboard.

Do not switch to the Retrospective agent automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).

## Environment

### CLI Tools

This system has modern CLI tools installed via Homebrew.
Prefer these over their traditional counterparts: `fd` over `find`, `rg` over `grep`, `eza` over `ls`, `bat` over `cat`, `sd` over `sed`, `dust` over `du`, `jq` for JSON processing.
Load the `cli-tools` skill for the full tool mapping and usage examples.

### GitHub Authentication

This system may have multiple GitHub users authenticated via `gh auth`.
A wrapper script at `~/.local/bin/gh` automatically selects the correct account when the `GH_USER` environment variable is set (typically by a per-directory `mise.toml`).

When running `gh` commands that interact with a repository, the wrapper handles authentication automatically if `GH_USER` is configured for the current directory.
If `GH_USER` is not set, the default active account is used.

If you encounter authentication errors or need to verify the current account, run `gh auth status`.
