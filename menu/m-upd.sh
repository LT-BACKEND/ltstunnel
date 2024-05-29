#!/bin/bash
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
clear
echo -e "   \e[41;97;1mUPDATE SCRIPT NEW VERSION\e[0m"
echo -e ""
# // Delete data Lama
cd /usr/bin
rm -rf menu
rm -rf dashboard
rm -rf m-bkp
rm -rf m-ssh
rm -rf m-tro
rm -rf m-vle
rm -rf m-vme
rm -rf m-nob
rm -rf m-ssr
rm -rf m-ipc
rm -rf m-udp
rm -rf m-ftr
rm -rf m-ftr
rm -rf m-upd
rm -rf m-bot
rm -rf m-tme
rm -rf m-tri
# // Delete File System
rm -rf restart
rm -rf running
rm -rf about
# // Download Data Baru
# //  Ui menu & Dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/dashboard.sh" && chmod +x /usr/bin/dashboard
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/menu.sh" && chmod +x /usr/bin/menu
# // Menu
wget -q -O /usr/bin/m-tme "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-tme.sh" && chmod +x /usr/bin/m-tme
wget -q -O /usr/bin/m-ssh "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-ssh.sh" &&  chmod +x /usr/bin/m-ssh
wget -q -O /usr/bin/m-tro "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-tro.sh" && chmod +x /usr/bin/m-tro
wget -q -O /usr/bin/m-bkp "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-bkp.sh" && chmod +x /usr/bin/m-bkp
wget -q -O /usr/bin/m-vle "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-vle.sh" && chmod +x /usr/bin/m-vle
wget -q -O /usr/bin/m-vme "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-vme.sh" && chmod +x /usr/bin/m-vme
wget -q -O /usr/bin/m-ssr "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-ssr.sh" && chmod +x /usr/bin/m-ssr
wget -q -O /usr/bin/m-nob "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-nob.sh" && chmod +x /usr/bin/m-nob
wget -q -O /usr/bin/m-tri "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-tri.sh" && chmod +x /usr/bin/m-tri
wget -q -O /usr/bin/m-ipc "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-ipc.sh" && chmod +x /usr/bin/m-ipc
wget -q -O /usr/bin/m-ftr "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-ftr.sh" && chmod +x /usr/bin/m-ftr
wget -q -O /usr/bin/m-ftr "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-ftr.sh" && chmod +x /usr/bin/m-ftr
wget -q -O /usr/bin/m-upd "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-upd.sh" && chmod +x /usr/bin/m-upd
wget -q -O /usr/bin/m-udp "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-udp.sh" && chmod +x /usr/bin/m-udp
wget -q -O /usr/bin/m-bot "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/menu/m-bot.sh" && chmod +x /usr/bin/m-bot
# // Repo system
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/system/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/system/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/about "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/system/about.sh" &&  chmod +x /usr/bin/about
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/LT-BACKEND/ltstunnel/main/system/running.sh" && chmod +x /usr/bin/running

clear
echo -e "\e[32;1mSuccessfully\e[0m"
sleep 2
clear
dashboard
