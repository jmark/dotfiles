# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# =========================================================================== #
# SETTING OPTIONS
# set -o vi

# =========================================================================== #
# Exports

export EDITOR=vi

shopt -s histappend
export HISTFILESIZE=99999
export HISTSIZE=
export HISTTIMEFORMAT="%F %T "
export HISTFILE="$HOME/.bash_history"
export HISTCONTROL="ignoreboth:erasedups"

SYSTEM_PATH="$PATH"
PATH=""

PATH+=":$HOME/bin"
PATH+=":/opt/wolfram/mathematica10.4.1/bin"

export PATH="$PATH:$SYSTEM_PATH"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_VAR_HOME="$HOME/.var"

# export XDG_RUNTIME_DIR= ... set by systemd

export LESS="-R -z5 -FX"
export LESSHISTFILE="$XDG_VAR_HOME/lesshst"

export RLWRAP_HOME="$HOME/.var/rlwrap"
export RLWRAP_EDITOR="$EDITOR '+call cursor(%L,%C)'"
# ?? export RLWRAP_FILTERDIR=""

mkdir -p "$RLWRAP_HOME"

export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export R_HISTFILE="$XDG_VAR_HOME/r/histfile"
#export R_HISTSIZE=
mkdir -p "$XDG_VAR_HOME/r"
export R_PDFVIEWER="evince"

export TMUX_TMPDIR="/run/user/$UID"

export VIFM="$HOME/.config/vifm/vifmrc"
export MYVIFM="$HOME/.config/vifm/vifmrc"

#export TERM=xterm-256color
export DVTM_TERM=xterm

# =========================================================================== #
# Bash Prompt

# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

PROMPT_COMMAND='history -a;'

# Note that the following escape sequences are enclosed in '\[' and '\]'. This
# makes sure, 'bash' is computing the lenght of PS1 correctly.
Default='\[\e[0m\]'
  Black='\[\e[0;30m\]'
    Red='\[\e[0;31m\]'
  Green='\[\e[0;32m\]'
 Yellow='\[\e[0;33m\]'
   Blue='\[\e[0;34m\]'
 Purple='\[\e[0;35m\]'
   Cyan='\[\e[0;36m\]'
  White='\[\e[0;37m\]'

 BoldBlack='\[\e[1;30m\]'
   BoldRed='\[\e[1;31m\]'
 BoldGreen='\[\e[1;32m\]'
BoldYellow='\[\e[1;33m\]'
  BoldBlue='\[\e[1;34m\]'
BoldPurple='\[\e[1;35m\]'
  BoldCyan='\[\e[1;36m\]'
 BoldWhite='\[\e[1;37m\]'

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    source /usr/share/bash-completion/bash_completion

# make bash autocomplete with up page arrow
bind '"\e[5~":history-search-backward' # PgUP
bind '"\e[6~":history-search-forward'  # PgDw

# make tab cycle through commands instead of listing via
# shift tab
bind '"\e[Z":menu-complete'

export PS1="${Default}${BoldCyan}\t ${BoldRed}\u${BoldYellow}@${BoldGreen}\h ${BoldPurple}\w\n${BoldYellow}->${Default} "
#export PS1="${BoldWhite}\t \u@\h \w \$${Default} "

# =========================================================================== #
# Functions

function ev {
    $(evince "$*" &> /dev/null &)
}

# =========================================================================== #
# SSH Agent

export SSH_AUTH_SOCK=/run/user/$UID/ssh-agent.socket

if ! pgrep -u $USER ssh-agent > /dev/null; then
    ssh-agent -a $SSH_AUTH_SOCK > /run/user/$UID/ssh-agent-cmds
    ssh-add $(find ~/.ssh/mycerts/ -type f ! -iname '*.pub')
fi

# =========================================================================== #
# Misc.

tput smkx

# =========================================================================== #
# Aliase

USR_ID=$UID
GRP_ID=$(id -g $UID)

UUID='f5dbb913-0ef5-43eb-9062-8a382f1965bd'
alias mount-icybox="sudo cryptsetup luksOpen /dev/disk/by-uuid/$UUID icybox && sudo mount /dev/mapper/icybox /mnt/icybox/"
alias umount-icybox='sudo umount /mnt/icybox/ && sudo cryptsetup luksClose icybox'

UUID='8e87c161-7466-46d8-b9f7-e0bc395a57cb'
alias mount-trekstor="sudo cryptsetup luksOpen /dev/disk/by-uuid/$UUID trekstor && sudo mount /dev/mapper/trekstor /mnt/trekstor/"
alias umount-trekstor='sudo umount /mnt/trekstor/ && sudo cryptsetup luksClose trekstor'

UUID='806B-13F6'
alias mount-galaxy="sudo mount /dev/disk/by-uuid/$UUID /mnt/galaxy/ -o uid=$USR_ID -o gid=$GRP_ID -o flush"
alias umount-galaxy='sudo umount /mnt/galaxy/'

UUID='66C1-0B4F'
alias mount-toshiba="sudo mount /dev/disk/by-uuid/$UUID /mnt/toshiba/ -o uid=$USR_ID -o gid=$GRP_ID -o flush"
alias umount-toshiba='sudo umount /mnt/toshiba/'

alias psync="$HOME/scripts/psync.sh"

alias lsc='ls -vF --color=auto --group-directories-first'
alias Ls='ls -vhlF --color=auto --group-directories-first --time-style=long-iso'

alias clip="xclip -o -selection clipboard"
alias cclip="xclip -o -selection primary"

alias today="date +%Y-%m-%d"
alias now="date +%Y-%m-%d-%H-%M-%S"

alias sniff='tshark -Qn -f tcp -Y http.request.method==GET -T fields -e http.request.full_uri -i'

alias ack='ack --pager=less'

alias python='python -q'

alias vim='vim -p'

alias deepblueradioshow='cat ~/dump/solaris/deepblueradioshow.txt | ~/projects/Werkzeugkasten/scripts/punchline.pl -qsS ~/dump/solaris/listenedto.txt -- tmux new-window mpv --no-video --save-position-on-quit @'

alias purgedir='rm -v ./*'

alias pyturb='~/projects/stirturb/turbubox/tools/run.sh ~/projects/stirturb/turbubox/tools/lib/'

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
