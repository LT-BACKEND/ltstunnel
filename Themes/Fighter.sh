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
nobz=$(cat /etc/lunatic/.noobzvpns.db | grep "#nob#" | wc -l)

clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'


export NC='\033[0m'




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

#RAM=$(free -m | awk 'NR==2 {print $2}')
#USAGERAM=$(free -m | awk 'NR==2 {print $3}')
# // color format 38
runn='\e[93;1m' 
acc='\e[38;5;146'
LO='\e[38;5;162m'
UK='\e[38;5;99m'  # UNGU KOLOT
BK='\e[38;5;196m' # BEREM KOLOT 
R1='\e[93;1m' # HEJO SEMU BODAS
R2='\e[38;5;49m'  # HEJO LIME / APEL
BC='\e[38;5;195m' # BODAS CERAH PISAN
HU='\e[38;5;115m' # HEJO SEMU ABU
UB='\e[38;5;147m' # UNGU KABODASAN
KT='\e[93;1m' # KONENG TARIGU
Suffix='\e[0m'



# // Others Managger 
function Others_Managers() {
clear
clear
echo -e "\e[0;93m ┌━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┐\e[0m"
echo -e "\e[0;93m │ \e[92;1m   .::.  SYSTEM SETTINGS  .::.     \e[0m"
echo -e "\e[0;93m └━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┘\e[0m"
echo -e "\e[0;93m ┌━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┐\033[0m"
echo -e "\e[0;93m │ \e[92;1m[01] • \e[0;36mCHANGES DOMAIN   \e[0m"
echo -e "\e[0;93m │ \e[92;1m[02] • \e[0;36mRENEW CERT HOST \e[0m"
echo -e "\e[0;93m │ \e[92;1m[03] • \e[0;36mFREE DOMAIN DNS  \e[0m"
echo -e "\e[0;93m │ \e[92;1m[04] • \e[0;36mCHECK SPEEDTEST   \e[0m"
echo -e "\e[0;93m │ \e[92;1m[05] • \e[0;36mKILL ALL PROCES  \e[0m"
echo -e "\e[0;93m │ \e[92;1m[06] • \e[0;36mCLEAR ALL LOGG  \e[0m"
echo -e "\e[0;93m │ \e[92;1m[07] • \e[0;36mAUTOREBOOT VPS \e[0m"
echo -e "\e[0;93m │ \e[92;1m[08] • \e[0;36mCHANGE BANNER   \e[0m"
echo -e "\e[0;93m │ \e[92;1m[09] • \e[0;36mAUTO KILL MULOG  \e[0m"
echo -e "\e[0;93m │ \e[92;1m[10] • \e[0;36mLIMIT SPEED VPS \e[0m"
echo -e "\e[0;93m │ \e[92;1m[11] • \e[0;36mINSTALER WEBMIN \e[0m"
echo -e "\e[0;93m │ \e[92;1m[12] • \e[0;36mFIXX NGINX EROR \e[0m"
echo -e "\e[0;93m │ \e[92;1m[13] • \e[0;36mADD CLOUDFRONT \e[0m"
echo -e "\e[0;93m │ \e[92;1m[14] • \e[0;36mUPDATE.SC\e[0m"
echo -e "\e[0;93m │ \e[92;1m[15] • \e[0;36mRUNNING SERVICE \e[0m"
echo -e "\e[0;93m │ \e[92;1m[16] • \e[0;36mRESTART SERVICE \e[0m"
echo -e "\e[0;93m │ \e[92;1m[17] • \e[0;36mRESTART UDP \e[0m"
echo -e "\e[0;93m │ \e[92;1m[18] • \e[0;36mCHECK BANDWITH \e[0m"
echo -e "\e[0;93m │ \e[92;1m[19] • \e[0;36mCHANGE THEMES MENU \e[0m"
echo -e "\e[0;93m │ \e[92;1m[20] • \e[0;36mABOUT \e[0m"
echo -e "\e[0;91m │ \e[91;1m[00] • \e[0;31mGO BACK    \e[0m"
echo -e "\e[0;93m └━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┘\033[0m"
read -p " Just Input :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addhost ;;
02 | 2) clear ; genssl ;;
03 | 3) clear ; fix ;;
04 | 4) clear ; speedtest ;;
05 | 5) clear ; killall /bin/bash /usr/bin/menu ;;
06 | 6) clear ; clearlog ;;
07 | 7) clear ; autoreboot ;;
08 | 8) clear ; nano /etc/cyber.site ;;
09 | 9) clear ; autokill ;;
10) clear ; limit-speed ;;
11) clear ; wbm ;;
12) clear ; genssl ;;
13) clear ; cftn ;;
14) clear ; m-upd ;;
15) clear ; running ;;
16) clear ; restart ;;
17) clear ; ins-udp ;;
18) clear ; bw ;;
19) clear ; m-tme;;
20) clear ; about ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
}



clear
echo -e "   \e[93;1m──────────────────────────────────────\e[0m"
echo -e "   \e[93;1m .::::.  ÷ LUNATIC TUNNELING ÷  .::::.\e[0m"
echo -e "   \e[93;1m──────────────────────────────────────\e[0m"
echo -e "       \e[93;1m┌───────────────────────────┐\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m SYS OS :\e[0;36m $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m RAM :\e[0;36m $(free -m | awk 'NR==2 {print $2}')MB/$(free -m | awk 'NR==2 {print $3}') MB\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m UP :\e[0;36m $(uptime -p | cut -d " " -f 2-10000)e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m CORE :\e[0;36m $(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)") CPU\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m ISP :\e[0;36m $(curl -s ipinfo.io/org | cut -d " " -f 2-10 )\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m IP :\e[0;36m $(wget -qO- ipinfo.io/ip)\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m DOMAIN :\e[0;36m $( cat /etc/xray/domain )\e[0m"
echo -e "       \e[93;1m│\e[0m\e[38;5;196m NS :\e[0;36m $(cat /root/nsdomain)\e[0m"
echo -e "       \e[93;1m└───────────────────────────┘\e[0m"
echo -e "     \e[93;1m┌────────────────────────────────┐\e[0m"
echo -e "     \e[93;1m│\e[0m\e[37;1m ID :\e[0m\e[92;1m $Name\e[0m"
echo -e "     \e[93;1m│\e[0m\e[37;1m Exp.sc :\e[0m\e[92;1m $(((d1 - d2) / 86400)) Day.Left\e[0m"
echo -e "     \e[93;1m└────────────────────────────────┘\e[0m"
echo -e " \e[0;92m         SSH OVPN: $ssh1  VMESS: $vma NOBZ: $nobz\e[0m"
echo -e " \e[0;92m       VLESS: $vla TROJAN: $trb SHADWSK: $ssa \e[0m"
echo -e "  \e[93;1m┌──────────────────────────────────────┐\e[0m"
echo -e "  \e[93;1m│\e[0m\e[92;1m  1.\e[0m\e[0;36mSSHVN MANAGER\e[0m   \e[92;1m 5.\e[0m\e[0;36mNOOBZV MANAGER\e[0m"
echo -e "  \e[93;1m│\e[0m\e[92;1m  2.\e[0m\e[0;36mVMESS MANAGER\e[0m   \e[92;1m 6.\e[0m\e[0;36mSHDWSK MANAGER\e[0m"
echo -e "  \e[93;1m│\e[0m\e[92;1m  3.\e[0m\e[0;36mVLESS MANAGER\e[0m   \e[92;1m 7.\e[0m\e[0;36mIPSECK MANAGER\e[0m"
echo -e "  \e[93;1m│\e[0m\e[92;1m  4.\e[0m\e[0;36mTRJAN MANAGER\e[0m   \e[92;1m 8.\e[0m\e[0;36mOTHERS SETTING\e[0m"
echo -e "  \e[93;1m└──────────────────────────────────────┘\e[0m"
echo -e "             \e[92;1m Version : 7.0.0 \e[0m"
echo -e "           \e[0;35━━━\e[0m\e[0;32m━━━\e[0m\e[0;37m━━━\e[0m\e[0;32m━━━\e[0m\e[0;31m━━━\e[0m\e[0;33m━━━\e[0m\e[0;34m━━━\e[0m\e[0;36m━━\e[0m"
echo -e ""
read -p "      Select From Options [ 1 - 8 ] : " opt
case $opt in
1) clear ; m-ssh ;;
2) clear ; m-vme ;;
3) clear ; m-vle ;;
4) clear ; m-tro ;; 
5) clear ; m-nob ;;
6) clear ; m-ssr ;;
7) clear ; m-ipc ;;
8) clear ; Others_Managers ;;
*) exit ;;
esac
