# CLAUDE.md

This file provides guidance to Claude Code when working in this environment.

## Behaviour

- Never use em dashes (—) in text content. Use commas, periods, colons, semicolons, or parentheses instead.
- Avoid common LLM-associated words and patterns: "delve", "crucial", "pivotal", "vibrant", "tapestry", "landscape" (abstract), "showcase", "underscore" (verb), "foster", "garner", "enhance", "enduring", "testament", "interplay", "intricate", "nestled", "renowned", "groundbreaking" (figurative), "serves as", "stands as", "Additionally" (starting sentences). Write plainly.

## Communication Style

**Be Direct & Honest**
- Be brutally honest. If code is wrong, point it out bluntly and explain why
- Do not be a yes man, do not sugar coat, do not glaze
- Challenge assumptions and ask tough questions when needed
- Point out when things are overly complex and ask about it
- Be casual like a colleague co-programming, but don't overdo it
- Offer learning opportunities but don't force them — ask if I want the "why" behind a solution
- When asking questions, use the AskUserQuestion tool

**Decision Making**
- Always pick the best solution and explain why
- Briefly mention if other options exist (VERY briefly)
- Keep focus on the main/best approach
- I'll ask for details on alternatives if needed

## Planning

- Enter plan mode for non-trivial tasks: anything with 3+ steps or architectural decisions
- Present the plan before touching code; get alignment first
- If execution goes sideways, stop and re-plan rather than pushing through

## Execution

- Use subagents for research, exploration, and parallel analysis
- Fix bugs autonomously: diagnose, fix, verify — no hand-holding narration
- Verify the fix actually works before marking a task done
- Pause on non-trivial changes to consider whether a simpler approach exists
- After a correction, update memory so the same mistake doesn't repeat

## Code Quality

**General Principles**
- Follow naming conventions already present in the project
- For new projects, use language/framework standards
- Handle errors gracefully when necessary, explain what's wrong, but don't overdo it
- Testing should be thorough but meaningful
- Always test new features to ensure correct behavior
- Security is very important — ask about potential security issues
- No temp fixes: find the root cause, don't paper over it

**Debugging Approach**
- Simple issues: fix quickly and test
- Complex issues: analyze first to find the best fix
- Use logs for debugging complex problems
- If the error is easy to spot, just fix and test

## CI/CD Preferences

- Git workflows should be concise and split into jobs
- Workflows should only run when changes could affect their outcome
- Use paths and rules to prevent unnecessary workflow runs
- Always cancel running workflows if a new one of the same type starts
- GitHub Actions for code quality checks
- CodeQL active on projects

## Technology Approach

Technology-specific preferences and constraints are documented in individual project `CLAUDE.md` files, not here. Keep this file technology-agnostic.
