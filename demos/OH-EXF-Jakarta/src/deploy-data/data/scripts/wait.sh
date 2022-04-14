#!/bin/sh

echo " wait: $*"
echo "hosts: ${WAIT_FOR_HOSTS:-}"

WAIT_FOR_HOSTS_TIMEOUT="${WAIT_FOR_HOSTS_TIMEOUT:-300}"
UNTIL=$(( $(date +%s) + $((WAIT_FOR_HOSTS_TIMEOUT)) ))
HOST_PREFIX="${WAIT_FOR_HOSTS_PREFIX:-}"
RUN_ANYWAY="${WAIT_FOR_HOSTS_RUN_ANYWAY:-0}"

check_timeout() {
    if [ "$(date +%s)" -ge "${UNTIL}" ]; then
        echo "Timed out waiting for hosts!"
        return 9
    fi
}

is_host_alive() {
    if [ -z "$2" ]; then
        echo "Checking for host "
        nslookup "$1" >/dev/null 2>&1
    else
        nc -w 1 -z "$1" "$2" >/dev/null 2>&1
    fi
}

wait_for_hosts() {
    for host_port in ${WAIT_FOR_HOSTS:-}; do
        host="${HOST_PREFIX}$(echo "${host_port}" | cut -d ':' -f 1)"
        port="$(echo "${host_port}" | cut -d ':' -f 2 -s)"
        while ! is_host_alive "$host" "$port"; do
            ip route get to 1.1.1.1
            if ! check_timeout; then
                if [ "${RUN_ANYWAY}" -eq 1 ]; then
                    echo "WAIT_FOR_HOSTS_RUN_ANYWAY is set, so we are still going to run even though we timed out!"
                    return 0
                else
                    echo "Exiting..."
                    exit 9
                fi
            fi

            echo "waiting up to $(( UNTIL - $(( $(date +%s) )) )) more seconds for ${host}:${port}..."
            sleep 0.5
        done

        echo "$host:$port is alive!"
    done
}

wait_for_hosts

echo "Running: exec $*"

exec "$@"
