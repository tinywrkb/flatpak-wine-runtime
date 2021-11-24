#!/bin/bash

set -e

if [ "$FLATPAK_ARCH" == 'x86_64' ]; then
  _ARCH='64'
elif [ "$FLATPAK_ARCH" == 'i386' ]; then
  _ARCH='32'
else
  exit 1
fi

export WINEARCH=win${_ARCH}
wineprefix=${flatpak_builder_builddir}/wine

make ${_ARCH}
install -Dm644 build${_ARCH}/wineasio.dll.so -t ${FLATPAK_DEST}/lib/${FLATPAK_ARCH}-linux-gnu/wine/${FLATPAK_ARCH}-unix/
winebuild --dll --fake-module -E wineasio.dll.spec build${_ARCH}/{asio,main,regsvr}.c.o > build${_ARCH}/wineasio.dll
install -Dm644 build${_ARCH}/wineasio.dll -t ${FLATPAK_DEST}/lib/${FLATPAK_ARCH}-linux-gnu/wine/${FLATPAK_ARCH}-windows/
