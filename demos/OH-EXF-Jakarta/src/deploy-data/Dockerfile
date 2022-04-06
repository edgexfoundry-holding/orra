FROM alpine:3.15

RUN apk add --no-cache rsync gettext tree

COPY data /data
COPY bin/entrypoint.sh /bin/

WORKDIR /data

ENTRYPOINT ["/bin/entrypoint.sh"]
