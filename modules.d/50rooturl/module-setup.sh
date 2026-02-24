#!/bin/bash

# called by dracut
depends() {
    echo systemd-import
}

# called by dracut
install() {
    inst_hook cmdline 50 "$moddir/parse-rooturl.sh"
    # rooturl-generator.sh must run after systemd-fstab-generator to overwrite sysroot.mount
    inst_script "$moddir/rooturl-generator.sh" "$systemdutildir"/system-generators/zzz-dracut-rooturl-generator
}
