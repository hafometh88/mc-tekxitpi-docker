#!/bin/bash
set -euo pipefail

MC_DIR="/minecraft"
VERSION_FILE="${MC_DIR}/vercheck/version"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

get_latest_version() {
    local latest_ver
    latest_ver=$(wget --timeout=15 -qO- https://www.tekxit.lol/ | grep -oP 'Server 1\.0\.[0-9]+' | head -n1 | cut -d' ' -f2)

    if [ -z "$latest_ver" ]; then
        log "Warning: Could not fetch latest version from website, using fallback version."
        latest_ver="1.0.980"  # FALLBACK_VERSION: Update this when new versions are released
    fi

    echo "$latest_ver"
}

verify_server_files() {
    if [ ! -f "${MC_DIR}/ServerLinux.sh" ]; then
        log "Server files missing."
        return 1
    fi
    return 0
}

download_server() {
    local version=$1
    local TmpDir
    TmpDir=$(mktemp -d)
    cd "${TmpDir}"

    log "Downloading TekxitPi server version ${version}..."
    wget -q --show-progress "https://www.tekxit.lol/downloads/tekxit3.14/${version}TekxitPiServer.zip"

    log "Extracting server files..."
    unzip -q "${version}TekxitPiServer.zip"

    log "Moving files to server directory..."
    mv -f "${version}TekxitPiServer"/* "${MC_DIR}/"

    log "Creating version marker..."
    mkdir -p "$(dirname "${VERSION_FILE}")"
    echo "${version}" > "${VERSION_FILE}"

    log "Cleaning up temporary directory..."
    cd /
    rm -rf "${TmpDir}"
}

# Main
if [ "${VER}" = "latest" ]; then
    DETECTED_VER=$(get_latest_version)
    log "Latest version detected: ${DETECTED_VER}"
else
    DETECTED_VER="${VER}"
fi

CURRENT_VERSION=""
if [ -f "${VERSION_FILE}" ]; then
    CURRENT_VERSION=$(cat "${VERSION_FILE}")
fi

log "Required Version: ${DETECTED_VER}"
log "Installed Version: ${CURRENT_VERSION}"

cd "${MC_DIR}"

if [ "${CURRENT_VERSION}" != "${DETECTED_VER}" ] || ! verify_server_files; then
    log "Server files not found or version mismatch. Starting installation..."
    download_server "${DETECTED_VER}"
else
    log "Server files found and version matches. Skipping download."
fi

log "Configuring memory settings..."
sed -i "s/-Xmx[0-9]\+[A-Za-z]/-Xmx${MEM}/" ServerLinux.sh
sed -i "s/-Xms[0-9]\+[A-Za-z]/-Xms${MEM}/" ServerLinux.sh

log "Starting server..."
chmod +x ServerLinux.sh

mkfifo /tmp/minecraft_stdin
cat /tmp/minecraft_stdin | ./ServerLinux.sh &
SERVER_PID=$!

graceful_shutdown() {
    log "Caught stop signal, sending 'stop' to Minecraft server..."
    if ps -p $SERVER_PID > /dev/null; then
        echo "stop" > /tmp/minecraft_stdin
        wait $SERVER_PID
    fi
    log "Server stopped gracefully."
    exit 0
}

trap graceful_shutdown SIGTERM SIGINT

wait $SERVER_PID