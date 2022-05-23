#!/usr/bin/env -S bash
[ -p /dev/stdin ] &&set -- $@ $(cat -)

_ver() {
    echo "Version:β0.1"
}

_usage() {
    cat << EOF
$(figlet $0)
    $(_ver)

    -v --version Show version
    -h --help Get help
EOF
}

declare -i argc=0
declare -a argv=()

while   (( $# > 0 )); do
    case $1 in
        -[A-Za-z0-9]*)
            echo a
            if [[ "$1" =~ "v" ]];then
                _ver
            fi
            if [[ "$1" =~ "h" || "$1" =~ "*" ]];then
                _usage
            fi
            shift
            ;;
        --[A-Za-z0-9]*)
            if [[ "$1" = "--version" ]];then
                _ver
            fi
            if [[ "$1" = "--help" ]];then
                _usage
            fi
            if [[ "$1" = "--*" ]];then
                _usage
            fi
            shift
            ;;
        *)
            _usage
            ((++argc))
            argv=("${argv[@]}" "$1")
            shift
            ;;
    esac
done
