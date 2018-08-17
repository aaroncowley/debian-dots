bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 2)\]"
YELLOW="\[$(tput setaf 3)\]"
BLUE="\[$(tput setaf 4)\]"
MAGENTA="\[$(tput setaf 5)\]"
CYAN="\[$(tput setaf 6)\]"
WHITE="\[$(tput setaf 7)\]"
RESET="\[$(tput sgr0)\]"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="${RED}\u@\h${GREEN}\$(parse_git_branch) ${BLUE}\W ${RED}$ ${RESET}"


[[ $- != *i* ]] && return

export EDITOR=vim
export PAGER=more

alias ls='ls --color=auto'
alias r='ranger'
alias n='ncmpcpp'
alias i3conf='vim ~/.i3/config'
alias i3blocksrc='vim ~/.i3/i3blocks.conf'
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias fetch='neofetch'
alias irc='irssi'
alias netmon='sudo watch -n .1 "sudo netstat -tulpna"'
alias top='htop'
alias ipmon='watch -n .1 "ip a"'
alias mnt='udiskie-mount'
alias umnt='udiskie-umount'

alias v='vim'
alias vi='vim'
alias svi='sudo vim'
alias vit='vim -p'

alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias restart='sudo systemctl restart'
alias suspend='systemctl suspend'
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias sources='sudo vim /etc/apt/sources.list'
