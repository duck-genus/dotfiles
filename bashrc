#
# ~/.bashrc 
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='lsd --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias fastfetch='fastfetch -c neofetch'

PS1='[\u@\h \W]\$ '


