FROM eclipse-temurin:8-jre-jammy

ENV VER="latest" \
    MEM="4G" \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip \
        wget \
        grep \
        dos2unix && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /minecraft && \
    chown -R 1000:1000 /minecraft

COPY launch.sh /launch.sh
RUN dos2unix /launch.sh && \
    chmod +x /launch.sh

EXPOSE 25565

USER 1000:1000

WORKDIR /minecraft
CMD ["/launch.sh"]
