#!/bin/bash
# =========================================
clear
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2

nob=$(noobzvpns --info-all-user | grep -i "username" | wc -l)
noob=$(cat /etc/noobzvpns/.noobzvpns.db | grep "#nob#" | wc -l)

clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
#export RED='\033[0;31m'
#export GREEN='\033[0;36m'
#export YELLOW='\033[0;33m'
#export BLUE='\033[0;34m'
#export PURPLE='\033[0;35m'
#export CYAN='\033[0;35m'
#export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
#export EROR="[${RED} EROR \e[0m]"
#export INFO="[\e[34;1m INFO \e[0m]"
#export OKEY="[\e[34;1m OKEY \e[0m]"
#export PENDING="[\e[34;1m PENDING \e[0m]"
#export SEND="[\e[34;1m SEND \e[0m]"
#export RECEIVE="[\e[34;1m RECEIVE \e[0m]"

# // Export Align
#export BOLD="\e[1m"
#export WARNING="${RED}\e[5m"
#export UNDERLINE="\e[4m"

# // Exporting URL Host
#export Server_URL="autosc.me/aio"
#export Server_Port="443"
#export Server_IP="underfined"
#export Script_Mode="Stable"
#export Auther="XdrgVPN"
# Getting
#echo "sedang memverifkasi"
MYIP=$(wget -qO- ipinfo.io/ip);
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
echo -e ""
clear
    else
echo -e "\e[31manda di tolak!\e[0m"
    exit 
fi
}

if [ ! -e /tmp/trojan ]; then
  mkdir -p /tmp/trojan
fi

if [ ! -e /tmp/vmess ]; then
  mkdir -p /tmp/vmess
fi

if [ ! -e /tmp/vless ]; then
  mkdir -p /tmp/vless
fi

IZIN=$(curl -sS https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
#echo "status akun masih aktif"
CEKEXPIRED 
else
echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m"
exit 0
fi
# status
#rm -rf /root/status
#wget -q -O /root/status "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/statushariini" 
clear
today=`date -d "0 days" +"%Y-%m-%d"`
Exp2=$(curl -sS https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
if [ "$Exp2" == "lifetime" ]; then
    Exp2="2099-12-09"
fi
# CERTIFICATE STATUS
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
left=$(((d1 - d2) / 86400))


 
#rm cybervpn.zip
#rm -rf cybervpn.zip

datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 \e[0m Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}

systemctl restart fail2ban

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi
#tomem="$(free | awk '{print $2}' | head -2 | tail -n 1 )"
#usmem="$(free | awk '{print $3}' | head -2 | tail -n 1 )"
#cpu1="$(mpstat | awk '{print $4}' | head -4 |tail -n 1)"
#cpu2="$(mpstat | awk '{print $6}' | head -4 |tail -n 1)"

#update
#wget -q -O updatsc.sh "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/menu/updateyes.sh" && chmod +x updatsc.sh && ./updatsc.sh 

# // Exporting IP Address
export MYIP=$( curl -s https://ipinfo.io/ip/ )
Name=$(curl -sS https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | grep $MYIP | awk '{print $2}')
Exp=$(curl -sS https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
clear
# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="\e[92;1mONLINE\e[0m"
else
    status_nginx="\e[91;1mOFLINE\e[0m"
fi
# // 
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="\e[92;1mONLINE\e[0m"
else
    status_xray="\e[91;1mOFLINE\e[0m"
fi

# // SSH Websocket Proxy
ssh=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_ssh="\e[92;1mONLINE\e[0m"
else
    status_ssh="\e[91;1mOFLINE\e[0m"
fi

## // ddos
dos=$( systemctl status ddos | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $dos == "running" ]]; then
    status_dos="\e[37;1m[\e[92;1mACTIVATED\e[37;1m]\e[0m"
else
    status_dos="\e[91;1mOFLINE\e[0m"
fi


## // fail2ban
fail2ban=$( systemctl status fail2ban | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $fail2ban == "running" ]]; then
    status_fail2ban="\e[92;1mONLINE\e[0m"
else
    status_fail2ban="\e[91;1mOFLINE\e[0m"
fi


## // net
netfilter=$( systemctl status netfilter-persistent | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $netfilter == "exited" ]]; then
    status_net="\e[92;1mONLINE\e[0m"
else
    status_net="\e[91;1mOFLINE\e[0m"
fi
#ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
#tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
#bot
runn='\e[38;5;187m' 
acc='\e[38;5;146m'
LO='\e[38;5;162m'
UK='\e[38;5;99m'  # UNGU KOLOT
BK='\e[38;5;196m' # BEREM KOLOT 
R1='\e[38;5;155m' # HEJO SEMU BODAS
R2='\e[38;5;49m'  # HEJO LIME / APEL
BC='\e[38;5;195m' # BODAS CERAH PISAN
HU='\e[38;5;115m' # HEJO SEMU ABU
UB='\e[38;5;147m' # UNGU KABODASAN
KT='\e[38;5;187m' # KONENG TARIGU
Suffix='\e[0m'


function Lunatic_Banner() {
clear
echo -e "\e[38;5;162m┌─────────────────────────────────────────────────┐\033[0m "
echo -e "\e[38;5;162m│\e[0m \033[41;97;1m                LUNATIC TUNNELING              \033[0m \e[38;5;162m│\e[0m"
echo -e "\e[38;5;162m└─────────────────────────────────────────────────┘\033[0m "
}


function Service_System_Operating() {
echo -e "\e[38;5;162m┌─────────────────────────────────────────────────┐\033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m SYSTEM          : \e[0;36m$(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g')     \033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m RAM             : \e[0;36m$(free -m | awk 'NR==2 {print $2}')    \033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m UPTIME          : \e[0;36m$(uptime -p | cut -d " " -f 2-10)\033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m IP VPS          : \e[0;36m$(curl -s ipv4.icanhazip.com)     \033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m ISP             : \e[0;36m$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )    \033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m DOMAIN          : \e[0;36m$(cat /etc/xray/domain)    \033[0m "
echo -e "\e[38;5;162m│\e[38;5;196m NS DOMAIN       : \e[0;36m$(cat /root/nsdomain) \e[0m"
echo -e "\e[38;5;162m└─────────────────────────────────────────────────┘\033[0m"

}



function Service_Status() {
echo -e "\e[38;5;162m┌─────────────────────────────────────────────────┐\033[0m "
echo -e "\e[38;5;162m|\033[0m\033[0;36m SSH \033[0m  $status_ssh  \e[38;5;162m|\e[0;36m NGINX  \e[0m $status_nginx  \e[38;5;162m|\033[0;36m XRAY  \033[0m $status_xray \e[38;5;162m|\e[0m"
echo -e "\e[38;5;162m└─────────────────────────────────────────────────┘\033[0m "
}


function Detect_Account() {
echo -e "               \e[4:37;1mTOTAL OF ALL ACCOUNTS\e[0m"
echo -e " \e[0;36m     SSH OVPN: $ssh1 \e[0;36mVLESS: $vla \e[0;36mVMESS: $vma \e[0;36mTROJAN: $tra \e[0m"
echo -e "         \e[0;36m  SHADOWSOCK: $ssa \e[0;36m NOOBZVPNS: $noob \e[0m"        
}



function Details_Clients_Name() {
echo -e "\e[38;5;162m   ┌───────────────────────────────────────────┐\033[0m "
echo -e "\e[38;5;162m   │\e[37;1m ID : \033[0m\e[32;1m$Name      \033[0m "
echo -e "\e[38;5;162m   │\e[37;1m Exp.Sc : \033[0m\e[32;1m$(((d1 - d2) / 86400)) Day.Left \033[0m "
echo -e "\e[38;5;162m   └───────────────────────────────────────────┘\033[0m "
}



function Acces_Use_Command() {
echo -e "\e[38;5;162m ————————————————————————————————————————————————— \033[0m "
echo -e "\e[38;5;162m             \e[37;1macces use \033[93;1m☞\033[0m \033[92;1mmenu\033[0m \e[37;1m command \033[0m " 
echo -e "\e[38;5;162m ————————————————————————————————————————————————— \033[0m "
}



Lunatic_Banner
Service_System_Operating
Service_Status
Detect_Account
Details_Clients_Name
Acces_Use_Command