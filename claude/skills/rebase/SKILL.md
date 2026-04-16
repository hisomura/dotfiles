---
name: rebase
description: Rebase a branch onto origin's default branch, resolving conflicts automatically. Use to incorporate latest upstream changes while keeping a linear commit history.
user-invocable: true
---

## Arguments

- First positional argument (optional): Branch name to rebase. Defaults to the current branch.

## Steps

### 1. Validate state

- Run `git status` to check for uncommitted changes. If any exist, abort with a message asking the user to commit or stash first.
- Determine the default branch: `gh repo view --json defaultBranchRef -q '.defaultBranchRef.name'`
- Determine the target branch (from the argument, or the current branch).
- If the target branch IS the default branch, abort — rebasing the default branch onto itself is not useful.

### 2. Fetch latest

- Run `git fetch origin` to get the latest remote state.

### 3. Switch to target branch

- If not already on the target branch, run `git checkout <target-branch>`.

### 4. Rebase

- Run `git rebase origin/<default-branch>`.
- If the rebase completes cleanly, skip to step 6.

### 5. Resolve conflicts

When a conflict occurs, repeat the following cycle until the rebase finishes:

1. Run `git diff --name-only --diff-filter=U` to list conflicted files.
2. For each conflicted file:
   a. Read the file and understand the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
   b. Run `git log --oneline -5 -- <file>` on both sides to understand the intent of each change.
   c. Read the surrounding code to understand the correct resolution.
   d. Resolve the conflict by editing the file — remove all conflict markers and produce the correct merged result.
   e. Run `git add <file>`.
3. After all conflicts in the current step are resolved, run `git rebase --continue`.
4. If new conflicts appear in subsequent commits, repeat from sub-step 1.

**Conflict resolution principles:**
- Preserve the intent of BOTH sides whenever possible.
- If both sides modified the same logic differently, prefer the branch's changes (ours) but integrate any new additions from upstream.
- Never leave conflict markers in the code.
- After resolving, verify the file is syntactically valid (no broken imports, unmatched brackets, etc.).

### 6. Report

- Run `git log --oneline origin/<default-branch>..HEAD` to show the rebased commits.
- Report success and the number of commits rebased.
- If conflicts were resolved, list the files that had conflicts and briefly describe each resolution.
