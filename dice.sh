





#!/usr/bin/bash



DICE_EXTRA() {
    echo "\$DICE_EXTRA: $DICE_EXTRA"

    case $DICE_EXTRA in
        \<=* )
            DICE_COMPARISON=011 ;;
        \<*  )
            DICE_COMPARISON=010 ;;
        \>=* )
            DICE_COMPARISON=021 ;;
        \>*  )
            DICE_COMPARISON=020 ;;
        \=*  )
            DICE_COMPARISON=030 ;;
        \+*  )
            DICE_COMPARISON=110 ;;
        \-*  )
            DICE_COMPARISON=120 ;;
        \**  )
            DICE_COMPARISON=130 ;;
        *    )
            DICE_COMPARISON=000 ;;
    esac
}


NdN () {
    for i in $(seq 1 $DICE_MANY) ;do
        DICE="$(($RANDOM % $DICE_NUMBER + 1))"
        echo -e "$1(${DICE_MANY}D${DICE_NUMBER}) > $DICE "
    done
}

NdN_ARI_OPE() {
    case $DICE_COMPARISON in
        110 )
            ARITHMETIC=\+ ;;
        120 )
            ARITHMETIC=\- ;;
        130 )
            ARITHMETIC=\* ;;
    esac
    DICE_NUMBER="${DICE_NUMBER%%[\+,\*,\-]*}"
    DICE_ADDITION=${DICE_EXTRA##*[\+,\*,\-]}
    echo "$DICE_NUMBER $ARITHMETIC $DICE_ADDITION"
    for i in $(seq 1 $DICE_MANY) ;do
        DICE="$(echo \"$(($(($RANDOM % $DICE_NUMBER + 1)) $ARITHMETIC $DICE_ADDITION)))\""
        echo -e "$1(${DICE_MANY}D${DICE_NUMBER}${ARITHMETIC}${DICE_ADDITION}) > $DICE"
    done
}

LIMIT_DICE() {
    case $DICE_COMPARISON in
        011 )
            DICE_SYMBOL=-le  ;;
        010 )
            DICE_SYMBOL=-lt  ;;
        021 )
            DICE_SYMBOL=-ge  ;;
        020 )
            DICE_SYMBOL=-gt  ;;
        030 )
            DICE_SYMBOL="==" ;;
    esac
    for i in $(seq 1 $DICE_MANY) ;do
        DICE="$(($RANDOM % $DICE_NUMBER + 1))"
        bash -c "
            $(echo "
                #echo $DICE $DICE_SYMBOL $DICE_LIMIT
                if [[ $DICE $DICE_SYMBOL $DICE_LIMIT ]] ;then
                    if [[ $DICE -le $CRITICAL_LIMIT && $CRIFUMB == "1" ]];then
                        echo -e \"\\e[32m$1(1D100${DICE_EXTRA%%[0-9]*}${DICE_LIMIT}) > $DICE \\e[1mCritical\"
                    else
                        echo -e \"\\e[32m$1(${DICE_MANY}D${DICE_NUMBER}${DICE_EXTRA%%[0-9]*}${DICE_LIMIT}) > $DICE Success       \"
                    fi
                else
                    if [[ $DICE -ge $FUMBLE_LIMIT && $CRIFUMB == "1" ]];then
                        echo -e \"\\e[31m$1(1D100${DICE_EXTRA%%[0-9]*}${DICE_LIMIT}) > $DICE \\e[1mFumble  \"
                    else
                        echo -e \"\\e[31m$1(${DICE_MANY}D${DICE_NUMBER}${DICE_EXTRA%%[0-9]*}${DICE_LIMIT}) > $DICE Failed        \"
                    fi
                fi
            ")
        "
    done
}


#================ main command ==================

NUMBER_JUDGE=[1-9][0-9]*[\+\*\-]*[1-9]*[0-9]*
CRITICAL_LIMIT=0
FUMBLE_LIMIT=100
CRIFUMB=0

echo "Dice: $1"
if [[ "$1" =~ ^${NUMBER_JUDGE}d${NUMBER_JUDGE} ]];then
    DICE_MANY=${1%%d*}
    echo "\$DICE_MANY: $DICE_MANY"
    if [[ $DICE_MANY =~ [\+\*\-]$ ]];then
        echo "+または-または*のあとに数字がありません"
        exit 1
    fi
    
    DICE_NUMBER=${1#*d}
    #echo "\$DICE_NUMBER: $DICE_NUMBER"
    DICE_NUMBER="${DICE_NUMBER%%[<,>,=]*}"
    echo "\$DICE_NUMBER: $DICE_NUMBER"
    if [[ $DICE_NUMBER =~ [\+\*\-]$ ]];then
        echo "+または-または*のあとに数字がありません"
        exit 1
    fi

    CRIFUMB=0
    
    DICE_EXTRA=$(echo "${1#*d}" | sed "s/[1-9][0-9]*//")
    DICE_EXTRA
    
    if [[ $DICE_COMPARISON != 000 ]];then
        DICE_LIMIT=${DICE_EXTRA##*[<,>,=]}
        DICE_LIMIT=${DICE_LIMIT:-NONUMBER}
        #echo DICE_LIMIT: $DICE_LIMIT
        if [[ $DICE_LIMIT =~ "NONUMBER" ]];then
            echo "制限値が設定されていません"
            exit 1
        fi
    fi
    if [[ $DICE_LIMIT =~ [\+\*\-] ]];then
        DICE_LIMIT=$(echo $(($DICE_LIMIT)) )
    fi

    echo "=============== $1 ==============="
    case $DICE_COMPARISON in
        000 )
            NdN $1 ;;
        0*  )
            LIMIT_DICE $1 ;;
        1*  )
            NdN_ARI_OPE $1 ;;
    esac
    echo -ne "\e[m"
    for i in $(seq 1 ${#1}) ;do
        EQUAL+="="
    done
    echo "${EQUAL}================================"


elif [[ "$1" =~ ^cc[b]*\<= ]];then
    DICE_MANY=1
    DICE_NUMBER=100

    if [[ "$1" =~ ^cc\<= ]];then
        DICE_EXTRA="${1##cc}"
    else
        DICE_EXTRA="${1##ccb}"
    fi
    DICE_EXTRA
    if [[ $DICE_COMPARISON == 000 ]];then
        echo "制限が設定されていません"
        exit 1
    fi

    DICE_LIMIT=${DICE_EXTRA##*[<,>,=]}
    DICE_LIMIT=${DICE_LIMIT:-NONUMBER}
    #echo DICE_LIMIT: $DICE_LIMIT
    if [[ $DICE_LIMIT =~ "NONUMBER" ]];then
        echo "制限値が設定されていません"
        exit 1
    fi
    if [[ $DICE_LIMIT =~ [\+\*\-] ]];then
        DICE_LIMIT=$(echo $(($DICE_LIMIT)) )
    fi

    if [[ "$1" =~ ^cc\<= ]];then
        CRITICAL_LIMIT=1
        FUMBLE_LIMIT=100
    else
        CRITICAL_LIMIT=5
        FUMBLE_LIMIT=96
    fi
    CRIFUMB=1

    echo "=============== $1 ==============="
    LIMIT_DICE $1
    echo -ne "\e[m"
    for i in $(seq 1 ${#1}) ;do
        EQUAL+="="
    done
    echo "${EQUAL}==============================="


else
    echo "ダイスを開始できませんでした"
    exit 1
fi
