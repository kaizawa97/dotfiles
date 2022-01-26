#!/bin/bash

DIR=$(cd $(dirname $0) && pwd)

function install () {
	if [[ $# -ne 2 ]]; then
		echo "Install Error"
		exit 1
	fi
	echo "Install $1 -> $2"

	# vimrc install
	ln -s "${DIR}/$1" "$2"

	if [[ $? -ne 0 ]]; then
		echo "Installation Failed"
	fi
}

echo "[Basic]"
install "vimrc" "${HOME}/.vimrc"
cd ${HOME}
vim
