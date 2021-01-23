EESchema Schematic File Version 4
LIBS:EV Hat-cache
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title "Raspberry Electric Vehicle Pi HAT"
Date "2020-12-14"
Rev "A"
Comp "Erland Lewin"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Mechanical:MountingHole H1
U 1 1 5834BC4A
P 5650 6000
F 0 "H1" H 5500 6100 60  0000 C CNN
F 1 "3mm_Mounting_Hole" H 5650 5850 60  0000 C CNN
F 2 "project_footprints:NPTH_3mm_ID" H 5550 6000 60  0001 C CNN
F 3 "" H 5550 6000 60  0001 C CNN
	1    5650 6000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5834BCDF
P 6650 6000
F 0 "H2" H 6500 6100 60  0000 C CNN
F 1 "3mm_Mounting_Hole" H 6650 5850 60  0000 C CNN
F 2 "project_footprints:NPTH_3mm_ID" H 6550 6000 60  0001 C CNN
F 3 "" H 6550 6000 60  0001 C CNN
	1    6650 6000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5834BD62
P 5650 6550
F 0 "H3" H 5500 6650 60  0000 C CNN
F 1 "3mm_Mounting_Hole" H 5650 6400 60  0000 C CNN
F 2 "project_footprints:NPTH_3mm_ID" H 5550 6550 60  0001 C CNN
F 3 "" H 5550 6550 60  0001 C CNN
	1    5650 6550
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5834BDED
P 6700 6550
F 0 "H4" H 6550 6650 60  0000 C CNN
F 1 "3mm_Mounting_Hole" H 6700 6400 60  0000 C CNN
F 2 "project_footprints:NPTH_3mm_ID" H 6600 6550 60  0001 C CNN
F 3 "" H 6600 6550 60  0001 C CNN
	1    6700 6550
	1    0    0    -1  
$EndComp
$Comp
L EV-Hat-rescue:OX40HAT-raspberrypi_hat J3
U 1 1 58DFC771
P 2600 2250
F 0 "J3" H 2950 2350 50  0000 C CNN
F 1 "40HAT" H 2300 2350 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_2x20_P2.54mm_Vertical" H 2600 2450 50  0001 C CNN
F 3 "" H 1900 2250 50  0000 C CNN
	1    2600 2250
	1    0    0    -1  
$EndComp
Text Label 3150 7400 2    60   ~ 0
P3V3
Text Label 7150 2400 2    60   ~ 0
P5V_HAT
Wire Wire Line
	6400 2400 6550 2400
Text Label 5300 2400 0    60   ~ 0
P5V
Wire Wire Line
	5300 2400 5750 2400
Text Notes 5150 1750 0    118  ~ 24
5V Powered HAT Protection
Text Notes 4900 2050 0    60   ~ 0
This is the recommended 5V rail protection for \na HAT with power going to the Pi.\nSee https://github.com/raspberrypi/hats/blob/master/designguide.md#back-powering-the-pi-via-the-j8-gpio-header
$Comp
L EV-Hat-rescue:DMG2305UX-raspberrypi_hat Q1
U 1 1 58E14EB1
P 6150 2400
F 0 "Q1" V 6300 2550 50  0000 R CNN
F 1 "DMG2305UX" V 6300 2350 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 6350 2500 50  0001 C CNN
F 3 "" H 6150 2400 50  0000 C CNN
	1    6150 2400
	0    -1   -1   0   
$EndComp
$Comp
L EV-Hat-rescue:DMMT5401-raspberrypi_hat Q2
U 1 1 58E1538B
P 5850 3000
F 0 "Q2" H 6050 3075 50  0000 L CNN
F 1 "DMMT5401" H 6050 3000 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 6050 2925 50  0001 L CIN
F 3 "" H 5850 3000 50  0000 L CNN
	1    5850 3000
	-1   0    0    1   
$EndComp
$Comp
L EV-Hat-rescue:DMMT5401-raspberrypi_hat Q2
U 2 1 58E153D6
P 6450 3000
F 0 "Q2" H 6650 3075 50  0000 L CNN
F 1 "DMMT5401" H 6650 3000 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-6" H 6650 2925 50  0001 L CIN
F 3 "" H 6450 3000 50  0000 L CNN
	2    6450 3000
	1    0    0    1   
$EndComp
$Comp
L Device:R R23
U 1 1 58E15896
P 5750 3600
F 0 "R23" V 5830 3600 50  0000 C CNN
F 1 "10K" V 5750 3600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 5680 3600 50  0001 C CNN
F 3 "" H 5750 3600 50  0001 C CNN
	1    5750 3600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 58E158A1
P 6550 3600
F 0 "R24" V 6630 3600 50  0000 C CNN
F 1 "47K" V 6550 3600 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 6480 3600 50  0001 C CNN
F 3 "" H 6550 3600 50  0001 C CNN
	1    6550 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 58E15A41
P 5750 3800
F 0 "#PWR01" H 5750 3550 50  0001 C CNN
F 1 "GND" H 5750 3650 50  0000 C CNN
F 2 "" H 5750 3800 50  0000 C CNN
F 3 "" H 5750 3800 50  0000 C CNN
	1    5750 3800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 58E15A9E
P 6550 3800
F 0 "#PWR02" H 6550 3550 50  0001 C CNN
F 1 "GND" H 6550 3650 50  0000 C CNN
F 2 "" H 6550 3800 50  0000 C CNN
F 3 "" H 6550 3800 50  0000 C CNN
	1    6550 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 3800 5750 3750
Wire Wire Line
	6550 3800 6550 3750
Wire Wire Line
	6550 3200 6550 3300
Wire Wire Line
	6150 2650 6150 3300
Wire Wire Line
	6150 3300 6550 3300
Connection ~ 6550 3300
Wire Wire Line
	5750 3200 5750 3350
Wire Wire Line
	6050 3000 6050 3350
Wire Wire Line
	5750 3350 6050 3350
Connection ~ 5750 3350
Wire Wire Line
	6250 3350 6250 3000
Connection ~ 6050 3350
Wire Wire Line
	5750 2800 5750 2400
Connection ~ 5750 2400
Wire Wire Line
	6550 2800 6550 2400
Connection ~ 6550 2400
$Comp
L EV-Hat-rescue:CAT24C32-raspberrypi_hat U2
U 1 1 58E1713F
P 2100 5850
F 0 "U2" H 2450 6200 50  0000 C CNN
F 1 "CAT24C32" H 1850 6200 50  0000 C CNN
F 2 "Package_SOIC:SOIC-8_3.9x4.9mm_P1.27mm" H 2100 5850 50  0001 C CNN
F 3 "" H 2100 5850 50  0000 C CNN
	1    2100 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 58E17715
P 2350 7400
F 0 "R6" V 2430 7400 50  0000 C CNN
F 1 "3.9K" V 2350 7400 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 2280 7400 50  0001 C CNN
F 3 "" H 2350 7400 50  0001 C CNN
	1    2350 7400
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 58E17720
P 2350 7650
F 0 "R8" V 2430 7650 50  0000 C CNN
F 1 "3.9K" V 2350 7650 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 2280 7650 50  0001 C CNN
F 3 "" H 2350 7650 50  0001 C CNN
	1    2350 7650
	0    1    1    0   
$EndComp
Wire Wire Line
	1250 7400 2150 7400
Wire Wire Line
	1250 7650 2150 7650
Wire Wire Line
	2150 7500 1250 7500
Wire Wire Line
	2150 7750 1250 7750
Wire Wire Line
	2150 7750 2150 7650
Connection ~ 2150 7650
Wire Wire Line
	2150 7500 2150 7400
Connection ~ 2150 7400
Wire Wire Line
	2500 7400 2700 7400
Wire Wire Line
	2700 7650 2500 7650
Connection ~ 2700 7400
Text Label 1250 7400 0    60   ~ 0
ID_SD_EEPROM_pu
Text Label 1250 7500 0    60   ~ 0
ID_SD_EEPROM
Text Label 1250 7650 0    60   ~ 0
ID_SC_EEPROM_pu
Text Label 1250 7750 0    60   ~ 0
ID_SC_EEPROM
Wire Wire Line
	3450 6050 2600 6050
Wire Wire Line
	2600 5950 3450 5950
Text Label 3450 6050 2    60   ~ 0
ID_SD_EEPROM_pu
Text Label 3450 5950 2    60   ~ 0
ID_SC_EEPROM_pu
$Comp
L Connector_Generic:Conn_01x02 J9
U 1 1 58E18D32
P 750 6100
F 0 "J9" H 750 6250 50  0000 C CNN
F 1 "CONN_01X02" V 850 6100 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 750 6100 50  0001 C CNN
F 3 "" H 750 6100 50  0000 C CNN
	1    750  6100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R29
U 1 1 58E19E51
P 1550 6250
F 0 "R29" V 1630 6250 50  0000 C CNN
F 1 "10K" V 1550 6250 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 1480 6250 50  0001 C CNN
F 3 "" H 1550 6250 50  0001 C CNN
	1    1550 6250
	-1   0    0    1   
$EndComp
Text Label 2400 5350 2    60   ~ 0
P3V3
Wire Wire Line
	2100 5350 2400 5350
Wire Wire Line
	2100 5350 2100 5450
$Comp
L power:GND #PWR03
U 1 1 58E1A612
P 1050 5750
F 0 "#PWR03" H 1050 5500 50  0001 C CNN
F 1 "GND" H 1050 5600 50  0000 C CNN
F 2 "" H 1050 5750 50  0000 C CNN
F 3 "" H 1050 5750 50  0000 C CNN
	1    1050 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 5650 1300 5750
Wire Wire Line
	1050 5650 1300 5650
Wire Wire Line
	1600 5750 1300 5750
Connection ~ 1300 5750
Wire Wire Line
	1300 5850 1600 5850
$Comp
L power:GND #PWR04
U 1 1 58E1AF98
P 1050 6150
F 0 "#PWR04" H 1050 5900 50  0001 C CNN
F 1 "GND" H 1050 6000 50  0000 C CNN
F 2 "" H 1050 6150 50  0000 C CNN
F 3 "" H 1050 6150 50  0000 C CNN
	1    1050 6150
	1    0    0    -1  
$EndComp
Text Notes 3250 5350 0    60   ~ 0
EEPROM WRITE ENABLE
$Comp
L Device:R R11
U 1 1 58E22900
P 1300 6100
F 0 "R11" V 1380 6100 50  0000 C CNN
F 1 "DNP" V 1300 6100 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad0.84x1.00mm_HandSolder" V 1230 6100 50  0001 C CNN
F 3 "" H 1300 6100 50  0001 C CNN
	1    1300 6100
	0    1    1    0   
$EndComp
Text Notes 1550 7050 0    118  ~ 24
Pullup Resistors
Text Notes 2000 4800 0    118  ~ 24
HAT EEPROM
Text Notes 5300 5700 0    118  ~ 24
Mounting Holes
Text Notes 1650 2000 0    118  ~ 24
40-Pin HAT Connector
Text Label 800  4150 0    60   ~ 0
GND
Wire Wire Line
	2000 4150 800  4150
Text Label 800  3550 0    60   ~ 0
ID_SD_EEPROM
Wire Wire Line
	2000 3550 800  3550
Text Label 800  3450 0    60   ~ 0
GND
Wire Wire Line
	2000 3450 800  3450
Text Label 800  2650 0    60   ~ 0
GND
Wire Wire Line
	2000 2650 800  2650
Text Label 800  2250 0    60   ~ 0
P3V3
Wire Wire Line
	2000 2250 800  2250
Wire Wire Line
	3200 2850 4400 2850
Wire Wire Line
	3200 3150 4400 3150
Wire Wire Line
	3200 3550 4400 3550
Wire Wire Line
	3200 3650 4400 3650
Wire Wire Line
	3200 3850 4400 3850
Text Label 4400 2850 2    60   ~ 0
GND
Text Label 4400 3150 2    60   ~ 0
GND
Text Label 4400 3650 2    60   ~ 0
GND
Text Label 4400 3550 2    60   ~ 0
ID_SC_EEPROM
Text Label 4400 3850 2    60   ~ 0
GND
Text Label 4400 2450 2    60   ~ 0
GND
Wire Wire Line
	3200 2450 4400 2450
Text Label 4400 2350 2    60   ~ 0
P5V_HAT
Wire Wire Line
	3200 2350 4400 2350
Text Label 4400 2250 2    60   ~ 0
P5V_HAT
Wire Wire Line
	3200 2250 4400 2250
Wire Wire Line
	2700 7650 2700 7400
Text Notes 1200 5200 0    60   ~ 0
The HAT spec requires this EEPROM with system information\nto be in place in order to be called a HAT. It should be set up as write\nprotected (WP pin held high), so it may be desirable to either put a \njumper as shown to enable writing, or to hook up a spare IO pin to do so.
Text Notes 1100 7250 0    60   ~ 0
These are just pullup resistors for the I2C bus on the EEPROM.\nThe resistor values are per the HAT spec.
Text Notes 850  1250 0    100  ~ 0
This is based on the official Raspberry Pi spec to be able to call an extension board a HAT.\nhttps://github.com/raspberrypi/hats/blob/master/designguide.md
$Comp
L power:GND #PWR05
U 1 1 58E3CC10
P 2100 6350
F 0 "#PWR05" H 2100 6100 50  0001 C CNN
F 1 "GND" H 2100 6200 50  0000 C CNN
F 2 "" H 2100 6350 50  0000 C CNN
F 3 "" H 2100 6350 50  0000 C CNN
	1    2100 6350
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 6250 2100 6350
Text Label 1800 6550 2    60   ~ 0
P3V3
Wire Wire Line
	1800 6550 1550 6550
Wire Wire Line
	1550 6550 1550 6400
Wire Wire Line
	1450 6050 1550 6050
Wire Wire Line
	1550 6000 1550 6050
Wire Wire Line
	1050 5650 1050 5750
Connection ~ 1300 5650
Wire Wire Line
	1450 6050 1450 6100
Connection ~ 1550 6050
Wire Wire Line
	950  6100 1050 6100
Wire Wire Line
	1050 6150 1050 6100
Connection ~ 1050 6100
Wire Wire Line
	950  6000 1550 6000
Wire Wire Line
	6550 3300 6550 3450
Wire Wire Line
	5750 3350 5750 3450
Wire Wire Line
	6050 3350 6250 3350
Wire Wire Line
	5750 2400 5900 2400
Wire Wire Line
	6550 2400 7150 2400
Wire Wire Line
	2150 7650 2200 7650
Wire Wire Line
	2150 7400 2200 7400
Wire Wire Line
	2700 7400 3150 7400
Wire Wire Line
	1300 5750 1300 5850
Wire Wire Line
	1300 5650 1600 5650
Wire Wire Line
	1550 6050 1600 6050
Wire Wire Line
	1550 6050 1550 6100
Wire Wire Line
	1050 6100 1150 6100
Text Notes 600  8500 0    50   ~ 0
BMS Slave Connection First
$Comp
L power:GND #PWR0101
U 1 1 5FF108BD
P 1700 9400
F 0 "#PWR0101" H 1700 9150 50  0001 C CNN
F 1 "GND" H 1705 9227 50  0000 C CNN
F 2 "" H 1700 9400 50  0001 C CNN
F 3 "" H 1700 9400 50  0001 C CNN
	1    1700 9400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 9200 1450 9200
Text Label 2200 9000 0    50   ~ 0
BMS_nFault
Text Label 2050 9200 2    50   ~ 0
BMS_RX
Wire Wire Line
	1400 9100 1450 9100
$Comp
L Connector:Screw_Terminal_01x04 J7
U 1 1 5FF108C7
P 10450 3250
F 0 "J7" H 10368 2917 50  0000 C CNN
F 1 "Screw_Terminal_01x03" H 10368 3016 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x4-RA-0901362204" H 10450 3250 50  0001 C CNN
F 3 "~" H 10450 3250 50  0001 C CNN
	1    10450 3250
	-1   0    0    1   
$EndComp
Wire Wire Line
	10650 3350 10750 3350
Wire Wire Line
	10750 3350 10750 3400
$Comp
L power:GND #PWR0102
U 1 1 5FF108CF
P 10750 3400
F 0 "#PWR0102" H 10750 3150 50  0001 C CNN
F 1 "GND" H 10755 3227 50  0000 C CNN
F 2 "" H 10750 3400 50  0001 C CNN
F 3 "" H 10750 3400 50  0001 C CNN
	1    10750 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	10650 3050 10750 3050
Wire Wire Line
	10750 3050 10750 2950
Wire Wire Line
	10650 3250 10900 3250
Wire Wire Line
	10650 3150 10900 3150
$Comp
L power:+3.3V #PWR0103
U 1 1 5FF108D9
P 10750 2950
F 0 "#PWR0103" H 10750 2800 50  0001 C CNN
F 1 "+3.3V" H 10765 3123 50  0000 C CNN
F 2 "" H 10750 2950 50  0001 C CNN
F 3 "" H 10750 2950 50  0001 C CNN
	1    10750 2950
	1    0    0    -1  
$EndComp
Text Label 10900 3250 0    50   ~ 0
GPS_RX
Text Label 10900 3150 0    50   ~ 0
GPS_TX
$Comp
L power:+3.3V #PWR0104
U 1 1 5FF108E1
P 1800 8500
F 0 "#PWR0104" H 1800 8350 50  0001 C CNN
F 1 "+3.3V" H 1815 8673 50  0000 C CNN
F 2 "" H 1800 8500 50  0001 C CNN
F 3 "" H 1800 8500 50  0001 C CNN
	1    1800 8500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 8900 1800 8900
Wire Wire Line
	1800 8900 1800 8550
$Comp
L Device:R R1
U 1 1 5FF108E9
P 2100 8800
F 0 "R1" H 2030 8754 50  0000 R CNN
F 1 "4.7k" H 2030 8845 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2030 8800 50  0001 C CNN
F 3 "~" H 2100 8800 50  0001 C CNN
	1    2100 8800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 8950 2100 9000
Wire Wire Line
	1800 8550 2100 8550
Wire Wire Line
	2100 8550 2100 8650
Connection ~ 1800 8550
Wire Wire Line
	1800 8550 1800 8500
$Comp
L Connector_Generic:Conn_01x05 J1
U 1 1 5FF108F5
P 1200 9100
F 0 "J1" H 1118 8675 50  0000 C CNN
F 1 "Conn_01x06" H 1118 8766 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-2x3-0901303206" H 1200 9100 50  0001 C CNN
F 3 "~" H 1200 9100 50  0001 C CNN
	1    1200 9100
	-1   0    0    1   
$EndComp
Wire Wire Line
	1400 9300 1700 9300
Wire Wire Line
	1700 9300 1700 9400
Wire Wire Line
	1450 9100 1450 9200
Connection ~ 1450 9200
Wire Wire Line
	1400 9000 2100 9000
Text Label 1600 10250 0    50   ~ 0
BMS_TX
$Comp
L Connector_Generic:Conn_01x04 J?
U 1 1 5FF17586
P 1200 10250
AR Path="/5FEB47F2/5FF17586" Ref="J?"  Part="1" 
AR Path="/5FF17586" Ref="J2"  Part="1" 
F 0 "J2" H 1118 9825 50  0000 C CNN
F 1 "Conn_01x04" H 1118 9916 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x4-0901361204" H 1200 10250 50  0001 C CNN
F 3 "~" H 1200 10250 50  0001 C CNN
	1    1200 10250
	-1   0    0    1   
$EndComp
Text Notes 900  9750 0    50   ~ 0
BMS Slave Connection Last
Wire Wire Line
	1400 10250 1500 10250
Wire Wire Line
	1400 10150 1500 10150
Wire Wire Line
	1500 10150 1500 10250
Connection ~ 1500 10250
$Comp
L power:GND #PWR?
U 1 1 5FF17592
P 1500 10400
AR Path="/5FEB47F2/5FF17592" Ref="#PWR?"  Part="1" 
AR Path="/5FF17592" Ref="#PWR0105"  Part="1" 
F 0 "#PWR0105" H 1500 10150 50  0001 C CNN
F 1 "GND" H 1505 10227 50  0000 C CNN
F 2 "" H 1500 10400 50  0001 C CNN
F 3 "" H 1500 10400 50  0001 C CNN
	1    1500 10400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 10350 1500 10350
Wire Wire Line
	1500 10350 1500 10400
$Comp
L power:+3.3V #PWR?
U 1 1 5FF1759A
P 1650 10000
AR Path="/5FEB47F2/5FF1759A" Ref="#PWR?"  Part="1" 
AR Path="/5FF1759A" Ref="#PWR0106"  Part="1" 
F 0 "#PWR0106" H 1650 9850 50  0001 C CNN
F 1 "+3.3V" H 1665 10173 50  0000 C CNN
F 2 "" H 1650 10000 50  0001 C CNN
F 3 "" H 1650 10000 50  0001 C CNN
	1    1650 10000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 10050 1650 10050
Wire Wire Line
	1650 10050 1650 10000
Text Notes 7300 9050 0    50   ~ 0
VESC interface\nSerial\nUse JST PH 2 to use straight cable to VESC\nTry to use CAN interface in VESC 100/250 to communicate with charger. At least initially
$Comp
L power:GND #PWR?
U 1 1 5FF32288
P 5050 8800
AR Path="/5FEB47F2/5FF32288" Ref="#PWR?"  Part="1" 
AR Path="/5FF32288" Ref="#PWR0109"  Part="1" 
F 0 "#PWR0109" H 5050 8550 50  0001 C CNN
F 1 "GND" H 5055 8627 50  0000 C CNN
F 2 "" H 5050 8800 50  0001 C CNN
F 3 "" H 5050 8800 50  0001 C CNN
	1    5050 8800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 8750 5050 8750
Wire Wire Line
	5050 8750 5050 8800
Wire Wire Line
	5150 8650 5100 8650
Text Label 5100 8650 2    50   ~ 0
VESC_RX
Text Label 4150 9050 2    50   ~ 0
VESC_TX
Text Notes 4300 8200 2    50   ~ 0
Unclear if VESC TX needs voltage divider. Is it 3.3 or 5V?
$Comp
L Device:R R?
U 1 1 5FF32294
P 4300 8850
AR Path="/5FEB47F2/5FF32294" Ref="R?"  Part="1" 
AR Path="/5FF32294" Ref="R2"  Part="1" 
F 0 "R2" H 4230 8804 50  0000 R CNN
F 1 "2k" H 4230 8895 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4230 8850 50  0001 C CNN
F 3 "~" H 4300 8850 50  0001 C CNN
	1    4300 8850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FF3229A
P 4300 9300
AR Path="/5FEB47F2/5FF3229A" Ref="R?"  Part="1" 
AR Path="/5FF3229A" Ref="R3"  Part="1" 
F 0 "R3" H 4230 9254 50  0000 R CNN
F 1 "3.6k" H 4230 9345 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4230 9300 50  0001 C CNN
F 3 "~" H 4300 9300 50  0001 C CNN
	1    4300 9300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FF322A0
P 4300 9550
AR Path="/5FEB47F2/5FF322A0" Ref="#PWR?"  Part="1" 
AR Path="/5FF322A0" Ref="#PWR0110"  Part="1" 
F 0 "#PWR0110" H 4300 9300 50  0001 C CNN
F 1 "GND" H 4305 9377 50  0000 C CNN
F 2 "" H 4300 9550 50  0001 C CNN
F 3 "" H 4300 9550 50  0001 C CNN
	1    4300 9550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 9550 4300 9450
Wire Wire Line
	4300 9150 4300 9050
Wire Wire Line
	4150 9050 4300 9050
Connection ~ 4300 9050
Wire Wire Line
	4300 9050 4300 9000
Wire Wire Line
	4300 8550 4300 8700
Wire Wire Line
	4300 8550 5150 8550
Wire Wire Line
	3200 2750 4400 2750
Text Label 4400 2750 2    50   ~ 0
GPIO18
Wire Wire Line
	3200 2550 4400 2550
Text Label 4400 2550 2    50   ~ 0
TXD1
Wire Wire Line
	3200 2650 4400 2650
Text Label 4400 2650 2    50   ~ 0
RXD1
$Comp
L Connector_Generic:Conn_01x02 J5
U 1 1 5FF7CE4B
P 5450 4800
F 0 "J5" H 5368 4567 50  0000 C CNN
F 1 "Conn_01x02" H 5368 4566 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 5450 4800 50  0001 C CNN
F 3 "~" H 5450 4800 50  0001 C CNN
	1    5450 4800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FF7DF95
P 5700 4850
AR Path="/5FEB47F2/5FF7DF95" Ref="#PWR?"  Part="1" 
AR Path="/5FF7DF95" Ref="#PWR0122"  Part="1" 
F 0 "#PWR0122" H 5700 4600 50  0001 C CNN
F 1 "GND" H 5705 4677 50  0000 C CNN
F 2 "" H 5700 4850 50  0001 C CNN
F 3 "" H 5700 4850 50  0001 C CNN
	1    5700 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 4800 5700 4800
Wire Wire Line
	5700 4800 5700 4850
Wire Wire Line
	5650 4700 5900 4700
Text Label 5900 4700 0    60   ~ 0
P5V
Text Notes 5350 4450 0    79   ~ 16
Power in from 5V DC/DC\n3 Amp
$Comp
L Connector_Generic:Conn_01x02 J11
U 1 1 5FFCB9F6
P 2350 10800
F 0 "J11" H 2268 10567 50  0000 C CNN
F 1 "Conn_01x02" H 2268 10566 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 2350 10800 50  0001 C CNN
F 3 "~" H 2350 10800 50  0001 C CNN
	1    2350 10800
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FFCCEF7
P 2650 10850
AR Path="/5FEB47F2/5FFCCEF7" Ref="#PWR?"  Part="1" 
AR Path="/5FFCCEF7" Ref="#PWR0123"  Part="1" 
F 0 "#PWR0123" H 2650 10600 50  0001 C CNN
F 1 "GND" H 2655 10677 50  0000 C CNN
F 2 "" H 2650 10850 50  0001 C CNN
F 3 "" H 2650 10850 50  0001 C CNN
	1    2650 10850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2550 10800 2650 10800
Wire Wire Line
	2650 10800 2650 10850
Wire Wire Line
	2550 10700 2650 10700
Text Label 2650 10700 0    50   ~ 0
SW_PWR_2_A
Text Notes 2300 10500 0    50   ~ 0
Power Switch\nOff Sense
Text Label 800  2350 0    50   ~ 0
GPIO2
$Comp
L Connector_Generic:Conn_01x03 J12
U 1 1 5FFF554D
P 7450 10750
F 0 "J12" H 7368 10517 50  0000 C CNN
F 1 "Conn_01x03" H 7368 10516 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x3-RA-0901362203" H 7450 10750 50  0001 C CNN
F 3 "~" H 7450 10750 50  0001 C CNN
	1    7450 10750
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FFF6AB4
P 7200 10900
AR Path="/5FEB47F2/5FFF6AB4" Ref="#PWR?"  Part="1" 
AR Path="/5FFF6AB4" Ref="#PWR0124"  Part="1" 
F 0 "#PWR0124" H 7200 10650 50  0001 C CNN
F 1 "GND" H 7205 10727 50  0000 C CNN
F 2 "" H 7200 10900 50  0001 C CNN
F 3 "" H 7200 10900 50  0001 C CNN
	1    7200 10900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7250 10850 7200 10850
Wire Wire Line
	7200 10850 7200 10900
Wire Wire Line
	7250 10750 7150 10750
Wire Wire Line
	7250 10650 7150 10650
Text Label 7150 10750 2    50   ~ 0
ON
Text Label 7150 10650 2    50   ~ 0
PRECHARGE
Text Notes 7150 10450 0    50   ~ 0
DC/DC\nControl
Wire Wire Line
	3200 2950 4400 2950
Wire Wire Line
	3200 3050 4400 3050
Text Label 4400 2950 2    50   ~ 0
GPIO23
Text Label 4400 3050 2    50   ~ 0
GPIO24
$Comp
L Connector_Generic:Conn_01x02 J13
U 1 1 6005DD91
P 7450 9800
F 0 "J13" H 7368 9567 50  0000 C CNN
F 1 "Conn_01x02" H 7368 9566 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 7450 9800 50  0001 C CNN
F 3 "~" H 7450 9800 50  0001 C CNN
	1    7450 9800
	1    0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60067B07
P 7200 9900
AR Path="/5FEB47F2/60067B07" Ref="#PWR?"  Part="1" 
AR Path="/60067B07" Ref="#PWR0125"  Part="1" 
F 0 "#PWR0125" H 7200 9650 50  0001 C CNN
F 1 "GND" H 7205 9727 50  0000 C CNN
F 2 "" H 7200 9900 50  0001 C CNN
F 3 "" H 7200 9900 50  0001 C CNN
	1    7200 9900
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7250 9800 7200 9800
Wire Wire Line
	7200 9800 7200 9900
Wire Wire Line
	7250 9700 7150 9700
Text Label 7150 9700 2    50   ~ 0
CONTACTOR
Text Label 800  3750 0    50   ~ 0
GPIO6
Wire Wire Line
	2000 3750 800  3750
$Comp
L Connector_Generic:Conn_01x08 J14
U 1 1 600B3697
P 4750 10950
F 0 "J14" V 4668 11330 50  0000 L CNN
F 1 "Conn_01x07" V 4713 11330 50  0001 L CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-2x4-RA-0901303208" H 4750 10950 50  0001 C CNN
F 3 "~" H 4750 10950 50  0001 C CNN
	1    4750 10950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 600BF544
P 5400 10850
AR Path="/5FEB47F2/600BF544" Ref="#PWR?"  Part="1" 
AR Path="/600BF544" Ref="#PWR0126"  Part="1" 
F 0 "#PWR0126" H 5400 10600 50  0001 C CNN
F 1 "GND" H 5405 10677 50  0000 C CNN
F 2 "" H 5400 10850 50  0001 C CNN
F 3 "" H 5400 10850 50  0001 C CNN
	1    5400 10850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 10750 5050 10650
Wire Wire Line
	5050 10650 5400 10650
Wire Wire Line
	5400 10650 5400 10850
Text Label 4150 5950 2    60   ~ 0
P3V3
$Comp
L power:+3.3V #PWR0127
U 1 1 600DCB9D
P 4350 5900
F 0 "#PWR0127" H 4350 5750 50  0001 C CNN
F 1 "+3.3V" H 4365 6073 50  0000 C CNN
F 2 "" H 4350 5900 50  0001 C CNN
F 3 "" H 4350 5900 50  0001 C CNN
	1    4350 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 5950 4350 5950
Wire Wire Line
	4350 5950 4350 5900
$Comp
L power:+3.3V #PWR0128
U 1 1 600E7398
P 4400 10650
F 0 "#PWR0128" H 4400 10500 50  0001 C CNN
F 1 "+3.3V" H 4415 10823 50  0000 C CNN
F 2 "" H 4400 10650 50  0001 C CNN
F 3 "" H 4400 10650 50  0001 C CNN
	1    4400 10650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 10750 4450 10650
Wire Wire Line
	4550 10750 4550 10400
Wire Wire Line
	4450 10650 4400 10650
Wire Wire Line
	4650 10750 4650 10400
Wire Wire Line
	4750 10750 4750 10400
Wire Wire Line
	4850 10750 4850 10400
Wire Wire Line
	4950 10750 4950 10400
Text Label 4850 10400 1    50   ~ 0
ADC_nIRQ
Text Label 4650 10400 1    50   ~ 0
ADC_MISO
Text Label 4950 10400 1    50   ~ 0
ADC_MOSI
Text Label 4750 10400 1    50   ~ 0
ADC_SCLK
Text Label 4550 10400 1    50   ~ 0
ADC_CS
Text Notes 4350 11100 0    50   ~ 0
Current Shunt ADC
$Comp
L Connector_Generic:Conn_01x03 J4
U 1 1 601402EA
P 5350 8650
F 0 "J4" H 5430 8692 50  0000 L CNN
F 1 "Conn_01x03" H 5430 8601 50  0000 L CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x3-RA-0901362203" H 5350 8650 50  0001 C CNN
F 3 "~" H 5350 8650 50  0001 C CNN
	1    5350 8650
	1    0    0    1   
$EndComp
Text Notes 7150 4350 0    50   ~ 0
Raspberry pi pins:\nSerial ports: \n* UART1: GPIO 14,15, Pins 8, 10 (BMS)\n* UART2: GPIO 0,1, Pins 27, 28, (Used by Hat ID)\n* UART3: GPIO 4,5: Pins 7, 29, (GPS)\n* UART4 GPIO 8, 9: Pins 24 (TXD4), Pin 21 (VESC)\n* UART5: GPIO 12, 13: Pins 32 (TXD5), Pin  33 (RXD5), ,both are PWM pins\n\nSPI options:\n* SPI0: pins \n* SPI1 pins (GPIO 18-21, pins 35, 36, 38, 40) Use\nCan’t use TXD2/RXD2, they’re used by hat ID\nWe need 3 serial ports: for BMS (Port 1, pins 8 & 10), VESC (, and GPS\nWe need SPI for the current ADC\nWe need \nRX0/TX0: 
Wire Wire Line
	800  2350 2000 2350
Wire Wire Line
	2000 2450 800  2450
Text Label 800  2450 0    50   ~ 0
GPIO3
Wire Wire Line
	2000 3050 800  3050
Text Label 800  3050 0    60   ~ 0
P3V3
Text Label 13250 5700 0    50   ~ 0
CHARGER_POWER_SENSE
Text Label 14300 4400 0    50   ~ 0
TYPE2_PROXIMITY
Text Label 13250 5900 0    50   ~ 0
PILOT_OUT
Text Label 13250 5600 0    50   ~ 0
TYPE2_PILOT_SEND
$Comp
L power:+3.3V #PWR0107
U 1 1 601DB6C1
P 13100 5200
F 0 "#PWR0107" H 13100 5050 50  0001 C CNN
F 1 "+3.3V" H 13115 5373 50  0000 C CNN
F 2 "" H 13100 5200 50  0001 C CNN
F 3 "" H 13100 5200 50  0001 C CNN
	1    13100 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 601DC015
P 13150 6100
AR Path="/5FEB47F2/601DC015" Ref="#PWR?"  Part="1" 
AR Path="/601DC015" Ref="#PWR0108"  Part="1" 
F 0 "#PWR0108" H 13150 5850 50  0001 C CNN
F 1 "GND" H 13155 5927 50  0000 C CNN
F 2 "" H 13150 6100 50  0001 C CNN
F 3 "" H 13150 6100 50  0001 C CNN
	1    13150 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	12950 5300 13100 5300
Wire Wire Line
	13100 5300 13100 5200
Wire Wire Line
	12950 6000 13150 6000
Wire Wire Line
	13150 6000 13150 6100
Wire Wire Line
	12950 5700 13250 5700
Wire Wire Line
	12950 5900 13250 5900
Wire Wire Line
	12950 5800 13250 5800
Wire Wire Line
	12950 5600 13250 5600
$Comp
L Jumper:SolderJumper_2_Bridged JP2
U 1 1 60263C4B
P 9800 5450
F 0 "JP2" H 9800 5350 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 5564 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5450 50  0001 C CNN
F 3 "~" H 9800 5450 50  0001 C CNN
	1    9800 5450
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP1
U 1 1 602C09A8
P 9800 5350
F 0 "JP1" H 9800 5250 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 5464 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5350 50  0001 C CNN
F 3 "~" H 9800 5350 50  0001 C CNN
	1    9800 5350
	1    0    0    -1  
$EndComp
Connection ~ 2100 9000
Wire Wire Line
	1450 9200 2050 9200
$Comp
L Connector:Conn_01x03_Male J10
U 1 1 60357F69
P 9350 5450
F 0 "J10" H 9350 5200 50  0001 R CNN
F 1 "Conn_01x03_Male" H 9322 5473 50  0001 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 9350 5450 50  0001 C CNN
F 3 "~" H 9350 5450 50  0001 C CNN
	1    9350 5450
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP4
U 1 1 60359E9A
P 9800 5550
F 0 "JP4" H 9800 5450 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 5664 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5550 50  0001 C CNN
F 3 "~" H 9800 5550 50  0001 C CNN
	1    9800 5550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x03_Male J15
U 1 1 603682E8
P 10250 5450
F 0 "J15" H 10222 5428 50  0001 R CNN
F 1 "Conn_01x03_Male" H 10358 5640 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 10250 5450 50  0001 C CNN
F 3 "~" H 10250 5450 50  0001 C CNN
	1    10250 5450
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9650 5550 9600 5550
Wire Wire Line
	9950 6050 10000 6050
Wire Wire Line
	10000 5550 10000 5600
Wire Wire Line
	10000 5600 10350 5600
Wire Wire Line
	9550 5450 9600 5450
Wire Wire Line
	10350 5500 10000 5500
Wire Wire Line
	10000 5500 10000 5450
Wire Wire Line
	10000 5450 10050 5450
Wire Wire Line
	9600 5550 9600 5600
Wire Wire Line
	1500 10250 1600 10250
Connection ~ 9600 5550
Wire Wire Line
	9600 5550 9550 5550
Wire Wire Line
	9600 5450 9600 5500
Wire Wire Line
	9600 5500 9300 5500
Connection ~ 9600 5450
Wire Wire Line
	9600 5450 9650 5450
Wire Wire Line
	2100 9000 2200 9000
Wire Wire Line
	10350 5400 10000 5400
Wire Wire Line
	10000 5400 10000 5350
Wire Wire Line
	10000 5350 10050 5350
Text Label 10350 5600 0    50   ~ 0
RXD1
Text Label 10300 7000 0    50   ~ 0
TXD1
Text Label 9250 7000 2    50   ~ 0
BMS_RX
Wire Wire Line
	9600 5600 9300 5600
Text Label 9300 5600 2    50   ~ 0
BMS_TX
Wire Wire Line
	9550 5350 9600 5350
Wire Wire Line
	9600 5350 9600 5400
Wire Wire Line
	9600 5400 9300 5400
Connection ~ 9600 5350
Wire Wire Line
	9600 5350 9650 5350
Text Label 9250 6900 2    50   ~ 0
BMS_nFault
Text Label 10350 5400 0    50   ~ 0
GPIO2
$Comp
L Connector:Conn_01x04_Male J16
U 1 1 6071553E
P 9350 5850
F 0 "J16" H 9458 6131 50  0001 C CNN
F 1 "Conn_01x04_Male" H 9458 6040 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 9350 5850 50  0001 C CNN
F 3 "~" H 9350 5850 50  0001 C CNN
	1    9350 5850
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP5
U 1 1 60724BDE
P 9800 5750
F 0 "JP5" H 9800 5650 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 5864 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5750 50  0001 C CNN
F 3 "~" H 9800 5750 50  0001 C CNN
	1    9800 5750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x04_Male J17
U 1 1 60724F86
P 10250 5850
F 0 "J17" H 10222 5824 50  0001 R CNN
F 1 "Conn_01x04_Male" H 10222 5733 50  0001 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 10250 5850 50  0001 C CNN
F 3 "~" H 10250 5850 50  0001 C CNN
	1    10250 5850
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9950 5950 10000 5950
Wire Wire Line
	9950 5850 10000 5850
Wire Wire Line
	9950 5750 10000 5750
Wire Wire Line
	9550 5750 9600 5750
Wire Wire Line
	9550 5850 9600 5850
Wire Wire Line
	9550 5950 9600 5950
Wire Wire Line
	9550 6050 9600 6050
$Comp
L Jumper:SolderJumper_2_Bridged JP7
U 1 1 60803389
P 9800 5950
F 0 "JP7" H 9800 5850 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6064 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5950 50  0001 C CNN
F 3 "~" H 9800 5950 50  0001 C CNN
	1    9800 5950
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP8
U 1 1 6080338F
P 9800 6050
F 0 "JP8" H 9800 5950 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6164 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6050 50  0001 C CNN
F 3 "~" H 9800 6050 50  0001 C CNN
	1    9800 6050
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP6
U 1 1 60803395
P 9800 5850
F 0 "JP6" H 9800 5750 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 5964 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 5850 50  0001 C CNN
F 3 "~" H 9800 5850 50  0001 C CNN
	1    9800 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 5350 10000 5350
Connection ~ 10000 5350
Wire Wire Line
	9950 5450 10000 5450
Connection ~ 10000 5450
Wire Wire Line
	9950 5550 10000 5550
Connection ~ 10000 5550
Wire Wire Line
	10000 5550 10050 5550
Wire Wire Line
	9600 5750 9600 5800
Wire Wire Line
	9600 5800 9250 5800
Connection ~ 9600 5750
Wire Wire Line
	9600 5750 9650 5750
Wire Wire Line
	9600 5850 9600 5900
Wire Wire Line
	9600 5900 9250 5900
Connection ~ 9600 5850
Wire Wire Line
	9600 5850 9650 5850
Wire Wire Line
	9600 5950 9600 6000
Wire Wire Line
	9600 6000 9250 6000
Connection ~ 9600 5950
Wire Wire Line
	9600 5950 9650 5950
Wire Wire Line
	9600 6050 9600 6100
Wire Wire Line
	9600 6100 9250 6100
Connection ~ 9600 6050
Wire Wire Line
	9600 6050 9650 6050
Text Label 9250 6100 2    50   ~ 0
ON
Wire Wire Line
	10000 5750 10000 5800
Wire Wire Line
	10000 5800 10300 5800
Connection ~ 10000 5750
Wire Wire Line
	10000 5750 10050 5750
Wire Wire Line
	10000 5850 10000 5900
Wire Wire Line
	10000 5900 10300 5900
Connection ~ 10000 5850
Wire Wire Line
	10000 5850 10050 5850
Wire Wire Line
	10000 5950 10000 6000
Wire Wire Line
	10000 6000 10300 6000
Connection ~ 10000 5950
Wire Wire Line
	10000 5950 10050 5950
Wire Wire Line
	10000 6050 10000 6100
Wire Wire Line
	10000 6100 10300 6100
Connection ~ 10000 6050
Wire Wire Line
	10000 6050 10050 6050
Text Label 10350 5500 0    50   ~ 0
GPIO3
Text Label 9250 6400 2    50   ~ 0
PRECHARGE
Text Label 10300 5800 0    50   ~ 0
GPIO18
Text Label 9250 6500 2    50   ~ 0
GPS_RX
Text Label 10300 6500 0    50   ~ 0
TXD3
Text Label 9250 6600 2    50   ~ 0
GPS_TX
Text Label 10300 6600 0    50   ~ 0
RXD3
Wire Wire Line
	2000 3150 800  3150
Wire Wire Line
	2000 3250 800  3250
Wire Wire Line
	2000 3350 800  3350
Text Label 800  3250 0    50   ~ 0
RXD4
Wire Wire Line
	2000 2550 800  2550
Text Label 800  2550 0    50   ~ 0
TXD3
Wire Wire Line
	2000 3650 800  3650
Text Label 800  3650 0    50   ~ 0
RXD3
Wire Wire Line
	2000 3950 800  3950
Text Label 800  3950 0    50   ~ 0
SPI1_MISO
Wire Wire Line
	3200 3950 4400 3950
Text Label 4400 3950 2    50   ~ 0
SPI1_CS0
Wire Wire Line
	3200 3350 4400 3350
Wire Wire Line
	3200 4050 4400 4050
Text Label 4400 4050 2    50   ~ 0
SPI1_MOSI
Wire Wire Line
	3200 4150 4400 4150
Text Label 4400 4150 2    50   ~ 0
SPI1_SCLK
Text Label 4400 3350 2    60   ~ 0
TXD4
Text Notes 10350 4950 2    50   ~ 0
Allow pin changes after production
$Comp
L Connector:Conn_01x07_Male J6
U 1 1 60B00106
P 9350 6650
F 0 "J6" H 9458 7131 50  0001 C CNN
F 1 "Conn_01x07_Male" H 9458 7040 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x07_P2.54mm_Vertical" H 9350 6650 50  0001 C CNN
F 3 "~" H 9350 6650 50  0001 C CNN
	1    9350 6650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x07_Male J18
U 1 1 60B012A4
P 10250 6650
F 0 "J18" H 10085 6628 50  0001 C CNN
F 1 "Conn_01x07_Male" V 10176 6628 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x07_P2.54mm_Vertical" H 10250 6650 50  0001 C CNN
F 3 "~" H 10250 6650 50  0001 C CNN
	1    10250 6650
	-1   0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP3
U 1 1 60B2AB07
P 9800 6350
F 0 "JP3" H 9800 6250 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6464 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6350 50  0001 C CNN
F 3 "~" H 9800 6350 50  0001 C CNN
	1    9800 6350
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP10
U 1 1 60B2AB11
P 9800 6550
F 0 "JP10" H 9800 6450 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6664 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6550 50  0001 C CNN
F 3 "~" H 9800 6550 50  0001 C CNN
	1    9800 6550
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP11
U 1 1 60B2AB1B
P 9800 6650
F 0 "JP11" H 9800 6550 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6764 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6650 50  0001 C CNN
F 3 "~" H 9800 6650 50  0001 C CNN
	1    9800 6650
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP9
U 1 1 60B2AB25
P 9800 6450
F 0 "JP9" H 9800 6350 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6564 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6450 50  0001 C CNN
F 3 "~" H 9800 6450 50  0001 C CNN
	1    9800 6450
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP13
U 1 1 60B38DAF
P 9800 6850
F 0 "JP13" H 9800 6750 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6964 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6850 50  0001 C CNN
F 3 "~" H 9800 6850 50  0001 C CNN
	1    9800 6850
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP14
U 1 1 60B38DB9
P 9800 6950
F 0 "JP14" H 9800 6850 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7064 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6950 50  0001 C CNN
F 3 "~" H 9800 6950 50  0001 C CNN
	1    9800 6950
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP12
U 1 1 60B38DC3
P 9800 6750
F 0 "JP12" H 9800 6650 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 6864 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 6750 50  0001 C CNN
F 3 "~" H 9800 6750 50  0001 C CNN
	1    9800 6750
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 6350 9600 6350
Wire Wire Line
	9550 6450 9600 6450
Wire Wire Line
	9550 6550 9600 6550
Wire Wire Line
	9550 6650 9600 6650
Wire Wire Line
	9550 6750 9600 6750
Wire Wire Line
	9550 6850 9600 6850
Wire Wire Line
	9550 6950 9600 6950
Wire Wire Line
	9950 6950 10000 6950
Wire Wire Line
	9950 6650 10000 6650
Wire Wire Line
	9950 6550 10000 6550
Wire Wire Line
	9950 6450 10000 6450
Wire Wire Line
	9950 6350 10000 6350
$Comp
L Jumper:SolderJumper_2_Bridged JP15
U 1 1 60C15381
P 9800 7450
F 0 "JP15" H 9800 7350 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7564 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7450 50  0001 C CNN
F 3 "~" H 9800 7450 50  0001 C CNN
	1    9800 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 7450 9600 7450
Wire Wire Line
	9550 7550 9600 7550
Wire Wire Line
	9550 7650 9600 7650
Wire Wire Line
	9550 7750 9600 7750
$Comp
L Jumper:SolderJumper_2_Bridged JP17
U 1 1 60C1539C
P 9800 7650
F 0 "JP17" H 9800 7550 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7764 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7650 50  0001 C CNN
F 3 "~" H 9800 7650 50  0001 C CNN
	1    9800 7650
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP18
U 1 1 60C153A6
P 9800 7750
F 0 "JP18" H 9800 7650 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7864 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7750 50  0001 C CNN
F 3 "~" H 9800 7750 50  0001 C CNN
	1    9800 7750
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP16
U 1 1 60C153B0
P 9800 7550
F 0 "JP16" H 9800 7450 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7664 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7550 50  0001 C CNN
F 3 "~" H 9800 7550 50  0001 C CNN
	1    9800 7550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 7450 9600 7500
Wire Wire Line
	9600 7500 9250 7500
Connection ~ 9600 7450
Wire Wire Line
	9600 7450 9650 7450
Wire Wire Line
	9600 7550 9600 7600
Wire Wire Line
	9600 7600 9250 7600
Connection ~ 9600 7550
Wire Wire Line
	9600 7550 9650 7550
Wire Wire Line
	9600 7650 9600 7700
Wire Wire Line
	9600 7700 9250 7700
Connection ~ 9600 7650
Wire Wire Line
	9600 7650 9650 7650
Wire Wire Line
	9600 7750 9600 7800
Wire Wire Line
	9600 7800 9250 7800
Connection ~ 9600 7750
Wire Wire Line
	9600 7750 9650 7750
Wire Wire Line
	4350 10750 4150 10750
Wire Wire Line
	4150 10750 4150 10600
Text Label 4150 10600 1    50   ~ 0
P5V
Wire Wire Line
	2000 2750 800  2750
Text Label 800  2750 0    50   ~ 0
GPIO17
Wire Wire Line
	9600 6350 9600 6400
Wire Wire Line
	9600 6400 9250 6400
Connection ~ 9600 6350
Wire Wire Line
	9600 6350 9650 6350
Text Label 9250 6700 2    50   ~ 0
SW_PWR_2_A
Wire Wire Line
	10000 6350 10000 6400
Wire Wire Line
	10000 6400 10300 6400
Connection ~ 10000 6350
Wire Wire Line
	10000 6350 10050 6350
Text Label 10300 5900 0    50   ~ 0
GPIO17
Text Label 9250 6800 2    50   ~ 0
CONTACTOR
Wire Wire Line
	9250 6500 9600 6500
Wire Wire Line
	9600 6500 9600 6450
Connection ~ 9600 6450
Wire Wire Line
	9600 6450 9650 6450
Wire Wire Line
	2000 2850 800  2850
Text Label 800  2850 0    50   ~ 0
GPIO27
Wire Wire Line
	10000 6450 10000 6500
Wire Wire Line
	10000 6500 10300 6500
Connection ~ 10000 6450
Wire Wire Line
	10000 6450 10050 6450
Text Label 10300 6000 0    50   ~ 0
GPIO27
Wire Wire Line
	9600 6550 9600 6600
Wire Wire Line
	9600 6600 9250 6600
Connection ~ 9600 6550
Wire Wire Line
	9600 6550 9650 6550
Text Label 9250 7600 2    50   ~ 0
ADC_MISO
Wire Wire Line
	10000 6550 10000 6600
Wire Wire Line
	10000 6600 10300 6600
Connection ~ 10000 6550
Wire Wire Line
	10000 6550 10050 6550
Text Label 10300 7550 0    50   ~ 0
SPI1_MISO
Wire Wire Line
	9600 6650 9600 6700
Wire Wire Line
	9600 6700 9250 6700
Connection ~ 9600 6650
Wire Wire Line
	9600 6650 9650 6650
Text Label 9250 7800 2    50   ~ 0
ADC_nIRQ
Wire Wire Line
	10000 6650 10000 6700
Wire Wire Line
	10000 6700 10300 6700
Connection ~ 10000 6650
Wire Wire Line
	10000 6650 10050 6650
Text Label 10300 6100 0    50   ~ 0
GPIO23
Wire Wire Line
	9600 6750 9600 6800
Wire Wire Line
	9600 6800 9250 6800
Connection ~ 9600 6750
Wire Wire Line
	9600 6750 9650 6750
Text Label 9250 7500 2    50   ~ 0
ADC_CS
Wire Wire Line
	9950 6750 10000 6750
Wire Wire Line
	9950 6850 10000 6850
Wire Wire Line
	10000 6750 10000 6800
Wire Wire Line
	10000 6800 10300 6800
Connection ~ 10000 6750
Wire Wire Line
	10000 6750 10050 6750
Text Label 10300 7450 0    50   ~ 0
SPI1_CS0
Wire Wire Line
	9600 6850 9600 6900
Wire Wire Line
	9600 6900 9250 6900
Connection ~ 9600 6850
Wire Wire Line
	9600 6850 9650 6850
Text Label 9250 7900 2    50   ~ 0
ADC_SCLK
Text Label 10300 7850 0    50   ~ 0
SPI1_SCLK
Wire Wire Line
	10300 6900 10000 6900
Wire Wire Line
	10000 6900 10000 6850
Connection ~ 10000 6850
Wire Wire Line
	10000 6850 10050 6850
Wire Wire Line
	10000 6950 10000 7000
Wire Wire Line
	10000 7000 10300 7000
Connection ~ 10000 6950
Wire Wire Line
	10000 6950 10050 6950
Text Label 10300 7650 0    50   ~ 0
SPI1_MOSI
Wire Wire Line
	9600 6950 9600 7000
Wire Wire Line
	9600 7000 9250 7000
Connection ~ 9600 6950
Wire Wire Line
	9600 6950 9650 6950
Text Label 9250 7700 2    50   ~ 0
ADC_MOSI
Text Label 9250 5800 2    50   ~ 0
PILOT_OUT
Text Label 9300 5500 2    50   ~ 0
TYPE2_PILOT_SEND
Wire Wire Line
	2000 2950 800  2950
Text Label 800  2950 0    50   ~ 0
GPIO22
Text Label 10300 6400 0    50   ~ 0
GPIO22
Text Label 10300 6700 0    50   ~ 0
GPIO24
Text Label 800  3150 0    60   ~ 0
GPIO10
Text Label 10300 6800 0    50   ~ 0
GPIO10
Text Label 9250 7300 2    50   ~ 0
VESC_RX
Text Label 10300 7250 0    50   ~ 0
TXD4
Wire Wire Line
	2000 4050 800  4050
Text Label 800  4050 0    50   ~ 0
GPIO26
Text Label 10300 7750 0    50   ~ 0
GPIO26
$Comp
L Connector:Conn_01x05_Male J19
U 1 1 60C15377
P 9350 7650
F 0 "J19" H 9458 7931 50  0001 C CNN
F 1 "Conn_01x04_Male" H 9458 7840 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical" H 9350 7650 50  0001 C CNN
F 3 "~" H 9350 7650 50  0001 C CNN
	1    9350 7650
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP19
U 1 1 61103991
P 9800 7850
F 0 "JP19" H 9800 7750 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7964 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7850 50  0001 C CNN
F 3 "~" H 9800 7850 50  0001 C CNN
	1    9800 7850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 7850 9600 7850
Wire Wire Line
	9950 7850 10300 7850
Wire Wire Line
	9600 7850 9600 7900
Wire Wire Line
	9600 7900 9250 7900
Connection ~ 9600 7850
Wire Wire Line
	9600 7850 9550 7850
Wire Wire Line
	9950 7750 10300 7750
Wire Wire Line
	9950 7650 10300 7650
Wire Wire Line
	9950 7550 10300 7550
Wire Wire Line
	9950 7450 10300 7450
$Comp
L Connector:Conn_01x01_Male J20
U 1 1 613A2F0A
P 9350 7150
F 0 "J20" H 9458 7239 50  0001 C CNN
F 1 "Conn_01x01_Male" H 9458 7240 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 9350 7150 50  0001 C CNN
F 3 "~" H 9350 7150 50  0001 C CNN
	1    9350 7150
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP20
U 1 1 613C27CA
P 9800 7150
F 0 "JP20" H 9800 7050 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7264 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7150 50  0001 C CNN
F 3 "~" H 9800 7150 50  0001 C CNN
	1    9800 7150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 7150 9600 7150
Wire Wire Line
	9600 7150 9600 7200
Wire Wire Line
	9600 7200 9250 7200
Connection ~ 9600 7150
Wire Wire Line
	9600 7150 9550 7150
Text Label 9250 7200 2    50   ~ 0
VESC_TX
Wire Wire Line
	9950 7150 10300 7150
Text Label 10300 7150 0    50   ~ 0
RXD4
Text Notes 2300 10300 0    50   ~ 0
TODO: Control power switch led through here?\n
$Comp
L Connector_Generic:Conn_01x08 J8
U 1 1 61B29155
P 12750 5700
F 0 "J8" H 12668 5075 50  0000 C CNN
F 1 "Conn_01x08" H 12668 5166 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-2x4-RA-0901303208" H 12750 5700 50  0001 C CNN
F 3 "~" H 12750 5700 50  0001 C CNN
	1    12750 5700
	-1   0    0    1   
$EndComp
Text Label 13250 5800 0    50   ~ 0
PROXIMITY_1
Wire Wire Line
	12950 5400 13250 5400
Text Label 13250 5400 0    50   ~ 0
PROXIMITY_0
$Comp
L Connector:Conn_01x01_Male J21
U 1 1 61B9875E
P 9350 7250
F 0 "J21" H 9458 7339 50  0001 C CNN
F 1 "Conn_01x01_Male" H 9458 7340 50  0001 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 9350 7250 50  0001 C CNN
F 3 "~" H 9350 7250 50  0001 C CNN
	1    9350 7250
	1    0    0    -1  
$EndComp
$Comp
L Jumper:SolderJumper_2_Bridged JP21
U 1 1 61B98768
P 9800 7250
F 0 "JP21" H 9800 7150 50  0001 C CNN
F 1 "SolderJumper_2_Bridged" H 9800 7364 50  0001 C CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Bridged_RoundedPad1.0x1.5mm" H 9800 7250 50  0001 C CNN
F 3 "~" H 9800 7250 50  0001 C CNN
	1    9800 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 7250 9600 7250
Wire Wire Line
	9600 7250 9600 7300
Wire Wire Line
	9600 7300 9250 7300
Connection ~ 9600 7250
Wire Wire Line
	9600 7250 9550 7250
Wire Wire Line
	9950 7250 10300 7250
Text Label 10900 6400 0    50   ~ 0
GPIO6
Text Label 9300 5400 2    50   ~ 0
PROXIMITY_0
Text Label 9250 5900 2    50   ~ 0
PROXIMITY_1
Text Label 9250 6000 2    50   ~ 0
CHARGER_POWER_SENSE
Wire Wire Line
	3200 3250 4400 3250
Text Label 4400 3250 2    50   ~ 0
GPIO25
Text Label 10300 6900 0    50   ~ 0
GPIO25
$EndSCHEMATC
