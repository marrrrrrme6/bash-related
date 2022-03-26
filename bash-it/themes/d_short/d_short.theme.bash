FILTER() {
    sed -z 's/\n\(.*\)//' \
    |sed \
    -e 's/\\\$/$/g' \
    -e 's/\\\n/\n/g' \
    -e 's/\\A/%H:%M/g' \
    -e 's/[\\\]\\\[]//g' \
    -e 's/$(d_short)/.../g' \
    -e "s/\\\u/$(whoami)/g" \
    -e "s/\\\h/$(hostname)/g" \
    |sed 's/\\D{\(.*\)}/\1/g'| xargs -i date +"{}" \
    |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g" 
}
d_short_prompt() {
    PS1='[\e[01;32m\u@\h\e[00m \D{%FT %T} :\e[01;34m$(d_short)\e[00m]\n\$ '
    d_short() {
        DIR=$(pwd | sed "s|$HOME|~|g")
        PROMPT_WIDTH=$(echo -e "$PS1" |FILTER |xargs)
        WIDTH=$(($(tput cols)-${#PROMPT_WIDTH}))
        if  [ ${#DIR} -gt ${WIDTH} ] ;then
            echo "...${DIR: -$WIDTH}"
        else
            echo $DIR
        fi
    }
PS1=$PS1
}

safe_append_prompt_command d_short_prompt
