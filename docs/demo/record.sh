#!/bin/sh
# Records the README's GIFs into docs/. Needs vhs and vim-fugitive.
#
#   docs/demo/record.sh               all of them
#   docs/demo/record.sh diff-this     one
set -e
cd "$(dirname "$0")/../.."
DEMO_FUGITIVE=${DEMO_FUGITIVE:-$HOME/.vim/plugged/vim-fugitive}
DEMO_VIMRC=$PWD/docs/demo/vimrc
export DEMO_FUGITIVE DEMO_VIMRC
if [ $# -eq 0 ]; then
  set -- diff-this diff-this-bang diff-commit diff-commit-bang branch-diff branch-diff-bang
fi
for name do
  vhs "docs/demo/$name.tape"
done
