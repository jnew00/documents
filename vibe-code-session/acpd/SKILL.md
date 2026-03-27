---
name: acpd
description: Complete branch workflow with AI-generated commit message
argument-hint: "[optional summary or scope]"
model: haiku
user-invocable: true
allowed-tools:
  - Bash(git add:*)
  - Bash(git commit:*)
  - Bash(git push:*)
  - Bash(git checkout:*)
  - Bash(git merge:*)
  - Bash(git branch:*)
  - Bash(git status:*)
  - Bash(git diff:*)
  - Bash(git log:*)
---

# Task: Complete Branch Workflow with AI-Generated Message

Please perform the following git operations in sequence:

1. Run `git status` to see all changes
2. Run `git diff` to analyze the actual modifications
3. Analyze the changes and draft a **Conventional Commit** message
4. Run `git add .` to stage all changes
5. Create a commit with your generated message
6. Push current branch to remote
7. Switch to main branch
8. Merge the feature branch into main
9. Push main to remote
10. Delete the feature branch (both locally and remotely)

**Conventional Commit Format (REQUIRED):**

```
<type>[optional scope]: <description>
```

**Types:**

* `feat` - New feature (appears in changelog)
* `fix` - Bug fix (appears in changelog)
* `perf` - Performance improvement (appears in changelog)
* `docs` - Documentation only
* `style` - Formatting, whitespace
* `refactor` - Code restructuring
* `test` - Adding/updating tests
* `chore` - Maintenance tasks
* `ci` - CI/CD changes

**Examples:**

* `feat: Add dark mode toggle`
* `fix(scanner): Resolve crash on empty dirs`
* `feat!: Redesign plugin API` (breaking change)

**Important:**

* Use lowercase for type and description
* No period at end of description
* Do NOT add the Claude Code attribution footer
* Before merging, verify there are no conflicts
* Confirm the current branch name before deletion
* Follow the Git Safety Protocol - never force push to main
* If any step fails, stop and report the error