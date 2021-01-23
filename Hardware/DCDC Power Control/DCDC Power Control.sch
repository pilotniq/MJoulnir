EESchema Schematic File Version 4
LIBS:DCDC Power Control-cache
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
Wire Wire Line
	1750 1950 2200 1950
Wire Wire Line
	2200 1950 2200 2050
$Comp
L Device:Fuse F1
U 1 1 5F8C2578
P 2150 1850
F 0 "F1" V 1953 1850 50  0000 C CNN
F 1 "5 A/80V" V 2044 1850 50  0000 C CNN
F 2 "erland-footprints:FUSE-KEYSTONE-3557-2" V 2080 1850 50  0001 C CNN
F 3 "~" H 2150 1850 50  0001 C CNN
	1    2150 1850
	0    1    1    0   
$EndComp
Wire Wire Line
	2300 1850 2500 1850
Text Notes 800  1150 0    50   ~ 0
Low current battery power in
Text Notes 2300 750  0    50   ~ 0
Momentary Power Switch Connection
$Comp
L Connector:Screw_Terminal_01x02 J4
U 1 1 5FA6745E
P 4850 1950
F 0 "J4" V 4814 1762 50  0000 R CNN
F 1 "Screw_Terminal_01x02" V 4723 1762 50  0001 R CNN
F 2 "Connector_AMASS:AMASS_XT30PW-F_1x02_P2.50mm_Horizontal" H 4850 1950 50  0001 C CNN
F 3 "~" H 4850 1950 50  0001 C CNN
	1    4850 1950
	1    0    0    1   
$EndComp
Wire Wire Line
	4600 2100 4600 1950
Text Notes 3800 800  0    50   ~ 0
Power to DC/DC Converters
Text Notes 2600 1150 0    50   ~ 0
Assume we don’t need DC/DC inrush protection
Text Notes 850  3300 0    50   ~ 0
Momentary Power Switch connection\n76V, 1.1 mA will go through switch
Text Label 1500 3500 0    50   ~ 0
POWER_GATE
Text Notes 4700 3150 0    50   ~ 0
72->12V DC/DC converter has output current of 20A.\nWorst case input voltage is 55V. \nWould mean 4.36A in @ 100% efficiency, 4.6A in @ 95% efficiency.\nUse SQJ479EP-T1_GE3.\nVgs max +-20V. \n15k/56k voltage divider gives min 60V @ gate=Vgs -16V @ 76V +BATT. \nAnd a power dissipation of 0.1W\n\n30 mOhm * 5A * 5A = 0.75W MOSFET dissipation. 68 C/W => 51 C temp rise. On Resistance will rise 30%, temp rise up 30% = 66 C. Hot!\nThis is at 5A. Normal load will be 45 mA, neglible temp rise.\n
$Comp
L Device:R R3
U 1 1 5FB20E41
P 3000 2200
F 0 "R3" H 2930 2154 50  0000 R CNN
F 1 "15K" H 2930 2245 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2930 2200 50  0001 C CNN
F 3 "~" H 3000 2200 50  0001 C CNN
	1    3000 2200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2850 2200 2800 2200
Wire Wire Line
	2800 2200 2800 1850
Connection ~ 2800 1850
Wire Wire Line
	3150 2200 3300 2200
Wire Wire Line
	3300 2200 3300 2150
Connection ~ 3300 2200
Wire Wire Line
	3300 2200 3300 2300
$Comp
L Device:R R4
U 1 1 5FB8EAFD
P 3300 2450
F 0 "R4" H 3230 2404 50  0000 R CNN
F 1 "56k" H 3230 2495 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3230 2450 50  0001 C CNN
F 3 "~" H 3300 2450 50  0001 C CNN
	1    3300 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 5FBF41E4
P 4200 2100
F 0 "D1" V 4239 1983 50  0000 R CNN
F 1 "LED" V 4148 1983 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4200 2100 50  0001 C CNN
F 3 "~" H 4200 2100 50  0001 C CNN
	1    4200 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 1950 4200 1850
Connection ~ 4200 1850
$Comp
L Device:R R5
U 1 1 5FBFD73A
P 4200 2550
F 0 "R5" H 4130 2504 50  0000 R CNN
F 1 "10k" H 4130 2595 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4130 2550 50  0001 C CNN
F 3 "~" H 4200 2550 50  0001 C CNN
	1    4200 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 2400 4200 2250
Wire Wire Line
	4200 2700 4200 2800
$Comp
L Connector:TestPoint TP2
U 1 1 5FD3DA0C
P 3400 2150
F 0 "TP2" V 3354 2338 50  0000 L CNN
F 1 "TestPoint" V 3445 2338 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 3600 2150 50  0001 C CNN
F 3 "~" H 3600 2150 50  0001 C CNN
	1    3400 2150
	0    1    1    0   
$EndComp
Wire Wire Line
	3400 2150 3300 2150
Wire Wire Line
	3300 2600 3300 2700
Wire Wire Line
	3300 2700 3400 2700
Connection ~ 3300 2700
$Comp
L Connector:TestPoint TP3
U 1 1 5FDF8CA7
P 3400 2700
F 0 "TP3" V 3354 2888 50  0000 L CNN
F 1 "TestPoint" V 3445 2888 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 3600 2700 50  0001 C CNN
F 3 "~" H 3600 2700 50  0001 C CNN
	1    3400 2700
	0    1    1    0   
$EndComp
$Comp
L power:GNDPWR #PWR05
U 1 1 5FE28399
P 2200 2050
F 0 "#PWR05" H 2200 1850 50  0001 C CNN
F 1 "GNDPWR" H 2204 1896 50  0000 C CNN
F 2 "" H 2200 2000 50  0001 C CNN
F 3 "" H 2200 2000 50  0001 C CNN
	1    2200 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR010
U 1 1 5FE4E716
P 4600 2100
F 0 "#PWR010" H 4600 1900 50  0001 C CNN
F 1 "GNDPWR" H 4604 1946 50  0000 C CNN
F 2 "" H 4600 2050 50  0001 C CNN
F 3 "" H 4600 2050 50  0001 C CNN
	1    4600 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR09
U 1 1 5FE4F02C
P 4200 2800
F 0 "#PWR09" H 4200 2600 50  0001 C CNN
F 1 "GNDPWR" H 4204 2646 50  0000 C CNN
F 2 "" H 4200 2750 50  0001 C CNN
F 3 "" H 4200 2750 50  0001 C CNN
	1    4200 2800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5FF10D82
P 1550 1950
F 0 "J3" H 1468 1625 50  0000 C CNN
F 1 "Conn_01x02" H 1468 1716 50  0000 C CNN
F 2 "Connector_AMASS:AMASS_XT30PW-M_1x02_P2.50mm_Horizontal" H 1550 1950 50  0001 C CNN
F 3 "~" H 1550 1950 50  0001 C CNN
	1    1550 1950
	-1   0    0    1   
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 5FF1697B
P 6300 7600
F 0 "H4" H 6400 7646 50  0000 L CNN
F 1 "MountingHole" H 6400 7555 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6300 7600 50  0001 C CNN
F 3 "~" H 6300 7600 50  0001 C CNN
	1    6300 7600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5FF16F3F
P 6300 7400
F 0 "H3" H 6400 7446 50  0000 L CNN
F 1 "MountingHole" H 6400 7355 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6300 7400 50  0001 C CNN
F 3 "~" H 6300 7400 50  0001 C CNN
	1    6300 7400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5FF17B4B
P 6300 7200
F 0 "H2" H 6400 7246 50  0000 L CNN
F 1 "MountingHole" H 6400 7155 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6300 7200 50  0001 C CNN
F 3 "~" H 6300 7200 50  0001 C CNN
	1    6300 7200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5FF1848C
P 6300 7000
F 0 "H1" H 6400 7046 50  0000 L CNN
F 1 "MountingHole" H 6400 6955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6300 7000 50  0001 C CNN
F 3 "~" H 6300 7000 50  0001 C CNN
	1    6300 7000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR01
U 1 1 6017D76C
P 1300 2900
F 0 "#PWR01" H 1300 2650 50  0001 C CNN
F 1 "GND" H 1305 2727 50  0000 C CNN
F 2 "" H 1300 2900 50  0001 C CNN
F 3 "" H 1300 2900 50  0001 C CNN
	1    1300 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 2850 1300 2850
Wire Wire Line
	1300 2850 1300 2900
Wire Wire Line
	1200 2750 1300 2750
Text Label 1300 2750 0    50   ~ 0
ON
Wire Wire Line
	4200 1850 4650 1850
Wire Wire Line
	4600 1950 4650 1950
$Comp
L Transistor_FET:SiS415DNT Q2
U 1 1 601B94E3
P 3300 1950
F 0 "Q2" V 3642 1950 50  0000 C CNN
F 1 "SQJ479EP-T1_GE3" V 3551 1950 50  0000 C CNN
F 2 "Package_SO:Vishay_PowerPAK_1212-8_Single" H 3500 1875 50  0001 L CIN
F 3 "https://www.vishay.com/docs/75129/sqj479ep.pdf" V 3300 1950 50  0001 L CNN
	1    3300 1950
	0    1    -1   0   
$EndComp
Connection ~ 3300 2150
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 601C2EE0
P 1150 3600
F 0 "J2" H 1068 3367 50  0000 C CNN
F 1 "Conn_01x02" H 1068 3366 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 1150 3600 50  0001 C CNN
F 3 "~" H 1150 3600 50  0001 C CNN
	1    1150 3600
	-1   0    0    1   
$EndComp
Wire Wire Line
	1350 3500 1500 3500
Wire Wire Line
	1750 1850 2000 1850
$Comp
L Device:R R6
U 1 1 5FD8E663
P 4650 4350
F 0 "R6" V 4550 4400 50  0000 R CNN
F 1 "11k/500mW" V 4750 4550 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 4350 50  0001 C CNN
F 3 "~" H 4650 4350 50  0001 C CNN
	1    4650 4350
	0    1    1    0   
$EndComp
$Comp
L power:+BATT #PWR03
U 1 1 5FD901BA
P 2500 1800
F 0 "#PWR03" H 2500 1650 50  0001 C CNN
F 1 "+BATT" H 2515 1973 50  0000 C CNN
F 2 "" H 2500 1800 50  0001 C CNN
F 3 "" H 2500 1800 50  0001 C CNN
	1    2500 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1800 2500 1850
Connection ~ 2500 1850
Wire Wire Line
	2500 1850 2800 1850
$Comp
L power:+BATT #PWR02
U 1 1 5FD913A6
P 2650 5300
F 0 "#PWR02" H 2650 5150 50  0001 C CNN
F 1 "+BATT" H 2665 5473 50  0000 C CNN
F 2 "" H 2650 5300 50  0001 C CNN
F 3 "" H 2650 5300 50  0001 C CNN
	1    2650 5300
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5FD9452A
P 4650 4700
F 0 "R7" V 4550 4750 50  0000 R CNN
F 1 "11k/500mW" V 4750 4900 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 4700 50  0001 C CNN
F 3 "~" H 4650 4700 50  0001 C CNN
	1    4650 4700
	0    1    1    0   
$EndComp
$Comp
L Device:R R8
U 1 1 5FD948F6
P 4650 5050
F 0 "R8" V 4550 5100 50  0000 R CNN
F 1 "11k/500mW" V 4750 5250 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 5050 50  0001 C CNN
F 3 "~" H 4650 5050 50  0001 C CNN
	1    4650 5050
	0    1    1    0   
$EndComp
$Comp
L Device:R R9
U 1 1 5FD94D01
P 4650 5400
F 0 "R9" V 4550 5450 50  0000 R CNN
F 1 "11k/500mW" V 4750 5600 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 5400 50  0001 C CNN
F 3 "~" H 4650 5400 50  0001 C CNN
	1    4650 5400
	0    1    1    0   
$EndComp
$Comp
L Device:R R10
U 1 1 5FD94FE6
P 4650 5750
F 0 "R10" V 4550 5800 50  0000 R CNN
F 1 "11k/500mW" V 4750 5950 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 5750 50  0001 C CNN
F 3 "~" H 4650 5750 50  0001 C CNN
	1    4650 5750
	0    1    1    0   
$EndComp
$Comp
L Device:R R11
U 1 1 5FD954C3
P 4650 6100
F 0 "R11" V 4550 6150 50  0000 R CNN
F 1 "11k/500mW" V 4750 6300 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 6100 50  0001 C CNN
F 3 "~" H 4650 6100 50  0001 C CNN
	1    4650 6100
	0    1    1    0   
$EndComp
$Comp
L Device:R R12
U 1 1 5FD95922
P 4650 6450
F 0 "R12" V 4550 6500 50  0000 R CNN
F 1 "11k/500mW" V 4750 6650 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 6450 50  0001 C CNN
F 3 "~" H 4650 6450 50  0001 C CNN
	1    4650 6450
	0    1    1    0   
$EndComp
$Comp
L Device:R R13
U 1 1 5FD95D57
P 4650 6800
F 0 "R13" V 4550 6850 50  0000 R CNN
F 1 "11k/500mW" V 4750 7000 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 6800 50  0001 C CNN
F 3 "~" H 4650 6800 50  0001 C CNN
	1    4650 6800
	0    1    1    0   
$EndComp
$Comp
L Device:R R14
U 1 1 5FD960CF
P 4650 7150
F 0 "R14" V 4550 7200 50  0000 R CNN
F 1 "11k/500mW" V 4750 7350 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 7150 50  0001 C CNN
F 3 "~" H 4650 7150 50  0001 C CNN
	1    4650 7150
	0    1    1    0   
$EndComp
$Comp
L Device:R R15
U 1 1 5FD96600
P 4650 7500
F 0 "R15" V 4550 7550 50  0000 R CNN
F 1 "11k/500mW" V 4750 7700 50  0000 R CNN
F 2 "Resistor_SMD:R_1206_3216Metric_Pad1.42x1.75mm_HandSolder" V 4580 7500 50  0001 C CNN
F 3 "~" H 4650 7500 50  0001 C CNN
	1    4650 7500
	0    1    1    0   
$EndComp
Wire Wire Line
	4800 7500 5050 7500
Wire Wire Line
	5050 7500 5050 7150
Wire Wire Line
	5050 4350 4800 4350
Wire Wire Line
	4800 4700 5050 4700
Connection ~ 5050 4700
Wire Wire Line
	5050 4700 5050 4350
Wire Wire Line
	4800 5050 5050 5050
Connection ~ 5050 5050
Wire Wire Line
	5050 5050 5050 4700
Wire Wire Line
	4800 5400 5050 5400
Connection ~ 5050 5400
Wire Wire Line
	5050 5400 5050 5050
Wire Wire Line
	4800 5750 5050 5750
Connection ~ 5050 5750
Wire Wire Line
	4800 6100 5050 6100
Connection ~ 5050 6100
Wire Wire Line
	5050 6100 5050 5750
Wire Wire Line
	4800 6450 5050 6450
Connection ~ 5050 6450
Wire Wire Line
	5050 6450 5050 6100
Wire Wire Line
	4800 6800 5050 6800
Connection ~ 5050 6800
Wire Wire Line
	5050 6800 5050 6450
Wire Wire Line
	4800 7150 5050 7150
Connection ~ 5050 7150
Wire Wire Line
	5050 7150 5050 6800
Wire Wire Line
	4500 7500 4250 7500
Wire Wire Line
	4250 7500 4250 7150
Wire Wire Line
	4250 4350 4500 4350
Wire Wire Line
	4500 4700 4250 4700
Connection ~ 4250 4700
Wire Wire Line
	4250 4700 4250 4550
Wire Wire Line
	4500 5050 4250 5050
Connection ~ 4250 5050
Wire Wire Line
	4250 5050 4250 4700
Wire Wire Line
	4250 5400 4500 5400
Connection ~ 4250 5400
Wire Wire Line
	4250 5400 4250 5050
Wire Wire Line
	4500 5750 4250 5750
Connection ~ 4250 5750
Wire Wire Line
	4250 5750 4250 5400
Wire Wire Line
	4500 6100 4250 6100
Connection ~ 4250 6100
Wire Wire Line
	4250 6100 4250 5750
Wire Wire Line
	4500 6450 4250 6450
Connection ~ 4250 6450
Wire Wire Line
	4250 6450 4250 6100
Wire Wire Line
	4500 6800 4250 6800
Connection ~ 4250 6800
Wire Wire Line
	4250 6800 4250 6450
Wire Wire Line
	4500 7150 4250 7150
Connection ~ 4250 7150
Wire Wire Line
	4250 7150 4250 6800
$Comp
L Connector_Generic:Conn_01x01 J5
U 1 1 5FDAF647
P 5450 5450
F 0 "J5" H 5530 5492 50  0000 L CNN
F 1 "Conn_01x01" H 5530 5401 50  0000 L CNN
F 2 "erland-footprints:CON-SCREW-KEYSTONE-VERTICAL" H 5450 5450 50  0001 C CNN
F 3 "~" H 5450 5450 50  0001 C CNN
	1    5450 5450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 5400 5050 5450
Connection ~ 5050 5450
Wire Wire Line
	5050 5450 5050 5750
Text Label 1300 2650 0    50   ~ 0
PRECHARGE_ON
$Comp
L Connector_Generic:Conn_01x03 J1
U 1 1 5FDCA808
P 1000 2750
F 0 "J1" H 918 2425 50  0000 C CNN
F 1 "Conn_01x03" H 918 2516 50  0000 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x3-RA-0901362203" H 1000 2750 50  0001 C CNN
F 3 "~" H 1000 2750 50  0001 C CNN
	1    1000 2750
	-1   0    0    1   
$EndComp
Wire Wire Line
	1200 2650 1300 2650
Wire Wire Line
	3700 4550 4250 4550
Connection ~ 4250 4550
Wire Wire Line
	4250 4550 4250 4350
$Comp
L Connector:TestPoint TP4
U 1 1 5FDD83BE
P 4250 4150
F 0 "TP4" H 4308 4268 50  0000 L CNN
F 1 "TestPoint" H 4308 4177 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 4450 4150 50  0001 C CNN
F 3 "~" H 4450 4150 50  0001 C CNN
	1    4250 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 4150 4250 4350
Connection ~ 4250 4350
Wire Wire Line
	5050 5450 5250 5450
Text Notes 5550 2150 0    50   ~ 0
R3/R4 is to ensure Vgs does not go below -20V\nTransistor can handle 80V.\n15k / 56k divider gives min Vg of 63V.\nSwitch is on when base is low. Then 1 extra mA will leak to ground. OK.\n
Wire Wire Line
	3300 2700 3300 2850
$Comp
L Erland's:CPC2025N U1
U 1 1 5FE0F380
P 2200 5700
F 0 "U1" H 2200 6225 50  0000 C CNN
F 1 "CPC2025N" H 2200 6134 50  0000 C CNN
F 2 "erland-footprints:SOIC-8_9.3x3.8mm_P2.54mm" H 2200 5700 50  0001 C CNN
F 3 "https://www.ixysic.com/home/pdfs.nsf/www/CPC2025N.pdf/$file/CPC2025N.pdf" H 2200 5700 50  0001 C CNN
	1    2200 5700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5FE2A65E
P 1450 5400
F 0 "R2" H 1380 5354 50  0000 R CNN
F 1 "820" H 1380 5445 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1380 5400 50  0001 C CNN
F 3 "~" H 1450 5400 50  0001 C CNN
	1    1450 5400
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5FE2AEC2
P 1350 5800
F 0 "R1" H 1280 5754 50  0000 R CNN
F 1 "820" H 1280 5845 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1280 5800 50  0001 C CNN
F 3 "~" H 1350 5800 50  0001 C CNN
	1    1350 5800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5FE2B3F3
P 1600 6200
F 0 "#PWR06" H 1600 5950 50  0001 C CNN
F 1 "GND" H 1605 6027 50  0000 C CNN
F 2 "" H 1600 6200 50  0001 C CNN
F 3 "" H 1600 6200 50  0001 C CNN
	1    1600 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 6200 1600 6000
Wire Wire Line
	1600 6000 1850 6000
Wire Wire Line
	1900 5600 1850 5600
Wire Wire Line
	1850 5600 1850 6000
Connection ~ 1850 6000
Wire Wire Line
	1850 6000 1900 6000
Wire Wire Line
	1600 5400 1650 5400
Wire Wire Line
	1300 5400 1200 5400
Wire Wire Line
	1200 5800 1100 5800
Text Label 1100 5800 2    50   ~ 0
ON
Text Label 1200 5400 2    50   ~ 0
PRECHARGE_ON
Text Notes 700  7000 0    50   ~ 0
LED voltage drop 0.9-1.5 V\nLED required current 2 mA\n(3.3-1.5) / R = 0.002\nR = 1.8 / 0.002 = 900 ohm. Use 820 Ohm\nmax current if voltage drop 0.9 => (3.3-0.9)/820 = 2.9 mA\nmin current it voltage drop 1.5 => (3.3-1.5)/820= 2.2 mA.
Wire Wire Line
	2500 5800 2600 5800
Wire Wire Line
	2500 6000 2750 6000
Text Label 5050 5950 0    50   ~ 0
PRECHARGE_POST_R
Text Label 2600 5600 0    50   ~ 0
PRECHARGE_PRE_R
$Comp
L power:GNDPWR #PWR07
U 1 1 5FE7C3DE
P 2750 6100
F 0 "#PWR07" H 2750 5900 50  0001 C CNN
F 1 "GNDPWR" H 2754 5946 50  0000 C CNN
F 2 "" H 2750 6050 50  0001 C CNN
F 3 "" H 2750 6050 50  0001 C CNN
	1    2750 6100
	1    0    0    -1  
$EndComp
Text Label 2600 5800 0    50   ~ 0
POWER_GATE
Wire Wire Line
	3300 2850 3150 2850
Text Label 3150 2850 2    50   ~ 0
POWER_GATE
$Comp
L power:GNDPWR #PWR04
U 1 1 5FEE1CFA
P 1600 3700
F 0 "#PWR04" H 1600 3500 50  0001 C CNN
F 1 "GNDPWR" H 1604 3546 50  0000 C CNN
F 2 "" H 1600 3650 50  0001 C CNN
F 3 "" H 1600 3650 50  0001 C CNN
	1    1600 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 3600 1600 3700
Wire Wire Line
	1350 3600 1600 3600
Wire Wire Line
	2500 5600 2600 5600
Wire Wire Line
	2800 1850 3100 1850
Wire Wire Line
	3500 1850 4200 1850
$Comp
L Connector:TestPoint TP6
U 1 1 5FF51AAC
P 1650 5000
F 0 "TP6" H 1708 5118 50  0000 L CNN
F 1 "TestPoint" H 1708 5027 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 1850 5000 50  0001 C CNN
F 3 "~" H 1850 5000 50  0001 C CNN
	1    1650 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 5000 1650 5400
Connection ~ 1650 5400
Wire Wire Line
	1650 5400 1900 5400
Wire Wire Line
	1500 5800 1550 5800
$Comp
L Connector:TestPoint TP1
U 1 1 5FF5A36A
P 1550 5700
F 0 "TP1" H 1608 5818 50  0000 L CNN
F 1 "TestPoint" H 1608 5727 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 1750 5700 50  0001 C CNN
F 3 "~" H 1750 5700 50  0001 C CNN
	1    1550 5700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 5700 1550 5800
Connection ~ 1550 5800
Wire Wire Line
	1550 5800 1900 5800
Wire Wire Line
	2750 6100 2750 6000
Wire Wire Line
	2650 5400 2650 5300
Wire Wire Line
	2500 5400 2650 5400
Text Label 3700 4550 2    50   ~ 0
PRECHARGE_PRE_R
Text Label 3300 2300 0    50   ~ 0
Q2_GATE
Text Notes 6050 4400 0    50   ~ 0
Precharge:\n10 x 11k in parallell gives 1100 ohm. 76V worst case gives current of 70 mA\n
$EndSCHEMATC
