YSH=$(dirname "$0")

alias ysh-reload="source $YSH/ysh.sh"
alias ysh-colors=$YSH/colors.sh

# color ls
if [[ -x "`whence -p dircolors`" ]]; then
  eval `dircolors`
  alias ls='ls -F --color=auto'
else
  alias ls='ls -F'
fi

# ignore-case completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
autoload -U compinit
compinit
setopt completeinword
# better killall completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# aliases
alias mvncp="mvn-color clean package"
alias mvnci="mvn-color clean install"
alias mvncsi="mvn-color clean source:jar install"
alias l="ls -hl"

source $YSH/keys.sh
source $YSH/sudo.sh
source $YSH/mvn.sh
source $YSH/history.sh
source $YSH/style.sh