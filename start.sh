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

sed -i "s/-Xmx[0-9]\+[A-Za-z]/-Xmx$MEM/" ServerLinux.sh
sed -i "s/-Xms[0-9]\+[A-Za-z]/-Xms$MEM/" ServerLinux.sh
echo "Version used: $VER"
echo "Memory set: $MEM"
cat ServerLinux.sh

chmod +x ServerLinux.sh
./ServerLinux.sh