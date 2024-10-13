#!/bin/bash

sudo echo -e "Wait a sec...\n"

# Function to install packages using pacman
install_packages() {
    for pkg in "$@"; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            echo "Installing $pkg..."
            sudo pacman -S --noconfirm "$pkg"
        else
            echo "$pkg is already installed."
        fi
    done
}

# Install figlet and lolcat if not installed
install_packages figlet lolcat

# Display ASCII art with figlet and lolcat
figlet "Let's GO!" | lolcat
sleep 3

# Check if yay is already installed
if ! command -v yay &> /dev/null; then
    # yay is not installed, proceed with installation

    # Clone yay repository from GitHub
    git clone https://aur.archlinux.org/yay.git /tmp/yay

    # Navigate to the yay directory
    cd /tmp/yay

    # Build and install yay using makepkg
    makepkg -si --noconfirm

    # Clean up by removing the temporary yay directory
    rm -rf /tmp/yay

    echo "yay has been installed."
else
    # yay is already installed
    echo "yay is already installed. Skipping installation."
fi

# Function to install package if not already installed
install_package() {
    local package_name="$1"
    if ! yay -Qi "$package_name" &> /dev/null; then
        yay -S --noconfirm "$package_name"
    else
        echo "$package_name is already installed. Skipping."
    fi
}

# Xorg and related packages for i3wm and other applications
x_packages=(
    "xorg-server"           # Xorg server
    "xorg-xinit"            # Xorg initialization
    "xorg-apps"             # Xorg applications (like xclock, xcalc, etc.)
    "xorg-xinput"           # Xorg input drivers
    "xorg-xrandr"           # Xorg screen size and orientation utilities
    "xorg-xset"             # Xorg preferences
    "xorg-xrdb"             # Xorg resource database utility
    "xorg-xhost"            # Xorg access control program
    "xorg-xev"              # Xorg event monitoring
    "xorg-xkill"            # Xorg process killer
    "xorg-xwininfo"         # Xorg window information utility
    "xorg-xauth"            # X11 authentication
)

# Loop through Xorg packages and install them
for x_package in "${x_packages[@]}"; do
    install_package "$x_package"
done

# Install lsd
install_package "lsd"

# Install neovim
install_package "neovim"

# Install Visual Studio Code
install_package "visual-studio-code-bin"

# Install Firefox
install_package "firefox"

# Install dmenu
install_package "dmenu"

# Install ly
install_package "ly"
sudo systemctl enable ly -f

# Install lf
install_package "lf"

# Install feh
install_package "feh"

# Install JetBrains Font
install_package "ttf-jetbrains-mono-nerd"

# Install GNOME Terminal
install_package "gnome-terminal"

# Install FastFetch
install_package "fastfetch"

# Installing Themes but configure using lxappearance
install_package "lxappearance"
install_package "materia-gtk-theme"
install_package "papirus-icon-theme"

# Installing brightnessctl
install_package "brightnessctl"

echo "Packages installation completed."

# Define source and destination paths
declare -A config_files=(
    ["vscode_settings.json"]="$HOME/.config/Code/User/settings.json"
    ["vscode_keybindings.json"]="$HOME/.config/Code/User/keybindings.json"
    ["i3_config"]="$HOME/.config/i3/config"
    ["ly_config"]="/etc/ly/config.ini"
    ["bashrc"]="$HOME/.bashrc"
    ["bgimage.jpg"]="$HOME/.bg.jpg"
)

# Function to move contents of a file
move_config_file() {
    local source_file="$1"
    local destination_file="$2"

    # Check if source file exists
    if [ ! -f "$source_file" ]; then
        echo "Error: $source_file does not exist."
        return 1
    fi

    # Ensure destination directory exists
    local destination_dir=$(dirname "$destination_file")
    mkdir -p "$destination_dir"

    # Move contents of source file to destination file
    cat "$source_file" > "$destination_file"
    echo "Contents of $source_file have been moved to $destination_file."
}

# Loop through config_files array and move each file
for source_file in "${!config_files[@]}"; do
    destination_file="${config_files[$source_file]}"
    move_config_file "$source_file" "$destination_file"
done

# Get the current directory
current_dir=$(dirname "$(readlink -f "$0")")

# Change directory to parent directory
cd ..

# Remove the directory
rm -rf "$current_dir"
