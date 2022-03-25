#!/bin/sh
#
#i=1
#while [ "$i" -ne 100 ]
#do
#    ip route get to 1.1.1.1
#    BIND_IP="$(ip route get to 1.1.1.1 | sed -En 's/.*src +(([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p')"
#    printf "\nIP: %s\n" "${BIND_IP}"
#    i=$((i + 1))
#    sleep 0.1
#done
#
##printf "\n\nip route:\n\n"
##
##ip route
##
##printf "\n\nsleeping...\n\n"
##
##sleep 5
##
##printf "\n\nip route:\n\n"
##
##ip route
##
##printf "\n\nrunning...\n\n"
##
##printf "\nIP: %s\n" "$(get_ip)"
#
#sleep 5
#
#BIND_IP="$(ip route get to 1.1.1.1 | sed -En 's/.*src +(([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p')"

#exec docker-entrypoint.sh agent -ui -bootstrap -server -client=0.0.0.0 -bind="${BIND_IP}"
exec docker-entrypoint.sh agent -ui -bootstrap -server -client=0.0.0.0 -bind="127.0.0.1"
