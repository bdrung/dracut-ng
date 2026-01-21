#!/bin/sh

command -v getarg > /dev/null || . /lib/dracut-lib.sh

if getarg rd.driver.export > /dev/null; then
    # Do not overwrite existing rd.driver.export
    return 0
fi

copymods=$(getarg copymods) || return 0

# Make copymods= an alias for rd.driver.export=
warn "Kernel command line option 'copymods' is deprecated, use 'rd.driver.export' instead."
if [ -n "$copymods" ]; then
    echo "rd.driver.export=$copymods" > /etc/cmdline.d/50-copymods.conf
else
    echo rd.driver.export > /etc/cmdline.d/50-copymods.conf
fi
