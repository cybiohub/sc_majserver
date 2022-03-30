#! /bin/bash
#set -x
# * **************************************************************************
# *
# * Creation:           (c) 2004-2022  Cybionet - Ugly Codes Division
# *
# * File:               majserver.sh
# * Version:            0.1.13d
# *
# * Comment:            Tool to configure update system.
# *
# * Creation: December 16, 2017
# * Change:   February 13, 2021
# *
# * **************************************************************************
# * chmod 500 majserver.sh
# ****************************************************************************


#############################################################################################
# ## CUSTOM VARIABLES

# ## Location of the log file.
readonly APTLOG='/var/log/maj-update.log'

# ## Force use of IPv4. To disable this option empty the variable.
readonly FORCEIPV4='-o Acquire::ForceIPv4=true'


#############################################################################################
# ## VARIABLES

# ## Retrieval of date and year
aptDate=$(date +'%b %d %H:%M:%S')
appYear=$(date +%Y)

# ## Application informations.
appHeader="(c) 2004-${appYear}  Cybionet - Ugly Codes Division"
readonly appVersion='0.1.13d'


#############################################################################################
# ## VERIFICATION

# ## Check if the script are running with sudo or under root user.
if [ "${EUID}" -ne 0 ] ; then
  echo -e "\n\e[34m${appHeader}\e[0m\n"
  echo -e "\n\n\n\e[33mCAUTION: This script must be run with sudo or as root.\e[0m"
  exit 0
else
  echo -e "\n\e[34m${appHeader}\e[0m"
  printf '%.s─' $(seq 1 "$(tput cols)")
  echo -e ""
fi

if [ ! -f '/etc/logrotate.d/majserver' ]; then
  echo -e "${APTLOG} {
        yearly
	size 10M
        missingok
        rotate 10
        compress
        delaycompress
        notifempty
        create 640 root adm
}" > /etc/logrotate.d/majserver
fi

#############################################################################################
# ## FUNCTIONS

# ## Show warning to remember to take snapshot.
function reminderCheck() {
 echo -n -e "\e[38;5;208mWARNING:\e[0m Have you taken the snapshot of the virtual machine before updating it? [y|N] "
 read -r ANSWER
 if [ "${ANSWER}" != 'y' ]; then
   echo 'Have a nice day!'
   exit 0
 fi
}

# ## Launch update.
function aptUpdate() {
 apt-get update "${FORCEIPV4}"
 echo "${aptDate} - UpDate Repository" >> "${APTLOG}"
}

# ## Launch upgrade.
function aptUpgrade() {
 reminderCheck
 apt-get upgrade "${FORCEIPV4}"
 echo "${aptDate} - UpGrade System" >> "${APTLOG}"
}

# ## Launch dist-upgrade.
function aptDistUpgrade() {
 reminderCheck
 apt-get dist-upgrade "${FORCEIPV4}"
 echo "${aptDate} - Distribution UpGrade" >> "${APTLOG}"
}

# ## Launch autoremove.
function autoRemove() {
 if [ -f '/var/run/reboot-required' ]; then
   echo -e "\e[38;5;208mWARNING: Reboot the system before removing old package.\e[0m"
   exit 0
 fi

 echo -n -e "\n\e[38;5;208mWARNING:\e[0m Are you sure you want to do this? [y|N] "
 read -r ANSWER
 if [ "${ANSWER}" != 'y' ]; then
   echo 'Have a nice day!'
   exit 0
 fi

 apt-get autoremove
 echo "${aptDate} - Autoremove Packages" >> "${APTLOG}"
}

# ## Launch autoclean.
function autoClean() {
 if [ -f '/var/run/reboot-required' ]; then
   echo -e "\e[38;5;208mWARNING: Reboot the system before cleaning archive packages.\e[0m"
   exit 0
 fi

 apt-get autoclean
 echo "${aptDate} - Autoclean Archive Packages" >> "${APTLOG}"
}

# ## Check if intervention is necessairy.
function aptCheck() {
 apt-get check
}

# ## Show the content of the log.
function showlog() {
 cat "${APTLOG}"
}

# ## Show the version of this app (hidden option).
function version() {
 echo -e "Version: ${appVersion}\n"
}

# ## Check if the system requires a reboot.
# ## Result: 0 (Ok), 1 (Reboot).
function rebootNeeded() {
 if [ -f '/var/run/reboot-required' ]; then
   echo -e "\e[38;5;208mWARNING: A system restart is required.\e[0m"
 fi
}


#############################################################################################
# ## MENU

case "${1}" in
  update)
        aptUpdate
  ;;
  upgrade)
        aptUpdate
        aptUpgrade
        rebootNeeded
  ;;
  distupgrade|dist-upgrade)
        aptDistUpgrade
        rebootNeeded
  ;;
  autoremove)
        autoRemove
  ;;
  autoclean)
        autoClean
  ;;
  check)
        aptCheck
  ;;
  showlog)
       showlog
  ;;
  version)
        version
  ;;
  *)
  echo -e '\n  Options: update | upgrade | dist-upgrade | autoremove | autoclean | check | showlog\n'
  ;;
esac


# ## Exit.
exit 0

# ## END
