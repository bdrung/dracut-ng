#!/bin/bash

# called by dracut
depends() {
    echo overlayfs
}

# called by dracut
install() {
    inst_hook cmdline 50 "$moddir/parse-overlayroot.sh"
}
