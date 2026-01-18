# Repository Guidelines

## Project Structure & Module Organization
- `setup.sh` is the single entrypoint. It contains all installation logic, flags, and helper functions.
- `README.md` documents usage and prerequisites.
- No additional source, test, or asset directories are present in this repo.

## Build, Test, and Development Commands
- `./setup.sh -h` shows supported flags and usage examples.
- `./setup.sh -o -v -t` installs Oh My Zsh, Vim, and tmux (examples of combinable options).
- Before running, update packages and install prerequisites as documented: `sudo apt-get update -y` and `sudo apt install -y git curl`.

## Coding Style & Naming Conventions
- Shell: Bash (`#!/bin/bash`) with `set -e` for early failure.
- Indentation: 2 spaces, consistent with the existing script.
- Functions use `snake_case` (e.g., `install_oh_my_zsh`, `setup_gitconfig`).
- Prefer explicit boolean flags and `if $flag; then` patterns for readability.
- Keep echo output user-facing and actionable.

## Testing Guidelines
- There is no automated test suite. Validate changes by running `./setup.sh -h` and exercising a small flag set on a safe environment (e.g., `-v` or `-g`).
- When adding new installers, ensure they fail fast and do not silently ignore errors.

## Commit & Pull Request Guidelines
- Recent commits use short, imperative subjects and occasional type prefixes (e.g., `chore: update setup.sh/gitconfig`).
- Follow a similar style: concise subject line, optional `type:` prefix, and a clear description of user impact in the PR.
- PRs should state which flags were tested and on which Ubuntu version.

## Security & Configuration Tips
- The script uses `sudo` and modifies user configuration (`~/.zshrc`, `~/.gitconfig`). Call this out in PRs.
- Avoid fetching remote scripts unless necessary; prefer local templates when available.
