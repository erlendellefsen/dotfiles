---
category: "planning"
phase: "planning"
complexity: "complex"
requires_review: true
tags: ["brainstorming", "feature-planning", "documentation", "architecture"]
---

# Brainstorm Feature

Interactive feature brainstorming that creates comprehensive implementation plans through critical questioning and iterative refinement.

## Purpose
Guide thorough feature planning by asking critical questions, challenging assumptions, and creating detailed implementation documentation that perfectly fits the current project.

## When to Use
- Before starting any new feature development
- When feature requirements are unclear or incomplete
- To validate feature ideas against current architecture
- When you need a systematic approach to feature planning

## Arguments
- `$ARGUMENTS` - Optional: Feature name or brief description. If not provided, will generate suggestions based on project analysis.

## Prompt

I need you to conduct a comprehensive feature brainstorming session. This is a critical planning phase that will determine the success of the implementation.

**Step 1: Feature Identification & Project Context**
${ARGUMENTS ? `Feature to brainstorm: "$ARGUMENTS"` : "No feature specified - I'll analyze the project and suggest potential features first."}

First, analyze the current project:
```bash
!pwd && git status --porcelain
!find . -name "package.json" -o -name "Cargo.toml" -o -name "go.mod" -o -name "requirements.txt" | head -5
```

- Examine project structure and identify main technology stack
- Review recent commits for context: `!git log --oneline -10`
- Check for existing CLAUDE.md and documentation
- Look for MCP servers configuration and suggest usage if relevant

${ARGUMENTS ? "" : "Based on this analysis, suggest 3-5 potential features that would fit well with the current project. Present them with brief descriptions and ask me to choose one or provide a different feature idea."}

**Step 2: Initial Feature Documentation Collection**
Ask me: "Do you have any existing documentation, notes, requirements, or specifications for this feature? Please share them or let me know if I should start from scratch."

Wait for my response before proceeding.

**Step 3: Critical Requirements Analysis**
Now I'll ask you a series of critical questions. Be thorough and challenge any assumptions:

**Core Functionality:**
- What is the EXACT problem this feature solves?
- Who are the specific users/personas that will use this?
- What are the must-have vs nice-to-have capabilities?
- Are there any existing solutions in the market? Why build this instead?

**Technical Integration:**
- How does this fit with our current architecture?
- What existing systems/components will this interact with?
- Are there any technical constraints or limitations?
- Will this require database changes? If so, what data models?

**User Experience:**
- What does the user journey look like step-by-step?
- Where will this feature be accessed in the current UI/interface?
- What are the error scenarios and how should they be handled?
- Are there any accessibility requirements?

**Dependencies & Resources:**
- What third-party services or APIs might be needed?
- Are there any new dependencies or libraries required?
- What are the performance requirements/expectations?
- Are there any security considerations?

**For each question area, I will:**
1. Ask follow-up questions if answers are vague
2. Challenge assumptions and propose alternatives when I see better solutions
3. Point out potential issues or conflicts with existing systems
4. Suggest improvements or different approaches
5. Ensure we cover all edge cases and scenarios

**Step 4: Architecture & Implementation Strategy**
After requirements are solid, we'll design:
- High-level architecture and component breakdown
- Database schema changes (if needed)
- API endpoints or interface contracts
- Integration points with existing systems
- Testing strategy and quality assurance approach

**Step 5: Risk Assessment & Validation**
Identify and plan for:
- Technical risks and mitigation strategies
- Potential blockers and dependencies
- Performance impact on existing systems
- Security implications
- Rollback/migration strategies if needed

**Step 6: Implementation Plan Creation**
Break down into:
- Sequential development phases
- Specific tasks and deliverables
- Dependencies between tasks
- Validation checkpoints
- Definition of "done" for each phase

**Step 7: Documentation Creation**
Create the final brainstorm document:
- Ensure `.claude/docs/brainstorm/` directory exists, create if needed
- Generate a unique, descriptive filename based on the feature
- Include all discussed requirements, architecture, risks, and implementation plan
- Format for easy reference during implementation
- Note that this will be used by `/workflow/implement-feature` command later

**Critical Guidelines:**
- **Be ruthlessly critical** - challenge every assumption
- **Ask "why" multiple times** - dig deep into motivations
- **Propose better alternatives** when you see them
- **Consider the existing project context** - nothing should feel bolted-on
- **Don't accept vague answers** - push for specificity
- **Think about edge cases** and error scenarios
- **Consider scalability and maintenance** from the start
- **Validate against current architecture** - ensure consistency

**Interactive Process:**
- Ask ONE focused question at a time
- Wait for complete answers before moving on
- Circle back to earlier topics if new information changes things
- Pause at each major section for validation before proceeding
- Don't rush - thorough planning saves implementation time

**When asking for external documentation or links:**
If I need to understand third-party systems, APIs, or technologies better, I'll ask you directly: "Can you provide documentation or links for [specific system/API] so I can better understand the integration requirements?"

**Output Format:**
The final brainstorm document should be well-structured markdown with:
- Clear problem statement and success criteria
- Detailed requirements and user stories
- Technical architecture and implementation approach
- Risk assessment and mitigation strategies
- Phased implementation plan
- Testing and validation strategy

Let's begin this thorough brainstorming process now.

## Human Review Required
- [ ] Approve feature scope and requirements before architecture design
- [ ] Validate proposed architecture against existing systems
- [ ] Confirm implementation plan phases and timeline expectations
- [ ] Review and approve final brainstorm documentation

## Success Criteria
- Comprehensive brainstorm document created in `.claude/docs/brainstorm/`
- All requirements thoroughly validated through critical questioning
- Architecture design aligns perfectly with existing project structure
- Implementation plan is actionable and properly sequenced
- All risks identified with mitigation strategies
- Documentation ready for `/workflow/implement-feature` command usage