#!/bin/sh

function setup_color() {
	# Only use colors if connected to a terminal
	if [ -t 1 ]; then
		RED=$(printf '\033[31m')
		GREEN=$(printf '\033[32m')
		YELLOW=$(printf '\033[33m')
		BLUE=$(printf '\033[34m')
		BOLD=$(printf '\033[1m')
		RESET=$(printf '\033[m')
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		RESET=""
	fi
}

function system_config() {

	if [ ! -f /data/ocserv.conf ]; then
		cp /ocserv.conf /data/
	fi

	sysctl -w net.ipv4.ip_forward=1
	sysctl -p

	# Enable NAT forwarding
	iptables -t nat -A POSTROUTING -j MASQUERADE
	#iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
}

function main() {
	setup_color
	system_config
	exec "$@"
}

main "$@"
