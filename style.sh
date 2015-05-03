# echo a fortune, if not installed swallow error
if fortune 2> /dev/null; then
    # empty line after fortune
    echo ""
fi

LAST_RETURN_VALUE=0

# terminal title

_set_title() {
    print -Pn "\e]0;$1\a"
}

precmd() {
    LAST_RETURN_VALUE=$?
    chpwd
}

preexec() {
    _set_title "$1"
}

chpwd() {
    title=''
    if ! [ $LAST_RETURN_VALUE = 0 ]; then
        title+="[$LAST_RETURN_VALUE] "
    fi
    title+='%~'
    _set_title $title
}

## print command
_pr() {
    echo -n $1
}

_build_prompt() {
    _pr '%F{green}%K{black}'
    _pr '%B%n@%m%b%K{black} ' # hostname

    if ! [ $LAST_RETURN_VALUE = 0 ]; then
        _pr "%F{red}"
    fi
    printf "%3d" $LAST_RETURN_VALUE
    _pr '%f%K{black} %F{green}%B»%b%K{black} '

    _pr '%~' # cwd

    _pr '%E%k' # move to EOL

    echo ""

    _pr "%K{black}"

    if [ -z "$HISTFILE" ]; then
        _pr '%F{cyan}p'
    fi

    if sudo -n echo 2>/dev/null > /dev/null; then
        _pr '%F{yellow}s'
    fi

    _pr '%k%F{green}%# %f'
}

setopt PROMPT_SUBST
PROMPT='$(_build_prompt)'
