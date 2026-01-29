#!/bin/sh

command -v getarg > /dev/null || . /lib/dracut-lib.sh

if getarg rd.overlay > /dev/null || getarg rd.overlay.crypt > /dev/null; then
    # Do not overwrite existing rd.overlay or rd.overlay.crypt
    return 0
fi

overlayroot=$(getarg overlayroot) || return 0

# Make overlayroot= an alias for rd.overlay= or rd.overlay.crypt=
warn "Kernel command line option 'overlayroot' is deprecated, use 'rd.overlay' instead."
case "$overlayroot" in
    tmpfs | tmpfs:*)
        echo rd.overlay > /etc/cmdline.d/50-overlayroot.conf
        ;;
    crypt:*)
        opts="${overlayroot#crypt:}"
        dev=""
        dracut_opts=""
        old_ifs="$IFS"
        IFS=","
        # shellcheck disable=SC2086
        set -- $opts
        IFS="$old_ifs"
        for kv in "$@"; do
            key="${kv%%=*}"
            val="${kv#*=}"
            case "$key" in
                dev) dev="$val" ;;
                pass) warn "overlayroot: crypt 'pass=' option is not supported, ignoring" ;;
                fstype | mkfs | timeout | mapname)
                    dracut_opts="${dracut_opts:+$dracut_opts,}${key}=${val}" ;;
                *) warn "overlayroot: unknown crypt option '${key}', ignoring" ;;
            esac
        done
        if [ -z "$dev" ]; then
            warn "overlayroot: crypt requires dev= option"
            return 0
        fi
        echo "rd.overlay.crypt=${dev}${dracut_opts:+,$dracut_opts}" > /etc/cmdline.d/50-overlayroot.conf
        ;;
    disabled)
        ;;
    *)
        echo "rd.overlay=$overlayroot" > /etc/cmdline.d/50-overlayroot.conf
        ;;
esac
