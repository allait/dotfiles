# By ieure@; copied from https://gist.github.com/1474072
function up ()
{
    if [ "$1" != "" -a "$2" != "" ]; then
        local DIR=$1
        local TARGET=$2
    elif [ "$1" ]; then
        local DIR=$PWD
        local TARGET=$1
    fi
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

function catup ()
{
    TARGET=`up $1`
    test "$TARGET" != "" && cat $TARGET
}

function lsup ()
{
    TARGET=`up $*`
    test "$TARGET" != "" && ls -l $TARGET
}

function cdup ()
{
    if [ "$1" != "" ]; then
        TARGET=$*
    else
        TARGET=.git
    fi

    TARGET=`up $TARGET`
    test "$TARGET" != "" && cd $(dirname $TARGET)
}
