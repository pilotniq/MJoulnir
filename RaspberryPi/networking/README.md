# Networking for Solo / MJoulnir

# WiFi
If my home network is available, the Pi will attempt to conncect to it.

If not, it will create an access point Wifi network by the name "solo"

# 3G Modem

I have a Huawei E220 3G modem.

A system service (wvdial) will attempt to always keep its connection up. It uses wvdial to connect, and then pppd to create the connection.

When the connection is achieved, another system service, wifiTunnel, will create a reverse ssh tunnel to my home server (www.lewin.nu).

The ppp default route will have a high metric (1000), so that if both PPP and WiFi are available, traffic will be routed over WiFi.

Changed configuration files will be stored in this directory.

## pppd

Solo currently runs Raspbian Buster, which uses pppd 2.4.7.

pppd 2.4.8 introduced the 'defaultroute-metric' option, but we will have to create an ifup script to do that.