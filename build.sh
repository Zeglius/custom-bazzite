#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

(
    # https://github.com/thesofproject/sof-bin
    cd "$(mktemp -d)"
    wget -o sof-bin.tar.gz \
        https://github.com/thesofproject/sof-bin/releases/download/v2024.06/sof-bin-2024.06.tar.gz
    mkdir sof-bin
    tar -C sof-bin -zvf sof-bin.tar.gz --strip-components=1
    cd ./sof-bin
    ./install.sh
)
