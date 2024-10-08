#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

FEATURES=(
    # thesofproject # Sound patch
)

# Sound patch
if "thesofproject" in "${FEATURES[@]}"; then
    (
        # https://github.com/thesofproject/sof-bin
        SOURCE=$(
            curl -L https://api.github.com/repos/thesofproject/sof-bin/releases/latest |
                jq -r '.assets[] | select(.name| test(".*.tar.gz$")).browser_download_url'
        )
        cd "$(mktemp -d)"
        curl -Lo sof_bin.tar.gz -A "*.tar.gz" "$SOURCE"
        # "https://github.com/thesofproject/sof-bin/releases/download/v2024.06/sof-bin-2024.06.tar.gz"
        mkdir sof_bin &&
            tar -C sof_bin -xavf sof_bin.tar.gz \
                --preserve-permissions \
                --strip-components=1 &&
            rm sof_bin.tar.gz
        cd ./sof_bin
        ./install.sh
    )
fi
