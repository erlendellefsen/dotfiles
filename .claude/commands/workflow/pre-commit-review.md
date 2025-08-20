---
category: "workflow"
phase: "implementation"
complexity: "medium"
requires_review: true
tags: ["git", "security", "quality", "pre-commit", "review"]
---

# Pre-Commit Review

## Purpose
Analyze git staged and modified files for security issues, unnecessary files, and code quality problems before committing, with severity-based reporting and interactive issue resolution.

## When to Use
- Before committing changes to ensure clean, secure commits
- When you want to catch issues before they reach GitHub Actions
- As part of your development workflow to maintain code quality
- Before creating pull requests

## Arguments
None - automatically analyzes all git staged and modified files

## Prompt

Perform a comprehensive pre-commit review of all git changes:

**Step 1: Analyze Git Status**
!git status --porcelain
!git diff --staged --name-only
!git diff --name-only

**Step 2: Security Analysis**
For each changed file, check for:
- Hardcoded secrets, API keys, passwords, tokens
- Insecure authentication patterns
- SQL injection vulnerabilities  
- XSS vulnerabilities
- Insecure file operations
- Exposed sensitive data
- Unsafe dependencies

**Step 3: Quality Analysis**
For each changed file, check for:
- Code style violations
- Missing error handling
- Performance issues
- Unused imports/variables
- TODO/FIXME comments that should be addressed
- Missing documentation for new functions/classes

**Step 4: Unnecessary Files Check**
Identify files that shouldn't be committed:
- Debug files, logs, temporary files
- IDE-specific files not in .gitignore
- Large binary files without clear purpose
- Generated files that should be excluded
- Personal configuration files

**Step 5: Report Results**
Present findings organized by severity with visual indicators:

🔴 **CRITICAL** (Must fix before commit):
- Security vulnerabilities
- Hardcoded secrets
- Files that expose sensitive data

🟡 **WARNING** (Should fix before commit):
- Code quality issues
- Performance problems
- Missing error handling
- Unnecessary files

🔵 **INFO** (Consider addressing):
- Style improvements
- Documentation gaps
- Minor optimizations

**For each issue, provide:**
- File path and line number
- Specific description of the problem
- Recommended fix or action

**Step 6: Summary and Decision**
If NO issues found:
- ✅ **All clear! Ready to commit.**

If issues ARE found:
- **Summary**: Count by severity level
- **Ask**: "I found X critical, Y warning, and Z info issues. Would you like me to help you fix these issues before committing?"

Follow the direct, honest communication style from `.claude/CLAUDE.md` - be blunt about problems found.

## Human Review Required
- [ ] Review all flagged security issues
- [ ] Decide whether to fix issues before committing
- [ ] Confirm unnecessary files should be excluded

## Success Criteria
- All git changes analyzed for security, quality, and necessity
- Issues categorized by severity with clear visual indicators
- Specific file locations and recommended fixes provided
- Clear go/no-go recommendation for committing