---
name: sync-pr
description: Create or sync a pull request from the current branch. Use after committing changes.
user-invocable: true
---

If another PR-related skill is available in the current project's skill list, use that instead of this one.

## Steps

### 1. Prepare branch

- If on the default branch (`gh repo view --json defaultBranchRef -q '.defaultBranchRef.name'`), pull latest and create a `<type>/<short-description>` feature branch.
- Run in parallel: `git status`, `git diff`, `git log origin/HEAD..HEAD --oneline`, `git diff origin/HEAD...HEAD`
- If uncommitted changes exist, commit them using the commit skill first.
- Push with `git push -u origin <branch>` if needed.

### 2. Create or update PR

Run `gh pr view --json number,title,body,url` to check for an existing PR.

**Existing PR:** Update title/body to reflect current commits. Preserve the existing body's section structure — do not remove or reorder sections.

**New PR:**

1. **Search for a PR template** using: `**/*pull_request_template*` (case-insensitive glob). Common locations: `.github/`, repo root, `docs/`.
2. **If a template is found, you MUST use it.** Read it, preserve its exact structure (headings, checkboxes, formatting), and fill in each section from the commit history and diff. Do not remove sections — write "N/A" for inapplicable ones. Append `🤖 Generated with [Claude Code](https://claude.com/claude-code)` at the end.
3. **If no template exists**, use this default:
   ```
   ## Summary
   <1-3 bullet points>

   ## Test plan
   - [ ] <checklist>

   🤖 Generated with [Claude Code](https://claude.com/claude-code)
   ```

### 3. Report

Return the PR URL.

## Conventions

- **Branch:** `<type>/<short-description>` (e.g., `feat/add-auth`, `fix/login-crash`)
- **PR title:** `<type>: <description>`
- **Types:** feat, fix, refactor, docs, chore, ui, test
