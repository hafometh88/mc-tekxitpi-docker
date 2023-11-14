FROM openjdk:8-jre-alpine

ENV VERSION="1.0.961"
ENV URL="https://www.tekxit.xyz/downloads/${VERSION}TekxitPiServer.zip"
ENV MEM="4G"

RUN apk add unzip
RUN apk add wget

RUN wget -O /tmp/tekkit.zip ${URL}
RUN unzip /tmp/tekkit.zip -d /minecraft/

RUN mv /minecraft/* /minecraft/tekxit
RUN chmod +x /minecraft/tekxit/ServerLinux.sh

EXPOSE 25565

WORKDIR /minecraft/tekxit
RUN sed -i 's/Xmx4G/Xmx${MEM}/g' ServerLinux.sh
RUN sed -i 's/Xms4G/Xms${MEM}/g' ServerLinux.sh

CMD /minecraft/tekxit/ServerLinux.sh
