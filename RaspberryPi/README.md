../../hats/eepromutils/eepmake eeprom/eeprom_settings.txt eeprom-with-dt.eep deviceTree/dcdc.dtb

There is a problem with the onboard bluetooth being disabled if booted with external Bluetooth dongle.
Described here: 

https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=282948&sid=cccd937b85c7b1e22671b3d9646a3ac6&start=25

Fix here:

https://github.com/RPi-Distro/pi-bluetooth/issues/18


