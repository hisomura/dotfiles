# dotfiles

Personal dotfiles repository for managing development environment. Configuration files are centrally managed via symlinks.

## Directory Structure

| Directory | Description |
| --- | --- |
| `home/` | Shell and editor config files (symlinked to `~/.<file>`) |
| `config/` | Application settings (symlinked under `~/.config/`) |
| `claude/` | Claude Code settings and commands |
| `docs/` | Documentation |
| `tmp/` | Temporary files |

## Setup

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install packages
brew bundle

# Create symlinks
./setup.sh
```

## Documentation

- [Homebrew Packages](docs/homebrew.md)
- [Keymaps](docs/keymaps.md)
