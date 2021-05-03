#!/bin/sh
#
# A script for the wpa_cli command
# based on https://raspberrypi.stackexchange.com/questions/96050/run-a-script-when-wifi-is-connected-to-a-particular-wifi-network
#
# Whenever the Raspberry Pi connects to WiFi network, it 
# establishes a reverse ssh tunnel to my home server
#
HOME_SERVER=www.lewin.nu
HOME_SERVER_USER=solo
# SSH Connections to REVERSE_PORT on the remote computer will be 
# routet to this Raspberry pi.
REVERSE_PORT=3024
PID_FILE=/tmp/wifiTunnel.pid

# redirect all output into a logfile
exec 1>> /var/log/wifi-tunnel.log 2>&1

case "$1" in
wlan0)
    case "$2" in
    CONNECTED)
        # do stuff on connect with wlan0
        echo `date`: wlan0 connected
	systemctl start wifiTunnel
        ;;
    DISCONNECTED)
        # do stuff on disconnect with wlan0
        echo `date`: wlan0 disconnected
	systemctl stop wifiTunnel
        ;;
    *)
        >&2 echo `date`: empty or undefined event for wlan0: "$2"
        exit 1
        ;;
    esac
    ;;

wlan1)
    case "$2" in
    CONNECTED)
        # do stuff on connect with wlan1
        echo wlan1 connected
        ;;
    DISCONNECTED)
        # do stuff on disconnect with wlan1
        echo wlan1 disconnected
        ;;
    *)
        >&2 echo empty or undefined event for wlan1: "$2"
        exit 1
        ;;
    esac
    ;;

*)
    >&2 echo empty or undefined interface: "$1"
    exit 1
    ;;
esac
