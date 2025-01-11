# .setup.sh
A script (ChatGPT-generated) to set up `vim`, `oh-my-zsh`, `git`, etc. on Ubuntu machines.

**Option 1:**
Execute the `setup.sh` script locally:
```
git clone https://github.com/sysec-uic/.setup.sh.git
cd .setup.sh
./setup.sh -h       # Show help
./setup.sh -o       # Install oh-my-zsh
```

**Option 2:**
Directly execute this `setup.sh` script from GitHub using `curl`. The last flag `-h` indicate `help`, you can replace it with other flags, such as `-o` (install `oh-my-zsh`) or `-v` (install `vim`).
```
curl -fsSL https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/setup.sh | bash -s -- -h
```
