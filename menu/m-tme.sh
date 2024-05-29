#!/bin/bash
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          THEMES FEATURES          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [1]• ( DEFAULT )         \e[0m"
echo -e "\e[37;1m [2]• Simple Menu x Blue Bird   \e[0m"
echo -e "\e[37;1m [3]• Lunatic Tunneling Backend   \e[0m"
echo -e "\e[37;1m [4]• Potato Tunneling Modd    \e[0m"
echo -e "\e[37;1m [5]• Fighter Tunnel Modd      \e[0m"
echo -e "\e[37;1m [6]• Sanz Tunneling x FT      \e[0m"
echo -e "\e[37;1m [7]• Andyyuda Tunnel x PT     \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          LUNATIC TUNNELING         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just input :  " regex

# // [ 1 ]  DEFAULT 
if [ $regex = 1 ] || [ $regex = 1 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/dashboard.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

# // [ 2 ] Simple Appereance
if [ $regex = 2 ] || [ $regex = 2 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/Simple.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

# // [ 3 ] Lunatic Tunneling
if [ $regex = 3 ] || [ $regex = 3 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/LunaticTunneling.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

# // [ 4 ] Potato Tunneling
if [ $regex = 4 ] || [ $regex = 4 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/PotatoTunneling.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

# // [ 5 ] Fighter Tunnel
if [ $regex = 5 ] || [ $regex = 5 ]
then
rm -rf /usr/bin/menu
rm -rf /usr/bin/dashboard
rm -rf /usr/bin/setting
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/Fighter.sh" && chmod 777 /usr/bin/menu
menu
fi

# // [ 6 ] Sanz Tunneling
if [ $regex = 6 ] || [ $regex = 6 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/SanzTunneling.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

#// [ 7 ] Andyyuda Tunnel
if [ $regex = 7 ] || [ $regex = 7 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/LT-BACKEND/stunnelvpn/momok/Themes/AndyyudaTunnel.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

