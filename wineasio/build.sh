#!/bin/bash

set -e

export WINEBUILD=winebuild
export WINECC=winegcc

if [ "$CC" == 'i686-unknown-linux-gnu-gcc' ]; then
  _ARCH='i386'
  _ML='32'
  # since 4b4f68165f963a7396118817fc1a97232782e1b2 there's no need to set winebuild target
  #export WINEBUILD+=" --target i686-unknown-linux-gnu"
  export WINECC+=" --target i686-unknown-linux-gnu"
else
  _ARCH='x86_64'
  _ML='64'
fi

export WINEARCH=win${_ML}
wineprefix=${FLATPAK_BUILDER_BUILDDIR}/wine

make ${_ML}
install -Dm755 build${_ML}/wineasio.dll.so -t ${FLATPAK_DEST}/lib/${_ARCH}-linux-gnu/wine/${_ARCH}-unix/
install -Dm755 build${_ML}/wineasio.dll -t ${FLATPAK_DEST}/lib/${_ARCH}-linux-gnu/wine/${_ARCH}-windows/
