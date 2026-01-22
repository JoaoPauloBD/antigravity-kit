---
name: cook
description: "Structured feature development workflow with multi-phase review gates. Plan -> Review -> Code -> Ship. Produces decision artifacts before any implementation. Use when: feature planning, development workflow, cook, well-done, microwave mode, code review, security review, QA planning."
---

# Cook - Feature Development with Guardrails

## Overview

Cook enforces a disciplined, multi-phase development process with proper review gates. Think of it as preparing a dish: ingredients must be fresh, cooking must be thorough, and plating must be precise.

The goal is not speed, but correctness, safety, and product discipline. Every dish must be properly prepared before serving. `/cook` produces ONLY a planning artifact - no code implementation until the artifact is approved.

## When to Use This Skill

- Use when starting any new feature development
- Use when you need structured planning before implementation
- Use when changes require product, UX, security, or QA review
- Use when you want to document decisions and trade-offs
- Use when working with teams that need visibility into planning
- Use when changes touch auth, payments, APIs, or database schemas

## Cooking Modes

### Well-Done (Default)

Full governance cooking. No shortcuts, no raw ingredients.

- Product scope check (ingredient approval)
- UX/Design review (presentation planning)
- Architecture review (kitchen design)
- QA review (taste testing)
- Security review (safety inspection)
- Documentation (recipe notes)

**Use for:** New features, architectural changes, core behavior changes.

### Microwave

Speed-optimized cooking for low-risk changes.

- Reduced review process
- No product or UX exploration
- Focus on minimal fix + tests

**Use for:** Bug fixes, small refactors, non-critical UI changes.

**Blocked topics (auto-escalate to well-done):**
- Auth / permissions / crypto
- Schema / migrations / storage
- Public API contracts
- UI flow changes
- Payments / purchase / paywall

## How It Works

### Step 0: Create Artifact (FIRST!)

Before ANY exploration, create the artifact file:

```
cook/<feature-slug>.<YYYY-MM-DD>.cook.md
```

This is mandatory - no other tools run until artifact exists.

### Phase 0: Project Policy & Context

- Scan CLAUDE.md, README.md, .claude/agents/
- Extract hard rules and preferred patterns
- Detect conflicts with request
- Classify policy alignment risk

### Step 1: Read the Order

- Restate feature in concrete terms
- Identify affected modules/components
- Identify risks and dependencies
- Check microwave blockers

### Step 2: Ingredient Approval (Product Review)

- Is this in scope for the project?
- Does it add user value?
- Decision: Approve / Reject / Defer

### Step 3: Presentation Planning (UX Review)

Triggered if UI changes are involved:
- Document user flow
- List UI components affected
- Note accessibility considerations

### Step 4: Implementation Plan

- Document selected approach
- List alternatives considered with trade-offs
- Create patch plan with files to modify
- Define commit sequence

### Step 5: Taste Testing (QA)

- Define test cases (happy path, edge cases, errors)
- List acceptance criteria
- Identify regression checks

### Step 6: Safety Inspection (Security)

- Input validation review
- Authentication/authorization check
- Data exposure risks
- Injection vulnerabilities

### Step 7: Recipe Notes (Documentation)

- List documentation updates needed
- Note new documentation required
- Migration guide if breaking changes

## Examples

### Example 1: New Feature (Well-Done)

```
/cook Add user authentication with OAuth
```

Creates artifact with full review cycle:
- Product approval for scope
- UX review for login flow
- Architecture decision on token storage
- Security review for auth implementation
- QA plan with 10+ test cases

### Example 2: Bug Fix (Microwave)

```
/cook Fix null pointer in payment handler --microwave
```

Creates minimal artifact:
- Problem statement with reproduction steps
- Minimal fix plan
- "Why safe" justification
- 1-2 verification tests

### Example 3: Dry Run (Preview)

```
/cook Add dark mode toggle --dry-run
```

Shows what would happen without creating artifacts:
- Which chefs would be consulted
- Which phases would run
- Potential blockers detected

## Artifact Structure

```markdown
# Cooking Result

## Dish
<feature description>

## Status
raw | cooking | blocked | needs-more-cooking | well-done | ready-for-merge | plated

## Cooking Mode
well-done | microwave

## Ownership
- Decision Owner: <name>
- Reviewers: <list>
- Approved by: <name>

---

# Phase 0 - Project Policy & Context
# Step 1 - Read the Order
# Step 2 - Ingredient Approval
# Step 3 - Presentation Planning
# Step 4 - Implementation Plan
# Step 5 - QA Review
# Step 6 - Security Review
# Step 7 - Documentation

---

# Risk Management
## Pre-mortem (3 scenarios)
## Rollback Plan
## Blast Radius

# Decision Log
```

## Best Practices

- **Create artifact first** - No exploration, reading, or analysis until artifact exists
- **One phase at a time** - Complete each phase before proceeding
- **Document trade-offs** - Always list alternatives considered
- **Pre-mortem required** - 3 failure scenarios for well-done, 1 for microwave
- **Ownership assigned** - Every well-done artifact needs a Decision Owner
- **Security blocks all** - Security blockers override everything else

## Common Pitfalls

- **Problem:** Skipping artifact creation to "explore first"
  **Solution:** Artifact-first is mandatory. Create skeleton, then explore.

- **Problem:** Using microwave mode for auth/payment changes
  **Solution:** System auto-escalates blocked topics to well-done.

- **Problem:** Starting implementation before artifact approval
  **Solution:** `/cook` is planning only. Implementation is a separate step.

- **Problem:** No alternatives considered in architecture decision
  **Solution:** Always document 2+ options with pros/cons.

## Cooking Statuses

| Status | Meaning |
|--------|---------|
| `raw` | Feature requested, not yet evaluated |
| `cooking` | /cook in progress, review phases running |
| `blocked` | Specific blocker identified (requires owner + next step) |
| `needs-more-cooking` | Rejected, incomplete, or killed |
| `well-done` | Approved and ready to implement |
| `ready-for-merge` | Post QA/Security, ready for merge |
| `plated` | Shipped to production |

## Stop Rules (Kill Switch)

Cooking is automatically killed if:
1. **No measurable effect** - feature has no clear, testable outcome
2. **Risk > value** - implementation risk outweighs user benefit
3. **No owner** (well-done mode) - no Decision Owner assigned
4. **No testable AC** - acceptance criteria cannot be verified

## Included Files

This skill includes everything needed to run cook:

### Agents (Chefs)
| Agent | Role | File |
|-------|------|------|
| `product_chef` | Scope, value, priorities | `agents/product_chef.md` |
| `ux_chef` | User flows, UI impact | `agents/ux_chef.md` |
| `engineer_chef` | Implementation plan | `agents/engineer_chef.md` |
| `architect_chef` | System impact, alternatives | `agents/architect_chef.md` |
| `qa_chef` | Test plan, edge cases | `agents/qa_chef.md` |
| `security_chef` | Threat assessment | `agents/security_chef.md` |
| `docs_chef` | Documentation updates | `agents/docs_chef.md` |
| `release_chef` | Versioning, changelog | `agents/release_chef.md` |
| `sous_chef` | Background monitoring | `agents/sous_chef.md` |

### Commands
| Command | Purpose | File |
|---------|---------|------|
| `/cook` | Main cooking workflow | `commands/cook.md` |
| `/cook-menu` | Artifact management | `commands/cook-menu.md` |
| `/cook-stats` | Analytics & insights | `commands/cook-stats.md` |
| `/sous-chef` | Background monitoring | `commands/sous-chef.md` |

### Templates
| Template | Purpose | File |
|----------|---------|------|
| Artifact skeleton | Base structure for cook artifacts | `templates/artifact-skeleton.md` |
| Well-done checklist | Full review checklist | `templates/well-done-checklist.md` |
| Microwave checklist | Quick fix checklist | `templates/microwave-checklist.md` |
| Validation checklist | Artifact validation | `templates/validation-checklist.md` |

### References
| Document | Content | File |
|----------|---------|------|
| Cook Contract | Required artifact sections | `references/COOK_CONTRACT.md` |
| Chef Matrix | Who produces what | `references/CHEF_MATRIX.md` |
| Anti-patterns | What NOT to do | `references/ANTI_PATTERNS.md` |

## Installation

```bash
# Option 1: Use the installer (recommended)
cd skills/claude-cook && ./install.sh

# Option 2: Manual copy
SKILL_DIR="path/to/skills/claude-cook"
cp -r "$SKILL_DIR/commands/"* ~/.claude/commands/
cp -r "$SKILL_DIR/agents/"* ~/.claude/agents/
cp -r "$SKILL_DIR/templates/"* ~/.claude/templates/
mkdir -p ~/.claude/skills/cook
cp "$SKILL_DIR/SKILL.md" ~/.claude/skills/cook/
```

## Related Skills

- `@brainstorming` - Use before /cook to explore ideas
- `@writing-plans` - For detailed implementation planning after cook
- `@test-driven-development` - For implementation phase after approval
- `@systematic-debugging` - For investigating issues before microwave fix

## Additional Resources

- [GitHub Repository](https://github.com/patrykjuniszewski/claude-cook)
- [COOK_CONTRACT.md](https://github.com/patrykjuniszewski/claude-cook/blob/main/COOK_CONTRACT.md) - Full artifact contract
- [CHEF_MATRIX.md](https://github.com/patrykjuniszewski/claude-cook/blob/main/CHEF_MATRIX.md) - Chef responsibilities
- [ANTI_PATTERNS.md](https://github.com/patrykjuniszewski/claude-cook/blob/main/ANTI_PATTERNS.md) - What NOT to do
