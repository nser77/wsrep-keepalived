#!/bin/sh

which stat chmod &>/dev/zero

if [ $? -ne 0 ]
then
    exit 1
fi

FILE=/var/lib/mysql/vrrp-status

while [ $# -gt 0 ]
do
   case $1 in
  	--status)
         	status=$2
         	shift
     	;;
   esac
   shift
done

if [ -e ${FILE} ]
then
    if [ ! -O ${FILE} ] || [ ! -G ${FILE} ]
    then
        exit 1
    fi

    if [ ! -w ${FILE} ]
    then
        exit 1
    fi

    if [ "$(stat -c "%a" ${FILE})" -ne "644" ]
    then
        chmod 644 ${FILE} &>/dev/zero

        if [ $? -ne 0 ]
        then
            exit 1
        fi
    fi
else
    umask 022

    if [ $? -ne 0 ]
    then
        exit 1
    fi
fi

# galera’s (3, 4) machine states that result in keepalived
#   joining the VRRP cluster.
if [ "${status}" = "Joined" ] || [ "${status}" = "Synced" ] || [ "${status}" = "Donor" ] \
    || [ "${status}" = "joined" ] || [ "${status}" = "synced" ] || [ "${status}" = "donor" ]
then
    echo 0 >${FILE} # OK
else
    echo 1 >${FILE} # KO
fi

exit 0
