EESchema Schematic File Version 4
LIBS:DCDC Power Control-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "Precharge & DCDC Control"
Date ""
Rev "2"
Comp "Erland Lewin"
Comment1 "Solo Electric Boat Drivetrain"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1150 1850 1600 1850
Wire Wire Line
	1600 1850 1600 1950
$Comp
L Device:Fuse F1
U 1 1 5F8C2578
P 1550 1750
F 0 "F1" V 1353 1750 50  0000 C CNN
F 1 "5 A/80V" V 1444 1750 50  0000 C CNN
F 2 "erland-footprints:FUSE-KEYSTONE-3557-2" V 1480 1750 50  0001 C CNN
F 3 "~" H 1550 1750 50  0001 C CNN
	1    1550 1750
	0    1    1    0   
$EndComp
Wire Wire Line
	1700 1750 1900 1750
Text Notes 800  1150 0    50   ~ 0
Low current battery power in
Text Notes 650  3750 0    50   ~ 0
Momentary Power Switch Connection
$Comp
L Connector:Screw_Terminal_01x02 J4
U 1 1 5FA6745E
P 9950 2550
F 0 "J4" V 9914 2362 50  0000 R CNN
F 1 "Screw_Terminal_01x02" V 9823 2362 50  0001 R CNN
F 2 "Connector_AMASS:AMASS_XT30PW-F_1x02_P2.50mm_Horizontal" H 9950 2550 50  0001 C CNN
F 3 "~" H 9950 2550 50  0001 C CNN
	1    9950 2550
	1    0    0    1   
$EndComp
Wire Wire Line
	9700 2700 9700 2550
Text Notes 9150 3050 0    50   ~ 0
Power to DC/DC Converters
Text Notes 2700 2650 0    50   ~ 0
Momentary Power Switch connection\n3.3V < 1 mA will go through switch
$Comp
L power:GNDPWR #PWR05
U 1 1 5FE28399
P 1600 1950
F 0 "#PWR05" H 1600 1750 50  0001 C CNN
F 1 "GNDPWR" H 1604 1796 50  0000 C CNN
F 2 "" H 1600 1900 50  0001 C CNN
F 3 "" H 1600 1900 50  0001 C CNN
	1    1600 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR010
U 1 1 5FE4E716
P 9700 2700
F 0 "#PWR010" H 9700 2500 50  0001 C CNN
F 1 "GNDPWR" H 9704 2546 50  0000 C CNN
F 2 "" H 9700 2650 50  0001 C CNN
F 3 "" H 9700 2650 50  0001 C CNN
	1    9700 2700
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5FF10D82
P 950 1850
F 0 "J3" H 868 1525 50  0000 C CNN
F 1 "Conn_01x02" H 868 1616 50  0000 C CNN
F 2 "Connector_AMASS:AMASS_XT30PW-M_1x02_P2.50mm_Horizontal" H 950 1850 50  0001 C CNN
F 3 "~" H 950 1850 50  0001 C CNN
	1    950  1850
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
DCDC_ON_IN
Wire Wire Line
	9700 2550 9750 2550
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
	1350 3500 1450 3500
Wire Wire Line
	1150 1750 1400 1750
$Comp
L power:+BATT #PWR03
U 1 1 5FD901BA
P 1900 1700
F 0 "#PWR03" H 1900 1550 50  0001 C CNN
F 1 "+BATT" H 1915 1873 50  0000 C CNN
F 2 "" H 1900 1700 50  0001 C CNN
F 3 "" H 1900 1700 50  0001 C CNN
	1    1900 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1700 1900 1750
$Comp
L Connector_Generic:Conn_01x01 J5
U 1 1 5FDAF647
P 9950 1950
F 0 "J5" H 10030 1992 50  0000 L CNN
F 1 "Conn_01x01" H 10030 1901 50  0000 L CNN
F 2 "erland-footprints:CON-SCREW-KEYSTONE-VERTICAL" H 9950 1950 50  0001 C CNN
F 3 "~" H 9950 1950 50  0001 C CNN
	1    9950 1950
	1    0    0    -1  
$EndComp
Text Label 1300 2650 0    50   ~ 0
VESC_PRECHARGE_IN
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
$Comp
L Erland's:CPC2025N U1
U 1 1 5FE0F380
P 2550 5650
F 0 "U1" H 2550 6175 50  0000 C CNN
F 1 "CPC2025N" H 2550 6084 50  0000 C CNN
F 2 "erland-footprints:SOIC-8_9.3x3.8mm_P2.54mm" H 2550 5650 50  0001 C CNN
F 3 "https://www.ixysic.com/home/pdfs.nsf/www/CPC2025N.pdf/$file/CPC2025N.pdf" H 2550 5650 50  0001 C CNN
	1    2550 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5FE2A65E
P 1800 5350
F 0 "R2" H 1730 5304 50  0000 R CNN
F 1 "820" H 1730 5395 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1730 5350 50  0001 C CNN
F 3 "~" H 1800 5350 50  0001 C CNN
	1    1800 5350
	0    1    1    0   
$EndComp
$Comp
L Device:R R1
U 1 1 5FE2AEC2
P 1700 5750
F 0 "R1" H 1630 5704 50  0000 R CNN
F 1 "820" H 1630 5795 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1630 5750 50  0001 C CNN
F 3 "~" H 1700 5750 50  0001 C CNN
	1    1700 5750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 5FE2B3F3
P 1950 6150
F 0 "#PWR06" H 1950 5900 50  0001 C CNN
F 1 "GND" H 1955 5977 50  0000 C CNN
F 2 "" H 1950 6150 50  0001 C CNN
F 3 "" H 1950 6150 50  0001 C CNN
	1    1950 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 6150 1950 6050
Wire Wire Line
	1950 5950 2200 5950
Wire Wire Line
	2250 5550 2200 5550
Wire Wire Line
	2200 5550 2200 5950
Connection ~ 2200 5950
Wire Wire Line
	2200 5950 2250 5950
Wire Wire Line
	1950 5350 2000 5350
Wire Wire Line
	1650 5350 1550 5350
Wire Wire Line
	1550 5750 1450 5750
Text Label 1450 5750 2    50   ~ 0
DCDC_ON_IN
Text Label 1550 5350 2    50   ~ 0
VESC_PRECHARGE_IN
Text Notes 700  7000 0    50   ~ 0
LED voltage drop 0.9-1.5 V\nLED required current 2 mA\n(3.3-1.5) / R = 0.002\nR = 1.8 / 0.002 = 900 ohm. Use 820 Ohm\nmax current if voltage drop 0.9 => (3.3-0.9)/820 = 2.9 mA\nmin current it voltage drop 1.5 => (3.3-1.5)/820= 2.2 mA.
Wire Wire Line
	2850 5750 3250 5750
Wire Wire Line
	2850 5950 3100 5950
$Comp
L power:GNDPWR #PWR07
U 1 1 5FE7C3DE
P 3100 6050
F 0 "#PWR07" H 3100 5850 50  0001 C CNN
F 1 "GNDPWR" H 3104 5896 50  0000 C CNN
F 2 "" H 3100 6000 50  0001 C CNN
F 3 "" H 3100 6000 50  0001 C CNN
	1    3100 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 3600 1500 3600
$Comp
L Connector:TestPoint TP6
U 1 1 5FF51AAC
P 2000 4950
F 0 "TP6" H 2058 5068 50  0000 L CNN
F 1 "TestPoint" H 2058 4977 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 2200 4950 50  0001 C CNN
F 3 "~" H 2200 4950 50  0001 C CNN
	1    2000 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 4950 2000 5350
Connection ~ 2000 5350
Wire Wire Line
	2000 5350 2250 5350
Wire Wire Line
	1850 5750 1900 5750
$Comp
L Connector:TestPoint TP1
U 1 1 5FF5A36A
P 1900 5650
F 0 "TP1" H 1958 5768 50  0000 L CNN
F 1 "TestPoint" H 1958 5677 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 2100 5650 50  0001 C CNN
F 3 "~" H 2100 5650 50  0001 C CNN
	1    1900 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 5650 1900 5750
Connection ~ 1900 5750
Wire Wire Line
	1900 5750 2250 5750
Wire Wire Line
	3100 6050 3100 5950
Wire Wire Line
	2850 5350 3250 5350
Text Notes 5250 1350 0    50   ~ 0
Changes for V2:\n* Precharge for DC/DC as well as VESC\n* More powerful precharge resistors\n* Can we have precharge automatically for DC/DC? Otherwise we need another control signal. Control signal is doable, might be worth less complexity\n* With more precharge current, SSR won’t be sufficient. Need to add or replace with optoisolated transistors\n\n
Text Label 9500 2450 2    50   ~ 0
DCDC_OUT
$Sheet
S 3450 3400 1400 1050
U 6024A624
F0 "Microcontroller" 50
F1 "Microcontroller.sch" 50
F2 "VBATT" I L 3450 3500 50 
F3 "ON" I L 3450 3800 50 
F4 "VESC_PRECHARGE" I L 3450 3900 50 
F5 "VESC_PRECHARGE_GATE" I R 4850 3550 50 
F6 "DCDC_PRECHARGE_GATE" I R 4850 3750 50 
F7 "SWITCH_A" I L 3450 4100 50 
F8 "SWITCH_B" I L 3450 4200 50 
F9 "DCDC_GATE" O R 4850 3850 50 
F10 "V_DCDC" I L 3450 3600 50 
$EndSheet
$Comp
L power:+BATT #PWR02
U 1 1 6027681F
P 3250 3400
F 0 "#PWR02" H 3250 3250 50  0001 C CNN
F 1 "+BATT" H 3265 3573 50  0000 C CNN
F 2 "" H 3250 3400 50  0001 C CNN
F 3 "" H 3250 3400 50  0001 C CNN
	1    3250 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 3500 3250 3500
Wire Wire Line
	3250 3500 3250 3400
Wire Wire Line
	3450 3600 3250 3600
Text Label 3250 3600 2    50   ~ 0
DCDC_OUT
$Sheet
S 5400 3450 2000 500 
U 6027BF0D
F0 "Power Switches" 50
F1 "power_switches.sch" 50
F2 "VESC_PRECHARGE_OUT" O R 7400 3550 50 
F3 "DCDC_OUT" O R 7400 3800 50 
F4 "VESC_PRECHARGE_GATE" I L 5400 3550 50 
F5 "DCDC_PRECHARGE_GATE" I L 5400 3750 50 
F6 "DCDC_POWER_GATE" I L 5400 3850 50 
$EndSheet
$Comp
L Device:LED D1
U 1 1 602E0348
P 8750 4100
AR Path="/602E0348" Ref="D1"  Part="1" 
AR Path="/6027BF0D/602E0348" Ref="D?"  Part="1" 
F 0 "D1" V 8789 3983 50  0000 R CNN
F 1 "Or LED" V 8698 3983 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 8750 4100 50  0001 C CNN
F 3 "~" H 8750 4100 50  0001 C CNN
F 4 "475-2486-1-ND" V 8750 4100 50  0001 C CNN "PN"
	1    8750 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8750 3950 8750 3850
Wire Wire Line
	8750 4400 8750 4250
Wire Wire Line
	8750 4700 8750 4800
$Comp
L power:GNDPWR #PWR04
U 1 1 602E0351
P 8750 4800
F 0 "#PWR04" H 8750 4600 50  0001 C CNN
F 1 "GNDPWR" H 8754 4646 50  0000 C CNN
F 2 "" H 8750 4750 50  0001 C CNN
F 3 "" H 8750 4750 50  0001 C CNN
	1    8750 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 602E0357
P 8750 4550
F 0 "R3" H 8680 4504 50  0000 R CNN
F 1 "47k 120 mW" H 8680 4595 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 8680 4550 50  0001 C CNN
F 3 "~" H 8750 4550 50  0001 C CNN
	1    8750 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7400 3800 7600 3800
Text Label 7600 3800 0    50   ~ 0
DCDC_OUT
Wire Wire Line
	7400 3550 7600 3550
Text Label 7600 3550 0    50   ~ 0
VESC_OUT
Text Label 8600 3850 2    50   ~ 0
VESC_OUT
Wire Wire Line
	8600 3850 8750 3850
Wire Wire Line
	4850 3550 5400 3550
Wire Wire Line
	4850 3750 5400 3750
Wire Wire Line
	4850 3850 5400 3850
$Comp
L Device:LED D2
U 1 1 6030D4E4
P 9700 4100
AR Path="/6030D4E4" Ref="D2"  Part="1" 
AR Path="/6027BF0D/6030D4E4" Ref="D?"  Part="1" 
F 0 "D2" V 9739 3983 50  0000 R CNN
F 1 "LED" V 9648 3983 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9700 4100 50  0001 C CNN
F 3 "~" H 9700 4100 50  0001 C CNN
F 4 "475-3118-1-ND" V 9700 4100 50  0001 C CNN "PN"
	1    9700 4100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 3950 9700 3850
Wire Wire Line
	9700 4400 9700 4250
Wire Wire Line
	9700 4700 9700 4800
$Comp
L power:GNDPWR #PWR08
U 1 1 6030D4ED
P 9700 4800
F 0 "#PWR08" H 9700 4600 50  0001 C CNN
F 1 "GNDPWR" H 9704 4646 50  0000 C CNN
F 2 "" H 9700 4750 50  0001 C CNN
F 3 "" H 9700 4750 50  0001 C CNN
	1    9700 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 6030D4F3
P 9700 4550
F 0 "R4" H 9630 4504 50  0000 R CNN
F 1 "47k" H 9630 4595 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9630 4550 50  0001 C CNN
F 3 "~" H 9700 4550 50  0001 C CNN
	1    9700 4550
	1    0    0    -1  
$EndComp
Text Label 9550 3850 2    50   ~ 0
DCDC_OUT
Wire Wire Line
	9550 3850 9700 3850
Text Label 1500 3600 0    50   ~ 0
SWITCH_A
Text Label 1500 3500 0    50   ~ 0
SWITCH_B
Text Label 3250 4100 2    50   ~ 0
SWITCH_A
Text Label 3250 4200 2    50   ~ 0
SWITCH_B
Wire Wire Line
	3250 4200 3450 4200
Wire Wire Line
	3250 4100 3450 4100
Wire Wire Line
	3100 5550 3100 5950
Wire Wire Line
	2850 5550 3100 5550
Connection ~ 3100 5950
Text Label 3250 5750 0    50   ~ 0
DCDC_ON
Text Label 3250 3800 2    50   ~ 0
DCDC_ON
Text Label 3250 5350 0    50   ~ 0
VESC_PRECHARGE
Text Label 3250 3900 2    50   ~ 0
VESC_PRECHARGE
Wire Wire Line
	3250 3900 3450 3900
Wire Wire Line
	3250 3800 3450 3800
Text Label 9500 1950 2    50   ~ 0
VESC_OUT
Wire Wire Line
	9500 1950 9600 1950
Text Notes 6950 5650 0    50   ~ 0
VESC LED: Orange, VF=2V\n\nMax battery -> 74V over resistor\nMax current = 20 mA\nR = 3.7k\n\nMin battery -> 55V, 53V over R\nCurrent = 14 mA\n\nAdjust to min current 1 mA\nR = 47k\n\nMin current: 1.1 mA\nMax current: 1.6 mA P=116 mW
Text Notes 9250 6350 0    50   ~ 0
DCDC LED: Green, VF=1.7V\n\nMax battery -> 74V over resistor\nMax current = 20 mA\nR = 3.7k\n\nMin battery -> 55V, 53V over R\nCurrent = 14 mA\n\nAdjust to min current 1 mA\nR = 47k\n\nMin current: 1.1 mA\nMax current: 1.6 mA P=116 mW
$Comp
L Connector:TestPoint TP16
U 1 1 601A6BFF
P 9650 2400
F 0 "TP16" H 9708 2518 50  0000 L CNN
F 1 "TestPoint" H 9708 2427 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9850 2400 50  0001 C CNN
F 3 "~" H 9850 2400 50  0001 C CNN
	1    9650 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 2450 9650 2450
Wire Wire Line
	9650 2400 9650 2450
Connection ~ 9650 2450
Wire Wire Line
	9650 2450 9750 2450
$Comp
L Connector:TestPoint TP15
U 1 1 601A8D20
P 9600 1900
F 0 "TP15" H 9658 2018 50  0000 L CNN
F 1 "TestPoint" H 9658 1927 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 9800 1900 50  0001 C CNN
F 3 "~" H 9800 1900 50  0001 C CNN
	1    9600 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9600 1900 9600 1950
Connection ~ 9600 1950
Wire Wire Line
	9600 1950 9750 1950
$Comp
L Connector:TestPoint TP20
U 1 1 601D4152
P 1450 3350
F 0 "TP20" H 1508 3468 50  0000 L CNN
F 1 "TestPoint" H 1508 3377 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 1650 3350 50  0001 C CNN
F 3 "~" H 1650 3350 50  0001 C CNN
	1    1450 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1450 3350 1450 3500
Connection ~ 1450 3500
Wire Wire Line
	1450 3500 1500 3500
$Comp
L Connector:TestPoint TP21
U 1 1 602EC0DF
P 1500 6000
F 0 "TP21" H 1558 6118 50  0000 L CNN
F 1 "TestPoint" H 1558 6027 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 1700 6000 50  0001 C CNN
F 3 "~" H 1700 6000 50  0001 C CNN
	1    1500 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 6000 1500 6050
Wire Wire Line
	1500 6050 1950 6050
Connection ~ 1950 6050
Wire Wire Line
	1950 6050 1950 5950
$Comp
L Connector:TestPoint TP22
U 1 1 602EDF87
P 2200 1800
F 0 "TP22" H 2258 1918 50  0000 L CNN
F 1 "TestPoint" H 2258 1827 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 2400 1800 50  0001 C CNN
F 3 "~" H 2400 1800 50  0001 C CNN
	1    2200 1800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1850 2200 1850
Wire Wire Line
	2200 1850 2200 1800
Connection ~ 1600 1850
$EndSCHEMATC
