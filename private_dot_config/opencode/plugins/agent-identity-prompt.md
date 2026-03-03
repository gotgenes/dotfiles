# Build: Agent Identity Plugins

## Goal

Build two OpenCode plugins, placed in `~/.config/opencode/plugins/` (chezmoi source: `~/.local/share/chezmoi/private_dot_config/opencode/plugins/`), that address two open issues in the OpenCode repository:

- **#7492** — Agents lack self-identity awareness when the user switches agents
- **#14930** — The conversation context sent to the model lacks per-message agent attribution

Each plugin should be a separate `.ts` file following the conventions of the existing plugin in the same directory (`suggest-command.ts`).

---

## Problem 1: Agent self-identity (#7492)

### What's happening

When a user switches primary agents (e.g. Plan → Build → Plan), the newly active agent has no way to know its own name. The `build` and `plan` built-in agents share the same provider base system prompt — there is no "You are the build agent" anywhere. The model infers its role only from tool availability and synthetic mode-reminder text injected by `insertReminders()`.

This causes the model to confuse itself with agents being _discussed_ in the conversation, or to fail to maintain role boundaries.

### Proposed fix

Use the `experimental.chat.system.transform` hook to inject a one-liner identity statement into the system prompt. Example output:

```text
You are currently operating as the "build" agent.
```

### Constraint

The `experimental.chat.system.transform` hook signature is:

```ts
"experimental.chat.system.transform"?: (
  input: { sessionID?: string; model: Model },
  output: { system: string[] },
) => Promise<void>
```

The `input` does **not** include the agent name. To get the current agent name, the plugin must look it up from the session — specifically, the agent name is stored on the most recent user message (`info.agent`). The plugin has access to an SDK `client` object that can query session/message data.

Alternatively, the plugin could use the `experimental.chat.messages.transform` hook instead (which does have the full message array including `info.agent` on each message), injecting into the last user message's parts rather than the system prompt.

The cleanest approach may be to combine both: use `experimental.chat.messages.transform` to extract the current agent from the last user message, then apply the identity annotation in a companion `experimental.chat.system.transform` call — but since the hooks run independently, that requires shared state or a single hook. Pick whichever approach is cleanest given the actual SDK client API.

---

## Problem 2: Per-message agent attribution (#14930)

### Current behavior

All agents in a session share one flat conversation history. The database stores `info.agent` on every message (both user and assistant), but `MessageV2.toModelMessages()` strips this metadata when converting to the format sent to the LLM. So downstream agents (e.g. a Retrospective agent reviewing a full session) see a flat transcript with no attribution — they cannot tell which agent produced which response.

### Proposed solution

Use the `experimental.chat.messages.transform` hook to prepend a small agent attribution header to each assistant message's text content before it reaches the LLM. The model should then see something like:

```text
[agent: plan]
Here is the analysis you requested...
```

### Hook signature

```ts
"experimental.chat.messages.transform"?: (
  input: {},
  output: {
    messages: {
      info: Message
      parts: Part[]
    }[]
  },
) => Promise<void>
```

Each `info` object has an `agent` field (string, the agent name). Each `parts` array contains parts of various types; text parts have `type === "text"` and a `content` field. User messages have `info.role === "user"`, assistant messages have `info.role === "assistant"`.

The mutation is ephemeral — it affects what the LLM sees in this call only, without altering what's persisted in the database. That's the desired behavior.

---

## Research context: Plugin system internals

- Plugin files in `~/.config/opencode/plugins/` are auto-loaded at startup
- Plugins export a named `const` of type `Plugin` (imported from `"@opencode-ai/plugin"`)
- Hooks receive an `output` object by reference; mutations to `output` properties are the return mechanism (return value is ignored)
- The `experimental.*` hooks are real and functional, but marked experimental — API may change
- `experimental.chat.system.transform` fires in `packages/opencode/src/session/llm.ts` right before `streamText()` is called
- `experimental.chat.messages.transform` fires in `packages/opencode/src/session/prompt.ts` in the main `loop()`, before `MessageV2.toModelMessages()` converts the message array for the LLM

## Existing plugin for style reference

```ts
// suggest-command.ts
import { type Plugin, tool } from "@opencode-ai/plugin";

export const SuggestCommandPlugin: Plugin = async ({ client }) => {
  return {
    tool: {
      suggest_command: tool({
        description: "...",
        args: {
          command: tool.schema.string().describe("..."),
        },
        async execute(args, _context) {
          await client.tui.clearPrompt();
          await client.tui.appendPrompt({ body: { text: args.command } });
          return `Suggested command pre-filled: ${args.command}`;
        },
      }),
    },
  };
};
```

## File naming

- Plugin for #7492: `agent-self-identity.ts`
- Plugin for #14930: `agent-message-attribution.ts`

Both go in `~/.local/share/chezmoi/private_dot_config/opencode/plugins/`.

## Verification

After writing the plugins, verify by:

1. Running `chezmoi apply` to sync to `~/.config/opencode/plugins/`
2. Starting a new OpenCode session and switching between Plan and Build agents
3. Checking that the system prompt includes the agent name (via a prompt like "What agent are you?")
4. Checking that assistant messages in the session have `[agent: ...]` prefixes visible to a downstream agent (e.g. ask the Retrospective agent to identify which agents handled which messages)
