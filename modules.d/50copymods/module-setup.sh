#!/bin/bash

# called by dracut
depends() {
    echo kernel-modules-export
}

# called by dracut
install() {
    inst_hook cmdline 50 "$moddir/parse-copymods.sh"
}
