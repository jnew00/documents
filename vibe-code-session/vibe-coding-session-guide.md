# Vibe Coding Session Guide

## Enterprise MVP Build with GitHub Copilot + Internal Design Kit

---

## Overview

A hands-on session where engineers learn agentic coding workflows by building a real MVP from rough requirements — using GitHub Copilot in VS Code with your internal design kit MCP server and custom skills.

**Duration:** ~3 hours
**Tooling:** VS Code, GitHub Copilot (Chat + Agent Mode), Internal Design Kit MCP Server, Custom Skills
**Constraints:** Locked-down environment, no external MCP servers or skill downloads

---

## Pre-Session Prep

### 1. Create the `COPILOT_INSTRUCTIONS.md` File

This is the most important artifact. Copilot reads this file for project-wide context. Create it in the repo root before the session. It should reference your design kit and set the rules the agent follows.

**Prompt to create this file (use in your own Claude/Copilot session):**

```
I need a COPILOT_INSTRUCTIONS.md for a project that uses our internal design kit.
Here are the constraints:

- All UI must use components from [YOUR DESIGN KIT PACKAGE NAME]
- Never use raw HTML form elements — always use FormField, Select, Checkbox, etc. from the kit
- All pages must use the [Shell/Layout/AppFrame] component as the root wrapper
- Follow [YOUR TEAM'S] naming conventions: PascalCase components, camelCase utils, kebab-case files
- Folder structure: src/pages/, src/components/, src/hooks/, src/utils/
- Routing: [React Router v6 / Next.js App Router / your setup]
- State management: [your preference]
- Every interactive element must meet WCAG 2.1 AA — use the kit's built-in a11y props
- Color tokens: only use design kit theme tokens, never hardcoded hex/rgb values
- Spacing: only use the kit's spacing scale (e.g., spacing.sm, spacing.md)

Generate a COPILOT_INSTRUCTIONS.md that enforces all of this.
Include a "Component Inventory" section listing the most common kit components
and when to use each one (Table, Card, Modal, Form, Button, Alert, etc.).
Include a "Do Not" section with anti-patterns.
```

### 2. Create the `refine-requirements` Skill

This skill transforms rough bullet points into structured, buildable requirements. You'll run it live in the session.

**Prompt to create this skill:**

```
Create a skill called "refine-requirements" for use with our internal design kit
MCP server. The skill should:

TRIGGER: When someone says "refine requirements", "turn these bullets into a spec",
"structure these requirements", "make these buildable", or provides a raw list of
features/needs and asks to organize them.

WHAT IT DOES:
1. Takes raw, unstructured requirement bullets as input
2. Calls the design kit MCP server to get the list of available components,
   page templates, and layout patterns
3. Produces a structured markdown document with these sections:

   ## Project Summary
   One paragraph describing what we're building and why.

   ## User Personas
   Who uses this and what do they need. Keep it to 2-3 personas max.

   ## Pages / Views
   For each page:
   - Page name and route
   - Purpose (one sentence)
   - Design kit layout template to use
   - Key components from the kit (mapped from component inventory)
   - Data requirements (what state/API data does this page need)
   - User actions (what can the user do here)

   ## Core Workflows
   Step-by-step user journeys that cross multiple pages.

   ## Acceptance Criteria
   Testable statements for each feature. "User can..." format.

   ## Out of Scope
   Things explicitly NOT in the MVP. This is critical for keeping the
   session focused.

   ## Build Order
   Suggested sequence for building pages/features, starting with the
   highest-value, lowest-complexity items.

IMPORTANT RULES:
- Every component suggestion must come from the actual design kit inventory,
  not generic React components
- If a requirement is too vague to map to components, flag it as
  "NEEDS CLARIFICATION" with a suggested question
- Keep the MVP tight — if a bullet sounds like a v2 feature, move it to
  Out of Scope and explain why
- The output should be a single markdown file that can be saved as
  REQUIREMENTS.md in the repo
```

### 3. Create the `requirements-to-pages` Skill

This skill takes the refined requirements and generates the page scaffolding.

**Prompt to create this skill:**

```
Create a skill called "requirements-to-pages" that works with our internal
design kit MCP server. The skill should:

TRIGGER: When someone says "generate pages from requirements", "scaffold the pages",
"create page stubs from spec", "build the page structure", or references a
REQUIREMENTS.md and asks to start building.

WHAT IT DOES:
1. Reads the structured REQUIREMENTS.md
2. For each page listed in the requirements:
   a. Calls the design kit MCP "scaffold-project" or "compose-page" skill
      to generate a page component using the correct layout template
   b. Adds placeholder sections for each key component identified in the spec
   c. Wires up the route in the router config
   d. Creates a corresponding test file stub
3. Generates an index file that exports all pages
4. Updates the app's main router with all routes
5. Produces a BUILD_CHECKLIST.md that lists every page and feature with
   checkboxes, ordered by the build sequence from the requirements

OUTPUT:
- One page component file per page in src/pages/
- Updated router configuration
- BUILD_CHECKLIST.md in the repo root
- A summary of what was created and what to build first

RULES:
- Every page must use the design kit Shell/Layout as its root
- Placeholder content should use the kit's Skeleton/Placeholder components,
  not hardcoded "TODO" strings
- Each page file should have a comment block at the top referencing which
  requirements it addresses
- Import paths must match the project's alias configuration
```

### 4. Create the `component-spec` Skill

This is the skill people will use most during the build sprint.

**Prompt to create this skill:**

```
Create a skill called "component-spec" that works with our internal design kit
MCP server. The skill should:

TRIGGER: When someone says "spec this feature", "break down this requirement",
"what components do I need for", "component spec for", or selects a requirement
bullet and asks how to build it.

WHAT IT DOES:
Takes a single feature requirement and produces a buildable component specification:

1. COMPONENT BREAKDOWN
   - List every component needed (from the design kit)
   - Show the component hierarchy (what nests inside what)
   - Note any custom components that need to be created (and what kit
     primitives they should extend)

2. PROPS & STATE
   - Define the props interface for any custom components
   - Identify local state (useState) vs shared state
   - List any context providers needed

3. DATA CONTRACT
   - Define the shape of data this feature needs
   - Mock data structure for development
   - API endpoint expectations (method, path, request/response shape)

4. INTERACTION MAP
   - Every user action and what happens (click, type, submit, hover)
   - Loading states, error states, empty states
   - Keyboard navigation requirements

5. ACCESSIBILITY REQUIREMENTS
   - ARIA attributes needed
   - Focus management rules
   - Screen reader announcements
   - Which kit a11y props to use

6. DESIGN KIT COMPONENT USAGE
   - For each kit component used, specify which variant/size/theme
   - Reference the design kit documentation for correct prop usage
   - Call the MCP server to verify component API if unsure

OUTPUT FORMAT:
A markdown spec block that can be pasted directly into Copilot chat
as context for "now build this component."

RULES:
- Never suggest a raw HTML element when a kit component exists
- Always include error and loading states — these are the first things
  people forget
- If the feature needs a component the kit doesn't have, spec it as
  a composition of kit primitives, not a from-scratch build
```

### 5. Create the `review-checkpoint` Skill

This runs periodically during the build sprint to catch drift.

**Prompt to create this skill:**

```
Create a skill called "review-checkpoint" that works with our internal design kit
MCP server. The skill should:

TRIGGER: When someone says "review checkpoint", "check progress", "audit the build",
"how are we doing", "run a check", or at any natural stopping point during building.

WHAT IT DOES:
1. Reads REQUIREMENTS.md and BUILD_CHECKLIST.md
2. Scans all component files in src/
3. Produces a checkpoint report:

   ## Progress
   - Requirements addressed: X / Y
   - Pages created: X / Y
   - Features complete: X / Y (based on checklist)

   ## Design Kit Compliance
   - Scan imports: flag any files importing from outside the design kit
     for UI components (e.g., raw `<input>`, `<button>`, `<table>`)
   - Flag any hardcoded color values (hex, rgb, hsl) not using kit tokens
   - Flag any inline styles that should use kit spacing/typography tokens
   - List components using kit components correctly (green)
   - List components with violations (red, with specific fix instructions)

   ## Accessibility Gaps
   - Run the MCP "ada-compliance" skill against each page
   - List any missing ARIA attributes, focus traps, or keyboard nav
   - Prioritize fixes by severity

   ## Missing Requirements
   - List requirements from REQUIREMENTS.md not yet addressed
   - Suggest which to tackle next based on build order

   ## Suggested Next Steps
   - Top 3 things to work on next, in priority order

OUTPUT: Print the report to chat. If writing to file, save as
CHECKPOINT.md in the repo root.

RULES:
- Be specific about violations — "line 42 of UserTable.tsx uses a raw
  <table> element, replace with DataTable from the kit"
- Don't just flag problems, provide the fix
- Keep the tone encouraging — this is a learning session
```

### 6. Create the `prompt-patterns` Cheat Sheet

This isn't a skill — it's a reference doc for attendees. Create it as a markdown file to share.

**Prompt to create this file:**

```
Create a one-page markdown cheat sheet called PROMPT_PATTERNS.md with effective
prompting patterns for building with GitHub Copilot + our design kit MCP server.
The audience is engineers who haven't done much agentic coding.

Include these sections:

## Starting a Feature
Template: "Build a [component/page] using [kit layout component] that [does what].
Use [specific kit components] for [specific parts]. Follow the spec in [file path]."

## Fixing Kit Compliance
Template: "This component uses raw HTML [element]. Refactor to use [kit component]
with [these props]. Keep the existing behavior."

## Adding a State/Interaction
Template: "Add [interaction] to [component]. When the user [action], [result].
Show a [kit loading/error component] during [async operation]."

## Debugging
Template: "This component renders [wrong behavior]. The expected behavior is
[correct behavior]. The data shape is [shape]. Fix it without changing
the kit components used."

## Accessibility Fix
Template: "Run the ada-compliance skill on [page/component]. Fix all violations.
Use the kit's built-in a11y props where available."

## Common Anti-Patterns (Don't Do This)
- "Make it look good" → Too vague, no kit reference
- "Build the whole page" → Too broad, breaks into bad output
- "Fix everything" → Agent will hallucinate fixes

## Pro Tips
- Always reference the specific kit component by name
- Break big features into individual component builds
- Run review-checkpoint after every 2-3 features
- If the agent suggests a raw HTML element, push back: "Use the kit's
  [component] instead"
- Paste the component-spec output before asking the agent to build
```

### 7. Build a Reference Implementation

Before the session, complete one feature end-to-end in the repo. Pick something representative — a page with a form, a table, and some interactive elements, all using the design kit.

This serves two purposes: it teaches the agent your patterns (Copilot learns from existing code in the project), and it gives attendees something to point at when the agent goes off track.

**Prompt to build the reference:**

```
Using our design kit MCP server, build a complete [pick a simple page from your
requirements — e.g., "Settings page" or "User Profile page"] that demonstrates:

1. Correct use of the kit's page layout/shell component
2. A form using kit FormField, Select, and Button components
3. A data table using the kit's DataTable component
4. Loading, error, and empty states using kit components
5. Full keyboard navigation and WCAG 2.1 AA compliance
6. Proper use of kit spacing and color tokens (no hardcoded values)
7. Responsive behavior using kit breakpoint utilities

Add detailed comments explaining WHY each kit component was chosen.
This will serve as a reference implementation for a team learning session.
```

---

## Session Agenda

### Step 1 — Show Raw Requirements + Refine Live (25 min)

**What happens:** Pull up your rough requirement bullets on screen. Let everyone
see how messy and incomplete they are — that's the point. Then run the
`refine-requirements` skill live and review the output as a group.

**How to run it:**

1. Open the raw bullets file in VS Code
2. Open Copilot Chat (Ctrl+Shift+I or Cmd+Shift+I)
3. Use agent mode and invoke the skill:

```
@workspace /refine-requirements

Here are our raw requirements:
[paste or reference your bullets file]

Use the design kit MCP server to map these to real components.
Flag anything too vague.
```

4. Review the output together:
   - Are the personas right?
   - Did it map to the right kit components?
   - What did it flag as "NEEDS CLARIFICATION"? Resolve those now.
   - What did it move to "Out of Scope"? Agree or override.
   - Is the build order sensible?

5. Save the output as `REQUIREMENTS.md` in the repo

**Teaching moment:** "The agent turned 15 vague bullets into a structured spec
in 2 minutes. But it also made assumptions — it put [X] in out of scope, and it
picked [wrong component] for [feature]. This is why you always review. The agent
is a fast first draft, not a final answer."

---

### Step 2 — Set Up the Project Context (10 min)

**What happens:** Walk through the COPILOT_INSTRUCTIONS.md and explain why it
exists. Show the MCP server connection and available skills.

1. Open `COPILOT_INSTRUCTIONS.md` and highlight key sections:
   - Component inventory ("these are the only UI components you should use")
   - Do-not list ("never raw HTML inputs, never hardcoded colors")
   - Folder structure expectations

2. Show the MCP server skills list in Copilot:
   - scaffold-project
   - compose-page
   - build-form
   - ada-compliance
   - brand-review
   - And your new custom skills

3. Show the reference implementation:
   - "This is what 'done' looks like"
   - Point out the kit component usage, token usage, accessibility

**Teaching moment:** "The agent can only follow rules it knows about. This
instructions file is how you teach it your team's standards. Without it, you'll
get generic React — with it, you get design-kit-compliant React."

---

### Step 3 — Bootstrap the Project (5 min)

**What happens:** Run the scaffold and page generation live. This is the fast
"wow" moment.

1. Run the scaffold skill:

```
@workspace Use the scaffold-project skill from the design kit MCP server.
Set up a new project with React, our design kit, and the routing structure
defined in REQUIREMENTS.md.
```

2. Immediately run `requirements-to-pages`:

```
@workspace /requirements-to-pages

Read REQUIREMENTS.md and generate page stubs for every page listed.
Use the design kit layouts specified in the requirements.
Wire up all routes. Create BUILD_CHECKLIST.md.
```

3. Show the result: folder structure, page files, router, checklist

**Teaching moment:** "We went from bullets to a structured repo in 10 minutes
total. Every page stub is already using the right kit layout. Now we just need
to fill them in."

---

### Step 4 — Model the Full Workflow on One Feature (20 min)

**What happens:** Pick one feature from the requirements. Walk through the
complete build cycle that everyone will repeat during the sprint. Go slow.
Narrate your thinking.

**Step 4a — Generate the spec:**

```
@workspace /component-spec

Spec this feature from REQUIREMENTS.md:
"[paste the specific requirement bullet]"

Map all components to our design kit. Include loading, error,
and empty states. Include full accessibility requirements.
```

Review the spec output. Point out how it mapped to kit components.

**Step 4b — Build from the spec:**

Copy the spec output, then:

```
@workspace Build this component based on the following spec.
Use only components from [design kit package]. Follow
COPILOT_INSTRUCTIONS.md strictly.

[paste the component spec]
```

Watch Copilot generate the code. Narrate:
- "It chose the right kit component here — good"
- "It used a raw `<div>` for spacing — I'll push back on that"
- "It missed the error state — let me ask for it"

**Step 4c — Fix issues:**

```
@workspace This component has the following issues:
1. Line 23 uses a raw <div> for spacing — use the kit's Stack or Box component
2. Missing error state — add an Alert from the kit when the API call fails
3. Needs keyboard navigation on the action buttons

Fix all three. Maintain the existing functionality.
```

**Step 4d — Validate:**

```
@workspace Run the ada-compliance skill on this component.
Then run brand-review. Report any violations.
```

**Teaching moment:** "That's the loop. Spec → Build → Fix → Validate. You'll
do this for every feature. The spec step is the one people skip — don't. It's
the difference between getting compliant output on the first try and spending
20 minutes fixing compliance issues after."

---

### Step 5 — Assign Work + Parallel Build Sprint (60-90 min)

**What happens:** Divide the remaining features among individuals or pairs.
Everyone follows the same workflow from Step 4.

1. Pull up `BUILD_CHECKLIST.md`
2. Assign features — let people pick what interests them
3. Share `PROMPT_PATTERNS.md` as a reference
4. Set a timer: "Every 20 minutes, run `/review-checkpoint`"

**Your role during the sprint:**
- Float between people
- Watch for common mistakes:
  - Skipping the component-spec step
  - Not pushing back when the agent uses non-kit components
  - Asking the agent to build too much at once
  - Not handling loading/error/empty states
- Help people refine their prompts when they get bad output
- Encourage people to share interesting agent interactions in the group chat

**Checkpoint cadence:**

At the 20 and 40 minute marks, have everyone run:

```
@workspace /review-checkpoint

Check my current work against REQUIREMENTS.md.
Scan for design kit compliance violations and accessibility gaps.
Tell me what to fix and what to build next.
```

At the 60 minute mark (or when most features are built), bring the group
back together for integration.

---

### Step 6 — Integration + Full Review (20 min)

**What happens:** Merge everyone's work. Run a comprehensive review across the
entire codebase.

1. Merge all branches / copy all work into one repo
2. Run a global review:

```
@workspace /review-checkpoint

Full project audit. Check every page and component against REQUIREMENTS.md.
Run ada-compliance on all pages. Run brand-review on all pages.
List every violation with the specific file and line number.
Prioritize fixes by severity.
```

3. Divide fix work: assign violations to whoever built that component
4. Run the review again after fixes to confirm resolution

**Teaching moment:** "The review skill found [N] issues across [N] files in
30 seconds. Manually reviewing all of this would take an hour. But notice it
also missed [thing] — the agent is a net, not a guarantee."

---

### Step 7 — Retrospective (10 min)

**Discussion prompts:**

1. **What prompting patterns worked best?**
   - Which prompt from the cheat sheet was most useful?
   - Did anyone discover a pattern not on the sheet?

2. **Where did the agent struggle?**
   - What kinds of requirements produced bad output?
   - When did you have to intervene most?

3. **Kit compliance:**
   - How many violations did review-checkpoint catch?
   - Were there patterns in what the agent got wrong?

4. **What would you change for next time?**
   - Skills that should exist but don't
   - COPILOT_INSTRUCTIONS.md rules to add
   - Requirements that needed more detail upfront

5. **Would you use this workflow on real work?**
   - What's the gap between this session and your actual sprint work?

---

## Quick Reference: Skill Summary

| Skill | When to Use | Creates |
|---|---|---|
| `refine-requirements` | Start of session, raw bullets → structured spec | REQUIREMENTS.md |
| `requirements-to-pages` | After requirements are finalized | Page stubs, routes, BUILD_CHECKLIST.md |
| `component-spec` | Before building each feature | Component spec (paste into Copilot) |
| `review-checkpoint` | Every 20 min during sprint + final review | Compliance report |
| `scaffold-project` | (existing) Project bootstrap | Project structure |
| `compose-page` | (existing) Individual page creation | Page components |
| `build-form` | (existing) Form-heavy features | Form components |
| `ada-compliance` | (existing) Accessibility audit | A11y report |
| `brand-review` | (existing) Visual/brand consistency check | Brand compliance report |

---

## Files to Prepare Before the Session

```
repo-root/
├── COPILOT_INSTRUCTIONS.md    ← Agent rules + kit component inventory
├── REQUIREMENTS_RAW.md        ← Your rough bullets (shown live, then refined)
├── PROMPT_PATTERNS.md         ← Cheat sheet for attendees
├── src/
│   └── pages/
│       └── SettingsPage.tsx   ← Reference implementation (one complete feature)
└── .vscode/
    └── settings.json          ← MCP server config for design kit
```

## Skills to Create Before the Session

1. `refine-requirements` — Bullets → structured spec
2. `requirements-to-pages` — Spec → page scaffolding + checklist
3. `component-spec` — Feature bullet → buildable component spec
4. `review-checkpoint` — Progress + compliance audit

---

## Tips for a Successful Session

- **Don't pre-polish the requirements.** The messier the input, the more impressive
  and educational the transformation.
- **Let the agent fail visibly.** When it uses a non-kit component or misses an
  accessibility requirement, don't fix it silently. Show the group, explain
  how to push back, and fix it with a prompt.
- **Keep the MVP scope ruthless.** The out-of-scope section of REQUIREMENTS.md
  is more important than the in-scope section. Kill anything that's not core.
- **Have a backup plan for MCP issues.** If the local MCP server hiccups, you
  should be able to fall back to referencing kit docs manually in prompts.
  Have the kit documentation URL bookmarked.
- **Record the session.** People will want to rewatch the Step 1 and Step 4
  demos when they try this on their own projects.
