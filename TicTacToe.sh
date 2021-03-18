echo "Legalne ruchy: a1 a2 a3 b1 b2 b3 c1 c2 c3"

PLANSZA=('_' '_' '_' '_' '_' '_' '_' '_' '_')
WYGRANA="0"
POLE=""
RUCH="O"

function wyswietl 
{
    echo " " 1 2 3
    echo a ${PLANSZA[0]} ${PLANSZA[1]} ${PLANSZA[2]}
    echo b ${PLANSZA[3]} ${PLANSZA[4]} ${PLANSZA[5]}
    echo c ${PLANSZA[6]} ${PLANSZA[7]} ${PLANSZA[8]}
}

function wykonajRuch
{
    while true; do
        read POLE
        echo $POLE
        if [ $POLE == "a1" ] && [ ${PLANSZA[0]} == "_" ]; then
            POLE=0
        elif [ $POLE == "a2" ] && [ ${PLANSZA[1]} == "_" ]; then
            POLE=1
        elif [ $POLE == "a3" ] && [ ${PLANSZA[2]} == "_" ]; then
            POLE=2
        elif [ $POLE == "b1" ] && [ ${PLANSZA[3]} == "_" ]; then
            POLE=3
        elif [ $POLE == "b2" ] && [ ${PLANSZA[4]} == "_" ]; then
            POLE=4
        elif [ $POLE == "b3" ] && [ ${PLANSZA[5]} == "_" ]; then
            POLE=5
        elif [ $POLE == "c1" ] && [ ${PLANSZA[6]} == "_" ]; then
            POLE=6
        elif [ $POLE == "c2" ] && [ ${PLANSZA[7]} == "_" ]; then
            POLE=7
        elif [ $POLE == "c3" ] && [ ${PLANSZA[8]} == "_" ]; then
            POLE=8
        else
            echo "To nie jest legalny ruch - sprobuj jeszcze raz"
            continue
        fi

        PLANSZA[POLE]=$RUCH
        break
    done
}

function sprawdzPionowo
{
    KOLUMNA=POLE%3
    echo ${PLANSZA[KOLUMNA]}
    echo ${PLANSZA[KOLUMNA+3]}
    echo ${PLANSZA[KOLUMNA+6]}
    if [ ${PLANSZA[KOLUMNA]} == $RUCH ] && [ ${PLANSZA[KOLUMNA+3]} == $RUCH ] && [ ${PLANSZA[KOLUMNA+6]} == $RUCH ]; then
        return 0
    fi

    return 1
}

function sprawdzPoziomo
{
    WIERSZ=POLE/3
    if [ ${PLANSZA[WIERSZ*3]} == $RUCH ] && [ ${PLANSZA[WIERSZ*3+1]} == $RUCH ] && [ ${PLANSZA[WIERSZ*3+2]} == $RUCH ]; then
        return 0
    fi

    return 1;
}

function sprawdzDiagonale
{
    if [ ${PLANSZA[0]} == $RUCH ] && [ ${PLANSZA[4]} == $RUCH ] && [ ${PLANSZA[8]} == $RUCH ]; then
        return 0
    fi

    if [ ${PLANSZA[2]} == $RUCH ] && [ ${PLANSZA[4]} == $RUCH ] && [ ${PLANSZA[6]} == $RUCH ]; then
        return 0
    fi

    return 1;
}

function sprawdzWygrana 
{
    if sprawdzPoziomo || sprawdzPionowo || sprawdzDiagonale
    then
        WYGRANA=$RUCH
    else
        sprawdzRemis
    fi
}

function sprawdzRemis
{
    for i in "${PLANSZA[@]}"; do
        if [ $i == "_" ]
        then
            return 1
        fi
    done

    WYGRANA="R"
    return 0
}

function zmienGracza
{
    if [ $RUCH == "O" ]
    then
        RUCH="X"
    else
        RUCH="O"
    fi
}

while [ $WYGRANA == "0" ]
do
    wyswietl
    wykonajRuch
    sprawdzWygrana
    zmienGracza
    clear
done

wyswietl
if [ $WYGRANA == "R" ]
then
    echo Remis
else
    echo Wygrywa $WYGRANA
fi