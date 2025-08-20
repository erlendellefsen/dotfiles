# Claude Code Commands Guide

## What are Commands?

Commands in Claude Code are markdown files stored in `.claude/commands/` that contain predefined prompts and instructions. They allow you to quickly execute common workflows by typing `/command-name` in the Claude Code interface.

## Command Structure

### Basic Format
```markdown
---
category: "workflow"
phase: "implementation"
complexity: "medium"
requires_review: true
tags: ["development", "feature", "implementation"]
---

# Command Title

Brief description of what this command does.

## Purpose
Clear, one-sentence description of what this command accomplishes.

## When to Use
- Specific scenarios where this command is most effective
- Prerequisites or conditions needed

## Arguments
- `$ARGUMENTS` - Description of what arguments this command accepts

## Prompt
The actual prompt that will be sent to Claude when the command is executed.

## Human Review Required
- [ ] Specific item that needs human validation
- [ ] Another item requiring manual review

## Success Criteria
- Measurable outcome 1
- Measurable outcome 2
```

### Frontmatter Metadata
All commands should include YAML frontmatter with:
- `category`: One of workflow/analysis/automation/planning/utility
- `phase`: Development phase (planning/implementation/testing/deployment)
- `complexity`: simple/medium/complex
- `requires_review`: boolean indicating if human review is needed
- `tags`: Array of relevant tags for searchability

## Command Categories

### Workflow Commands (`workflow/`)
Commands that guide development processes:
- Feature implementation workflows
- Code review processes
- Bug fixing procedures
- Release preparation steps

### Analysis Commands (`analysis/`)
Commands for code and project analysis:
- Security audits
- Performance analysis
- Code quality reviews
- Architecture assessments

### Automation Commands (`automation/`)
Commands that automate repetitive tasks:
- Testing procedures
- Deployment checks
- Documentation generation
- Environment setup

### Planning Commands (`planning/`)
Commands for project planning and design:
- Feature brainstorming
- Technical specifications
- Architecture planning
- Risk assessment

### Utility Commands (`utility/`)
General-purpose helper commands:
- Quick fixes
- Status checks
- Environment diagnostics
- Configuration management

## Advanced Features

### Arguments Support
Use `$ARGUMENTS` placeholder to accept parameters:

```markdown
## Prompt
Please analyze $ARGUMENTS for security vulnerabilities:
- Input validation issues
- Authentication bypasses
- Data exposure risks
```

Usage: `/security-audit src/auth.js`

### File References
Use `@` prefix to include file contents:

```markdown
## Prompt
Review the code in @$ARGUMENTS and suggest improvements for:
- Performance optimizations
- Code readability
- Error handling
```

### Bash Command Execution
Use `!` prefix to run shell commands:

```markdown
## Prompt
!npm test -- --coverage

Analyze the test results above and provide:
- Coverage gap analysis
- Suggestions for improving test quality
```

### Documentation References
Always reference relevant documentation within commands:

```markdown
## Prompt
Using the patterns defined in `.claude/docs/organization-guide.md`, 
analyze the current project structure and suggest improvements.
```

## Best Practices

### Command Design Principles
1. **Single Responsibility**: Each command should have one clear objective
2. **Descriptive Names**: Use clear, action-oriented naming
3. **Context-Rich Prompts**: Include specific instructions and expected outcomes
4. **Documentation Links**: Reference relevant docs and standards
5. **Reusable Design**: Make commands flexible for multiple scenarios

### Prompt Engineering
1. **Be Specific**: Define exact analysis criteria and output format
2. **Set Context**: Reference project files, frameworks, and constraints
3. **Include Examples**: Show expected output format when helpful
4. **Chain Actions**: Break complex workflows into sequential steps
5. **Use Available Tools**: Leverage Read, Edit, Bash, Grep, Glob, etc.

### File Organization
1. **Category Placement**: Use appropriate subdirectory for command type
2. **Consistent Naming**: Use kebab-case with descriptive names
3. **Logical Grouping**: Group related commands together
4. **Version Control**: Include in git for team sharing

## Common Patterns

### Analysis Pattern
```markdown
## Prompt
Analyze @$ARGUMENTS for [specific criteria]:

1. **Assessment**: [What to evaluate]
2. **Findings**: [Expected output format]
3. **Recommendations**: [Action items format]
4. **Priority**: [How to rank issues]

Reference standards from `.claude/docs/[relevant-doc].md`
```

### Implementation Pattern
```markdown
## Prompt
Implement $ARGUMENTS following these steps:

1. **Planning**: Review requirements and constraints
2. **Implementation**: Write code following project standards
3. **Testing**: Create/update tests as needed
4. **Documentation**: Update relevant documentation
5. **Review**: Check against `.claude/docs/quality-standards.md`
```

### Automation Pattern
```markdown
## Prompt
!command-to-run

Based on the output above:
1. Analyze results for [specific criteria]
2. Identify any issues or failures
3. Provide specific remediation steps
4. Suggest process improvements
```

## Integration with Settings

Commands work with your `.claude/settings.json` configuration:
- Tool permissions affect which tools commands can use
- Model settings determine response quality and speed
- Project-specific settings can customize command behavior

## Quality Standards

### Command Documentation
- Clear purpose statement
- Specific usage scenarios
- Well-defined success criteria
- Human review checkpoints where needed

### Prompt Quality
- Specific, actionable instructions
- Clear output format expectations
- Relevant context and constraints
- Error handling considerations

### Maintenance
- Regular review and updates
- Feedback incorporation
- Performance optimization
- Documentation synchronization