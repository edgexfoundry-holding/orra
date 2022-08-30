# Copyright (C) 2022 Intel Corporation
# SPDX-License-Identifier: Apache-2.0

FROM alpine:3.15

RUN apk add --no-cache rsync gettext tree

COPY models /data/models
COPY pipelines /data/pipelines
COPY config.json /data/config.json
COPY bin/entrypoint.sh /bin/

WORKDIR /data

ENTRYPOINT ["/bin/entrypoint.sh"]
