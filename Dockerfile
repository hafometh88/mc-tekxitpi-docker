FROM openjdk:8-jre-alpine

ENV VERSION="1.0.7.1"
ENV URL="https://www.tekxit.xyz/downloads/${VERSION}TekxitPiServer.zip"
ENV MEM="8G"

RUN apk add unzip
RUN apk add wget

RUN mkdir /minecraft
RUN wget -O /tmp/tekkit.zip ${URL}
RUN unzip /tmp/tekkit.zip -d /minecraft/
RUN mv /minecraft/

RUN chmod +x /minecraft/${VERSION}TekxitPiServer/ServerLinux.sh

EXPOSE 25565

WORKDIR /minecraft/${VERSION}TekxitPiServer
#RUN echo "java -server -Xmx${MEM} -Xms${MEM} -jar forge-1.12.2-14.23.5.2854.jar nogui" > ServerLinux.sh
RUN sed -i 's/Xmx4G/Xmx${MEM}/g' ServerLinux.sh
RUN sed -i 's/Xms4G/Xms${MEM}/g' ServerLinux.sh
CMD /minecraft/${VERSION}TekxitPiServer/ServerLinux.sh
