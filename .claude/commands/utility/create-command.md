---
category: "utility"
phase: "development"
complexity: "medium"
requires_review: false
tags: ["meta", "command-creation", "productivity"]
---

# Create Command

## Purpose
Interactively create a new Claude Code command with proper structure, documentation, and placement within the organized command system.

## When to Use
- Creating new workflow automation
- Building reusable development patterns  
- Standardizing team processes
- Implementing project-specific commands

## Arguments
- `$ARGUMENTS` - Brief description of the command to create (e.g., "security audit for API endpoints")

## Prompt

You are a command creation specialist. Create a new Claude Code command based on: $ARGUMENTS

**First, read the documentation to understand the system:**
- Read `.claude/docs/commands-guide.md` for command creation guidelines
- Read `.claude/docs/organization-guide.md` for structure and categorization
- Check existing commands in `.claude/commands/` to avoid duplication

**Follow this interactive process - ask ONE question at a time:**

### Question 1: Command Purpose
What specific problem or workflow does this command solve? Be precise about the intended outcome.

*Wait for answer, then proceed to Question 2*

### Question 2: Category Classification  
Based on the commands guide, which category does this belong to?
- `workflow/` - Development process guidance
- `analysis/` - Code/project analysis  
- `automation/` - Automated tasks
- `planning/` - Project planning and design
- `utility/` - General helper commands

*Wait for answer, then proceed to Question 3*

### Question 3: Tool Requirements
- Does this command need arguments via `$ARGUMENTS`?
- Should it reference specific files with `@filename` syntax?
- Does it need to execute bash commands with `!command` syntax?
- Does it require any MCP (Model Context Protocol) servers for extended functionality?

*Wait for answer, then proceed to Question 4*

### Question 4: MCP Integration
If MCP servers are needed:
- Which specific MCP servers should be used?
- What MCP commands/prompts are required?
- Should the command check for MCP server availability?
- Any fallback behavior if MCP servers are unavailable?

*Wait for answer, then proceed to Question 5*

### Question 5: Complexity and Review
- Complexity level: simple/medium/complex?
- Does this command require human review checkpoints?
- What are the success criteria?

*Wait for answer, then proceed to Question 6*

### Question 6: Integration and Flow
- Does this command work with or reference other existing commands?
- Should it create supporting documentation?
- Any specific output format requirements?

**After gathering all answers, create the command file following the structure from `.claude/docs/commands-guide.md`:**

1. Generate the complete command file with proper frontmatter
2. Place it in the correct `.claude/commands/[category]/` directory
3. Use descriptive kebab-case naming
4. Include comprehensive documentation
5. Include MCP server requirements and usage if applicable
6. Add any supporting documentation if needed
7. Explain the design decisions made

**Focus on creating commands that solve real workflow problems and integrate seamlessly with the existing command ecosystem.**

## Human Review Required
- [ ] Verify command placement and naming follows conventions
- [ ] Confirm command doesn't duplicate existing functionality
- [ ] Validate MCP server requirements are correct

## Success Criteria
- Command file created in correct location with proper structure
- Follows documentation guidelines from commands-guide.md
- Integrates well with existing command ecosystem
- Properly handles MCP server integration if needed
- Solves a specific, measurable workflow problem