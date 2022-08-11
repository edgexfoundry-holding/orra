FROM alpine:3.15

RUN apk add --no-cache rsync gettext tree

COPY models /data/models
COPY pipelines /data/pipelines
COPY bin/entrypoint.sh /bin/

WORKDIR /data

ENTRYPOINT ["/bin/entrypoint.sh"]
