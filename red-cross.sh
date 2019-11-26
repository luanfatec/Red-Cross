#!/bin/bash

yellow="\033[01;33m"
green="\033[01;32m"
red="\033[01;31m"
standard="\033[00m"

clear

function dependencies() {
    echo -e $green"Checking Dependencies..."$standard; sleep 1

	PROGRAMA=( "gnome-terminal" "figlet" "grep" )
	for prog in "${PROGRAMA[@]}";do
        echo -ne "\033[00;32m               ----------------| $prog for dependencies "
		if ! hash "$prog" 2>/dev/null;then
			echo -e "\033[00;31m<<<Not installed!>>>\033[00;37m"
		else
			echo -e "\033[00;32m<<<Installed!>>>\033[00;37m"
		fi
		sleep 1
		
    done
    
    
    for prog_inst in "${PROGRAMA[@]}";do
        if ! hash "$prog_inst" 2>/dev/null;then
            clear; echo -e $green"Trying to install missing dependencies..."$standard; sleep 1
            apt-get update && sleep 3 && apt-get install $prog_inst -y && exit 
            sleep 0.5
        else
            sleep 0.5
            continue
        fi
    done

}

config_ngrok() {      
    if ! which /opt/ngrok/ngrok >/dev/null ;then
        clear
        wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok.zip
        unzip ngrok.zip
        rm ngrok.zip
        mkdir /opt/ngrok
        mv ngrok /opt/ngrok/
        clear        
    else 
        echo -e $green"Ngrok is already installed"$standard
	sleep 2
	source red-cross.sh
    fi

}

config_ngrok_key() {
    echo -ne $yellow"\nPlease create a Ngrok account, copy your authtoken key, and enter it here: "$standard; read key
    amount=`echo $key |wc -m`
    if test $amount -lt 40; then
        config_ngrok_key
    else
        conf_key=`/opt/ngrok/ngrok authtoken $key &>/dev/null && echo "YES" || echo "NO"`
    fi

    if [ $conf_key = "YES" ];then
        echo "teste"
    else
        config_ngrok_key
    fi
}


logo()
{
        clear
        echo -e $red"=========================================================================="$standard
        echo -e "                                Red Cross                         "
        echo -e $red"=========================================================================="$standard
}
logo
echo -ne "\n$yellow [1]$green Attack android system \n$yellow [2]$green Attack linux system \n$yellow [3]$green Attack windows system \n$yellow [4]$green Configure ngrok \
        \n$yellow [5]$green Configure authtoken key \n$yellow [6]$green Check for dependencies \n\
        \033[01;37m\n\033[01;34mEnter the option:\033[00;37m ";read option


case $option in
    1) clear
        attack_android 
	source red-cross.sh;;
    2) clear
        attack_linux 
	source red-cross.sh;;
    3) clear
        attack_windows 
	source red-cross.sh;;
    4) clear
        config_ngrok 
	source red-cross.sh;;
    5) clear
        config_ngrok_key 
	source red-cross.sh ;;
    6) clear
        dependencies 
	source red-cross.sh;;
    *) clear
        source red-cross.sh ;;
esac
