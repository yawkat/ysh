# echo a fortune, if not installed swallow error
if fortune 2> /dev/null; then
    # empty line after fortune
    echo ""
fi

## print command
_pr() {
    echo -n $1
}

_build_prompt() {
    RET=$?

    _pr '%F{green}%K{black}'
    _pr '%B%n@%m%b%K{black} %T ' # hostname

    if ! [ $RET = 0 ]; then
        _pr "%F{red}"
    fi
    printf "%3d" $RET
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

_prompt_and_resched() { sched +10 _prompt_and_resched; zle && zle reset-prompt }
_prompt_and_resched

setopt PROMPT_SUBST
PROMPT='$(_build_prompt)'
