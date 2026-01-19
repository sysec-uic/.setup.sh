# .setup.sh
A script to set up essential tools like `vim`, `oh-my-zsh`, `git`, and more on **Ubuntu/Debian** and **Arch Linux**.

**Option 1:** Clone and Run Locally (**recommended**)

Execute the `setup.sh` script locally:
```
git clone https://github.com/sysec-uic/.setup.sh.git
cd .setup.sh
./setup.sh -h       # Show help
./setup.sh -oH      # Install oh-my-zsh and htop (see Flags below)
```

**Option 2:** Run Directly via curl (some tools like `git` and `vim` may not work properly)

You can execute the script directly from GitHub without cloning the repository. Replace the last flag (`-h`) with the desired option. For non-interactive shells, add `-y`:
```
curl -fsSL https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/setup.sh | bash -s -- -h
curl -fsSL https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/setup.sh | bash -s -- -y -r
```

## Flags
```
- `-h`, `--help`: Show help.
- `--dry-run`: Print planned actions without making changes.
- `-y`, `--yes`: Skip confirmation prompts (defaults to Yes when prompted).
- `-o`: Install `oh-my-zsh`.
- `-v`: Install `vim`.
- `-t`: Install `tmux`.
- `-b`: Install `build-essential`.
- `-g`: Install `git` and a default `.gitconfig`.
- `-H`: Install `htop`.
- `-s`: Install `silversearcher-ag`.
- `-x`: Install `exa`.
- `-G`: Install `gdb`.
- `-C`: Install `clang`.
- `-V`: Install `valgrind`.
- `-D`: Install Docker.
- `-n`: Install `ncdu`.
- `-S`: Install `shellcheck`.
- `-r`: Install `ripgrep`.
- `-q`: Install QEMU.
```

## Arch Linux Notes
- Some packages use Arch names: `build-essential` maps to `base-devel`, `silversearcher-ag` to `the_silver_searcher`, and `exa` to `eza`.
- Docker is installed from the Arch repos and the service is enabled automatically.

## Prerequisites
- The script will install `which`, `git`, `wget`, and `curl` automatically if they are missing.
- When running non-interactively (e.g., via `curl | bash`), Git config uses the default name/email.
