---
category: "workflow"
phase: "planning"
complexity: "complex"
requires_review: true
tags: ["documentation", "analysis", "maintenance", "pre-development"]
---

# Context Primer

Analyzes repository structure and updates CLAUDE.md and documentation files to reflect current codebase state before major feature development.

## Purpose
Synchronizes project documentation with current codebase reality, removing outdated information and documenting new patterns/features discovered.

## When to Use
- Before starting major feature development
- After significant codebase changes or refactoring
- When onboarding to a project with potentially stale documentation
- Periodic maintenance to keep context files current

## Arguments
- `$ARGUMENTS` - Optional: `[path] [mcp-servers]`
  - `path`: Directory to analyze (defaults to current repository)
  - `mcp-servers`: Comma-separated list of MCP servers to use for enhanced analysis

## Prompt

I need you to perform a comprehensive context primer analysis. Here's what I need:

**Step 1: Repository Discovery**
```
!pwd && git status --porcelain && git log --oneline -10
```

Analyze the current repository at: ${ARGUMENTS contains path ? "the specified path" : "current directory"}

**Step 2: Documentation Structure Analysis**
Find and catalog all documentation files:
- CLAUDE.md files (project and global)
- README files  
- Documentation in /docs, /documentation, /.claude/docs directories
- Architecture/design documents
- API documentation

**Step 3: Codebase Structure Analysis**
```
!find . -name "*.json" -o -name "*.toml" -o -name "*.yaml" -o -name "*.yml" | head -20
!git log --since="2 months ago" --pretty=format:"%h %s" | head -20
```

Analyze:
- Project configuration files (package.json, Cargo.toml, etc.)
- Recent git commits for major changes
- Directory structure and key architectural patterns
- Dependencies and frameworks in use
- Build/deployment configurations

**Step 4: MCP Integration (if specified)**
${ARGUMENTS contains MCP servers ? "Use the specified MCP servers: [servers] for enhanced analysis" : "Skip MCP integration - using built-in tools only"}

**Step 5: Gap Analysis & Recommendations**
Compare documentation against codebase reality:

1. **Outdated Information Detection**:
   - Find statements in documentation that no longer match codebase
   - Identify deprecated patterns/technologies mentioned
   - Check if file paths and examples are still valid

2. **Missing Documentation**:
   - New frameworks/libraries not documented
   - Recent architectural changes not reflected
   - New development patterns that should be documented

3. **Proposed Changes**:
   - Show EXACT text to be removed/updated with reasons
   - Show EXACT new text to be added with explanations
   - Organize by priority (critical/important/nice-to-have)

**Step 6: Interactive Updates**
For each proposed change:
- Show current text vs proposed text
- Give SHORT explanation of why the change is needed
- Wait for confirmation before applying
- Apply confirmed changes immediately
- Provide brief summary of what was changed

**Step 7: Iteration & Validation**
After initial updates:
- Re-analyze updated documentation
- Check for any inconsistencies created
- Suggest additional improvements if found
- Continue until documentation accurately reflects codebase

**Guidelines:**
- ONLY edit documentation files, never source code
- Be conservative - ask before removing anything you're unsure about  
- Focus on factual accuracy over style preferences
- Provide clear, concise explanations for all changes
- Maintain existing documentation structure and tone

**Output Format with Colors:**
```
## 📊 Analysis Summary
- Files analyzed: [count]
- Documentation files found: [list]
- Issues identified: [count]
- Changes proposed: [count]

## 🔄 Change Details

### 📄 [File]: [Brief description]
**🚨 Issue**: [What's wrong]
**✅ Proposed Fix**: [What to change]
**💡 Reason**: [Why this change]

### 🟡 Priority Levels:
🔴 **Critical**: Factually incorrect information
🟡 **Important**: Missing new features/patterns  
🟢 **Nice-to-have**: Clarity improvements

### 🎯 Status Updates:
✅ **Applied**: Change successfully made
❌ **Rejected**: Change declined by user
⏸️ **Pending**: Awaiting user confirmation
```

Use these color-coded emojis throughout your analysis and updates to make the output easy to scan and understand.

Begin the analysis now.

## Human Review Required
- [ ] Approve all proposed documentation changes before applying
- [ ] Verify removed statements are truly outdated
- [ ] Confirm new documentation accurately reflects codebase

## Success Criteria
- CLAUDE.md reflects current project state and technologies
- All outdated information removed from documentation
- New patterns and features properly documented
- Clear explanations provided for all changes made
- Documentation structure and tone preserved