## Just a automated setter for config files and install some basic packages.

includes packages from AUR - **vscode, figlet, lolcat, neovim, lsd, brave, dmenu, i3-wm, ly, lf, feh, gnome-terminal, JetBrains Font, fastfetch, xorg packages, brightnessctl** and some themes.

# Install instructions

Cloning the git repo

`$ git clone https://github.com/duck-genus/dotfiles`

Getting into dotfile directory

`$ cd dotfiles`

Make *sync_dotfiles.sh* executable

`$ chmod +x ./sync_dotfiles.sh`

Run *sync_dotfiles.sh*

`$ ./sync_dotfiles.sh`

Or you can use one-liner, but actually you have to configure the lxappearance

`$ git clone https://github.com/duck-genus/dotfiles && cd dotfiles && chmod +x ./sync_dotfiles.sh && ./sync_dotfiles.sh && lxappearance`

and it's recommended to reboot (hope your arch install doesn't break)
