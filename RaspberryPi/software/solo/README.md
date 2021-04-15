Installation

copy solo.service to /etc/systemd/system

Do 
sudo systemctl start solo.service
sudo systemctl stop solo.service
sudo systemctl enable myscript.service

sudo setcap cap_net_raw+eip $(eval readlink -f `which node`)

NOBLE_HCI_DEVICE_ID=1 to use other device for NOBLE

Works:

NOBLE_HCI_DEVICE_ID=1 BLENO_HCI_DEVICE_ID=0 npm start > >(tee -a charging.log) 2> >(tee -a charging.log >&2)
