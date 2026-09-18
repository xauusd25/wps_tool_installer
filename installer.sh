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