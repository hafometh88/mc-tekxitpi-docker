FROM openjdk:8-jre-slim

ENV VER="1.0.961"
ENV MEM="4G"

RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get install -y wget

COPY start.sh /minecraft/
RUN chmod +x /minecraft/start.sh

EXPOSE 25565

CMD /minecraft/start.sh



