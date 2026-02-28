import { type Plugin, tool } from "@opencode-ai/plugin";

export const SuggestCommandPlugin: Plugin = async ({ client }) => {
  return {
    tool: {
      suggest_command: tool({
        description:
          "Pre-fill the user's input prompt with a suggested slash command and show a toast notification. " +
          "Use this when recommending a next step that involves a slash command (e.g., /build, /retro, /plan). " +
          "Always also mention the command in your text output as a fallback.",
        args: {
          command: tool.schema
            .string()
            .describe(
              "The full slash command text to suggest (e.g., '/build docs/plans/foo.md', '/retro')",
            ),
        },
        async execute(args, _context) {
          await client.tui.clearPrompt();
          await client.tui.appendPrompt({ body: { text: args.command } });
          await client.tui.showToast({
            body: {
              message: `Suggested: ${args.command} -- press Enter to run`,
              variant: "info",
              duration: 5000,
            },
          });
          return `Suggested command pre-filled: ${args.command}`;
        },
      }),
    },
  };
};
