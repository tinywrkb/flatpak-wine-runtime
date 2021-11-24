#!/bin/bash

set -e

if [ "$CC" == 'i686-unknown-linux-gnu-gcc' ]; then
  _ARCH='i386'
else
  _ARCH='x86_64'
fi

sed -i "s|@@PREFIX@@|"${FLATPAK_DEST}"|;s|@@ARCH@@|"${_ARCH}"|" pipewire-jack-runtime.pc
_LIBDIR=${FLATPAK_DEST}/lib
[ ${FLATPAK_DEST} == '/usr' ] && _LIBDIR+=/${_ARCH}-linux-gnu
install -Dm644 pipewire-jack-runtime.pc ${_LIBDIR}/pkgconfig/jack.pc
