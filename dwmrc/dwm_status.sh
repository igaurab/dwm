#!/bin/bash
print_wifi() {
  ip=$(ip route get 1.1.1.1 | awk '{print $7}')
  echo -e "$ip"
}

print_memory() {
  	echo "$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))"
}

print_bat(){
	hash acpi || return 0
	onl="$(grep "on-line" <(acpi -V))"
	charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)"
	if test -z "$onl"
	then
		# suspend when we close the lid
		#systemctl --user stop inhibit-lid-sleep-on-battery.service
		echo -e "${charge}"
	else
		# On mains! no need to suspend
		#systemctl --user start inhibit-lid-sleep-on-battery.service
		echo -e "${charge}"
	fi
}

print_date(){
	date "+%a %m-%d %T%:::z"
}

while true
do
	xsetroot -name "RAM: $(print_memory) Mb | $(print_wifi) |  Bat: $(print_bat)% | Date: $(print_date)"
	sleep 1m
done
