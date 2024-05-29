#!/bin/bash

touch /etc/xray/blacklist.json
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
colornow=$(cat /etc/ssnvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1='\033[0;35m'
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
function con() {
local -i bytes=$1;
if [[ $bytes -lt 1024 ]]; then
echo "${bytes}B"
elif [[ $bytes -lt 1048576 ]]; then
echo "$(( (bytes + 1023)/1024 ))KB"
elif [[ $bytes -lt 1073741824 ]]; then
echo "$(( (bytes + 1048575)/1048576 ))MB"
else
echo "$(( (bytes + 1073741823)/1073741824 ))GB"
fi
}
function cekmember (){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • LIST VMESS USER •                      ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • LIST VMESS USER •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " ─────────────────────────────────────────────────"
echo -e "  user  | usage  |   quota  | limit ip | expired"
echo -e " ─────────────────────────────────────────────────"
data=( `cat /etc/xray/config.json | grep '###' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${data[@]}"
do
exp=$(grep -wE "^### $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
iplimit=$(cat /etc/lunatic/limit/vmess/ip/${akun})
byte=$(cat /etc/lunatic/vmess/${akun})
lim=$(con ${byte})
wey=$(cat /etc/lunatic/limit/vmess/${akun})
gb=$(con ${wey})
printf "%-10s %-10s %-10s %-20s\n"  " ${akun}"   " ${gb}" "${lim}" "$iplimit     $exp"
done
echo -e ""
read -n 1 -s -r -p "  • [NOTE] Press any key to back on menu"
m-vme
}
function delvmess(){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
m-vme
else
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/$user/d" /etc/lunatic/vmess/.vmess.db
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • DELETE XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound Delete Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
fi
}
function unlock(){
sed -i 's/ UNLOCKED//g' /etc/lunatic/vmess/.vmess.db
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • UNLOCK XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -rp "   Input Username for unlock: " user
if [ -z $user ]; then
m-vme
else
uuid=$(cat /etc/lunatic/vmess/.vmess.db | grep $user | awk '{print $4}')
exp=$(cat /etc/lunatic/vmess/.vmess.db | grep $user | awk '{print $3}')
if [ -z "$uuid" ]; then
echo "Oh tidak, UUID-mu terhapus."
echo "Membuat UUID baru..."
uuid=$(cat /proc/sys/kernel/random/uuid)
else
echo "UUID tersedia: $uuid"
fi
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • UNLOCKED XRAY USER •          ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound unlocked Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}
function recovery(){
sed -i 's/ UNLOCKED//g' /etc/lunatic/vmess/.vmess.db
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RECOVERY XRAY USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$NC LIST USER EXPIRED"
echo ""
current_date=$(date +%s)
data=( $(grep -E "^### " "/etc/lunatic/vmess/.vmess.db" | cut -d ' ' -f 2 | column -t | sort | uniq ) )
for user in "${data[@]}"
do
expiration_date=$(grep -E "^### " "/etc/lunatic/vmess/.vmess.db" | cut -d ' ' -f 3 | column -t | sort | uniq)
expiration_date=$(echo "$expiration_date" | sed -E 's/Jan/01/;s/Feb/02/;s/Mar/03/;s/Apr/04/;s/May/05/;s/Jun/06/;s/Jul/07/;s/Aug/08/;s/Sep/09/;s/Oct/10/;s/Nov/11/;s/Dec/12/')
expiration_timestamp=$(date -d "$expiration_date" +%s 2>/dev/null)
if [ -n "$expiration_timestamp" ] && [ "$current_date" -le "$expiration_timestamp" ]; then
echo "$user masih aktif"
else
echo "• $user expired"
fi
done
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -rp "   Input Username for recovery: " user
if [ -z $user ]; then
m-vme
else
echo "reset Quota usage"
rm /etc/limit/vmess/$user
uuid=$(cat /etc/lunatic/vmess/.vmess.db | grep $user | awk '{print $4}')
exp=$(cat /etc/lunatic/vmess/.vmess.db | grep $user | awk '{print $3}')
if [ -z "$uuid" ]; then
echo "Oh tidak, UUID-mu terhapus."
sleep 1
echo "Membuat UUID baru..."
uuid=$(cat /proc/sys/kernel/random/uuid)
else
echo "UUID tersedia: $uuid"
fi
sed -i "/$user/d" /etc/lunatic/vmess/.vmess.db
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
echo "### ${user} ${exp} ${uuid}" >>/etc/lunatic/vmess/.vmess.db
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RECOVERY XRAY USER •          ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound recovery Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1│${NC}   • uuid  : $uuid"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
fi
}
function renewvmess(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -rp "Input Username : " user
if [ -z $user ]; then
m-vme
else
read -p "Expired (days): " masaaktif
rm -f /etc/lunatic/limit/vmess/ip/${user}
rm -f /etc/vmess/$user
read -p "Limit User (GB): " Quota
read -p "Limit User (IP): " iplimit
exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
mkdir -p /etc/lunatic/limit/vmess/ip
echo $iplimit > /etc/lunatic/limit/vmess/ip/${user}
if [ ! -e /etc/lunatic/vmess/ ]; then
mkdir -p /etc/lunatic/vmess/
fi
if [ -z ${Quota} ]; then
Quota="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/lunatic/vmess/${user}
fi
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/### $user/c\### $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1│${NC}   "
echo -e "$COLOR1│${NC}   Client Name : $user"
echo -e "$COLOR1│${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1│${NC}   limit ip    : $iplimit ip"
echo -e "$COLOR1│${NC}   limit Quota : $Quota GB"
echo -e "$COLOR1│${NC}   Expired On  : $exp4"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
fi
}
function con() {
local -i bytes=$1;
if [[ $bytes -lt 1024 ]]; then
echo "${bytes}B"
elif [[ $bytes -lt 1048576 ]]; then
echo "$(( (bytes + 1023)/1024 ))KB"
elif [[ $bytes -lt 1073741824 ]]; then
echo "$(( (bytes + 1048575)/1048576 ))MB"
else
echo "$(( (bytes + 1073741823)/1073741824 ))GB"
fi
}
function cekvmess(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '###' | cut -d ' ' -f 2 | sort | uniq`);
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • VMESS USER ONLINE •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e " ────────────────────────────────────────────────"
echo -e "   user  | usage | quota | limit | login | waktu "
echo -e " ────────────────────────────────────────────────"
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvmess.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvmess.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvmess.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvmess.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
iplimit=$(cat /etc/lunatic/limit/vmess/ip/${akun})
jum2=$(cat /tmp/ipvmess.txt | wc -l)
byte=$(cat /etc/vmess/${akun})
lim=$(con ${byte})
wey=$(cat /etc/lunatic/limit/vmess/${akun})
gb=$(con ${wey})
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
printf "  %-13s %-7s %-8s %2s\n"  " ${akun}    ${gb}    ${lim}      $iplimit       $jum2    $lastlogin"
fi
rm -rf /tmp/ipvmess.txt
done
rm -rf /tmp/other.txt
echo ""
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
}
function addvmess(){
source /var/lib/ssnvpn-pro/ipvps.conf
domain=$(cat /etc/xray/domain)
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
read -rp " Input Username : "  user
read -rp " input limit IP :"  iplimit
read -rp " input limit kuota :"  Quota
folder="/etc/lunatic/limit/vmess/ip/"
if [ ! -d "$folder" ]; then
mkdir -p "$folder"
else
echo ""
fi
echo $iplimit > /etc/lunatic/limit/vmess/ip/${user}
if [ -z $user ]; then
echo -e "$COLOR1│${NC} [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "   Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
asu=`cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "443",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "${domain}",
"tls": "tls"
}
EOF`
ask=`cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "80",
"id": "${uuid}",
"aid": "0",
"net": "ws",
"path": "/vmess",
"type": "none",
"host": "${domain}",
"tls": "none"
}
EOF`
grpc=`cat<<EOF
{
"v": "2",
"ps": "${user}",
"add": "${domain}",
"port": "443",
"id": "${uuid}",
"aid": "0",
"net": "grpc",
"path": "vmess-grpc",
"type": "none",
"host": "${domain}",
"tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
if [ ! -e /etc/lunatic/vmess ]; then
mkdir -p /etc/lunatic/vmess
fi
if [ -z ${iplimit} ]; then
iplimit="0"
fi
if [ -z ${Quota} ]; then
Quota="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/lunatic/vmess/${user}
fi
DATADB=$(cat /etc/lunatic/vmess/.vmess.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
sed -i "/\b${user}\b/d" /etc/lunatic/vmess/.vmess.db
fi
echo "### ${user} ${exp} ${uuid}" >>/etc/lunatic/vmess/.vmess.db
clear -x
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat >/home/vps/public_html/vmess-$user.yaml <<-END
- name: Vmess-$user-WS TLS
type: vmess
server: ${domain}
port: 443
uuid: ${uuid}
alterId: 0
cipher: auto
udp: true
tls: true
skip-cert-verify: true
servername: ${domain}
network: ws
ws-opts:
path: /vmess
headers:
Host: ${domain}
- name: Vmess-$user-WS Non TLS
type: vmess
server: ${domain}
port: 80
uuid: ${uuid}
alterId: 0
cipher: auto
udp: true
tls: false
skip-cert-verify: false
servername: ${domain}
network: ws
ws-opts:
path: /vmess
headers:
Host: ${domain}
- name: Vmess-$user-gRPC (SNI)
server: ${domain}
port: 443
type: vmess
uuid: ${uuid}
alterId: 0
cipher: auto
network: grpc
tls: true
servername: ${domain}
skip-cert-verify: true
grpc-opts:
grpc-service-name: vmess-grpc
END
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Remarks       : ${user}"
echo -e "$COLOR1 ${NC} Expired On    : $exp"
echo -e "$COLOR1 ${NC} Domain        : ${domain}"
echo -e "$COLOR1 ${NC} Port TLS      : ${tls}"
echo -e "$COLOR1 ${NC} Port none TLS : ${none}"
echo -e "$COLOR1 ${NC} Port  GRPC    : ${tls}"
echo -e "$COLOR1 ${NC} id            : ${uuid}"
echo -e "$COLOR1 ${NC} Security      : auto"
echo -e "$COLOR1 ${NC} Network       : ws"
echo -e "$COLOR1 ${NC} Limit (GB)    : $Quota GB"
echo -e "$COLOR1 ${NC} Limit (IP)    : $iplimit IP"
echo -e "$COLOR1 ${NC} Path          : /vmess - /whatever"
echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vmess"
echo -e "$COLOR1 ${NC} ServiceName   : vmess-grpc"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Link TLS : "
echo -e "$COLOR1 ${NC} ${vmesslink1}"
echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
echo -e "$COLOR1 ${NC} Link none TLS : "
echo -e "$COLOR1 ${NC} ${vmesslink2}"
echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
echo -e "$COLOR1 ${NC} Link GRPC : "
echo -e "$COLOR1 ${NC} ${vmesslink3}"
echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
echo -e "$COLOR1 ${NC} Config OpenClash : http://${domain}:81/vmess-$user.yaml"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e ""
cat >/tmp/vmess/$user.txt << EOF
-------------------------------------------
Remarks       : ${user}
Expired On    : $exp
Domain        : ${domain}
Port TLS      : ${tls}
Port none TLS : ${none}
id            : ${uuid}
Limit (IP)    : ${iplimit}
Limit (GB)    : $Quota GB
------------------------------------------
Link TLS :
${vmesslink1}
-------------------------------------------
Link none TLS :
${vmesslink2}
-------------------------------------------
Link GRPC :
${vmesslink3}
--------------------------------------------
EOF
read -n 1 -s -r -p "   Press any key to back on menu"
m-vme
}
function cek(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • RESULT VMESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}Notice!! Result akan terhapus otomatis setelah Reboot"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
m-vme
else
cat /tmp/vmess/$user.txt
fi
}

function Trial_Account() {
clear
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m         VMESS TRIAL ACCOUNT          \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Akumulasi masa aktif minimal 1 jam (1=1jam)"
read -p "masukan angka: " hh
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
	user=$Login
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
clear
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\E[0;41;36m         VMESS ACCOUNT          \E[0m"
            echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
      menu
		fi
	done

uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=$hh
exp=`date -d "$masaaktif hours" +"%H:%M:%S"`
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
exp=`date -d "$masaaktif hours" +"%H:%M:%S"`
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

DATADB=$(cat /root/akun/vmess/.vmess.conf | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/vmess/.vmess.conf
fi
echo "### ${user} ${exp} ${uuid}" >>/root/akun/vmess/.vmess.conf

asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1


cat >/home/vps/public_html/vmess-$user.yaml <<-END

# Format Vmess WS TLS

- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS

- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC

- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc


END

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\\E[0;41;36m      TRIAL  XRAY/Vmess Account        \E[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Remarks          : ${user}" | tee -a /root/akun/vmess/$user.txt
echo -e "Domain           : ${domain}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port TLS         : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port none TLS    : ${none}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port  GRPC       : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "id               : ${uuid}" | tee -a /root/akun/vmess/$user.txt
echo -e "alterId          : 0" | tee -a /root/akun/vmess/$user.txt
echo -e "Security         : auto" | tee -a /root/akun/vmess/$user.txt
echo -e "Network          : ws" | tee -a /root/akun/vmess/$user.txt
echo -e "Path             : /Multi-Path" | tee -a /root/akun/vmess/$user.txt
echo -e "Dynamic          : http://bugmu.com/path" | tee -a /root/akun/vmess/$user.txt
echo -e "ServiceName      : vmess-grpc" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link TLS         : ${vmesslink1}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link none TLS    : ${vmesslink2}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link GRPC        : ${vmesslink3}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Format OpenClash : http://${domain}:81/vmess-$user.yaml" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Expired On       : $exp" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo "" | tee -a /root/akun/vmess/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
menu
}


function Ganti_Quota() {
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
y="\033[1;93m"
g="\e[1;92m"
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Quota Vmess       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vme
	fi

clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Quota Vmess       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
  	grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	read -rp "Input Username : " user
if [ -z $user ]; then
echo -e "Input Username Dengan Benar ! "
sleep 2 ; m-vme
else
rm -f /etc/lunatic/vmess/$user
read -p "Limit User (GB): " Quota

if [ ! -e /etc/vmess/ ]; then
  mkdir -p /etc/lunatic/vmess/
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/lunatic/vmess/${user}
fi
systemctl restart xray > /dev/null 2>&1
systemctl restart crons > /dev/null 2>&1
systemctl restart limitvmess > /dev/null 2>&1
clear
load
sleep 2
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${g}Edit Quota Account Vmess Successfully ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo " Username      : $user"
echo " Jumlah Quota  : $Quota"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vme
fi

}


function Ganti_Ip() {
clear
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
y="\033[1;93m"
g="\e[1;92m"
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Limit IP Vmess       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vme
	fi

clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Limit IP Vmess       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
  	grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	read -rp "Input Username : " user
if [ -z $user ]; then
m-vme
else
rm -f /etc/lunatic/limit/vmess/ip/${user}
read -p "Limit User (IP): " iplim
mkdir -p /etc/lunatic/limit/vmess/ip
echo ${iplim} >> /etc/lunatic/limit/vmess/ip/${user}
systemctl restart xray > /dev/null 2>&1
systemctl restart crons > /dev/null 2>&1
systemctl restart vmip > /dev/null 2>&1
clear
load
sleep 2
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${g}Edit Limit IP Account Vmess Successfully ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo " Username    : $user"
echo " Jumlah Limit IP: $iplim"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vme
fi
}




clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          VMESS LIBEV            \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • ADDEDD ACCOUNT    \e[0m"
echo -e "\e[37;1m [02] • RENEWS ACCOUNT    \e[0m"
echo -e "\e[37;1m [03] • DELETE ACCOUNT    \e[0m"
echo -e "\e[37;1m [04] • ONLINE ACCOUNT    \e[0m"
echo -e "\e[37;1m [05] • MEMBER ACCOUNT    \e[0m"
echo -e "\e[37;1m [06] • RIWYAT ACCOUNT    \e[0m"
echo -e "\e[37;1m [07] • UNLOCK ACCOUNT    \e[0m"
echo -e "\e[37;1m [08] • RECOVE ACCOUNT    \e[0m"
echo -e "\e[37;1m [09] • TRIALL ACCOUNT    \e[0m"
echo -e "\e[37;1m [10] • CHANGE QUOTA      \e[0m"
echo -e "\e[37!1m [11] • CHANGE LIMITIP    \e[0m"
echo -e "\e[31;1m [00] • GO BACK           \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;91;1m        LUNATIC TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just Input :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addvmess ;;
02 | 2) clear ; renewvmess ;;
03 | 3) clear ; delvmess ;;
04 | 4) clear ; cekvmess ;;
05 | 5) clear ; cekmember ;;
06 | 6) clear ; cek ;;
07 | 7) clear ; unlock ;;
08 | 8) clear ; recovery ;;
09 | 9) clear ; Trial_Account ;;
10) clear ; Ganti_Quota ;;
11) clear ; Ganti_Ip ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vmess ;;
esac
