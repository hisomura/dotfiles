---
name: commit
description: Fix files appropriately before committing and commit with proper granularity as needed. Use when to commit some changes.
---

## Instructions

Before creating a commit, you must follow these steps:

> **Note**: Identify the appropriate commands for formatting, linting, building, and testing from project configuration files (e.g., `package.json`, `build.gradle`, `Makefile`, `Justfile`) or project documentation (e.g., `README.md`, `CONTRIBUTING.md`).

1. **Check current branch**: If you are on a main branch (`master`, `main`, or `develop`), create a new feature branch before proceeding. Use a descriptive branch name based on the changes (e.g., `feat/add-user-authentication`, `fix/login-error`).
2. **Format and Lint**: Always format the code and fix linting issues. Ensure the code style adheres to the project's standards and no lint errors remain.
3. **Build**: If the changes might affect the build integrity, run the build to verify it succeeds. Fix any errors.
4. **Test**: If the changes affect business logic or existing tests, run relevant tests. Fix any failures.
5. Use `git status`, `git diff`, and `git show` to understand the previous commit content and current state
6. Group changes into logical units. If changes logically belong to the previous commit, include them using `git commit --amend`.
7. Commit one group. Follow the commit message format described below.
8. Repeat steps 5 through 7 until there are no more changes

## Commit Splitting Guidelines

### Basic Principles

1. **One commit = One logical change**
   - One bug fix
   - One feature addition
   - One refactoring
   - One documentation update

2. **Split by type**
   - Feature additions (feat) and refactoring (refactor) should be separate commits
   - Documentation updates (docs) should be separate commits
   - Configuration changes (chore) should be separate commits

3. **Split by platform (if necessary)**
   - Changes to shared code (commonMain) and platform-specific code may be separated
   - However, changes required for a single feature implementation can be combined into one commit

4. **Merge small fixes into the previous commit**
   - Typo fixes, comment fixes, removing unused imports, etc.
   - Small improvements that logically belong to the previous commit
   - **Important**: Only amend commits you created
   - **Strictly prohibited**: Amending commits by other developers or commits that have been pushed

### Splitting Examples

**Good example:**
```
commit 1: feat: add task creation functionality
commit 2: refactor: simplify loadTasks method
commit 3: docs: update README with API links
```

**Bad example (multiple types mixed):**
```
commit 1: feat: add task creation and refactor loadTasks and update docs
```

## Commit Message Format

### Basic Format

```
<type>: <description>
```

### Types

- **feat**: Adding a new feature
  - Example: `feat: add task creation functionality`
  - Example: `feat: implement drag and drop task reordering`

- **fix**: Bug fix
  - Example: `fix: resolve crash when deleting last task`
  - Example: `fix: correct task order after drag and drop`

- **refactor**: Refactoring (no functional changes)
  - Example: `refactor: simplify loadTasks and treat empty lists as a valid state`
  - Example: `refactor: remove Web compatibility layer from TasksRepository`

- **docs**: Documentation changes
  - Example: `docs: add UI/UX design specifications to DESIGN.md`
  - Example: `docs: update README with additional Google Tasks API links`

- **chore**: Build, configuration file changes
  - Example: `chore: update gradle dependencies`
  - Example: `chore: configure ktlint rules`

- **ui**: UI-related changes (visual improvements, not feature additions)
  - Example: `ui: replace FloatingActionButton with larger ExtendedFloatingActionButton`
  - Example: `ui: adjust task card padding for better readability`

- **test**: Adding or modifying tests
  - Example: `test: add unit tests for TasksRepository`

### Description Guidelines

1. **Write in English**
2. **Use imperative mood** (add, not added; fix, not fixed)
3. **Be concise** (ideally within 50 characters)
4. **Be specific** (make it clear what was changed)
5. **Start with lowercase**
