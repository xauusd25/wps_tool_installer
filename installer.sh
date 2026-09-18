#!/data/data/com.termux/files/usr/bin/bash

set -e

R='\033[0;31m'
G='\033[0;32m'
N='\033[0m'

TOTAL_STEPS=10
STEP=0

run_step() {
    STEP=$((STEP + 1))
    local msg="$1" cmd="$2" output

    printf "[%d/%d] %s... " "$STEP" "$TOTAL_STEPS" "$msg"

    if output=$(bash -c "$cmd" 2>&1); then
        echo -e "${G}✔${N}"
    else
        echo -e "${R}✘${N}"
        echo -e "${R}Error occurred during: $msg${N}"
        echo "$output"
        exit 1
    fi
}

echo

arch=$(dpkg --print-architecture)
if [[ "$arch" != "aarch64" && "$arch" != "arm" ]]; then
    echo "MiTool does not support architecture $arch"
    exit 1
fi

if [ ! -d "$HOME/storage" ]; then
    echo -e "\nGrant permission: termux-setup-storage\nThen rerun the command.\n"
    exit 1
fi

if ! cmd package list packages --user 0 com.termux.api < /dev/null 2>/dev/null | grep -q 'com.termux.api'; then
    echo -e "\ncom.termux.api app is not installed\nPlease install it first\n"
    exit 1
fi

run_step "Updating system & fixing broken packages" \
    "yes | apt --fix-broken install && yes | apt update && yes | apt upgrade"

run_step "Installing Root-Repo" \
    "yes | pkg install root-repo"

run_step "Installing git" \
    "yes | pkg install git"

run_step "Installing sudo" \
    "yes | pkg install sudo"

run_step "Installing python" \
    "yes | pkg install python"

run_step "Installing wpa-supplicant" \
    "yes | pkg install wpa-supplicant"

run_step "Installing pixiewps" \
    "yes | pkg install pixiewps"

run_step "Installing iw" \
    "yes | pkg install iw"

run_step "Installing wps_hack" \
    "git clone https://github.com/xauusd25/wps_hack.git"

run_step "Installing wps_hack" \
    "python wps_hack/wtf.py --help"
