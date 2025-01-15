#!/bin/bash

# Exit on error
set -e

# Flags to control installations
install_ohmyzsh=false
install_vim=false
install_tmux=false
install_htop=false
install_build_essential=false
install_git=false
install_curl=false

install_ag=false
install_exa=false
install_gdb=false
install_clang=false
install_valgrind=false
install_docker=false
install_ncdu=false
install_shellcheck=false
install_ripgrep=false
install_qemu=false

# Function to display help information
show_help() {
  echo "Usage: setup.sh [options]"
  echo ""
  echo "Options:"
  echo "  -o    Install Oh My Zsh (a popular Zsh configuration framework)"
  echo "  -v    Install Vim with a basic configuration and useful plugins"
  echo "  -t    Install tmux (terminal multiplexer for session management)"
  echo "  -b    Install build-essential (gcc, g++, make, and other essential build tools)"
  echo "  -g    Install Git (version control system) and a default config file"
  echo "  -s    Install The Silver Searcher (ag) (fast code search tool)"
  echo "  -x    Install exa (modern replacement for ls with enhanced features)"
  echo "  -G    Install GDB (GNU Debugger for debugging C/C++ programs)"
  echo "  -C    Install Clang (alternative C/C++ compiler with better diagnostics)"
  echo "  -V    Install Valgrind (memory debugging and profiling tool)"
  echo "  -D    Install Docker (container platform for isolated environments)"
  echo "  -n    Install ncdu (disk usage analyzer with a nice CLI interface)"
  echo "  -S    Install ShellCheck (linter for shell scripts)"
  echo "  -r    Install ripgrep (rg) (fast file search tool)"
  echo "  -q    Install QEMU (system virtualization)"
  echo "  -h, --help  Display this help message"
  echo ""
  echo "Example: setup.sh -o -v -t -g"
  echo "This will install Oh My Zsh, Vim, tmux, and Git."
}

# Parse options
while getopts "ovtbhbgcsxGCVDnSrq-:" opt; do
  case ${opt} in
    o ) install_ohmyzsh=true ;;
    v ) install_vim=true ;;
    t ) install_tmux=true ;;
    h ) 
      show_help
      exit 0
      ;;
    b ) install_build_essential=true ;;
    g ) install_git=true ;;
    c ) install_curl=true ;;
    s ) install_ag=true ;;
    x ) install_exa=true ;;
    G ) install_gdb=true ;;
    C ) install_clang=true ;;
    V ) install_valgrind=true ;;
    D ) install_docker=true ;;
    n ) install_ncdu=true ;;
    S ) install_shellcheck=true ;;
    r ) install_ripgrep=true ;;
    q ) install_qemu=true ;;
    - ) 
      if [[ "$OPTARG" == "help" ]]; then
        show_help
        exit 0
      else
        echo "Invalid option: --$OPTARG"
        exit 1
      fi
      ;;
    \? ) show_help
         exit 1 ;;
  esac
done

# Function to check if the user's password is set
check_password() {
    # Get the status of the current user's password
    USER_STATUS=$(passwd --status "$(whoami)" | awk '{print $2}')

    # Check for password status and handle accordingly
    if [[ "$USER_STATUS" == "NP" ]]; then
        echo "No password is set for the user $(whoami)."
        echo "Please set a password to continue."
        sudo passwd "$(whoami)"
    elif [[ "$USER_STATUS" == "L" ]]; then
        echo "The password for the user $(whoami) is locked."
        echo "Unlocking the password. You will need to set a new password."
        sudo passwd -u "$(whoami)"  # Unlock the password
        sudo passwd "$(whoami)"    # Prompt to set a new password
    fi

    # Recheck the password status after any changes
    USER_STATUS=$(passwd --status "$(whoami)" | awk '{print $2}')
    if [[ "$USER_STATUS" != "P" ]]; then
        echo "Failed to set or unlock the password. Exiting."
        exit 1
    fi

    echo "Password is properly set and active for the user $(whoami)."
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  check_password  # Check password before proceeding

  if ! command -v zsh &> /dev/null; then
    echo "Zsh not found, installing Zsh..."
    sudo apt update
    sudo apt install -y zsh
  fi
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# Function to install Zsh plugins
install_zsh_plugins() {
  echo "Installing Zsh plugins..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
}

# Function to configure .zshrc for plugins
configure_zshrc() {
  echo "Configuring .zshrc..."
  sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
  sed -i 's/robbyrussell/bira/g' ~/.zshrc
}

# Function to change the default shell to Zsh
change_default_shell_to_zsh() {
  echo "Changing default shell to Zsh..."
  sudo chsh -s "$(which zsh)" "$(whoami)"

  # Verify the shell change
  CURRENT_SHELL=$(getent passwd "$(whoami)" | cut -d: -f7)
  if [[ "$CURRENT_SHELL" != "$(which zsh)" ]]; then
    echo "Failed to set Zsh as the default shell. Exiting."
    exit 1
  fi
  echo "Zsh is now the default shell. Restart your terminal or run 'zsh' to start using it."
}

# Function to install Vim
install_vim() {
  echo "Installing Vim..."
  sudo apt install -y vim python3-dev cmake
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Backup existing .vimrc if it exists
  if [ -f "${HOME}/.vimrc" ]; then
    echo "Backing up existing .vimrc to .vimrc.bak"
    mv "${HOME}/.vimrc" "${HOME}/.vimrc.bak"
  fi
  #cp .vimrc ~/.vimrc
  wget -qO "${HOME}/.vimrc" https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/.vimrc

  vim +PlugInstall +qall
}

setup_gitconfig() {
  echo "Setting up .gitconfig..."

  # Define the GitHub URL for the .gitconfig.template file
  TEMPLATE_URL="https://raw.githubusercontent.com/sysec-uic/.setup.sh/refs/heads/main/.gitconfig.template"

  # Check if .gitconfig.template exists locally
  if [ -f .gitconfig.template ]; then
    echo "Using local .gitconfig.template file."
    TEMPLATE_SOURCE=".gitconfig.template"
  else
    echo "Downloading .gitconfig.template from GitHub..."
    TEMPLATE_SOURCE=$(curl -fsSL "$TEMPLATE_URL")
    if [[ $? -ne 0 || -z "$TEMPLATE_SOURCE" ]]; then
      echo "Failed to download .gitconfig.template. Exiting."
      exit 1
    fi
  fi

  # Default values for Git name and email
  default_name="Xiaoguang Wang"
  default_email="xjtuwxg@gmail.com"

  # Prompt user for input with defaults
  read -rp "Enter your Git user name [${default_name}]: " user_name
  user_name=${user_name:-$default_name}

  read -rp "Enter your Git user email [${default_email}]: " user_email
  user_email=${user_email:-$default_email}

  # Escape special characters in user_name and user_email for sed
  escaped_user_name=$(printf '%s\n' "$user_name" | sed 's/[&/\]/\\&/g')
  escaped_user_email=$(printf '%s\n' "$user_email" | sed 's/[&/\]/\\&/g')

  # Process the template and save to ~/.gitconfig
  if [ "$TEMPLATE_SOURCE" = ".gitconfig.template" ]; then
    # Use local file
    sed "s/{{default_name}}/${escaped_user_name}/; s/{{default_email}}/${escaped_user_email}/" "$TEMPLATE_SOURCE" > ~/.gitconfig
  else
    # Use downloaded content
    echo "$TEMPLATE_SOURCE" | \
    sed "s/{{default_name}}/${escaped_user_name}/; s/{{default_email}}/${escaped_user_email}/" > ~/.gitconfig
  fi

  # Check for errors
  if [[ $? -ne 0 ]]; then
    echo "Failed to set up .gitconfig. Exiting."
    exit 1
  fi

  echo "Git configuration set up with:"
  echo "  Name: ${user_name}"
  echo "  Email: ${user_email}"
}

# Function to install Docker
install_docker() {
  echo "Installing Docker..."
  check_password  # Check password before proceeding

  # Update package index and install prerequisites
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

  # Add Docker’s official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # Set up the stable repository
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Update the package index again and install Docker
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io

  # Add the current user to the Docker group to avoid using `sudo` with Docker commands
  sudo usermod -aG docker "$USER"

  echo "Docker installation complete! Please log out and log back in for group changes to take effect."
}

# Function to install QEMU
install_qemu() {
  echo "Installing QEMU and related packages..."

  # Update package list
  sudo apt update
  
  # Install QEMU and virtualization tools
  sudo apt install -y qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

  # Enable and start the libvirtd service for managing virtual machines
  sudo systemctl enable libvirtd
  sudo systemctl start libvirtd

  # Add the current user to the libvirt and kvm groups
  sudo usermod -aG libvirt "$USER"
  sudo usermod -aG kvm "$USER"

  echo "QEMU installation complete! Please log out and log back in for group changes to take effect."
}

# Function to install additional tools
install_tool() {
  local tool_name=$1
  echo "Installing ${tool_name}..."
  sudo apt install -y "${tool_name}"
}

# Execute selected installations
echo "Starting selected installations..."

if $install_ohmyzsh; then
  install_oh_my_zsh
  install_zsh_plugins
  configure_zshrc
  change_default_shell_to_zsh
fi
$install_vim && install_vim
$install_docker && install_docker
$install_qemu && install_qemu

$install_tmux && install_tool "tmux"
$install_htop && install_tool "htop"
$install_build_essential && install_tool "build-essential"
$install_git && install_tool "git" && setup_gitconfig
$install_curl && install_tool "curl"
$install_gdb && install_tool "gdb"
$install_clang && install_tool "clang"
$install_ncdu && install_tool "ncdu"
$install_shellcheck && install_tool "shellcheck"
$install_ag && install_tool "silversearcher-ag"
$install_exa && install_tool "exa"
$install_valgrind && install_tool "valgrind"
$install_ripgrep && install_tool "ripgrep"

echo "Selected installations are complete!"
