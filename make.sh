# make into self extracting jar archive
NAME=clef-host
BASE=$(
    cd "$(dirname "$0")"
    pwd -P
)
set -e
ETC_AREA=$BASE/etc
BIN_AREA=$BASE/bin
MAKE_AREA=$BASE/.make
PACK_AREA=$MAKE_AREA/pack/
rm -fr $MAKE_AREA/*
mkdir -p $PACK_AREA 

if [ ! -f $BASE/pubspec.lock ]; then
    cd $BASE
    dart pub update
fi

dart compile exe $BIN_AREA/main.dart -o $PACK_AREA/$NAME
cp -R $ETC_AREA/* $PACK_AREA/
tar -zcvf $MAKE_AREA/$NAME.gzip -C $PACK_AREA .