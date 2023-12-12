cd /minecraft/tekxit
FILE="vercheck/${VER}"
if [ -f "$FILE" ]; then
    echo "The file '$FILE' is present."
else
    rm -r vercheck
    cd /minecraft
    wget https://www.tekxit.lol/downloads/tekxit3.14/${VER}TekxitPiServer.zip
    unzip ./${VER}TekxitPiServer.zip
    cd ${VER}TekxitPiServer
    mkdir vercheck && touch vercheck/${VER}
    mv -f * /minecraft/tekxit/
fi

cd /minecraft/tekxit
sed -i "s/-Xmx[0-9]\+[A-Za-z]/-Xmx$MEM/" ServerLinux.sh
sed -i "s/-Xms[0-9]\+[A-Za-z]/-Xms$MEM/" ServerLinux.sh
echo "$VER"
echo "$MEM"
cat ServerLinux.sh

chmod +x ServerLinux.sh