# echo a fortune, if not installed swallow error
if fortune 2> /dev/null; then
    # empty line after fortune
    echo ""
fi

LAST_RETURN_VALUE=0

# these two values are used to make the first prompt line only show up just after a command
IN_COMMAND=true
AFTER_COMMAND=

# terminal title

_set_title() {
    title="$1"
    title+=" @ $HOST"
    echo -en "\e]0;$title\a"
}

precmd() {
    LAST_RETURN_VALUE=$?
    AFTER_COMMAND=$IN_COMMAND
    IN_COMMAND=false
    chpwd
}

preexec() {
    _set_title "$1"
    IN_COMMAND=true
}

chpwd() {
    title=''
    if ! [ $LAST_RETURN_VALUE = 0 ]; then
        title+="[$LAST_RETURN_VALUE] "
    fi
    title+=$(print -Pn '%~')
    _set_title "$title"
}

## print command
_pr() {
    echo -n $1
}

_build_after_command_prompt() {
    _pr '%K{black}'

    _pr '%F{cyan}%~' # cwd

    _pr '%F{green}%B « %n@%m%b%K{black} ' # hostname

    if ! [ $LAST_RETURN_VALUE = 0 ]; then
        _pr "%F{red}"
    fi
    printf "%3d" $LAST_RETURN_VALUE
    _pr '%f%K{black} %F{green}%B%b%K{black} %T'

    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null || true)
    if test "$branch"; then
        _pr "%F{green}%B « %b%K{black}%F{cyan}$branch"
    fi

    _pr '%E%k' # move to EOL

    echo ""
}

_build_prompt() {
    if $AFTER_COMMAND; then
        _build_after_command_prompt
    fi

    _pr "%K{black}"

    if [ -z "$HISTFILE" ]; then
        _pr '%F{cyan}p'
    fi

    if sudo -n true 2>/dev/null > /dev/null; then
        _pr '%F{yellow}#'
    fi

    _pr '%k%F{green}%# %f'
}

setopt PROMPT_SUBST
PROMPT='$(_build_prompt)'

TMOUT=10

TRAPALRM() {
    zle reset-prompt
}
