#!/bin/bash

_FPID=org.winehq.Sdk

[ -f ${_FPID}.yaml ] || { echo "Can't find ${_FPID}.yaml"; exit 1; }

flatpak run \
  --runtime=org.freedesktop.Sdk//21.08 \
  --filesystem=$PWD \
  org.flathub.flatpak-external-data-checker \
  --edit-only ${_FPID}.yaml

{
  cd wine/perl-parse-yapp
  ./update.sh
}
