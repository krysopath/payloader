#!/bin/bash -ex

uuencode="on"
if test "$1" = '--binary'
then
  binary="on"
  uuencode="off"
  shift
fi
if test "$1" = '--uuencode'
then
  binary="off"
  uuencode="on"
  shift
fi

if test -z "$1"
then
  echo "Usage: $0 [--binary | --uuencode] PAYLOAD_FILE"
  exit 1
fi


if test "$binary" = 'on'
then
  sed \
    -e 's/uuencode=./uuencode=0/' \
    -e 's/binary=./binary=1/' \
			 install.sh.in >install.sh
  echo "PAYLOAD:" >> install.sh
	cat $1 >>install.sh
fi

if test $uuencode = 'off'
then
  sed \
    -e 's/uuencode=./uuencode=1/' \
    -e 's/binary=./binary=0/' \
        install.sh.in >install.sh
  echo "PAYLOAD:" >> install.sh
  cat $1 | uuencode - >>install.sh
fi
