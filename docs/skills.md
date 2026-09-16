# Agent skills

User-level external skills are managed with [APM](https://microsoft.github.io/apm/).
This setup was verified with Homebrew APM 0.30.0.

## Files and scope

- `config/apm/apm.yml` declares dependencies, update refs, and target agents.
- `config/apm/apm.lock.yaml` records resolved commits, file hashes, and deployment ownership. Let APM generate it.
- `~/.apm` contains the working copies of these files and downloaded packages.
- Project-specific skills use a separate manifest and lockfile in their project.

Use ordinary APM commands with `--global` for user-level skills. Copy the two
configuration files between dotfiles and `~/.apm` when needed; no wrapper or
automatic synchronization is used. Run the copy commands from the dotfiles root.

Keep `~/.apm` as a real directory. APM 0.30.0 rejects a symlinked lifecycle-lock
path, and atomic metadata writes replace individual file symlinks.

## Restore from dotfiles

Install APM with `brew bundle`, then restore the recorded versions:

```sh
mkdir -p "$HOME/.apm"
cp config/apm/apm.yml config/apm/apm.lock.yaml "$HOME/.apm/"
apm install --global --frozen
```

Copying overwrites the working configuration. If it contains changes you want to
keep, save them to dotfiles first using the commands below.

## Save changes to dotfiles

After a successful APM operation, copy its configuration back and review the diff:

```sh
cp "$HOME/.apm/apm.yml" "$HOME/.apm/apm.lock.yaml" config/apm/
git diff -- config/apm/apm.yml config/apm/apm.lock.yaml
```

Commit both files together. If APM removes the lockfile after the last dependency
is uninstalled, remove the dotfiles copy too and copy only the remaining manifest.
Downloaded skill content stays outside Git.

## Add or change dependencies

Edit `config/apm/apm.yml`, then apply it while keeping the current runtime lockfile:

```sh
cp config/apm/apm.yml "$HOME/.apm/"
apm install --global
```

Save the resulting configuration back to dotfiles. Prefer individual skill
subdirectories over entire plugin or repository bundles.

## Weekly review and updates

```sh
apm deps list --global
apm outdated --global
apm update --global --dry-run
```

Review upstream changes, then update a selected dependency:

```sh
apm update --global anthropics/skills/skills/skill-creator
```

Save the resulting configuration back to dotfiles. `ref: main` selects the update
source; the lockfile records the commit restored by `install --frozen`.
No recurring job is configured.

## Remove or roll back a dependency

Remove a managed skill through APM, then save the configuration back to dotfiles:

```sh
apm uninstall --global anthropics/skills/skills/skill-creator
```

To roll back, restore the matching manifest and lockfile from Git and follow
"Restore from dotfiles." Uninstall dependencies added after that revision before
replacing the files, while APM still has their deployment ownership records.

## Current dependency

Anthropic's `skills/skill-creator` has dependency-level `targets: [claude]` and is
deployed to `~/.claude/skills/skill-creator`. Keep this restriction when editing
the manifest; Codex retains its built-in `skill-creator`.

Existing skills installed by other tools remain outside APM until individually
migrated. Manage each skill through one installer.
