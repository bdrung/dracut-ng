#!/bin/bash

# called by dracut
check() {
    # The dmsquash-live Dracut module rejects working in host-only mode.
    if [[ $hostonly ]]; then
        dwarning "${moddir##*/}: not included in host-only mode."
        return 1
    fi
    return 0
}

# called by dracut
depends() {
    echo livenet
}
