FROM openjdk:8-jre-alpine

ENV URL="https://www.tekxit.xyz/downloads/1.0.6TekxitPiServer.zip"
ENV MEM="8G"

RUN apk add unzip
RUN apk add wget

RUN mkdir /minecraft
RUN wget -O /tmp/tekkit.zip ${URL}
RUN unzip /tmp/tekkit.zip -d /minecraft/

RUN chmod +x /minecraft/1.0.6TekxitPiServer/ServerLinux.sh

EXPOSE 25565

WORKDIR /minecraft/1.0.6TekxitPiServer
RUN echo "java -server -Xmx${MEM} -Xms${MEM} -jar forge-1.12.2-14.23.5.2854.jar nogui" > ServerLinux.sh
CMD /minecraft/1.0.6TekxitPiServer/ServerLinux.sh
