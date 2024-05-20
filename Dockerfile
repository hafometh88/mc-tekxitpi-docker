FROM openjdk:8-jre-slim

ENV VER="1.0.980"
ENV MEM="4G"

RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get install -y wget

COPY launch.sh /
RUN chmod +x /launch.sh

RUN mkdir /tekxit-server
WORKDIR /tekxit-server

RUN wget https://www.tekxit.lol/downloads/tekxit3.14/${VER}TekxitPiServer.zip

RUN \
    unzip ${VER}TekxitPiServer.zip \
    && mv ${VER}TekxitPiServer/* . \
    && rm -r ${VER}TekxitPiServer

WORKDIR /data

EXPOSE 25565

CMD /launch.sh
