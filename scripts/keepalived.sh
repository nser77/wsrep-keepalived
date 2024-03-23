#!/bin/sh

FILE=/var/lib/mysql/vrrp-status

status=1; [ $(cat ${FILE} 2>/dev/zero) -eq 0 ] && status=0

exit ${status}