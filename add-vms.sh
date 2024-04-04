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

# Banner
function banner() {
   clear
   echo -e ""
   echo -e "${RB}    ᴀᴜᴛʜᴏʀ    ${NC}"
   echo -e "${GB}    _  _ ____ ____ _  _ ___  ____ ____ _  _ ${NC}" | lolcat
   echo -e "${GB}    |__| |__| |    |_/  |  \ |___ |___ |\/| ${NC}" | lolcat
   echo -e "${GB}    |  | |  | |___ | \_ |__/ |___ |___ |  | ${NC}" | lolcat
}

# Info Script
function val_user() {
   date_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
   date=$(date +"%Y-%m-%d" -d "$date_server")
   Ip=$(cat /var/tmp/.ip)
   Exp=$(cat /var/tmp/.izin_ip | grep $Ip | cut -d ' ' -f 3)
   User=$(cat /var/tmp/.izin_ip | grep $Ip | cut -d ' ' -f 2)
   d2=$(date -d "$date" +%s)
   d1=$(date -d "$Exp" +%s)
   dayleft=$(( (d1 - d2) / 86400 ))
   Latest=$(cat /var/tmp/.update_script | grep v | awk '{print $2}')
   Update=$(cat /root/.update | awk '{print $2}')
   if [[ $Update == $Latest ]]; then
       Version="${GB}   ʟᴀᴛᴇꜱᴛ${NC}"
   else
       Version="${RB}   ᴜᴘᴅᴀᴛᴇ${NC}"
   fi
   if [[ $User == "" ]]; then 
       echo -e "${GB}    ┌───────────────────────────────────────┐${NC}" | lolcat
       echo -e "${WB}      ꜱᴄʀɪᴘᴛ :${NC} ${GB}ꜰʀᴇᴇ${NC}         ${BB}ᴠᴇʀꜱɪᴏɴ${NC} : ${YB}$Update${NC}"
       echo -e "${WB}      ᴜꜱᴇʀ   :${NC} ${PB}ꜰʀᴇᴇ${NC}            ${WB}ꜱᴛᴀᴛᴜꜱ${NC}"
       echo -e "${WB}      ᴇxᴘɪʀᴇ :${NC} ${RB}ᴜɴʟɪᴍɪᴛᴇᴅ${NC}    $Version"
       echo -e "${GB}    └───────────────────────────────────────┘${NC}" | lolcat
   else
       echo -e "${GB}    ┌───────────────────────────────────────┐${NC}" | lolcat
       echo -e "${WB}      ꜱᴄʀɪᴘᴛ :${NC} ${GB}ᴘʀᴇᴍɪᴜɴ${NC}      ${BB}ᴠᴇʀꜱɪᴏɴ${NC} : ${YB}$Update${NC}"
       echo -e "${WB}      ᴜꜱᴇʀ   :${NC} ${PB}$User${NC}        ${WB}ꜱᴛᴀᴛᴜꜱ${NC}"
       echo -e "${WB}      ᴇxᴘɪʀᴇ :${NC} ${RB}$dayleft ᴅᴀʏꜱ${NC}      $Version"
       echo -e "${GB}    └───────────────────────────────────────┘${NC}" | lolcat
   fi
}

# Validation Access Script

# Info Server
domain=$(cat /var/tmp/.domain)
uuid=$(cat /proc/sys/kernel/random/uuid)

# Add Vmess WS
function add-vmessws() {
  banner
  val_user
  echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
  echo -e "    ${WB}       ──── [ ᴄʀᴇᴀᴛᴇ ᴠᴍᴇꜱꜱ ᴡꜱ ] ────      ${NC}" | lolcat
  echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
  until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
    read -rp "     ᴜꜱᴇʀɴᴀᴍᴇ : " user
    if [ -z $user ]; then
      echo ""
      echo -e "    ${RB} ʏᴏᴜ ᴘʀᴇꜱꜱᴇᴅ ᴡʀᴏɴɢ${NC}"
      sleep 1 ; menu-vmessws
    fi
    CLIENT_EXISTS=$(grep -w $user /usr/local/etc/xray/config.json | wc -l)
    if [[ ${CLIENT_EXISTS} == '2' ]]; then
      banner
      val_user
      echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
      echo -e "    ${WB}       ──── [ ᴄʀᴇᴀᴛᴇ ᴠᴍᴇꜱꜱ ᴡꜱ ] ────      ${NC}" | lolcat
      echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
      echo -e "    ${RB}         ɴᴀᴍᴇ ᴡᴀꜱ ᴀʟʀᴇᴀᴅʏ ᴄʀᴇᴀᴛᴇᴅ        ${NC}"
      echo -e "    ${RB}        ᴘʟᴇᴀꜱᴇ ᴄʜᴏᴏꜱᴇ ᴀɴᴏᴛʜᴇʀ ɴᴀᴍᴇ       ${NC}"
      echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
      echo -e ""
      read -n 1 -s -r -p "     ᴘʀᴇꜱꜱ ᴀɴʏ ᴋᴇʏ ᴛᴏ ʙᴀᴄᴋ ᴏɴ ᴄʀᴇᴀᴛᴇ ᴀᴄᴄᴏᴜɴᴛ"
      add-vmessws
    fi
  done
  read -rp "     ᴇxᴘɪʀᴇᴅ  : " masaaktif
  read -rp "     Qᴜᴏᴛᴀ ʟɪᴍɪᴛ (y/n)? : " limit
  if [ ! -e /etc/vmess ]; then
    mkdir -p /etc/vmess
  fi
  if [ ! -e /etc/limit/vmess ]; then
    mkdir -p /etc/limit/vmess
  fi
  if [[ ${limit} == 'y' ]]; then
      read -rp "     Qᴜᴏᴛᴀ ʟɪᴍɪᴛ (ɢʙ) : " Quota
  else
      Quota="0"
      touch /etc/vmess/${user}
      touch /etc/limit/vmess/${user}
  fi
  c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
  d=$((${c} * 1024 * 1024 * 1024))
  if [[ ${c} != "0" ]]; then
    echo "${d}" >/etc/vmess/${user}
    touch /etc/limit/vmess/${user}
  fi

  # Date Expired
  exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
  sed -i '/#vmess$/a\###@& '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

  # Base Vmess
  acs=`cat<<EOF
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
  vmesslink1="vmess://$(echo $acs | base64 -w 0)"
  vmesslink2="vmess://$(echo $ask | base64 -w 0)"
  vmesslink3="vmess://$(echo $grpc | base64 -w 0)"

  # Restart xray
  systemctl restart xray.service

  # Add To Web
  cat > /var/www/html/vmess/vmessws-$user.txt << END
========================================
     ----- [ Vmess Account ] -----
========================================
Remarks   : $user
Host/IP   : $domain
Port TLS  : 443
Port NTLS : 80
Uuid      : $uuid
Path      : /vmess
========================================
Link TLS  :
$vmesslink1
========================================
Link NTLS :
$vmesslink2
========================================
Expired   : $exp
========================================
ꜱᴄʀɪᴘᴛ ᴍᴏᴅ ʙʏ ʜᴀᴄᴋᴅᴇᴇᴍ
END

# Send To Bot
  CHATID=$(cat /var/tmp/.bot | awk '{print $3}')
  KEY=$(cat /var/tmp/.bot | awk '{print $2}')
  URL="https://api.telegram.org/bot$KEY/sendMessage"
  TIMES="10"
  TEXT="
<code>◇═══════════════════◇</code>
<code> ----- [ Vmess Account ] -----</code>
<code>◇═══════════════════◇</code>
<code>Remarks      : </code> <code>${user}</code>
<code>Domain       : </code> <code>${domain}</code>
<code>Port TLS     : </code> <code>443</code>
<code>Port NTLS    : </code> <code>80, 8080</code>
<code>User ID      : </code> <code>${uuid}</code>
<code>AlterId      : 0</code>
<code>Security     : auto</code>
<code>Network      : WS</code>
<code>Path         : </code> <code>/vmess</code>
<code>Expired On   : </code> <code>$exp</code>
<code>◇═══════════════════◇</code>
<code>Link TLS     :</code> 
<code>${vmesslink1}</code>
<code>◇═══════════════════◇</code>
<code>Link NTLS    :</code> 
<code>${vmesslink2}</code>
<code>◇═══════════════════◇</code>
ꜱᴄʀɪᴘᴛ ᴍᴏᴅ ʙʏ ʜᴀᴄᴋᴅᴇᴇᴍ
"
  curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null

  # Account Vmess WS
  clear
  echo -e "    ${BB}┌───────────────────────────────────────┐${NC}" | lolcat
  echo -e "    ${WB}      ──── [ ᴠᴍᴇꜱꜱ ᴡꜱ ᴀᴄᴄᴏᴜɴᴛ ] ────      ${NC}" | lolcat
  echo -e "    ${BB}└───────────────────────────────────────┘${NC}" | lolcat
  echo -e "     ʀᴇᴍᴀʀᴋꜱ      : ${user}"
  echo -e "     ʜᴏꜱᴛ/ɪᴘ      : ${domain}"
  echo -e "     ᴘᴏʀᴛ ᴛʟꜱ     : 443"
  echo -e "     ᴘᴏʀᴛ ɴᴛʟꜱ    : 80"
  echo -e "     ᴜᴜɪᴅ         : ${uuid}"
  echo -e "     ᴘᴀᴛʜ         : /vmess"
  echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
  echo -e "     ʟɪɴᴋ ᴛʟꜱ     : ${vmesslink1}"
  echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
  echo -e "     ʟɪɴᴋ ɴᴛʟꜱ    : ${vmesslink2}"
  echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
  echo -e "     ᴇxᴘɪʀᴇᴅ ᴏɴ   : $exp"
  echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
  echo -e "     ʟɪɴᴋ         : https://$domain:81/vmess/vmessws-$user.txt"
  echo -e "    ${BB} ────────────────────────────────────────${NC}" | lolcat
  echo -e "     ꜱᴄʀɪᴘᴛ ᴍᴏᴅ ʙʏ ʜᴀᴄᴋᴅᴇᴇᴍ"
  echo ""
  read -n 1 -s -r -p "     ᴘʀᴇꜱꜱ ᴀɴʏ ᴋᴇʏ ᴛᴏ ʙᴀᴄᴋ ᴏɴ ᴍᴇɴᴜ ᴠᴍᴇꜱꜱ ᴡꜱ"
  menu-vmessws
}
val_script
add-vmessws
