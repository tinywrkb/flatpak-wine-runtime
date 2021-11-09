#!/bin/bash

_FPID=perl-parse-yapp

[ -f ${_FPID}.json ] || { echo "Can't find ${_FPID}.json"; exit 1; }

../../tools/cpan-updater
