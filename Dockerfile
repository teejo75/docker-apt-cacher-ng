FROM debian:bookworm-slim

LABEL org.opencontainers.image.source=https://github.com/teejo75/docker-apt-cacher-ng
LABEL org.opencontainers.image.description="Dockerized apt-cacher-ng"

RUN apt-get update && apt-get install -y apt-cacher-ng && apt-get clean all; \
    rm -rf /var/lib/apt/lists/*; mkdir -p /tmp/acng && cp -a /etc/apt-cacher-ng/* /tmp/acng; \
    echo "PassThroughPattern: .*" >> /tmp/acng/acng.conf; \
    echo "UnbufferLogs: 1" >> /tmp/acng/acng.conf; \
    echo "VerboseLog: 1" >> /tmp/acng/acng.conf; \
    echo "DnsCacheSeconds: 1800" >> /tmp/acng/acng.conf;

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3142

VOLUME [ "/etc/apt-cacher-ng", "/var/cache/apt-cacher-ng" ]

ENTRYPOINT [ "/start.sh" ]