echo Turning on Precharge
echo "1" > precharge
echo "Waiting 4 seconds"
sleep 4
echo Turning on contactor
echo "1" > contactor
echo "Waiting one second"
sleep 1
echo "Turning off Precharge"
echo "0" > precharge
echo "Started"
