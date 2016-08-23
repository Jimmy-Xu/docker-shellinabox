#!/bin/bash

ACCESS_KEY=
SECRET_KEY=
USER_NAME=test
USER_PASS=$(date +%s |sha256sum |base64 |head -c 32 ;echo)

ARG_E=""
[ "${ACCESS_KEY}" != "" ] && ARG_E="${ARG_E} -e ACCESS_KEY=${ACCESS_KEY} "
[ "${SECRET_KEY}" != "" ] && ARG_E="${ARG_E} -e SECRET_KEY=${SECRET_KEY} "
[ "${USER_NAME}" != "" ] && ARG_E="${ARG_E} -e SIAB_USER=${USER_NAME} "
[ "${USER_PASS}" != "" ] && ARG_E="${ARG_E} -e SIAB_PASSWORD=${USER_PASS} "

CID=$(docker run -d -p 4200 \
${ARG_E} \
-e SIAB_SUDO=true \
xjimmyshcn/shellinabox
)

CPORT=$(docker port $CID | awk -F":" '{print $NF}')
echo http://127.0.0.1:$CPORT

echo "user: ${USER_NAME} password: ${USER_PASS}"
