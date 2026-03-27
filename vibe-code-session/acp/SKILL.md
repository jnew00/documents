---
name: acp
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

# Task: Add, Commit, and Push with AI-Generated Message

Please perform the following git operations:

1. Run `git status` to see all untracked/modified files
2. Run `git diff` to see the actual changes
3. Analyze the changes and draft a **Conventional Commit** message
4. Run `git add .` to stage all changes
5. Create a commit with your generated message
6. Push to the remote repository

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
* Follow the Git Safety Protocol from system instructions