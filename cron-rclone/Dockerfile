FROM alpine:latest AS certs

RUN apk add --no-cache ca-certificates && update-ca-certificates

FROM busybox:latest

ENV RCLONE_VERSION=v1.66.0
COPY --from=certs /usr/share/ca-certificates/* /usr/ssl/certs
RUN \
    OS=linux &&\
    if [[ $(uname -m) == "aarch64" ]]; then \
        ARCH=arm64 ; \
    elif [[ $(uname -m) == "amd64" ]]; then \
        ARCH=amd64 ; \
    fi && \
    wget https://downloads.rclone.org/${RCLONE_VERSION}/rclone-${RCLONE_VERSION}-${OS}-${ARCH}.zip -qO - | tar -zxvf - -C /tmp && \
    mv /tmp/rclone /bin/ && \
    chmod a+x /bin/rclone && \
    rclone -v && \
    rm -rf /tmp*

USER 1000

ENTRYPOINT [ "/bin/crond", "-f" ]
CMD [ "/crontab" ]