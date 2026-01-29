#!/bin/sh

[ ! -e "$NEWROOT/media/root-ro" ] || return 0

[ -d "$NEWROOT/media" ] || mkdir "$NEWROOT/media"
ln -s /run/rootfsbase "$NEWROOT/media/root-ro"
