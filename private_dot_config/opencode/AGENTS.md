# Global Agent Instructions

## Session Retrospective

At the end of a session — when the user's request appears to be fully resolved, or when the conversation has reached a natural stopping point — suggest that the user invoke `@retrospective` to review the session.

A natural stopping point includes: a task or issue being closed, a commit being made, a planning document being written, or the user saying something like "thanks" or "that's all."
Frame it as a brief, optional recommendation, not a demand.
For example: "If you'd like, you can run `@retrospective` to review this session for any improvements to the agent configuration."

Do not invoke `@retrospective` automatically.
Only suggest it when substantial work was completed (not for quick questions or trivial changes).
