FROM alpine:3.15

RUN apk add --no-cache rsync gettext tree

COPY deploy-data/data /data
COPY deploy-data/bin/entrypoint.sh /entrypoint.sh
COPY device-mqtt/data /data/device-mqtt
COPY edgex-ui/data /data/edgex-ui

RUN tree -up /data

WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
