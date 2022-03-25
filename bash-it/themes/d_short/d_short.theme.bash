PS1='[\e[01;32m\u@\h\e[00m \D{%FT %T} :\e[01;34m$(d_short)\e[00m]\n$ '
d_short() {
    DIR=$(pwd | sed "s|$HOME|~|g")
    PROMPT_WIDTH=$(echo -e "$PS1" |sed -e "s/\\\u/$(whoami)/g" -e "s/\\\h/$(hostname)/g" -e 's/$(d_short)/.../g' |sed 's/\\\D{\(.*\)}/\1/g' |xargs -i -0 date +"{}" |sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?m//g" |xargs)
    WIDTH=$(($(tput cols)-${#PROMPT_WIDTH}+2))
    if  [ ${#DIR} -gt ${WIDTH} ] ;then
        echo "...${DIR: -$WIDTH}"
    else
        echo $DIR
    fi
    PS1="$PS1"
}
