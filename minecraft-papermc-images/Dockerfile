FROM alpine:latest

RUN apk add --no-cache \
    openjdk17-jre \
    curl \
    dumb-init \
    ; \
    curl -Lo /paper.jar https://api.papermc.io/v2/projects/paper/versions/1.20.4/builds/373/downloads/paper-1.20.4-373.jar; \
    chmod +x /paper.jar; \
    adduser -D paper; \
    mkdir /paper && chown paper:paper /paper && chmod 1700 /paper;

COPY docker-entrypoint.sh /
USER paper:paper
WORKDIR /paper

ENTRYPOINT ["/docker-entrypoint.sh"]