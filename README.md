# .setup.sh
A ChatGPT-generated script to set up essential tools like `vim`, `oh-my-zsh`, `git`, and more on Ubuntu machines.

Before running the script, ensure your package list is up-to-date by executing:
```
sudo apt-get update -y
sudo apt install -y git curl
```

**Option 1:** Clone and Run Locally (recommended)

Execute the `setup.sh` script locally:
```
git clone https://github.com/sysec-uic/.setup.sh.git
cd .setup.sh
./setup.sh -h       # Show help
./setup.sh -o       # Install oh-my-zsh
```

**Option 2:** Run Directly via curl

You can execute the script directly from GitHub without cloning the repository. Replace the last flag (`-h`) with the desired option:
```
curl -fsSL https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/setup.sh | bash -s -- -h
```
Flags:
-	`-h`: Show help.
-	`-o`: Install `oh-my-zsh`.
-	`-v`: Install `vim`.
