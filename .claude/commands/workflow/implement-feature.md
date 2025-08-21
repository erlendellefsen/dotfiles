---
category: "workflow"
phase: "implementation"
complexity: "complex"
requires_review: true
tags: ["implementation", "feature-development", "testing", "incremental-development"]
---

# Implement Feature

Systematically implement features based on brainstorm documentation through incremental development with continuous testing and validation.

## Purpose
Execute comprehensive feature implementation following brainstorm plans, developing incrementally with automatic issue resolution and continuous validation.

## When to Use
- After completing `/planning/brainstorm-feature` and approving the plan
- When you have detailed brainstorm documentation ready for implementation
- For systematic, phase-by-phase feature development
- When you need automated testing and validation throughout development

## Arguments
- `$ARGUMENTS` - Optional: Feature name or brainstorm file identifier. Will auto-discover available brainstorms if not provided or unclear.

## Prompt

I need to implement a feature based on existing brainstorm documentation. This will be done incrementally with continuous testing and validation.

**Step 1: Brainstorm Documentation Discovery**
${ARGUMENTS ? `Looking for brainstorm documentation for: "$ARGUMENTS"` : "No specific feature specified - I'll discover available brainstorm files."}

```bash
!find .claude/docs/brainstorm -name "*.md" 2>/dev/null || echo "No brainstorm directory found"
```

${ARGUMENTS ? "" : "If multiple brainstorm files exist, I'll list them and ask you to choose which feature to implement."}

${ARGUMENTS ? "If the specified feature name doesn't match exactly, I'll show similar options and ask for clarification." : ""}

Load the selected brainstorm documentation and validate it contains:
- Clear feature requirements and scope
- Technical architecture and component breakdown
- Implementation plan with defined phases
- Success criteria and validation points

**Step 2: Code Comments Strategy**
Before starting implementation, ask: "What code commenting style would you like me to use for this implementation? For example:
- Minimal comments only for complex logic
- JSDoc/docstring style for functions and classes
- Inline explanations for business logic
- Architecture decision comments
- Or follow existing project comment patterns?"

Wait for your preference before proceeding.

**Step 3: Project Context Analysis**
Analyze current project state:
```bash
!pwd && git status --porcelain
!find . -name "package.json" -o -name "Cargo.toml" -o -name "go.mod" -o -name "requirements.txt" | head -5
```

- Review project structure and tech stack
- Check for existing related code or components
- Identify testing framework and patterns used
- Look for MCP servers configuration and suggest usage if relevant for documentation lookup
- Check for project-specific docs folder structure: `!find . -path "*/docs/feature*" -type d 2>/dev/null`

**Step 4: Implementation Strategy Setup**
Based on the brainstorm plan:
- Break down implementation into discrete, testable components
- Map each component to existing project patterns and structure
- Identify dependencies between components
- Plan testing approach for each component
- Determine if progress tracking in brainstorm file is needed (for "big" features)

Ask for confirmation of the implementation approach before proceeding.

**Step 5: Incremental Implementation Process**

For each major component/phase in the brainstorm plan:

**5a. Component Planning**
- Announce which component is being implemented
- Reference the specific requirements from brainstorm documentation
- Explain how this fits into the overall architecture

**5b. Implementation**
- Create/modify files following existing project patterns
- Implement the component according to brainstorm specifications
- Follow established coding conventions and styles
- **Add concise code comments** using the agreed-upon style
- Integrate properly with existing systems

**5c. Testing Implementation**
- Create comprehensive tests for the component
- Follow project's existing testing patterns and frameworks
- Ensure tests cover edge cases mentioned in brainstorm
- Include integration tests if the component interacts with other systems

**5d. Validation & Issue Resolution**
- Run all relevant tests for the new component
- Run existing tests to ensure no regressions
- **Auto-fix strategy**:
  - If tests fail because feature needs more functionality: implement missing parts
  - If tests fail due to bugs: fix the bugs in implementation
  - If tests fail due to wrong testing approach: fix the testing strategy ONLY if it's genuinely incorrect
  - NEVER adjust tests just to make them pass if the implementation is wrong

**5e. Human Review Checkpoint**
After each major component:
- Summarize what was implemented
- Show test results and validation status
- Wait for approval before proceeding to next component
- Address any feedback or requested changes

**Step 6: Progress Tracking** (if applicable)
For substantial features:
- Update brainstorm file with implementation progress
- Mark completed phases/components
- Note any architectural decisions made during implementation
- DO NOT alter the original feature plan unless explicitly requested

**Step 7: Documentation Updates**
Check for project-specific documentation needs:

**Project Documentation:**
- Look for `docs/feature/` or similar project documentation structure
- If found, either:
  - Update existing feature documentation with new implementation details
  - Create new feature documentation if this is a significant new feature
- Include API documentation, usage examples, and integration notes

**Claude Documentation:**
- Update project CLAUDE.md if implementation introduces new patterns, technologies, or architectural changes
- Document any new development workflows or testing approaches
- Note any new dependencies or configuration requirements

**Step 8: Final Validation & Completion**
Before marking complete:
- Run full test suite to ensure everything works
- Validate all success criteria from brainstorm are met
- Ensure feature works end-to-end as planned
- Check for any remaining TODOs or incomplete implementations

**Step 9: Post-Implementation Options**
After successful completion, ask:
- "Should I run `/workflow/pre-commit-review` to review all changes before committing?"
- "Are there any additional validations or reviews needed?"
- "Should we update any additional documentation or configurations?"

**Critical Guidelines:**
- **Follow brainstorm plan exactly** - don't deviate without permission
- **Test continuously** - never move to next component with failing tests  
- **Auto-fix aggressively** - resolve issues immediately, don't defer
- **Maintain project consistency** - follow existing patterns and conventions
- **Add concise, meaningful comments** using agreed-upon style
- **Document as you go** - keep all documentation current
- **Ask before major decisions** - pause for architectural choices not in brainstorm
- **Preserve existing functionality** - ensure no regressions

**When requesting external help:**
If I need clarification on third-party integrations or unclear brainstorm details, I'll ask: "I need clarification on [specific aspect] to implement this correctly. Can you provide more details or point me to relevant documentation?"

**Error Handling Strategy:**
- Implementation bugs: Fix immediately and continue
- Missing dependencies: Install and configure appropriately  
- Test failures: Analyze root cause and fix properly
- Integration issues: Resolve by adjusting implementation, not tests
- Architecture conflicts: Pause and ask for guidance

**Progress Communication:**
Throughout implementation, I'll provide clear updates:
- "Implementing [component]: [brief description]"
- "Tests created and passing for [component]"
- "Ready for review: [component] is complete and validated"
- "Moving to next component: [next component name]"

Begin implementation now.

## Human Review Required
- [ ] Specify preferred code commenting style before implementation begins
- [ ] Approve implementation approach and component breakdown
- [ ] Review and validate each major component after implementation
- [ ] Confirm final feature meets all brainstorm success criteria
- [ ] Approve any architectural decisions not explicit in brainstorm

## Success Criteria
- Complete feature implemented according to brainstorm specifications
- All tests passing throughout implementation process
- No regressions in existing functionality
- Concise, meaningful comments added throughout implementation
- Documentation updated appropriately (project docs and CLAUDE.md if needed)
- Progress tracked in brainstorm file if applicable
- Feature works end-to-end as designed
- Ready for pre-commit review if requested