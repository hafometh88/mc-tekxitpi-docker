#!/bin/bash

cd /minecraft
FILE="${VER}TekxitPiServer.zip"
if [ -f "$FILE" ]; then
    echo "The file '$FILE' is present."
else
    wget https://www.tekxit.lol/downloads/tekxit3.14/${VER}TekxitPiServer.zip
    unzip ./${VER}TekxitPiServer.zip
fi
cd ${VER}TekxitPiServer
sed -i 's/Xmx4G/Xmx${MEM}/g' ServerLinux.sh
sed -i 's/Xms4G/Xms${MEM}/g' ServerLinux.sh
chmod +x ServerLinux.sh
./ServerLinux.sh
