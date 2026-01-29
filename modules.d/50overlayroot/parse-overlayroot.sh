#!/bin/sh

command -v getarg > /dev/null || . /lib/dracut-lib.sh

if getarg rd.overlay > /dev/null; then
    # Do not overwrite existing rd.overlay
    return 0
fi

overlayroot=$(getarg overlayroot) || return 0

# Make overlayroot= an alias for rd.overlay=
warn "Kernel command line option 'overlayroot' is deprecated, use 'rd.overlay' instead."
case "$overlayroot" in
    tmpfs|tmpfs:*)
        echo rd.overlay > /etc/cmdline.d/50-overlayroot.conf
        ;;
    disabled)
        ;;
    *)
        echo "rd.overlay=$overlayroot" > /etc/cmdline.d/50-overlayroot.conf
        ;;
esac
