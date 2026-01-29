#!/bin/bash

# called by dracut
depends() {
    echo overlayfs overlayfs-crypt
}

# called by dracut
install() {
    inst_hook cmdline 50 "$moddir/parse-overlayroot.sh"
    inst_hook pre-pivot 50 "$moddir/overlayroot-compat-symlink.sh"   # after mount-overlayfs.sh from overlayfs
}
