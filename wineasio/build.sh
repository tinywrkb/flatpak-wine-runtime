#!/bin/bash

set -e

WINEBUILD=winebuild
export WINECC=winegcc

if [ "$CC" == 'i686-unknown-linux-gnu-gcc' ]; then
  _ARCH='i386'
  _ML='32'
  WINEBUILD+=" --target i686-unknown-linux-gnu"
  export WINECC+=" --target i686-unknown-linux-gnu"
else
  _ARCH='x86_64'
  _ML='64'
fi

export WINEARCH=win${_ML}
wineprefix=${FLATPAK_BUILDER_BUILDDIR}/wine

make ${_ML}
install -Dm644 build${_ML}/wineasio.dll.so -t ${FLATPAK_DEST}/lib/${_ARCH}-linux-gnu/wine/${_ARCH}-unix/
$WINEBUILD --dll --fake-module -E wineasio.dll.spec build${_ML}/{asio,main,regsvr}.c.o > build${_ML}/wineasio.dll
install -Dm644 build${_ML}/wineasio.dll -t ${FLATPAK_DEST}/lib/${_ARCH}-linux-gnu/wine/${_ARCH}-windows/
