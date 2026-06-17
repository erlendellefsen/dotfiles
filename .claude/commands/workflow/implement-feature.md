---
name: implement-feature
description: >
  Implement a feature from a brainstorm plan. Use this skill when the user has a brainstorm plan
  ready and wants to start building. Trigger on phrases like "implement the feature", "let's build
  this", "start implementing", "implement from the plan", "build the feature", "execute the plan",
  or any time the user references a brainstorm doc and wants to move into code. Also trigger when
  the user provides a path to a brainstorm markdown file and asks to implement it.
---

# Implement Feature

Implement a feature from a brainstorm plan, in phases, with parallel subagents where safe, tests
before and after, documentation checks, and a conventional-commits git summary at the end.

---

## Step 1: Load the plan

If the user gave a file path or feature name, read that file. If not, list `.claude/docs/brainstorm/`
and ask which plan to implement. Read the full plan before doing anything else.

Validate the plan has: acceptance criteria, a technical approach, and an implementation plan with
phases. If any are missing, tell the user what's absent and ask whether to proceed anyway.

---

## Step 2: Pre-flight exploration (parallel)

Before writing a single line of code, understand the terrain. Spawn parallel subagents to explore
the areas the plan says you'll touch. Each agent should:

- Read the files named in "Key files to touch" (or infer from technical approach if not listed)
- Identify the patterns already in use (naming, structure, how similar features are built)
- Note anything that contradicts or complicates the plan

Pay special attention to facts the plan assumes but hasn't confirmed — for example, whether an
entity the plan says to "create" already exists, whether a method the plan references actually
exists in the codebase, or whether the plan uses the right field types (e.g., plan says "priority 1
or 2" but the codebase uses string names).

Bring the findings together into a short summary: what was confirmed, what conflicts with the plan,
and what decisions are needed before coding. If there are conflicts or unresolved questions, go to
the "Ask at crossroads" section below before proceeding to Step 3.

---

## Step 3: Baseline tests

Before any changes: run the test suite. Record the result (pass/fail counts). If tests are already
failing, tell the user and ask how to proceed — don't write code on top of a broken baseline.

---

## Step 4: Implement phases

Work through the implementation plan phase by phase. Within a phase, look for work that is
independent across layers (e.g., backend service logic vs frontend component) and parallelize across
subagents when safe. Tasks that share a file or depend on each other must stay sequential.

For each phase:

**4a. Announce** — state the phase name, what it does, and which subagents (if any) will run in
parallel.

**4b. Implement** — write code that matches the plan. Follow the existing patterns you found in
Step 2. Don't deviate from the plan without asking. If you hit something unexpected mid-phase that
requires an architectural decision, go to "Ask at crossroads" immediately.

**4c. Test new code** — for any logic that is deterministic and verifiable (data transformations,
service methods, API responses, utility functions), write tests. Follow the project's existing test
patterns and frameworks exactly. Tests must be meaningful: test the real behavior, not
implementation details.

**4d. Validate** — run the full test suite. All tests must pass before moving to the next phase.
Auto-fix legitimate bugs in the implementation. Never adjust a test to make it pass if the
implementation is wrong — fix the implementation.

**4e. Checkpoint** — summarize what was built, show test results, and wait for a quick "looks good"
before continuing. Keep checkpoints light: one short paragraph + test status is enough.

---

## Ask at crossroads

When you hit an architectural decision not covered by the plan — either during pre-flight (Step 2)
or mid-implementation (Step 4b) — stop and present it as a numbered list:

```
Before I continue, I need answers to these questions:

1. [Question about X]: [1-sentence context on why this matters]
   My read: [your recommendation if you have one]

2. [Question about Y]: ...
```

State clearly that you will not proceed until these are answered. Do not provide a "conditional
implementation" (e.g., "assuming the answer is X, here's what I'd build...") as a substitute for
asking — write the questions, stop, and wait.

---

## Step 5: Post-implementation test run

Run the full test suite again at the very end. All tests that passed in Step 3 must still pass. No
regressions. If anything fails, fix it before continuing.

---

## Step 6: Documentation

Check whether the feature warrants a documentation update. Do this concretely:

```bash
# Search for existing docs on this feature area
grep -r "<feature keyword>" docs/ --include="*.md" -l
# or
ls docs/features/
```

**For new features:** if the feature is user-visible or changes how an API/integration works, and
docs exist in the project, create or update a doc that matches the existing style. Keep it short:
what the feature does, how to use it, any configuration. Don't repeat what's already in code.

**For changes to existing features:** if you found a matching doc, update only the parts that
changed. Don't rewrite from scratch.

If the docs folder doesn't exist, or the feature is purely internal with no user-facing behavior
change, skip this step.

---

## Step 7: Git summary

After a successful implementation, produce a ready-to-use git summary the user can copy:

```
Branch name:    feat/<short-kebab-description>

Commit message: feat(<scope>): <what was done in present tense>

                <optional body: 1-3 sentences on why, not what>

PR title:       feat(<scope>): <same as commit title>

PR description:
## What

<1-2 sentences: the problem this solves and how>

## Changes

- <key change 1>
- <key change 2>
- ...

## Testing

<how to verify: what to click, what endpoint to hit, what to look for>
```

Use conventional commit types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`. The scope should
be the domain or module (e.g., `alerts`, `mailrisk`, `export`). If the change spans multiple
scopes, pick the most significant one.

---

## Guidelines

**Follow the plan, don't extend it.** If the brainstorm says "add X," add X. Don't also add Y
because it seems related. Additions not in the plan need user approval.

**Parallel where safe, sequential where not.** Independent backend and frontend work can go in
parallel subagents. Work within the same file or where one task depends on another output must be
sequential.

**Tests before and after.** The baseline in Step 3 and the final run in Step 5 are both required.
Don't skip them.

**Ask at crossroads, then stop.** When you need a decision, ask and wait. Don't make calls
silently. Don't soften the ask by also providing a conditional plan — just ask.

**Match existing patterns exactly.** This is not the time to refactor. If the project does X, do X.
If the plan says "follow the pattern of Y," read Y first and actually follow it.

**Documentation check is not optional.** Search for existing docs before deciding whether to write
or update them.
