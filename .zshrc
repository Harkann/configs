# prompt theme configuration

#~# autoload -Uz promptinit
#~# promptinit

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
  '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
  hook_com[unstaged]+='%F{1}??%f'
fi
}
precmd () { vcs_info }


autoload -Uz colors && colors
PROMPT="%{$fg_bold[white]%}%W-%T%{$reset_color%}
%{$fg_bold[white]%}%n%{$reset_color%}@%{$fg_bold[red]%}%M %{$reset_color%}%# "
RPROMPT="[%{$fg_no_bold[green]%}%?%{$reset_color%}] %F{5} %F{3}%3~ ${vcs_info_msg_0_} %f%# "




# command completion
autoload -Uz compinit
compinit
# permet d'uttiliser les fleches
zstyle ':completion:*' menu select
# prend en compte les alias
setopt COMPLETE_ALIASES

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#cree un cache pour la completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

#correction des commandes
setopt correctall

# keybindings -e : emacs -v : vi
bindkey -e

# history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# historique
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
export HISTFILE SAVEHIST

# utilistation des fleches
[[ -n "${key[Up]}"   ]] && bindkey "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search

#aliases
alias ls='ls --color=auto'
alias ll='ls -Al'
export GREP_COLOR=31
alias grep='grep --color=auto'
alias emilie='echo "Oh, une petite patate"'
alias alice='echo "Moink !"'
alias herisson='echo "I am fluffy and I know it !"'
alias rémi='echo "Coin! Coin!"'
alias texCours='pdflatex --shell-escape Cours.tex'
