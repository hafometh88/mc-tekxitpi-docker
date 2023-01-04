FROM openjdk:8-jre-alpine

ENV VERSION="1.0.7.1"
ENV MEM="4G"

ENV URL="https://www.tekxit.xyz/downloads/${VERSION}TekxitPiServer.zip"

RUN apk add unzip
RUN apk add wget

RUN mkdir /minecraft
RUN wget -O /tmp/tekkit.zip ${URL}
RUN unzip /tmp/tekkit.zip -d /minecraft/

RUN chmod +x /minecraft/${VERSION}TekxitPiServer/ServerLinux.sh
RUN mv /minecraft/* /minecraft/tekxit

EXPOSE 25565

WORKDIR /minecraft/tekxit
RUN sed -i 's/Xmx4G/Xmx${MEM}/g' ServerLinux.sh
RUN sed -i 's/Xms4G/Xms${MEM}/g' ServerLinux.sh
CMD /minecraft/tekxit/ServerLinux.sh
