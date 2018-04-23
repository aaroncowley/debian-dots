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

export PS1="${RED}\u${GREEN}\$(parse_git_branch) ${BLUE}\W ${CYAN}>>> ${RESET}"


[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias r='ranger'

