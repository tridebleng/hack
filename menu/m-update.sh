#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/rmbl/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="$(cat /etc/rmbl/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/rmbl/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
WH='\033[1;37m'
###########- END COLOR CODE -##########

echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                 ${WH}⇱ UPDATE ⇲                    ${NC} $COLOR1 $NC"
echo -e "$COLOR1 ${NC} ${COLBG1}             ${WH}⇱ SCRIPT TERBARU ⇲                ${NC} $COLOR1 $NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

# Bersih-bersih file lama
rm -rf restore m-trgo backup menu addnoobz cek-noobz m-noobz m-vmess m-vless \
       m-trojan m-system m-sshovpn m-ssws running m-update m-backup m-theme \
       m-ip m-bot update ws-dropbear bckpbot tendang bottelegram cleaner \
       m-allxray xraylimit xp trialvmess trialvless trialtrojan trialssh \
       bantwidth ws-stunnel

cd /usr/bin || exit 1
rm -rf restore m-trgo backup menu addnoobz cek-noobz m-noobz m-vmess m-vless \
       m-trojan m-system m-sshovpn m-ssws running m-backup m-theme m-ip m-bot \
       update ws-dropbear bckpbot tendang bottelegram cleaner m-allxray \
       xraylimit xp trialvmess trialvless trialtrojan trialssh autocpu \
       bantwidth ws-stunnel

# Spinner + progress bar
SPIN='/-\|'
SPINIDX=0
draw_progress() {
    local current=$1 total=$2 width=30
    local percent=$(( current*100/total ))
    (( percent > 100 )) && percent=100
    local filled=$(( percent*width/100 ))
    local bar=$(printf "%${filled}s" | tr ' ' '█')
    local space=$(( width - filled ))
    local pad=$(printf "%${space}s")
    printf "\r  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m[%s%s] %3d%% \033[36m%s\033[0m" \
        "$bar" "$pad" "$percent" "${SPIN:$SPINIDX:1}"
    SPINIDX=$(( (SPINIDX+1) % 4 ))
}

# Daftar file untuk diunduh
TASKS=(
'wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/tridebleng/hack/main/menu/menu.sh" && chmod +x /usr/bin/menu'
'wget -q -O /usr/bin/m-trgo "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-trgo.sh" && chmod +x /usr/bin/m-trgo'
'wget -q -O /usr/bin/restore "https://raw.githubusercontent.com/tridebleng/hack/main/menu/restore.sh" && chmod +x /usr/bin/restore'
'wget -q -O /usr/bin/backup "https://raw.githubusercontent.com/tridebleng/hack/main/menu/backup.sh" && chmod +x /usr/bin/backup'
'wget -q -O /usr/bin/addnoobz "https://raw.githubusercontent.com/tridebleng/hack/main/bot/addnoobz.sh" && chmod +x /usr/bin/addnoobz'
'wget -q -O /usr/bin/cek-noobz "https://raw.githubusercontent.com/tridebleng/hack/main/bot/cek-noobz.sh" && chmod +x /usr/bin/cek-noobz'
'wget -q -O /usr/bin/m-noobz "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-noobz.sh" && chmod +x /usr/bin/m-noobz'
'wget -q -O /usr/bin/m-ip "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-ip.sh" && chmod +x /usr/bin/m-ip'
'wget -q -O /usr/bin/m-bot "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-bot.sh" && chmod +x /usr/bin/m-bot'
'wget -q -O /usr/bin/update "https://raw.githubusercontent.com/tridebleng/hack/main/menu/update.sh" && chmod +x /usr/bin/update'
'wget -q -O /usr/bin/m-theme "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-theme.sh" && chmod +x /usr/bin/m-theme'
'wget -q -O /usr/bin/m-vmess "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-vmess.sh" && chmod +x /usr/bin/m-vmess'
'wget -q -O /usr/bin/m-vless "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-vless.sh" && chmod +x /usr/bin/m-vless'
'wget -q -O /usr/bin/m-trojan "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-trojan.sh" && chmod +x /usr/bin/m-trojan'
'wget -q -O /usr/bin/m-system "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-system.sh" && chmod +x /usr/bin/m-system'
'wget -q -O /usr/bin/m-sshovpn "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-sshovpn.sh" && chmod +x /usr/bin/m-sshovpn'
'wget -q -O /usr/bin/m-ssws "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-ssws.sh" && chmod +x /usr/bin/m-ssws'
'wget -q -O /usr/bin/running "https://raw.githubusercontent.com/tridebleng/hack/main/menu/running.sh" && chmod +x /usr/bin/running'
'wget -q -O /usr/bin/m-backup "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-backup.sh" && chmod +x /usr/bin/m-backup'
'wget -q -O /usr/bin/m-update "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-update.sh" && chmod +x /usr/bin/m-update'
'wget -q -O /usr/bin/speedtest "https://raw.githubusercontent.com/tridebleng/hack/main/speedtest_cli.py" && chmod +x /usr/bin/speedtest'
'wget -q -O /usr/bin/bckpbot "https://raw.githubusercontent.com/tridebleng/hack/main/menu/bckpbot.sh" && chmod +x /usr/bin/bckpbot'
'wget -q -O /usr/bin/tendang "https://raw.githubusercontent.com/tridebleng/hack/main/menu/tendang.sh" && chmod +x /usr/bin/tendang'
'wget -q -O /usr/bin/bottelegram "https://raw.githubusercontent.com/tridebleng/hack/main/menu/bottelegram.sh" && chmod +x /usr/bin/bottelegram'
'wget -q -O /usr/bin/m-allxray "https://raw.githubusercontent.com/tridebleng/hack/main/menu/m-allxray.sh" && chmod +x /usr/bin/m-allxray'
'wget -q -O /usr/bin/xraylimit "https://raw.githubusercontent.com/tridebleng/hack/main/menu/xraylimit.sh" && chmod +x /usr/bin/xraylimit'
'wget -q -O /usr/bin/trialvmess "https://raw.githubusercontent.com/tridebleng/hack/main/menu/trialvmess.sh" && chmod +x /usr/bin/trialvmess'
'wget -q -O /usr/bin/trialvless "https://raw.githubusercontent.com/tridebleng/hack/main/menu/trialtrojan.sh" && chmod +x /usr/bin/trialtrojan'
'wget -q -O /usr/bin/trialtrojan "https://raw.githubusercontent.com/tridebleng/hack/main/menu/trialvless.sh" && chmod +x /usr/bin/trialvless'
'wget -q -O /usr/bin/trialssh "https://raw.githubusercontent.com/tridebleng/hack/main/menu/trialssh.sh" && chmod +x /usr/bin/trialssh'
'wget -q -O /usr/bin/autocpu "https://raw.githubusercontent.com/tridebleng/hack/main/install/autocpu.sh" && chmod +x /usr/bin/autocpu'
'wget -q -O /usr/bin/bantwidth "https://raw.githubusercontent.com/tridebleng/hack/main/install/bantwidth" && chmod +x /usr/bin/bantwidth'
'wget -q -O /usr/bin/autocpu "https://raw.githubusercontent.com/tridebleng/hack/main/sshws/ws-stunnel" && chmod +x /usr/bin/autocpu'
)

TOTAL=${#TASKS[@]}
DONE=0
echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m[                              ]  0% \033[36m${SPIN:0:1}\033[0m"

for task in "${TASKS[@]}"; do
  bash -c "$task" >/dev/null 2>&1 &
  pid=$!
  while kill -0 $pid 2>/dev/null; do
    draw_progress "$DONE" "$TOTAL"
    sleep 0.12
  done
  wait $pid
  DONE=$((DONE+1))
  draw_progress "$DONE" "$TOTAL"
done

echo -e "\n \033[0;33m[INFO]\033[0m Download File Successfully"
sleep 0.5
clear

cd ~
menu
