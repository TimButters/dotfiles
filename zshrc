# Environment Variables and Settings
DE=openbox
export EDITOR=/usr/bin/vim
eval "$(dircolors -b)" && export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
bindkey -e
unset MULTIBYTE

# ZSH Modules
autoload -Uz compinit promptinit zkbd vcs_info
compinit
promptinit

# Set correct mappings for Home, End, Delete, etc...
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# Collect Git Info and Set Format String
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
precmd() { vcs_info }

zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "
zstyle ':vcs_info:git*' formats "%b %B%m%u%c "

# Prompt Settings
autoload -U colors && colors
setopt prompt_subst

PROMPT='%{$fg_bold[black]%}%n@%m%{$reset_color%} %{$fg_bold[yellow]%}%2~%{$fg_no_bold[red]%} ${vcs_info_msg_0_}%{$fg[black]%}%B%#%b %{$reset_color%}'
RPROMPT='%{$fg_no_bold[yellow]%}%D{%H:%M:%S %d-%m-%Y}%{$reset_color%}'

# My Aliases
alias ls='ls --color=auto'
alias l='ls -lFh'
alias ll='ls -lht'
alias la='ls -a'
alias ..='cd ../'
alias ...='cd ../../'

