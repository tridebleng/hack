#!/bin/bash

# Code Color
NC='\e[0m'
RB='\e[31;1m'
GB='\e[32;1m'
YB='\e[33;1m'
BB='\e[34;1m'
PB='\e[35;1m'
DBB='\033[0;36m'
WB='\e[39;1m'
RW='\e[41;1m'
GW='\e[42;1m'
BW='\e[44;1m'
PW='\e[45;1m'
DBW='\e[46;1m'
WW='\e[47;1m'
DB='\e[90;1m'

# Information Repositories Google Drive
ID_ver_sc="11aEkNEbPO9WtaTGDo1yFwsJE_8lggLZM"
ID_izin="1b7lCJ9EMJvSY1BhCNdXHRqeLqQwNortf"

# Tools Download With Curl #1
# function download_file() {
#   curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=$1" > /dev/null
#   curl -Lb ./cookie -s "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=$1" -o $2
#   rm -rf cookie
# }

# Tools Download With Curl #2
function download_file() {
  curl -sL "https://drive.usercontent.google.com/download?id=$1&confirm=t" -o $2
}


# Validation Access Script
function val_script() {
  date_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
  date_list=$(date +"%Y-%m-%d" -d "$date_server")
  IP=$(cat /var/tmp/.ip)
  user_exp=$(cat /var/tmp/.izin_ip | grep $IP | awk '{print $3}')
  if [[ $(date -d "$date_list" +%s) -lt $(date -d "$user_exp" +%s) ]]; then
      echo -ne
  else
      clear
      echo -e "    ${GB}┌─────────────────────────────────────┐${NC}" | lolcat
      echo -e "    ${RB}       ɪᴘ ɴᴏᴛ ʀᴇɢɪꜱᴛᴇʀ ᴀᴜᴛᴏꜱᴄʀɪᴘᴛ       ${NC}"
      echo -e "    ${GB}└─────────────────────────────────────┘${NC}" | lolcat
      echo -e ""
      read -n 1 -s -r -p "     ᴘʀᴇꜱꜱ ᴀɴʏ ᴋᴇʏ ᴛᴏ ʙᴀᴄᴋ ᴏɴ ᴍᴇɴᴜ"
      menu
  fi
}

# Download Update
function update() {
    # Update Izin IP
    sed -i "d" /var/tmp/.izin_ip > /dev/null 2>&1
    download_file $ID_izin /var/tmp/.izin_ip

    # Update Version Script
    sed -i "d" /var/tmp/.update_script > /dev/null 2>&1
    download_file $ID_ver_sc /var/tmp/.update_script

    # Update Info Server
    curl -s ipinfo.io/org > /var/tmp/.isp
    curl -s ipinfo.io/city > /var/tmp/.city
    curl -s ipinfo.io/ip > /var/tmp/.ip
    curl -s ipinfo.io/region > /var/tmp/.region
}

# Auto Remove Vmess WS
function remove_vmessws() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^###@&' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^###@& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^###@& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/vmess/vmessws-$user.txt
            rm -rf /etc/vmess/$user
            rm -rf /etc/limit/vmess/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove Vmess gRPC
function remove_vmessgrpc() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^###@!' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^###@! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^###@! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/vmess/vmessgrpc-$user.txt
            rm -rf /etc/vmess/$user
            rm -rf /etc/limit/vmess/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove Vless WS
function remove_vlessws() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^##@&' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^##@& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^##@& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/vless/vlessws-$user.txt
            rm -rf /etc/vless/$user
            rm -rf /etc/limit/vless/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove Vless gRPC
function remove_vlessgrpc() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^##@!' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^##@! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^##@! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/vless/vlessgrpc-$user.txt
            rm -rf /etc/vless/$user
            rm -rf /etc/limit/vless/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove Trojan WS
function remove_trojanws() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^#@&' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^#@& $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^#@& $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/trojan/trojanws-$user.txt
            rm -rf /etc/trojan/$user
            rm -rf /etc/limit/trojan/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove Trojan gRPC
function remove_trojangrpc() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^#@!' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^#@! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^#@! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/trojan/trojangrpc-$user.txt
            rm -rf /etc/trojan/$user
            rm -rf /etc/limit/trojan/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove All Services
function remove_allservices() {
    data=( `cat /usr/local/etc/xray/config.json | grep '^##@&!' | cut -d ' ' -f 2 | sort | uniq`);
    now=`date +"%Y-%m-%d"`
    for user in "${data[@]}"; do
        exp=$(grep -w "^##@&! $user" "/usr/local/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$now" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            sed -i "/^##@&! $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
            rm -rf /var/www/html/allservices/allservices-$user.txt
            rm -rf /etc/allservices/$user
            rm -rf /etc/limit/allservices/$user
            rm -rf /tmp/$user
        fi
    done
}

# Auto Remove SSH
function remove_ssh() {
    hariini=`date +%d-%m-%Y`
    cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
    totalaccounts=`cat /tmp/expirelist.txt | wc -l`
    for((i=1; i<=$totalaccounts; i++ )); do
        tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
        username=`echo $tuserval | cut -f1 -d:`
        userexp=`echo $tuserval | cut -f2 -d:`
        userexpireinseconds=$(( $userexp * 86400 ))
        tglexp=`date -d @$userexpireinseconds`             
        tgl=`echo $tglexp |awk -F" " '{print $3}'`
        while [ ${#tgl} -lt 2 ]; do
            tgl="0"$tgl
        done
        while [ ${#username} -lt 15 ]; do
            username=$username" " 
        done
        bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
        todaystime=`date +%s`
        if [ $userexpireinseconds -ge $todaystime ]; then
            :
        else
            userdel --force $username
            noobzvpns --remove-user $username > /dev/null 2>&1
            rm -rf /var/www/html/ssh/ssh-$username.txt
        fi
    done
}

function auto_xp() {
    # Remove Xray
    remove_vmessws
    remove_vmessgrpc
    remove_vlessws
    remove_vlessgrpc
    remove_trojanws
    remove_trojangrpc
    remove_allservices
    sed -i "d" /var/log/xray/access.log
    systemctl restart xray.service

    # Remove SSH
    remove_ssh
}
#val_script
update
auto_xp
