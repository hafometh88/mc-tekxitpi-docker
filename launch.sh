FILE="vercheck/${VER}"
if [ -f "$FILE" ]; then
    echo "The file '$FILE' is present."
else
    rm -r vercheck
    cp -R /tekxit-server/* /data/
    mkdir vercheck && touch vercheck/${VER}
    
fi

sed -i "s/-Xmx[0-9]\+[A-Za-z]/-Xmx$MEM/" ServerLinux.sh
sed -i "s/-Xms[0-9]\+[A-Za-z]/-Xms$MEM/" ServerLinux.sh

chmod +x ServerLinux.sh
./ServerLinux.sh