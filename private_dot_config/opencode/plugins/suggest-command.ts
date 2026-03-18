import { type Plugin, tool } from "@opencode-ai/plugin";

async function copyToClipboard(text: string): Promise<boolean> {
  try {
    const proc = Bun.spawn(["pbcopy"], {
      stdin: new TextEncoder().encode(text),
    });
    await proc.exited;
    return proc.exitCode === 0;
  } catch {
    return false;
  }
}

export const SuggestCommandPlugin: Plugin = async ({ client }) => {
  return {
    tool: {
      suggest_command: tool({
        description:
          "Copy a suggested slash command to the clipboard and show a toast notification. " +
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
          const copied = await copyToClipboard(args.command);
          const message = copied
            ? `Suggested: ${args.command} -- paste to run`
            : `Suggested: ${args.command}`;
          await client.tui.showToast({
            body: {
              message,
              variant: "info",
              duration: 5000,
            },
          });
          return copied
            ? `Suggested command copied to clipboard: ${args.command}`
            : `Suggested command (clipboard unavailable): ${args.command}`;
        },
      }),
    },
  };
};
