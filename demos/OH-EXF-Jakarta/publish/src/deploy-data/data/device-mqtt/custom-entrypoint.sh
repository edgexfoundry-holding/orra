#!/bin/sh

for host in ${WAIT_FOR_HOSTS}; do
    while ! nslookup "${host}" >/dev/null 2>&1; do
        echo "waiting for ${host}..."
        sleep 0.1
    done
done

echo "starting..."

exec /device-mqtt -cp="${CONFIGURATION_PROVIDER_URL}" --registry
