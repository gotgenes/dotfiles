---
description: Start a design evaluation for a feature, flow, or page
agent: designer
---

# Design Evaluation

Evaluate the following design question, feature, or user flow.

$ARGUMENTS

Before starting:

1. Read the project's AGENTS.md for product context, UI conventions, and any Designer-specific instructions.
1. If the arguments reference a GitHub issue number, read the issue for full context.
1. Start the dev server to view the running application. Use `dev:preview` mode when evaluating flows that involve persistent data (athlete lists, user profiles, session bookings). Use `dev:msw` only for offline/mock scenarios.
1. If the arguments include a URL or page reference, use Playwright to view the current state.
1. Load the `mobile-ux` skill for mobile interaction patterns.
1. Load the `shadcn` skill if the evaluation involves component selection.

Begin by viewing the product as a user would — form impressions before reading code.
