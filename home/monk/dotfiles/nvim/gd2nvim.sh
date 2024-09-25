#!/bin/bash
[ -n "$1" ] && file=$1
/home/v/.nix-profile/bin/nvim --server ~/.cache/nvim/godot.pipe --remote-send ':e '$file'<CR>'
