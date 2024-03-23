#!/bin/sh

FPERM=644
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

    if [ "$(stat -L -c "%a" ${FILE})" -ne "${FPERM}" ]
    then
        chmod ${FPERM} ${FILE}

        if [ $? -ne 0 ]
        then
            exit 1
        fi
    fi
else
    T_FILE=$(touch ${FILE})
    P_FILE=$(chmod ${FPERM} ${FILE})

    if [ ${T_FILE} -ne 0 ] || [ ${P_FILE} -ne 0 ]
    then
        exit 1
    fi

    unset T_FILE P_FILE
fi

unset FPERM

# galera’s (3, 4) machine states that result in keepalived
#   joining the VRRP cluster.
if [ "${status}" = "Joined" ] || [ "${status}" = "Synced" ] || [ "${status}" = "Donor" ] \
  [ "${status}" = "joined" ] || [ "${status}" = "synced" ] || [ "${status}" = "donor" ]
then
    echo 0 >${FILE} # OK
else
    echo 1 >${FILE} # KO
fi

exit 0
