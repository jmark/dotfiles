# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jmark/.zshrc'
autoload -Uz compinit && compinit
# End of lines added by compinstall
zstyle ':completion:*' menu select

PS1=$'%B%F{cyan}%*%F{red}%n%F{yellow}@%F{green}%m %F{magenta}%d%E\n%F{yellow}->%b%F{default} '

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
