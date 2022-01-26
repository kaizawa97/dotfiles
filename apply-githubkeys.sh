#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "$0 [username]"
	exit 1
fi

if ! type curl > /dev/null 2>&1; then
	echo "curl is required"
	exit 1
fi

DIR=$(cd $(dirname $0) && pwd)

AUTHORIZED_KEYS="${HOME}/.ssh/authorized_keys"
GIT_AUTHORIZED_KEYS="${DIR}/git_authorized_keys"

mkdir -p $(dirname ${AUTHORIZED_KEYS})
echo "get github keys..."

STATUSCODE=$( \
	curl -sS \
		-w '%{http_code}' \
		"https://github.com/$1.keys" \
		-o ${GIT_AUTHORIZED_KEYS} \
)

if [[ "${STATUSCODE}" != "200" ]]; then
	echo "Download Error. Invalid Github Username $1"
	exit 1
fi

cat "${GIT_AUTHORIZED_KEYS}" > "${AUTHORIZED_KEYS}"

rm "${GIT_AUTHORIZED_KEYS}"

echo "DONE!! "
