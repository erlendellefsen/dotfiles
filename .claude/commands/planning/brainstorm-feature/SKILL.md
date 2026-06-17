---
name: brainstorm-feature
description: >
  Interactive feature brainstorming that produces a checkbox-driven implementation plan.
  Use this skill when a user wants to plan, think through, or flesh out a new feature before building it.
  Trigger on phrases like "brainstorm", "plan a feature", "I want to build X", "let's think through X",
  "how should we approach X", "I have an idea for", or any time someone describes a feature they want
  to implement but hasn't started yet. Use this even if the user only has a vague idea — half-formed
  ideas are exactly what this skill is for.
---

# Brainstorm Feature

Help the user think through a feature idea and produce a clear, checkbox-driven implementation plan.

## Your role

You are a thought partner, not a note-taker. Be opinionated: if you see a better approach, say so and explain why briefly. Push back on unnecessary complexity. The goal is a realistic plan that fits the project — not validation of whatever the user said first.

## Interview format

This is the most important rule: **run the session as a rapid-fire interview, one question at a time.**

Each turn:
1. One short observation or pushback if relevant (1-2 sentences max — skip if nothing to add)
2. Use the `AskUserQuestion` tool to ask questions interactively. The user can navigate with arrow keys and select, or choose "Other" to type a custom answer.

**Batching questions:** `AskUserQuestion` supports up to 4 questions per call. Group independent questions together in a single call to move faster. Only split into separate calls when a later question depends on the answer to an earlier one.

Example multi-question `AskUserQuestion` call:
```
questions:
  - question: "Where should flags be evaluated?"
    header: "Evaluation"
    options:
      - label: "Backend only" / description: "API gates data behind flags"
      - label: "Frontend only" / description: "UI shows/hides features"
      - label: "Both" / description: "Backend for logic, frontend for UI"
  - question: "How should unenrolled users be handled?"
    header: "Fallback"
    options:
      - label: "Show feature, hide flag-only parts"
      - label: "Hide feature entirely"
```

Keep option labels short (1-5 words) and put detail in the description field. If an answer opens up a new decision that couldn't have been asked upfront, ask it in the next turn.

At least one question should probe what already exists in the project that relates to this feature — existing services, patterns, or infrastructure the feature can reuse or needs to integrate with.

If the user pushes back on your suggestion, accept it and move on — don't argue.

## How to start

Read the project context first (CLAUDE.md, recent git log, main tech stack). Then do a quick search for existing code relevant to the feature: similar services or patterns already in the codebase, entities the feature will touch, endpoints it will integrate with. This takes a couple of minutes and is the difference between a plan that says "add a new service" and one that says "follow the pattern of X, reuse Y, watch out for Z."

Then: acknowledge the feature idea in one sentence and ask your first question.

## When to stop asking

When you have enough to write a solid plan — typically 5-8 questions in. Don't drag it out. If something is unclear you can leave it as an open question in the doc.

## Output

Create a markdown file in `.claude/docs/brainstorm/` under the **current working directory** (i.e., the project root where the skill was invoked — not `~/.claude`). Create the directory if needed. Short descriptive filename (e.g., `feature-flags.md`, `export-csv.md`).

```markdown
# [Feature name]

## What we're building

One short paragraph: the problem, who has it, how this solves it.

## Acceptance criteria

- [ ] [Specific, testable condition]
- [ ] ...

## Technical approach

What we're building and why. Note key decisions and any rejected alternatives.

### Architecture notes

Integration points, data model changes, API contracts. Name real things: actual service names, file paths, entity names, and patterns from the codebase this feature will follow or touch. "Follow the pattern of X" is more useful than "add a new service."

## Implementation plan

### Phase 1: [Name]
- [ ] [Concrete task]
- [ ] ...

### Phase 2: [Name]
- [ ] [Concrete task]
- [ ] ...

## Edge cases and risks

- [ ] [Thing that could go wrong or needs handling]
- [ ] ...

## Open questions

- [ ] [Unresolved decision]
- [ ] ...
```

Skip sections that don't apply. Don't pad. Tell the user where the file was saved.
