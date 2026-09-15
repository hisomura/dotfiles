# Agent skills

User-level external skills are managed with [APM](https://microsoft.github.io/apm/).
The initial setup was verified with Homebrew APM 0.30.0.

## Management policy

Keep the desired user-level dependencies and their resolved versions in dotfiles.
APM owns dependency resolution, installation, updates, and removal; the wrapper
only synchronizes the manifest and lockfile. This keeps declarative management
without maintaining a separate package manager or committing downloaded skills.

Use the wrapper for user-level changes and APM directly inside each project for
project-level changes. Add external skills individually as needed, rather than
migrating every existing skill at once.

## Files and scope

- `config/apm/apm.yml` declares dependencies, update refs, and target agents.
- `config/apm/apm.lock.yaml` records resolved commits, content hashes, and deployment ownership. Let APM generate it.
- `~/.apm` is a normal directory containing live APM state and downloaded packages.
- `scripts/apm-global` copies the two metadata files into `~/.apm`, runs the standard APM command with `--global`, and copies successful results back. It does not resolve or install dependencies itself.
- APM 0.30.0 rejects a symlinked `~/.apm` lifecycle lock path. Individual metadata symlinks also break when APM atomically replaces files, so this setup uses file synchronization.
- Project-specific knowledge belongs in its project. Use a separate project `apm.yml` and lockfile there.

Run the commands below from the dotfiles root. The wrapper always selects user scope.
Do not run project-scoped APM commands in `config/apm`.

## Bootstrap

Install APM with `brew bundle`, then restore the committed versions:

```sh
./scripts/apm-global install --frozen
```

If `~/.apm` already has a different manifest or lockfile, the wrapper stops
without overwriting it. Reconcile the two configurations before adopting this setup.

## Current dependency

Anthropic's `skills/skill-creator` is restricted to `targets: [claude]` on the
dependency entry. The top-level targets can include both Claude and Codex;
dependency-level targets constrain where this skill is deployed.

- Claude reads the APM-managed `~/.claude/skills/skill-creator`.
- Codex keeps its built-in `skill-creator`.
- Do not install another Anthropic copy in `~/.agents/skills` or `~/.codex/skills`.

Existing skills installed by other tools remain outside APM management until migrated.
Manage each skill through one installer. Do not run `gh skills update --all` as
part of APM maintenance.

## Add or change dependencies

Edit `config/apm/apm.yml`, keeping `targets: [claude]` on Claude-only dependencies.
Prefer a direct skill subdirectory over an entire plugin or repository bundle.
Then install and review the generated lockfile:

```sh
./scripts/apm-global install
git -C "$HOME/dotfiles" diff -- config/apm/apm.yml config/apm/apm.lock.yaml
```

Commit both files together. Downloaded skill content is not committed.

## Weekly review and updates

```sh
./scripts/apm-global deps list
./scripts/apm-global outdated
./scripts/apm-global update --dry-run
```

Review upstream changes for affected skills, then apply selected updates:

```sh
./scripts/apm-global update anthropics/skills/skills/skill-creator
git -C "$HOME/dotfiles" diff -- config/apm/apm.yml config/apm/apm.lock.yaml
```

The manifest's `ref: main` is the update source; the lockfile pins the installed
commit. A frozen install restores that commit without advancing to `main`.
The lockfile also stores per-file hashes and ownership records, so updates can
change multiple metadata lines even though the skill content stays untracked.

This documents the weekly procedure; no recurring job is created by setup.

## Remove a managed skill

Use APM so it updates both metadata and deployed files:

```sh
./scripts/apm-global uninstall anthropics/skills/skills/skill-creator
```

Review the manifest and lockfile diff before committing. Other installers' skills
must be migrated or removed separately; they are not APM-owned files.

## Restore a previous version

Restore the matching manifest and lockfile from the desired Git revision, then:

```sh
./scripts/apm-global install --frozen
```

For dependencies that were added after that revision, uninstall them with APM
before restoring the older files so their deployment ownership is still known.
Do not edit installed skill files in place; update the dependency or use a fork.

## Direct APM commands

Read-only commands such as `apm deps list --global` remain available. If you
change metadata with a direct APM command, the wrapper detects the change and
refuses to overwrite it. To adopt the live metadata after reviewing it:

```sh
./scripts/apm-global import
git diff -- config/apm/apm.yml config/apm/apm.lock.yaml
```

Use the wrapper consistently and avoid simultaneous direct APM mutations. Its
synchronization lock coordinates wrapper invocations, not other APM processes.
If an APM command fails, the wrapper leaves dotfiles metadata unchanged; inspect
the runtime state before importing or retrying.
