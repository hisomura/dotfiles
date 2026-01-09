---
name: create-pr
description: Create a pull request from the current branch. Use after committing changes.
---

## Instructions

Before creating a pull request, you must follow these steps:

1. **Verify branch**: Ensure you are NOT on the main branch (master/main). If on the main branch, create and switch to a new feature branch first.

2. **Check current state**: Run the following commands in parallel to understand the branch state:
   - `git status` to see all untracked files
   - `git diff` to see staged and unstaged changes
   - `git log origin/master..HEAD --oneline` to see commits that will be included in the PR
   - `git diff master...HEAD` to understand the full changes from the base branch

3. **Commit pending changes**: If there are uncommitted changes, commit them first using the commit workflow.

4. **Push to remote**: Push the branch to remote with `-u` flag if not already pushed:
   ```
   git push -u origin <branch-name>
   ```

5. **Create PR**: Use `gh pr create` with the format below:
   ```bash
   gh pr create --title "<type>: <description>" --body "$(cat <<'EOF'
   ## Summary
   <1-3 bullet points describing what this PR does>

   ## Test plan
   - [ ] <Testing checklist items>

   🤖 Generated with [Claude Code](https://claude.com/claude-code)
   EOF
   )"
   ```

6. **Report**: Return the PR URL to the user.

## Branch Naming Guidelines

When creating a new branch, use the following format:

```
<type>/<short-description>
```

### Examples
- `feat/add-user-authentication`
- `fix/resolve-login-crash`
- `refactor/simplify-task-repository`
- `chore/update-dependencies`

## PR Title Format

Use the same format as commit messages:

```
<type>: <description>
```

### Types
- **feat**: New feature
- **fix**: Bug fix
- **refactor**: Code refactoring
- **docs**: Documentation changes
- **chore**: Build/configuration changes
- **ui**: UI-related changes
- **test**: Adding or modifying tests

## PR Body Guidelines

1. **Summary**: Briefly describe what this PR accomplishes (1-3 bullet points)
2. **Test plan**: Include a checklist of testing steps or verification items
3. **Keep it concise**: Focus on the "why" and "what", not the "how"
