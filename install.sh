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
#ssh setup
if [[ $# -eq 1 ]]; then
	SH_SSH_KEYS=${DIR}/apply-githubkeys.sh
	chmod +x ${SH_SSH_KEYS}
	./apply-githubkeys.sh $1
fi

cd ${HOME}
vim
