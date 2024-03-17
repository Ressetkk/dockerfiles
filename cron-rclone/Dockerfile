FROM alpine:latest AS prep

RUN apk add --no-cache ca-certificates dumb-init && update-ca-certificates

FROM alpine:latest

ENV VERSION_RCLONE=v1.66.0
COPY --from=prep /etc/ssl/certs /etc/ssl/certs
COPY --from=prep /usr/bin/dumb-init /usr/bin/dumb-init
COPY init.sh /init.sh
RUN set -eux; \
    osarch="$(uname -m)"; \
    case "$osarch" in \
        'x86_64') \
            export ARCH=amd64 OS=linux ; \
            ;; \
        'aarch64') \
            export ARCH=arm64 OS=linux ; \
            ;; \
        *) \
            echo >&2 "unsupported arch '$osarch'" ;; \
    esac; \
    wget https://downloads.rclone.org/${VERSION_RCLONE}/rclone-${VERSION_RCLONE}-${OS}-${ARCH}.zip -qO /tmp/rclone.zip && \
    unzip /tmp/rclone.zip -d /tmp && \
    mv "/tmp/rclone-${VERSION_RCLONE}-${OS}-${ARCH}/rclone" /bin/ && \
    chmod a+x /bin/rclone && \
    rclone version && \
    rm -rf /tmp/* ; \
    chmod a+x /init.sh ; \
    adduser -S -u 1000 user; \
    addgroup -g 1000 -S user ; \
    mkdir /cron; chown user:user /cron

USER 1000

ENTRYPOINT [ "/init.sh" ]