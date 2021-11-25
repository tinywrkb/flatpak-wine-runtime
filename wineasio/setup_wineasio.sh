#!/bin/bash

# TODO: symlinks support
# TODO: install/uninstall
# TODO: more WINEPREFIX testing (existence, absolute path, ...)

[ -n "$WINEPREFIX" ] || { echo "WINEPREFIX must be set"; exit 1; }

if [ "$WINEARCH" == 'win32' ]; then
  [ -e "$WINEPREFIX"/drive_c/windows/system32/wineasio.dll ] ||
    install -Dm755 -t "$WINEPREFIX"/drive_c/windows/system32/ \
    /usr/lib/i386-linux-gnu/wine/i386-windows/wineasio.dll
  wine regsvr32 wineasio.dll

elif [ "$WINEARCH" == 'win64' ]; then

  [ -e "$WINEPREFIX"/drive_c/windows/syswow64/wineasio.dll ] ||
    install -Dm755 -t "$WINEPREFIX"/drive_c/windows/syswow64/ \
    /usr/lib/i386-linux-gnu/wine/i386-windows/wineasio.dll
  wine regsvr32 wineasio.dll

  [ -e "$WINEPREFIX"/drive_c/windows/system32/wineasio.dll ] ||
    install -Dm755 -t "$WINEPREFIX"/drive_c/windows/system32/ \
    /usr/lib/x86_64-linux-gnu/wine/x86_64-windows/wineasio.dll
  wine64 regsvr32 wineasio.dll
else
  echo "WINEARCH must be explicitly set!"
  exit 1
fi
