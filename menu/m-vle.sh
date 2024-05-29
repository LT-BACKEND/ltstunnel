#!/bin/bash

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')biji=`date +"%Y-%m-%d" -d "$dateFromServer"`         colornow=$(cat /etc/ssnvpn/theme/color.conf)         NC="\e[0m"                                           RED="\033[0;31m"                                     COLOR1='\033[0;35m'
BURIQ () {                                           curl -sS  https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS > /root/tmp
data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
d1=(`date -d "$exp" +%s`)
d2=(`date -d "$biji" +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo $user > /etc/.$user.ini
else
rm -f /etc/.$user.ini > /dev/null 2>&1
fi
done
rm -f /root/tmp
}
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS  https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)
Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
if [ "$CekOne" = "$CekTwo" ]; then
res="Expired"
fi
else
res="Permission Accepted..."
fi
}
PERMISSION () {
MYIP=$(curl -sS ipv4.icanhazip.com)
IZIN=$(curl -sS  https://raw.githubusercontent.com/LT-BACKEND/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
Bloman
else
res="Permission Denied!"
fi
BURIQ
}
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
function cekvless(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '#&' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • ONLINE VLESS USER •              ${NC} $COLOR1│$NC"
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
echo -n > /tmp/ipvless.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
iplimit=$(cat /etc/cybervpn/limit/vless/ip/${akun})
jum2=$(cat /tmp/ipvless.txt | wc -l)
byte=$(cat /etc/vless/${akun})
lim=$(con ${byte})
wey=$(cat /etc/limit/vless/${akun})
gb=$(con ${wey})
lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
printf "  %-13s %-7s %-8s %2s\n"  " ${akun}     ${gb}    ${lim}      $iplimit       $jum2    $lastlogin"
fi
rm -rf /tmp/ipvless.txt
done
rm -rf /tmp/other.txt
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}
function renewvless(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1│${NC}  • You have no existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo -e ""
read -rp "Input Username : " user
if [ -z $user ]; then
menu
else
rm -f /etc/cybervpn/limit/vless/ip/${user}
rm -f /etc/vless/$user
read -p "Expired (days): " masaaktif
read -p "Limit User (GB): " Quota
read -p "Limit User (IP): " iplim
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
mkdir -p /etc/cybervpn/limit/vless/ip
echo $iplim > /etc/cybervpn/limit/vless/ip/${user}
if [ ! -e /etc/vless/ ]; then
mkdir -p /etc/vless/
fi
if [ -z ${Quota} ]; then
Quota="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vless/${user}
fi
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#& $user/c\#& $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RENEW VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   [INFO]  $user Account Renewed Successfully"
echo -e "$COLOR1│${NC}   "
echo -e "$COLOR1│${NC}   Client Name : $user"
echo -e "$COLOR1│${NC}   limit IP    : $iplim"
echo -e "$COLOR1│${NC}   limit quota : $Quota"
echo -e "$COLOR1│${NC}   Days Added  : $masaaktif Days"
echo -e "$COLOR1│${NC}   Expired On  : $exp4"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
}
function delvless(){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
sed -i "/$user/d" /etc/lunatic/vless/.vless.db
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • DELETE VLESS USE •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound Delete Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
}
function unlock(){
sed -i 's/ UNLOCKED//g' /etc/lunatic/vless/.vless.db
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • UNLOCK VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
read -rp "   Input Username for unlock: " user
if [ -z $user ]; then
menu-vless
else
uuid=$(cat /etc/lunatic/vless/.vless.db | grep $user | awk '{print $4}')
exp=$(cat /etc/lunatic/vless/.vless.db | grep $user | awk '{print $3}')
if [ -z "$uuid" ]; then
echo "Oh tidak, UUID-mu terhapus."
echo "Membuat UUID baru..."
uuid=$(cat /proc/sys/kernel/random/uuid)
else
echo "UUID tersedia: $uuid"
fi
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • UNLOCKED VLESS USER •          ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}   • Accound unlocked Successfully"
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}   • Client Name : $user"
echo -e "$COLOR1│${NC}   • Expired On  : $exp"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-trojan
fi
}
function recovery(){
sed -i 's/ UNLOCKED//g' /etc/lunatic/vless/.vless.db
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RECOVERY VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$NC LIST USER EXPIRED"
echo ""
current_date=$(date +%s)
data=( $(grep -E "^#& " "/etc/lunatic/vless/.vless.db" | cut -d ' ' -f 2 | column -t | sort | uniq ) )
for user in "${data[@]}"
do
expiration_date=$(grep -E "^#& " "/etc/lunatic/vless/.vless.db" | cut -d ' ' -f 3 | column -t | sort | uniq)
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
menu-vless
else
echo "reset Quota usage"
rm /etc/limit/vless/$user
uuid=$(cat /etc/lunatic/vless/.vless.db | grep $user | awk '{print $4}')
exp=$(cat /etc/lunatic/vless/.vless.db | grep $user | awk '{print $3}')
if [ -z "$uuid" ]; then
echo "Oh tidak, UUID-mu terhapus."
sleep 1
echo "Membuat UUID baru..."
uuid=$(cat /proc/sys/kernel/random/uuid)
else
echo "UUID tersedia: $uuid"
fi
sed -i "/$user/d" /etc/lunatic/vless/.vless.db
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
echo "#& ${user} ${exp} ${uuid}" >>/etc/lunatic/vless/.vless.db
systemctl restart xray > /dev/null 2>&1
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • RECOVERY VLESS USER •          ${NC} $COLOR1│$NC"
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
menu-vless
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
function cekmember (){
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}             • LIST XRAY USER •                      ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC}  • You Dont have any existing clients!"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo 
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • LIST XRAY USER •                 ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e " ─────────────────────────────────────────────────"
echo -e "  user  | usage  |   quota  | limit ip | expired"
echo -e " ─────────────────────────────────────────────────"
data=( `cat /etc/xray/config.json | grep '#&' | cut -d ' ' -f 2 | sort | uniq`);
for akun in "${data[@]}"
do
exp=$(grep -wE "^#& $akun" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
iplimit=$(cat /etc/cybervpn/limit/vless/ip/${akun})
byte=$(cat /etc/vless/${akun})
lim=$(con ${byte})
wey=$(cat /etc/limit/vless/${akun})
gb=$(con ${wey})
printf "%-10s %-10s %-10s %-20s\n"  " ${akun}"   " ${gb}" "${lim}" "$iplimit     $exp"
done
echo -e ""
read -n 1 -s -r -p "  • [NOTE] Press any key to back on menu"
menu-vless
}
function addvless(){
domain=$(cat /etc/xray/domain)
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
read -rp "  Input Username : " -e user
if [ -z $user ]; then
echo -e "$COLOR1│${NC} [Error] Username cannot be empty "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)
if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo -e "$COLOR1│${NC} Please choose another name."
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "  Expired (days): " masaaktif
read -p "  Limit Quota (GB):" Quota
read -p "  Limit ip:" iplim
folder="/etc/cybervpn/limit/vless/ip/"
if [ ! -d "$folder" ]; then
mkdir -p "$folder"
else
echo ""
fi
echo $iplim > /etc/cybervpn/limit/vless/ip/${user}
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
if [ ! -e /etc/vless ]; then
mkdir -p /etc/vless
fi
if [ -z ${iplim} ]; then
iplim="0"
fi
if [ -z ${Quota} ]; then
Quota="0"
fi
c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
echo "${d}" >/etc/vless/${user}
fi
DATADB=$(cat /etc/lunatic/vless/.vless.db | grep "^#&" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
sed -i "/\b${user}\b/d" /etc/lunatic/vless/.vless.db
fi
echo "#& ${user} ${exp} ${uuid}" >>/etc/lunatic/vless/.vless.db
cat >/home/vps/public_html/vless-$user.yaml <<-END
- name: Vless-$user-WS TLS
server: ${domain}
port: 443
type: vless
uuid: ${uuid}
cipher: auto
tls: true
skip-cert-verify: true
servername: ${domain}
network: ws
ws-opts:
path: /vless
headers:
Host: ${domain}
- name: Vless-$user-WS (CDN) Non TLS
server: ${domain}
port: 80
type: vless
uuid: ${uuid}
cipher: auto
tls: false
skip-cert-verify: false
servername: ${domain}
network: ws
ws-opts:
path: /vless
headers:
Host: ${domain}
udp: true
- name: Vless-$user-gRPC (SNI)
server: ${domain}
port: 443
type: vless
uuid: ${uuid}
cipher: auto
tls: true
skip-cert-verify: true
servername: ${domain}
network: grpc
grpc-opts:
grpc-mode: gun
grpc-service-name: vless-grpc
udp: true
END
systemctl restart xray
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}            • CREATE VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Remarks       : ${user}"
echo -e "$COLOR1 ${NC} Expired On    : $exp"
echo -e "$COLOR1 ${NC} Domain        : ${domain}"
echo -e "$COLOR1 ${NC} port TLS      : $tls"
echo -e "$COLOR1 ${NC} port none TLS : $none"
echo -e "$COLOR1 ${NC} id            : ${uuid}"
echo -e "$COLOR1 ${NC} limit  Quota  : $Quota GB"
echo -e "$COLOR1 ${NC} limit  ip     : $iplim IP"
echo -e "$COLOR1 ${NC} Network       : ws"
echo -e "$COLOR1 ${NC} Path          : /vless"
echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vless"
echo -e "$COLOR1 ${NC} Path          : vless-grpc"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} Link TLS :"
echo -e "$COLOR1 ${NC} ${vlesslink1}"
echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$ ${NC}"
echo -e "$COLOR1 ${NC} Link none TLS : "
echo -e "$COLOR1 ${NC} ${vlesslink2}"
echo -e "$COLOR1  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$${NC}"
echo -e "$COLOR1 ${NC} Link GRPC : "
echo -e "$COLOR1 ${NC} ${vlesslink3}"
echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
echo -e "Format OpenClash : http://${domain}:81/vless-$user.yaml"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
cat >/tmp/vless/$user.txt << EOF
-------------------------------------------
Remarks       : ${user}
Expired On    : $exp
Domain        : ${domain}
Port TLS      : ${tls}
Port none TLS : ${none}
id            : ${uuid}
Limit (GB)    : $Quota GB
------------------------------------------
Link TLS :
${vlesslink1}
-------------------------------------------
Link none TLS :
${vlesslink2}
-------------------------------------------
Link GRPC :
${vlesslink3}
--------------------------------------------
EOF
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}
function cek(){
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}           • RESULT VLESS USER •              ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e "$COLOR1│${NC}"
echo -e "$COLOR1│${NC}Notice!! Result akan terhapus otomatis setelah Reboot"
echo -e "$COLOR1│${NC}  • [NOTE] Press any key to back on menu "
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1───────────────────────────────────────────────────${NC}"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
cat /tmp/vless/$user.txt
fi
}



function Trial_Account() {
clear
domain=$(cat /etc/xray/domain)
clear
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\E[0;41;36m            TRIAL VLESS ACCOUNT           \E[0m"
  echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "masa aktif minimal 1 jam, angka 1 sama dengan 1 jam"
read -p "masukan angka: " hh
  Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
  user=$Login
  CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

  if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m             VLESS ACCOUNT           \E[0m"
    echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo "A client with the specified name was already created, please choose another name."
    echo ""
    echo -e "\033[1;93m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
  fi
done
uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=$hh
exp=$(date -d "$masaaktif day" +"%M")
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

cat >/home/vps/public_html/vless-$user.yaml <<-END

# Format Vless WS TLS

- name: Vless-$user-WS TLS
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}

# Format Vless WS Non TLS

- name: Vless-$user-WS (CDN) Non TLS
  server: ${domain}
  port: 80
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}
  udp: true

# Format Vless gRPC (SNI)

- name: Vless-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: grpc
  grpc-opts:
  grpc-mode: gun
  grpc-service-name: vless-grpc
  udp: true



END

systemctl restart xray
systemctl restart nginx

DATADB=$(cat /root/akun/vless/.vless.conf | grep "^#&" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/vless/.vless.conf
fi
echo "#& ${user} ${exp} ${uuid}" >>/root/akun/vless/.vless.conf

clear
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\E[0;41;36m    Xray/Vless Account     \E[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Remarks     : ${user}" | tee -a /root/akun/vless/$user.txt
echo -e "Domain      : ${domain}" | tee -a /root/akun/vless/$user.txt
echo -e "port TLS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port DNS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port NTLS   : 80" | tee -a /root/akun/vless/$user.txt
echo -e "User ID     : ${uuid}" | tee -a /root/akun/vless/$user.txt
echo -e "Encryption  : none" | tee -a /root/akun/vless/$user.txt
echo -e "Path TLS    : /vless " | tee -a /root/akun/vless/$user.txt
echo -e "ServiceName : vless-grpc" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link TLS    : ${vlesslink1}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link NTLS   : ${vlesslink2}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link GRPC   : ${vlesslink3}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Format OpenClash : http://${domain}:81/vless-$user.yaml" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Expired On : $exp" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "" | tee -a /root/akun/vless/$user.txt
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
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Quota Vless       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vless
	fi

clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Quota Vless       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -rp " Just Input User: " user
if [ -z $user ]; then
m-vle
else
rm -f /etc/vless/${user}
read -p " New Limit Quota : " Quota

if [ ! -e /etc/vless/ ]; then
  mkdir -p /etc/vless/
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vless/${user}
fi
systemctl restart xray > /dev/null 2>&1
systemctl restart crons > /dev/null 2>&1
systemctl restart limitvless > /dev/null 2>&1
clear
load
sleep 2
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${g}Edit Quota Account Vless Successfully ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "\e[32;1m Username     : $user  \e[0m"
echo -e "\e[32;1m New Quota    : $Quota \e[0m"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vle
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
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Limit IP Vless       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "You have no existing clients!"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vle
	fi

clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "        $g Edit Limit IP Vless       ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
echo ""
red "tap enter to go back"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
	read -rp "Input Username : " user
if [ -z $user ]; then
m-vle
else
rm -f /etc/cybervpn/limit/vless/ip/${user}
read -p "Limit User (IP): " iplim
mkdir -p /etc/cybervpn/limit/vless/ip
echo ${iplim} >> /etc/cybervpn/limit/vless/ip/${user}
if [ ! -e /etc/vless/ ]; then
  mkdir -p /etc/vless/
fi
systemctl restart xray > /dev/null 2>&1
systemctl restart crons > /dev/null 2>&1
systemctl restart vlip > /dev/null 2>&1
clear
load
sleep 2
clear
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${g}Edit Limit IP Account Vless Successfully ${NC}"
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo " Username    : $user"
echo " Jumlah Limit IP: $iplim"
echo ""
echo -e "${y}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-vle
fi
}




clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m           VLESS LIBEV            \e[0m"
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
echo -e "\e[37;2m [11] • CHANGE LIMITIP    \e[0m"
echo -e "\e[31;1m [00] • GO BACK           \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;91;1m        LUNATIC TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just Input :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addvless ;;
02 | 2) clear ; renewvless ;;
03 | 3) clear ; delvless ;;
04 | 4) clear ; cekvless ;;
05 | 5) clear ; cekmember ;;
06 | 6) clear ; cek ;;
07 | 7) clear ; unlock ;;
08 | 8) clear ; recovery ;;
09 | 9) clear ; Trial_Account ;;
10) clear ; Ganti_Quota ;;
11) clear ; Ganti_Ip ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vless ;;
esac
