# Environment Variables and Settings
DE=openbox
export EDITOR=/usr/bin/vim
eval "$(dircolors -b)" && export ZLS_COLORS=$LS_COLORS
xseticon -id "$WINDOWID" /usr/share/icons/AwOkenWhite/clear/128x128/apps/terminal2.png
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
bindkey -e
unset MULTIBYTE
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

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
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-st
precmd() { vcs_info }

#zstyle ':vcs_info:git*' actionformats "%s  %r/%S %b %m%u%c "
zstyle ':vcs_info:git*' formats "%b %m%u%c"

# Prompt Settings
autoload -U colors && colors
setopt prompt_subst

# Auto cd options
setopt autocd
cdpath=(~ ~/Documents/KTP/Sabisu/Algorithms/CPP)
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{green}%d%f


black="%{$fg_bold[black]%}"
yellow="%{$fg_bold[yellow]%}"
green="%{$fg_bold[green]%}"
red="%{$fg_bold[red]%}"
rednb="%{$fg_no_bold[red]%}"

PROMPT='${black}%n@%m ${yellow}%1~${rednb} ${vcs_info_msg_0_}${black}%# %{$reset_color%}'
#RPROMPT='%{$fg_no_bold[yellow]%}%D{%H:%M:%S %d-%m-%Y}%{$reset_color%}'

# Show remote ref name and number of commits ahead-of or behind
function +vi-git-st() {
		local ahead behind remote
		local -a gitstatus

		# Are we on a remote-tracking branch?
		remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
				--symbolic-full-name 2>/dev/null)/refs\/remotes\/}

		if [[ -n ${remote} ]] ; then
				# for git prior to 1.7
				# ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
				ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
				(( $ahead )) && gitstatus+=( "${green}+${ahead}${black}" )

				# for git prior to 1.7
				# behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
				behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
				(( $behind )) && gitstatus+=( "${red}-${behind}${black}" )

				if [[ $ahead -ne 0 ]] || [[ $behind -ne 0 ]]; then
						hook_com[branch]="${hook_com[branch]} ${black}[${remote} ${(j:/:)gitstatus}]${red}"
				else
						hook_com[branch]="${hook_com[branch]}${red}"
				fi
		fi
}

# My Aliases
alias ls='ls --color=auto'
alias l='ls -lFh'
alias ll='ls -lht'
alias la='ls -a'
alias ..='cd ../'
alias ...='cd ../../'

hash -d sabisu=~/Documents/KTP/Sabisu
hash -d alarms=~/Documents/KTP/Sabisu/Algorithms/AlarmManagement
hash -d prediction=~/Documents/KTP/Sabisu/Algorithms/PredictionSystem
hash -d d3=~/Documents/KTP/Sabisu/Algorithms/Javascript/d3
hash -d cpp=~/Documents/KTP/Sabisu/Algorithms/CPP

# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
