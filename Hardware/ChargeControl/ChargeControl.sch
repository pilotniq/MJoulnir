EESchema Schematic File Version 4
LIBS:ChargeControl-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R R5
U 1 1 60244E78
P 5800 2100
AR Path="/60244E78" Ref="R5"  Part="1" 
AR Path="/602353FF/60244E78" Ref="R?"  Part="1" 
F 0 "R5" H 5730 2054 50  0000 R CNN
F 1 "100k" H 5730 2145 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5730 2100 50  0001 C CNN
F 3 "~" H 5800 2100 50  0001 C CNN
	1    5800 2100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R6
U 1 1 60244E7E
P 5800 2500
AR Path="/60244E7E" Ref="R6"  Part="1" 
AR Path="/602353FF/60244E7E" Ref="R?"  Part="1" 
F 0 "R6" H 5730 2454 50  0000 R CNN
F 1 "30k" H 5730 2545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5730 2500 50  0001 C CNN
F 3 "~" H 5800 2500 50  0001 C CNN
	1    5800 2500
	-1   0    0    1   
$EndComp
Wire Wire Line
	5800 2700 5800 2650
Wire Wire Line
	5800 2350 5800 2300
Connection ~ 5800 2300
Wire Wire Line
	5800 2300 5800 2250
Wire Wire Line
	5800 1900 5800 1950
Wire Wire Line
	5600 1900 5700 1900
$Comp
L power:+12V #PWR012
U 1 1 60244E94
P 6800 1800
AR Path="/60244E94" Ref="#PWR012"  Part="1" 
AR Path="/602353FF/60244E94" Ref="#PWR?"  Part="1" 
F 0 "#PWR012" H 6800 1650 50  0001 C CNN
F 1 "+12V" H 6815 1973 50  0000 C CNN
F 2 "" H 6800 1800 50  0001 C CNN
F 3 "" H 6800 1800 50  0001 C CNN
	1    6800 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 3700 3750 3700
$Comp
L Device:R R2
U 1 1 6025E03D
P 5350 3900
AR Path="/6025E03D" Ref="R2"  Part="1" 
AR Path="/602353FF/6025E03D" Ref="R?"  Part="1" 
F 0 "R2" H 5280 3854 50  0000 R CNN
F 1 "2.0k 1%" H 5280 3945 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5280 3900 50  0001 C CNN
F 3 "~" H 5350 3900 50  0001 C CNN
	1    5350 3900
	-1   0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 6025E04C
P 4800 3900
AR Path="/6025E04C" Ref="R1"  Part="1" 
AR Path="/602353FF/6025E04C" Ref="R?"  Part="1" 
F 0 "R1" H 4730 3854 50  0000 R CNN
F 1 "1.3k" H 4730 3945 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4730 3900 50  0001 C CNN
F 3 "~" H 4800 3900 50  0001 C CNN
	1    4800 3900
	-1   0    0    1   
$EndComp
Wire Wire Line
	4800 3700 4800 3750
Wire Wire Line
	4800 4150 4800 4050
$Comp
L power:GND #PWR03
U 1 1 6025E05C
P 4800 5000
AR Path="/6025E05C" Ref="#PWR03"  Part="1" 
AR Path="/602353FF/6025E05C" Ref="#PWR?"  Part="1" 
F 0 "#PWR03" H 4800 4750 50  0001 C CNN
F 1 "GND" H 4805 4827 50  0000 C CNN
F 2 "" H 4800 5000 50  0001 C CNN
F 3 "" H 4800 5000 50  0001 C CNN
	1    4800 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 5000 4800 4900
Wire Wire Line
	4500 4350 4450 4350
$Comp
L 74xGxx:74AHC1G14 U1
U 1 1 6025E065
P 6050 4100
AR Path="/6025E065" Ref="U1"  Part="1" 
AR Path="/602353FF/6025E065" Ref="U?"  Part="1" 
F 0 "U1" H 6025 4367 50  0000 C CNN
F 1 "74LVC1G14" H 6025 4276 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-353_SC-70-5_Handsoldering" H 6050 4100 50  0001 C CNN
F 3 "https://www.ti.com/lit/ds/symlink/sn74lvc1g14.pdf" H 6050 4100 50  0001 C CNN
	1    6050 4100
	1    0    0    -1  
$EndComp
Connection ~ 4800 3700
$Comp
L Device:R R4
U 1 1 60266F83
P 5600 5850
AR Path="/60266F83" Ref="R4"  Part="1" 
AR Path="/602353FF/60266F83" Ref="R?"  Part="1" 
F 0 "R4" H 5530 5804 50  0000 R CNN
F 1 "DNP (2.7k in connector?)" H 5530 5895 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5530 5850 50  0001 C CNN
F 3 "~" H 5600 5850 50  0001 C CNN
	1    5600 5850
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 60266F89
P 5600 6050
AR Path="/60266F89" Ref="#PWR05"  Part="1" 
AR Path="/602353FF/60266F89" Ref="#PWR?"  Part="1" 
F 0 "#PWR05" H 5600 5800 50  0001 C CNN
F 1 "GND" H 5605 5877 50  0000 C CNN
F 2 "" H 5600 6050 50  0001 C CNN
F 3 "" H 5600 6050 50  0001 C CNN
	1    5600 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 6050 5600 6000
Wire Wire Line
	5600 5650 5600 5700
$Comp
L Device:R R7
U 1 1 60266F97
P 6000 5400
AR Path="/60266F97" Ref="R7"  Part="1" 
AR Path="/602353FF/60266F97" Ref="R?"  Part="1" 
F 0 "R7" H 5930 5354 50  0000 R CNN
F 1 "330" H 5930 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5930 5400 50  0001 C CNN
F 3 "~" H 6000 5400 50  0001 C CNN
	1    6000 5400
	-1   0    0    1   
$EndComp
Wire Wire Line
	5600 5650 6000 5650
Wire Wire Line
	6000 5650 6000 5550
Wire Wire Line
	6000 5250 6000 5200
Connection ~ 6000 5650
$Comp
L power:GND #PWR020
U 1 1 60266FAD
P 10400 5150
AR Path="/60266FAD" Ref="#PWR020"  Part="1" 
AR Path="/602353FF/60266FAD" Ref="#PWR?"  Part="1" 
F 0 "#PWR020" H 10400 4900 50  0001 C CNN
F 1 "GND" H 10405 4977 50  0000 C CNN
F 2 "" H 10400 5150 50  0001 C CNN
F 3 "" H 10400 5150 50  0001 C CNN
	1    10400 5150
	1    0    0    -1  
$EndComp
Text Notes 4800 1500 0    50   ~ 0
Polyfuse to prevent more than 5A draw\nIn a charging situation, battery will also provide power to 12V DC/DC, \nso no problem if fuse trips and 12V is powered by battery only.\nProblem is if bilge pump starts before contactor is turned on.\n\nWith current solution, bilge pump can’t run when boat is turned\noff. Do we want to always power RasPi and 12V system?\n\nInitial resistance 34 mOhm @ 3A is 0,1V voltage drop, 0,3 mW\n\nThis diode must handle 5A\nUse: Bel Fuse 0ZCF0300AF2C
Wire Wire Line
	6050 4200 6050 4250
$Comp
L power:GND #PWR09
U 1 1 604D43DE
P 6050 4250
AR Path="/604D43DE" Ref="#PWR09"  Part="1" 
AR Path="/602353FF/604D43DE" Ref="#PWR?"  Part="1" 
F 0 "#PWR09" H 6050 4000 50  0001 C CNN
F 1 "GND" H 6055 4077 50  0000 C CNN
F 2 "" H 6050 4250 50  0001 C CNN
F 3 "" H 6050 4250 50  0001 C CNN
	1    6050 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 4000 6050 3750
$Comp
L power:+3.3V #PWR08
U 1 1 604D504B
P 6050 3750
F 0 "#PWR08" H 6050 3600 50  0001 C CNN
F 1 "+3.3V" H 6065 3923 50  0000 C CNN
F 2 "" H 6050 3750 50  0001 C CNN
F 3 "" H 6050 3750 50  0001 C CNN
	1    6050 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 2800 9650 2800
Wire Wire Line
	9650 2800 9650 2850
$Comp
L power:GND #PWR018
U 1 1 618E08DA
P 9650 2850
AR Path="/618E08DA" Ref="#PWR018"  Part="1" 
AR Path="/602353FF/618E08DA" Ref="#PWR?"  Part="1" 
F 0 "#PWR018" H 9650 2600 50  0001 C CNN
F 1 "GND" H 9655 2677 50  0000 C CNN
F 2 "" H 9650 2850 50  0001 C CNN
F 3 "" H 9650 2850 50  0001 C CNN
	1    9650 2850
	-1   0    0    -1  
$EndComp
Text Notes 6900 3350 0    50   ~ 0
From Wikipedia schematic
Wire Wire Line
	8100 1800 8000 1800
Wire Wire Line
	8000 1800 8000 1850
$Comp
L power:+12V #PWR013
U 1 1 618E4D11
P 7950 1400
AR Path="/618E4D11" Ref="#PWR013"  Part="1" 
AR Path="/602353FF/618E4D11" Ref="#PWR?"  Part="1" 
F 0 "#PWR013" H 7950 1250 50  0001 C CNN
F 1 "+12V" H 7965 1573 50  0000 C CNN
F 2 "" H 7950 1400 50  0001 C CNN
F 3 "" H 7950 1400 50  0001 C CNN
	1    7950 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7950 1600 7950 1500
Wire Wire Line
	6250 1900 6400 1900
$Comp
L power:+3.3V #PWR07
U 1 1 618E8252
P 6000 5200
F 0 "#PWR07" H 6000 5050 50  0001 C CNN
F 1 "+3.3V" H 6015 5373 50  0000 C CNN
F 2 "" H 6000 5200 50  0001 C CNN
F 3 "" H 6000 5200 50  0001 C CNN
	1    6000 5200
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP602 U2
U 1 1 618ECB40
P 7850 5250
F 0 "U2" H 7850 5617 50  0000 C CNN
F 1 "MCP602" H 7850 5526 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 7850 5250 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21314g.pdf" H 7850 5250 50  0001 C CNN
	1    7850 5250
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP602 U2
U 2 1 618F68F8
P 7850 6050
F 0 "U2" H 7850 6417 50  0000 C CNN
F 1 "MCP602" H 7850 6326 50  0000 C CNN
F 2 "" H 7850 6050 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21314g.pdf" H 7850 6050 50  0001 C CNN
	2    7850 6050
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:MCP602 U2
U 3 1 618F8A55
P 10500 4750
F 0 "U2" H 10458 4796 50  0000 L CNN
F 1 "MCP602" H 10458 4705 50  0000 L CNN
F 2 "" H 10500 4750 50  0001 C CNN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/21314g.pdf" H 10500 4750 50  0001 C CNN
	3    10500 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 5650 6100 5650
Wire Wire Line
	10400 5150 10400 5100
Wire Wire Line
	7550 5150 7350 5150
$Comp
L power:+3.3V #PWR015
U 1 1 6190D9AD
P 9200 4800
F 0 "#PWR015" H 9200 4650 50  0001 C CNN
F 1 "+3.3V" H 9215 4973 50  0000 C CNN
F 2 "" H 9200 4800 50  0001 C CNN
F 3 "" H 9200 4800 50  0001 C CNN
	1    9200 4800
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR019
U 1 1 6190E23C
P 10400 4350
F 0 "#PWR019" H 10400 4200 50  0001 C CNN
F 1 "+3.3V" H 10415 4523 50  0000 C CNN
F 2 "" H 10400 4350 50  0001 C CNN
F 3 "" H 10400 4350 50  0001 C CNN
	1    10400 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 4450 10400 4400
$Comp
L Device:R R10
U 1 1 6190FC95
P 9200 5050
AR Path="/6190FC95" Ref="R10"  Part="1" 
AR Path="/602353FF/6190FC95" Ref="R?"  Part="1" 
F 0 "R10" H 9130 5004 50  0000 R CNN
F 1 "100k 1%" H 9130 5095 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9130 5050 50  0001 C CNN
F 3 "~" H 9200 5050 50  0001 C CNN
	1    9200 5050
	-1   0    0    1   
$EndComp
$Comp
L Device:R R11
U 1 1 61910148
P 9200 5450
AR Path="/61910148" Ref="R11"  Part="1" 
AR Path="/602353FF/61910148" Ref="R?"  Part="1" 
F 0 "R11" H 9130 5404 50  0000 R CNN
F 1 "73.2k 1%" H 9130 5495 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9130 5450 50  0001 C CNN
F 3 "~" H 9200 5450 50  0001 C CNN
	1    9200 5450
	-1   0    0    1   
$EndComp
$Comp
L Device:R R12
U 1 1 61910403
P 9200 5900
AR Path="/61910403" Ref="R12"  Part="1" 
AR Path="/602353FF/61910403" Ref="R?"  Part="1" 
F 0 "R12" H 9130 5854 50  0000 R CNN
F 1 "127k 1%" H 9130 5945 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9130 5900 50  0001 C CNN
F 3 "~" H 9200 5900 50  0001 C CNN
	1    9200 5900
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR016
U 1 1 61910AED
P 9200 6150
AR Path="/61910AED" Ref="#PWR016"  Part="1" 
AR Path="/602353FF/61910AED" Ref="#PWR?"  Part="1" 
F 0 "#PWR016" H 9200 5900 50  0001 C CNN
F 1 "GND" H 9205 5977 50  0000 C CNN
F 2 "" H 9200 6150 50  0001 C CNN
F 3 "" H 9200 6150 50  0001 C CNN
	1    9200 6150
	1    0    0    -1  
$EndComp
Text Label 9700 5250 0    50   ~ 0
2.2V
Text Label 9800 5700 0    50   ~ 0
1.4V
Wire Wire Line
	9200 4900 9200 4800
Wire Wire Line
	9200 5200 9200 5250
Wire Wire Line
	9200 5250 9650 5250
Connection ~ 9200 5250
Wire Wire Line
	9200 5250 9200 5300
Wire Wire Line
	9200 5600 9200 5700
Wire Wire Line
	9800 5700 9700 5700
Connection ~ 9200 5700
Wire Wire Line
	9200 5700 9200 5750
Wire Wire Line
	9200 6050 9200 6150
Wire Wire Line
	7550 6150 7500 6150
Wire Wire Line
	7550 5350 7450 5350
Text Label 7350 5150 2    50   ~ 0
2.2V
Text Label 7300 5950 2    50   ~ 0
1.4V
Wire Wire Line
	8150 6050 8200 6050
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 61919ECA
P 1550 3600
F 0 "J1" H 1468 3275 50  0000 C CNN
F 1 "Conn_01x03" H 1468 3366 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x3-RA-0901362203" H 1550 3600 50  0001 C CNN
F 3 "~" H 1550 3600 50  0001 C CNN
	1    1550 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	1750 3700 1850 3700
Wire Wire Line
	1850 3700 1850 3750
$Comp
L power:GND #PWR01
U 1 1 61921BE6
P 1850 3750
AR Path="/61921BE6" Ref="#PWR01"  Part="1" 
AR Path="/602353FF/61921BE6" Ref="#PWR?"  Part="1" 
F 0 "#PWR01" H 1850 3500 50  0001 C CNN
F 1 "GND" H 1855 3577 50  0000 C CNN
F 2 "" H 1850 3750 50  0001 C CNN
F 3 "" H 1850 3750 50  0001 C CNN
	1    1850 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 3600 1900 3600
Text Label 1900 3600 0    50   ~ 0
PLUG_PROXIMITY
Wire Wire Line
	1750 3500 1900 3500
Text Label 1900 3500 0    50   ~ 0
PLUG_PILOT
Wire Wire Line
	5600 5650 5550 5650
Connection ~ 5600 5650
Text Label 5450 5650 2    50   ~ 0
PLUG_PROXIMITY
Text Label 7050 6150 2    50   ~ 0
PLUG_PROXIMITY
Text Label 7050 5350 2    50   ~ 0
PLUG_PROXIMITY
Wire Wire Line
	7300 5950 7550 5950
Wire Wire Line
	8150 5250 8200 5250
$Comp
L Device:C C3
U 1 1 61931F7F
P 10850 4750
F 0 "C3" H 10965 4796 50  0000 L CNN
F 1 "0.1uF" H 10965 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10888 4600 50  0001 C CNN
F 3 "~" H 10850 4750 50  0001 C CNN
	1    10850 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 6193247E
P 9950 4750
F 0 "C2" H 10065 4796 50  0000 L CNN
F 1 "1uF" H 10065 4705 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9988 4600 50  0001 C CNN
F 3 "~" H 9950 4750 50  0001 C CNN
	1    9950 4750
	1    0    0    -1  
$EndComp
Text Label 8300 5250 0    50   ~ 0
PROXIMITY_1
Text Label 8300 6050 0    50   ~ 0
PROXIMITY_0
$Comp
L Device:R R8
U 1 1 61934930
P 7300 5350
AR Path="/61934930" Ref="R8"  Part="1" 
AR Path="/602353FF/61934930" Ref="R?"  Part="1" 
F 0 "R8" H 7230 5304 50  0000 R CNN
F 1 "3.3k" H 7230 5395 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7230 5350 50  0001 C CNN
F 3 "~" H 7300 5350 50  0001 C CNN
	1    7300 5350
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R9
U 1 1 6193554F
P 7300 6150
AR Path="/6193554F" Ref="R9"  Part="1" 
AR Path="/602353FF/6193554F" Ref="R?"  Part="1" 
F 0 "R9" H 7230 6104 50  0000 R CNN
F 1 "3.3k" H 7230 6195 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7230 6150 50  0001 C CNN
F 3 "~" H 7300 6150 50  0001 C CNN
	1    7300 6150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7150 5350 7050 5350
Wire Wire Line
	7150 6150 7050 6150
Wire Wire Line
	6800 1900 6800 1800
$Comp
L Connector_Generic:Conn_01x04 J2
U 1 1 61942C87
P 1600 1750
F 0 "J2" H 1518 1325 50  0000 C CNN
F 1 "Conn_01x04" H 1518 1416 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x4-RA-0901362204" H 1600 1750 50  0001 C CNN
F 3 "~" H 1600 1750 50  0001 C CNN
	1    1600 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	1800 1850 1900 1850
Wire Wire Line
	1900 1850 1900 1900
Wire Wire Line
	1800 1750 1900 1750
Wire Wire Line
	1900 1750 1900 1850
Connection ~ 1900 1850
Wire Wire Line
	1800 1650 1900 1650
Wire Wire Line
	1900 1650 1900 1550
Wire Wire Line
	1900 1550 1800 1550
Wire Wire Line
	1900 1550 2050 1550
Connection ~ 1900 1550
Text Label 2050 1550 0    50   ~ 0
13V8_FROM_CHARGER
Text Label 5600 1900 2    50   ~ 0
13V8_FROM_CHARGER
Text Label 6250 2300 0    50   ~ 0
CHARGER_POWER_SENSE
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 61953D9E
P 8300 1700
F 0 "J3" H 8380 1692 50  0000 L CNN
F 1 "Conn_01x04" H 8380 1601 50  0000 L CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x4-RA-0901362204" H 8300 1700 50  0001 C CNN
F 3 "~" H 8300 1700 50  0001 C CNN
	1    8300 1700
	1    0    0    1   
$EndComp
Wire Wire Line
	7950 1600 8100 1600
Wire Wire Line
	8100 1500 7950 1500
Connection ~ 7950 1500
Wire Wire Line
	7950 1500 7950 1400
Wire Wire Line
	8100 1700 8000 1700
Wire Wire Line
	8000 1700 8000 1800
Connection ~ 8000 1800
$Comp
L power:GNDPWR #PWR02
U 1 1 6195F4E9
P 1900 1900
F 0 "#PWR02" H 1900 1700 50  0001 C CNN
F 1 "GNDPWR" H 1904 1746 50  0000 C CNN
F 2 "" H 1900 1850 50  0001 C CNN
F 3 "" H 1900 1850 50  0001 C CNN
	1    1900 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR014
U 1 1 619619FA
P 8000 1850
F 0 "#PWR014" H 8000 1650 50  0001 C CNN
F 1 "GNDPWR" H 8004 1696 50  0000 C CNN
F 2 "" H 8000 1800 50  0001 C CNN
F 3 "" H 8000 1800 50  0001 C CNN
	1    8000 1850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR06
U 1 1 619677B9
P 5800 2700
AR Path="/619677B9" Ref="#PWR06"  Part="1" 
AR Path="/602353FF/619677B9" Ref="#PWR?"  Part="1" 
F 0 "#PWR06" H 5800 2450 50  0001 C CNN
F 1 "GND" H 5805 2527 50  0000 C CNN
F 2 "" H 5800 2700 50  0001 C CNN
F 3 "" H 5800 2700 50  0001 C CNN
	1    5800 2700
	1    0    0    -1  
$EndComp
$Comp
L Device:Polyfuse F1
U 1 1 6196BCEE
P 6100 1900
F 0 "F1" V 5875 1900 50  0000 C CNN
F 1 "Polyfuse" V 5966 1900 50  0000 C CNN
F 2 "Fuse:Fuse_2920_7451Metric_Pad2.10x5.45mm_HandSolder" H 6150 1700 50  0001 L CNN
F 3 "~" H 6100 1900 50  0001 C CNN
	1    6100 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	5800 1900 5950 1900
Connection ~ 5800 1900
Text Label 9450 2200 2    50   ~ 0
PROXIMITY_0
Text Label 9450 2600 2    50   ~ 0
PROXIMITY_1
Text Label 9450 2500 2    50   ~ 0
CHARGER_POWER_SENSE
Text Notes 4450 3300 2    50   ~ 0
D1: 12V, 15 mA
$Comp
L Device:R R3
U 1 1 6197CF21
P 5350 4350
AR Path="/6197CF21" Ref="R3"  Part="1" 
AR Path="/602353FF/6197CF21" Ref="R?"  Part="1" 
F 0 "R3" H 5280 4304 50  0000 R CNN
F 1 "1240 1%" H 5280 4395 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5280 4350 50  0001 C CNN
F 3 "~" H 5350 4350 50  0001 C CNN
	1    5350 4350
	-1   0    0    1   
$EndComp
Wire Wire Line
	5350 3700 5350 3750
Wire Wire Line
	4800 3700 5050 3700
$Comp
L power:GND #PWR04
U 1 1 6197F3D9
P 5350 4600
AR Path="/6197F3D9" Ref="#PWR04"  Part="1" 
AR Path="/602353FF/6197F3D9" Ref="#PWR?"  Part="1" 
F 0 "#PWR04" H 5350 4350 50  0001 C CNN
F 1 "GND" H 5355 4427 50  0000 C CNN
F 2 "" H 5350 4600 50  0001 C CNN
F 3 "" H 5350 4600 50  0001 C CNN
	1    5350 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 4600 5350 4500
Wire Wire Line
	5350 4050 5350 4100
Wire Wire Line
	5750 4100 5650 4100
Connection ~ 5350 4100
Wire Wire Line
	5350 4100 5350 4200
Text Notes 7200 4550 0    50   ~ 0
Proximity: For the EV to detect:\nIn resistance is:\n* 2.7k (not connected) => 2.94V\n* 408 ohm (Button pressed) => 1.8V\n* 142 ohm (connected) => 1V (7 mA)\n\n330 ohm is to protect against short circuit on bad connector\n\nProximity signal:\n11=connected\n10=button pressed\n00=not connected
Text Notes 2900 3100 0    50   ~ 0
Pilot:\nVoltage on Pilot will be 9V when vehicle connected,  6V when ready.\nMinimum that should be detected on schmitt trigger around 1.6 V.\n\nUse same diode as flyback: Micro Commercial SFM16PL-TP\nForward voltage drop @ 4-14 mA will be approx 0.55-0.7V\n\nDiodes inc 74LVC1G14 (MPN 74LVC1G14SE-7) with 3.3V supply. Can allow 5.5V in.\nWith 3V VCC positive going voltage is max 2V.\n\nDivider: I=12/2750: R3*12/2750=5.5 => R=1260\nNew min V out is 2.715 V. => will work!\n\n
Wire Wire Line
	4350 3700 4800 3700
Wire Wire Line
	6300 4100 6350 4100
Text Label 6400 4100 0    50   ~ 0
PILOT_OUT
Text Label 9450 2700 2    50   ~ 0
PILOT_OUT
Text Label 9450 2400 2    50   ~ 0
PILOT_EV_CHARGE
Text Label 3700 4350 2    50   ~ 0
PILOT_EV_CHARGE
Text Label 3650 3700 2    50   ~ 0
PLUG_PILOT
$Comp
L Connector_Generic:Conn_01x08 J4
U 1 1 619A6468
P 9900 2500
F 0 "J4" H 9980 2492 50  0000 L CNN
F 1 "Conn_01x08" H 9980 2401 50  0000 L CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-2x4-RA-0901303208" H 9900 2500 50  0001 C CNN
F 3 "~" H 9900 2500 50  0001 C CNN
	1    9900 2500
	1    0    0    1   
$EndComp
Wire Wire Line
	9700 2700 9450 2700
Wire Wire Line
	9700 2600 9450 2600
Wire Wire Line
	9700 2500 9450 2500
Wire Wire Line
	9700 2400 9450 2400
Wire Wire Line
	9700 2100 9650 2100
Wire Wire Line
	9650 2100 9650 2050
$Comp
L power:+3.3V #PWR017
U 1 1 619B5CBA
P 9650 2050
F 0 "#PWR017" H 9650 1900 50  0001 C CNN
F 1 "+3.3V" H 9665 2223 50  0000 C CNN
F 2 "" H 9650 2050 50  0001 C CNN
F 3 "" H 9650 2050 50  0001 C CNN
	1    9650 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	10400 4400 9950 4400
Wire Wire Line
	9950 4400 9950 4600
Connection ~ 10400 4400
Wire Wire Line
	10400 4400 10400 4350
Wire Wire Line
	10400 5100 9950 5100
Wire Wire Line
	9950 5100 9950 4900
Connection ~ 10400 5100
Wire Wire Line
	10400 5100 10400 5050
Wire Wire Line
	10400 5100 10850 5100
Wire Wire Line
	10850 5100 10850 4900
Wire Wire Line
	10400 4400 10850 4400
Wire Wire Line
	10850 4400 10850 4600
$Comp
L Device:C C1
U 1 1 619C0FE8
P 6450 3600
F 0 "C1" H 6565 3646 50  0000 L CNN
F 1 "0.1uF" H 6565 3555 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6488 3450 50  0001 C CNN
F 3 "~" H 6450 3600 50  0001 C CNN
	1    6450 3600
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR010
U 1 1 619C1FFE
P 6450 3350
F 0 "#PWR010" H 6450 3200 50  0001 C CNN
F 1 "+3.3V" H 6465 3523 50  0000 C CNN
F 2 "" H 6450 3350 50  0001 C CNN
F 3 "" H 6450 3350 50  0001 C CNN
	1    6450 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3450 6450 3350
$Comp
L power:GND #PWR011
U 1 1 619C751A
P 6450 3800
AR Path="/619C751A" Ref="#PWR011"  Part="1" 
AR Path="/602353FF/619C751A" Ref="#PWR?"  Part="1" 
F 0 "#PWR011" H 6450 3550 50  0001 C CNN
F 1 "GND" H 6455 3627 50  0000 C CNN
F 2 "" H 6450 3800 50  0001 C CNN
F 3 "" H 6450 3800 50  0001 C CNN
	1    6450 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3800 6450 3750
$Comp
L Mechanical:MountingHole H1
U 1 1 61A1AF3D
P 5500 6700
F 0 "H1" H 5600 6746 50  0000 L CNN
F 1 "MountingHole" H 5600 6655 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 5500 6700 50  0001 C CNN
F 3 "~" H 5500 6700 50  0001 C CNN
	1    5500 6700
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 61A247CA
P 5500 6950
F 0 "H2" H 5600 6996 50  0000 L CNN
F 1 "MountingHole" H 5600 6905 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 5500 6950 50  0001 C CNN
F 3 "~" H 5500 6950 50  0001 C CNN
	1    5500 6950
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 61A248F1
P 6300 6700
F 0 "H3" H 6400 6746 50  0000 L CNN
F 1 "MountingHole" H 6400 6655 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6300 6700 50  0001 C CNN
F 3 "~" H 6300 6700 50  0001 C CNN
	1    6300 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 2200 9450 2200
$Comp
L Erland's:D-CMPSH1-4 D1
U 1 1 61FAA259
P 4200 3700
F 0 "D1" H 4150 3965 50  0000 C CNN
F 1 "D-CMPSH1-4" H 4150 3874 50  0000 C CNN
F 2 "erland-footprints:SOT23F" H 4200 3700 50  0001 C CNN
F 3 "https://my.centralsemi.com/datasheets/CMPSH1-4.PDF" H 4200 3700 50  0001 C CNN
	1    4200 3700
	1    0    0    -1  
$EndComp
$Comp
L Erland's:D-MBRD540 D2
U 1 1 61FC6807
P 6550 1900
F 0 "D2" H 6550 1675 50  0000 C CNN
F 1 "D-MBRD540" H 6550 1766 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:TO-252-3_TabPin2" H 6800 1700 50  0001 C CNN
F 3 "" H 6550 1900 50  0001 C CNN
	1    6550 1900
	-1   0    0    1   
$EndComp
Wire Wire Line
	6400 1850 6400 1900
Wire Wire Line
	6400 1950 6400 1900
Connection ~ 6400 1900
$Comp
L Erland's:Q-FET-N-SSM3K36MFV Q1
U 1 1 61FE1E97
P 4700 4350
F 0 "Q1" H 4905 4396 50  0000 L CNN
F 1 "Q-FET-N-SSM3K36MFV" H 4905 4305 50  0001 L CNN
F 2 "Package_TO_SOT_SMD:SOT-723" H 4900 4275 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/BS/BSS138.pdf" H 4700 4350 50  0001 L CNN
	1    4700 4350
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP16
U 1 1 60328243
P 9650 5100
F 0 "TP16" H 9708 5218 50  0000 L CNN
F 1 "TestPoint" H 9708 5127 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9850 5100 50  0001 C CNN
F 3 "~" H 9850 5100 50  0001 C CNN
	1    9650 5100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP17
U 1 1 6032898D
P 9700 5550
F 0 "TP17" H 9758 5668 50  0000 L CNN
F 1 "TestPoint" H 9758 5577 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9900 5550 50  0001 C CNN
F 3 "~" H 9900 5550 50  0001 C CNN
	1    9700 5550
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 5100 9650 5250
Connection ~ 9650 5250
Wire Wire Line
	9650 5250 9700 5250
Wire Wire Line
	9700 5550 9700 5700
Connection ~ 9700 5700
Wire Wire Line
	9700 5700 9200 5700
$Comp
L Connector:TestPoint TP12
U 1 1 603310B8
P 8200 5100
F 0 "TP12" H 8258 5218 50  0000 L CNN
F 1 "TestPoint" H 8258 5127 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 8400 5100 50  0001 C CNN
F 3 "~" H 8400 5100 50  0001 C CNN
	1    8200 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5100 8200 5250
Connection ~ 8200 5250
Wire Wire Line
	8200 5250 8300 5250
$Comp
L Connector:TestPoint TP13
U 1 1 603342B0
P 8200 5900
F 0 "TP13" H 8258 6018 50  0000 L CNN
F 1 "TestPoint" H 8258 5927 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 8400 5900 50  0001 C CNN
F 3 "~" H 8400 5900 50  0001 C CNN
	1    8200 5900
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5900 8200 6050
Connection ~ 8200 6050
Wire Wire Line
	8200 6050 8300 6050
$Comp
L Connector:TestPoint TP5
U 1 1 6033750D
P 5550 5500
F 0 "TP5" H 5608 5618 50  0000 L CNN
F 1 "TestPoint" H 5608 5527 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5750 5500 50  0001 C CNN
F 3 "~" H 5750 5500 50  0001 C CNN
	1    5550 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5550 5500 5550 5650
Connection ~ 5550 5650
Wire Wire Line
	5550 5650 5450 5650
$Comp
L Connector:TestPoint TP10
U 1 1 6033AFCB
P 7450 5550
F 0 "TP10" H 7392 5576 50  0000 R CNN
F 1 "TestPoint" H 7392 5667 50  0000 R CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 7650 5550 50  0001 C CNN
F 3 "~" H 7650 5550 50  0001 C CNN
	1    7450 5550
	-1   0    0    1   
$EndComp
Wire Wire Line
	7450 5550 7450 5350
Connection ~ 7450 5350
$Comp
L Connector:TestPoint TP11
U 1 1 6033E87D
P 7500 6300
F 0 "TP11" H 7442 6326 50  0000 R CNN
F 1 "TestPoint" H 7442 6417 50  0000 R CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 7700 6300 50  0001 C CNN
F 3 "~" H 7700 6300 50  0001 C CNN
	1    7500 6300
	-1   0    0    1   
$EndComp
Wire Wire Line
	7500 6300 7500 6150
Connection ~ 7500 6150
Wire Wire Line
	7500 6150 7450 6150
$Comp
L Connector:TestPoint TP4
U 1 1 603450F7
P 5050 3650
F 0 "TP4" H 5108 3768 50  0000 L CNN
F 1 "TestPoint" H 5108 3677 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5250 3650 50  0001 C CNN
F 3 "~" H 5250 3650 50  0001 C CNN
	1    5050 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 3650 5050 3700
Connection ~ 5050 3700
Wire Wire Line
	5050 3700 5350 3700
$Comp
L Connector:TestPoint TP1
U 1 1 6034B9CC
P 3750 3600
F 0 "TP1" H 3808 3718 50  0000 L CNN
F 1 "TestPoint" H 3808 3627 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3950 3600 50  0001 C CNN
F 3 "~" H 3950 3600 50  0001 C CNN
	1    3750 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3600 3750 3700
Connection ~ 3750 3700
Wire Wire Line
	3750 3700 3950 3700
$Comp
L Device:R R13
U 1 1 60352729
P 4250 4350
AR Path="/60352729" Ref="R13"  Part="1" 
AR Path="/602353FF/60352729" Ref="R?"  Part="1" 
F 0 "R13" H 4180 4304 50  0000 R CNN
F 1 "3.3k" H 4180 4395 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4180 4350 50  0001 C CNN
F 3 "~" H 4250 4350 50  0001 C CNN
	1    4250 4350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4100 4350 4000 4350
$Comp
L Device:R R14
U 1 1 6035D527
P 4450 4700
AR Path="/6035D527" Ref="R14"  Part="1" 
AR Path="/602353FF/6035D527" Ref="R?"  Part="1" 
F 0 "R14" H 4380 4654 50  0000 R CNN
F 1 "100k" H 4380 4745 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4380 4700 50  0001 C CNN
F 3 "~" H 4450 4700 50  0001 C CNN
	1    4450 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4450 4550 4450 4350
Connection ~ 4450 4350
Wire Wire Line
	4450 4350 4400 4350
Wire Wire Line
	4450 4850 4450 4900
Wire Wire Line
	4450 4900 4800 4900
Connection ~ 4800 4900
Wire Wire Line
	4800 4900 4800 4550
$Comp
L Connector:TestPoint TP3
U 1 1 60369957
P 4500 4200
F 0 "TP3" H 4558 4318 50  0000 L CNN
F 1 "TestPoint" H 4558 4227 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 4700 4200 50  0001 C CNN
F 3 "~" H 4700 4200 50  0001 C CNN
	1    4500 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 4200 4500 4350
Connection ~ 4500 4350
$Comp
L Connector:TestPoint TP2
U 1 1 6036DE73
P 4000 4250
F 0 "TP2" H 4058 4368 50  0000 L CNN
F 1 "TestPoint" H 4058 4277 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 4200 4250 50  0001 C CNN
F 3 "~" H 4200 4250 50  0001 C CNN
	1    4000 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 4250 4000 4350
Connection ~ 4000 4350
Wire Wire Line
	4000 4350 3700 4350
$Comp
L Connector:TestPoint TP6
U 1 1 60376636
P 5650 3450
F 0 "TP6" H 5708 3568 50  0000 L CNN
F 1 "TestPoint" H 5708 3477 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5850 3450 50  0001 C CNN
F 3 "~" H 5850 3450 50  0001 C CNN
	1    5650 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 3450 5650 4100
Connection ~ 5650 4100
Wire Wire Line
	5650 4100 5350 4100
$Comp
L Connector:TestPoint TP9
U 1 1 6037B4E7
P 6350 4150
F 0 "TP9" H 6292 4176 50  0000 R CNN
F 1 "TestPoint" H 6292 4267 50  0000 R CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 6550 4150 50  0001 C CNN
F 3 "~" H 6550 4150 50  0001 C CNN
	1    6350 4150
	-1   0    0    1   
$EndComp
Wire Wire Line
	6350 4150 6350 4100
Connection ~ 6350 4100
Wire Wire Line
	6350 4100 6400 4100
$Comp
L Connector:TestPoint TP7
U 1 1 603804AD
P 5700 1650
F 0 "TP7" H 5758 1768 50  0000 L CNN
F 1 "TestPoint" H 5758 1677 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5900 1650 50  0001 C CNN
F 3 "~" H 5900 1650 50  0001 C CNN
	1    5700 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 1650 5700 1900
Connection ~ 5700 1900
Wire Wire Line
	5700 1900 5800 1900
$Comp
L Connector:TestPoint TP8
U 1 1 603858A0
P 6100 2150
F 0 "TP8" H 6158 2268 50  0000 L CNN
F 1 "TestPoint" H 6158 2177 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 6300 2150 50  0001 C CNN
F 3 "~" H 6300 2150 50  0001 C CNN
	1    6100 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 2300 6100 2300
Wire Wire Line
	6100 2150 6100 2300
Connection ~ 6100 2300
Wire Wire Line
	6100 2300 6250 2300
$Comp
L Connector:TestPoint TP15
U 1 1 6038F4DB
P 9100 2950
F 0 "TP15" H 9042 2976 50  0000 R CNN
F 1 "TestPoint" H 9042 3067 50  0000 R CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9300 2950 50  0001 C CNN
F 3 "~" H 9300 2950 50  0001 C CNN
	1    9100 2950
	-1   0    0    1   
$EndComp
Wire Wire Line
	9650 2800 9100 2800
Wire Wire Line
	9100 2800 9100 2950
Connection ~ 9650 2800
$Comp
L Connector:TestPoint TP14
U 1 1 603951B8
P 9100 1900
F 0 "TP14" H 9158 2018 50  0000 L CNN
F 1 "TestPoint" H 9158 1927 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9300 1900 50  0001 C CNN
F 3 "~" H 9300 1900 50  0001 C CNN
	1    9100 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9650 2100 9100 2100
Wire Wire Line
	9100 2100 9100 1900
Connection ~ 9650 2100
$Comp
L Connector:TestPoint TP18
U 1 1 606D4D79
P 2200 1900
F 0 "TP18" H 2142 1926 50  0000 R CNN
F 1 "TestPoint" H 2142 2017 50  0000 R CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 2400 1900 50  0001 C CNN
F 3 "~" H 2400 1900 50  0001 C CNN
	1    2200 1900
	-1   0    0    1   
$EndComp
Wire Wire Line
	1900 1750 2200 1750
Wire Wire Line
	2200 1750 2200 1900
Connection ~ 1900 1750
$Comp
L Connector:TestPoint TP19
U 1 1 606E0272
P 7050 1800
F 0 "TP19" H 7108 1918 50  0000 L CNN
F 1 "TestPoint" H 7108 1827 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 7250 1800 50  0001 C CNN
F 3 "~" H 7250 1800 50  0001 C CNN
	1    7050 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1900 7050 1800
Wire Wire Line
	6700 1900 6800 1900
Connection ~ 6800 1900
Wire Wire Line
	6800 1900 7050 1900
$EndSCHEMATC
