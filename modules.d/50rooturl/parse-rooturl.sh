#!/bin/sh

command -v getarg > /dev/null || . /lib/dracut-lib.sh

print_deprecation() {
    local root="$1"
    local url="$2"
    local type="$3"
    local new

    if [ "$type" = raw ]; then
        new="rd.systemd.pull=raw,machine,verify=no,blockdev:rootdisk:$url root=/dev/disk/by-loop-ref/rootdisk.raw"
    elif [ "$type" = tar ]; then
        new="rd.systemd.pull=tar,machine,verify=no:root:$url root=bind:/run/machines/root"
    fi
    warn "Kernel command line option 'root=$root' is deprecated, use '$new' instead."
}

parse_root() {
    local root="$1"
    local url type

    case "$root" in
        tar:http*)
            url="${root#*:}"
            type=tar
            ;;
        squash:http*)
            url="${root#*:}"
            type=raw
            ;;
        http*.tar.?? | http*.tar.??? | http*.t?z)
            url="$root"
            type=tar
            ;;
        http*squash | http*squashfs)
            url="$root"
            type=raw
            ;;
        *)
            return 0
            ;;
    esac

    print_deprecation "$root" "$url" "$type"

    echo "rd.neednet=1" > /etc/cmdline.d/50-rooturl.conf
    if ! getarg "ip="; then
        echo "ip=dhcp" >> /etc/cmdline.d/50-rooturl.conf
    fi

    # shellcheck disable=SC2034
    rootok=1
}

parse_root "$(getarg root=)"
