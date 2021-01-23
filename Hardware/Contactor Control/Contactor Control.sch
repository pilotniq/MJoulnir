EESchema Schematic File Version 4
LIBS:Contractor Control-cache
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
Text Notes 6850 800  0    50   ~ 0
Electric Boat Controller\nRaspberry Pi interface\n
Text Notes 4550 1000 0    50   ~ 0
Contactor Connection\nTODO: Change footprint
Wire Wire Line
	3350 2600 3350 2500
$Comp
L Device:R R1
U 1 1 5F9C2B22
P 2600 2050
F 0 "R1" V 2393 2050 50  0000 C CNN
F 1 "3.3k" V 2484 2050 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2530 2050 50  0001 C CNN
F 3 "~" H 2600 2050 50  0001 C CNN
	1    2600 2050
	0    1    1    0   
$EndComp
Wire Wire Line
	3050 2050 3000 2050
$Comp
L Device:R R2
U 1 1 5F9C3ECF
P 3000 2300
F 0 "R2" H 2930 2254 50  0000 R CNN
F 1 "1M" H 2930 2345 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2930 2300 50  0001 C CNN
F 3 "~" H 3000 2300 50  0001 C CNN
	1    3000 2300
	-1   0    0    1   
$EndComp
Wire Wire Line
	3000 2150 3000 2050
Connection ~ 3000 2050
Wire Wire Line
	3000 2050 2900 2050
Wire Wire Line
	3000 2450 3000 2500
Wire Wire Line
	3000 2500 3350 2500
Connection ~ 3350 2500
Wire Wire Line
	3350 2500 3350 2250
Wire Wire Line
	2450 2050 2250 2050
Text Label 2250 2050 2    50   ~ 0
CONTACTOR
$Comp
L power:+12V #PWR01
U 1 1 5FA7BA9B
P 1950 3100
F 0 "#PWR01" H 1950 2950 50  0001 C CNN
F 1 "+12V" H 1965 3273 50  0000 C CNN
F 2 "" H 1950 3100 50  0001 C CNN
F 3 "" H 1950 3100 50  0001 C CNN
	1    1950 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 3200 1950 3200
Text Notes 1500 2850 0    50   ~ 0
Power from DC/DC Converters\nvia Cut Switch
$Comp
L power:+12V #PWR04
U 1 1 5FBCB358
P 3900 1100
F 0 "#PWR04" H 3900 950 50  0001 C CNN
F 1 "+12V" H 3915 1273 50  0000 C CNN
F 2 "" H 3900 1100 50  0001 C CNN
F 3 "" H 3900 1100 50  0001 C CNN
	1    3900 1100
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 5FBD6373
P 5150 1800
F 0 "D2" V 5189 1683 50  0000 R CNN
F 1 "LED" V 5098 1683 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5150 1800 50  0001 C CNN
F 3 "~" H 5150 1800 50  0001 C CNN
	1    5150 1800
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R3
U 1 1 5FBDAD22
P 5150 2200
F 0 "R3" H 5080 2154 50  0000 R CNN
F 1 "10k" H 5080 2245 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5080 2200 50  0001 C CNN
F 3 "~" H 5150 2200 50  0001 C CNN
	1    5150 2200
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5FBDF783
P 5150 2400
F 0 "#PWR05" H 5150 2150 50  0001 C CNN
F 1 "GND" H 5155 2227 50  0000 C CNN
F 2 "" H 5150 2400 50  0001 C CNN
F 3 "" H 5150 2400 50  0001 C CNN
	1    5150 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2400 5150 2350
Wire Wire Line
	5150 2050 5150 1950
Text Notes 4950 3000 0    50   ~ 0
Contactor LED
Wire Wire Line
	3900 1300 3900 1250
Wire Wire Line
	3900 1800 3900 1750
Connection ~ 3900 1250
Wire Wire Line
	3900 1750 4250 1750
Connection ~ 3900 1750
Wire Wire Line
	3900 1750 3900 1700
Text Notes 3600 1500 2    50   ~ 0
Flywheel Diode\nReverse 12V\nCurrent 150 mA\nUse Micro Commercial SFM16PL-TP
$Comp
L Connector:TestPoint TP1
U 1 1 5FD54476
P 2900 1900
F 0 "TP1" H 2958 2018 50  0000 L CNN
F 1 "TestPoint" H 2958 1927 50  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 3100 1900 50  0001 C CNN
F 3 "~" H 3100 1900 50  0001 C CNN
	1    2900 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 1900 2900 2050
Connection ~ 2900 2050
Wire Wire Line
	2900 2050 2750 2050
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5FDA5E86
P 2300 3100
F 0 "#FLG01" H 2300 3175 50  0001 C CNN
F 1 "PWR_FLAG" H 2300 3273 50  0000 C CNN
F 2 "" H 2300 3100 50  0001 C CNN
F 3 "~" H 2300 3100 50  0001 C CNN
	1    2300 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 3200 2300 3200
Wire Wire Line
	2300 3200 2300 3100
Connection ~ 1950 3200
Wire Wire Line
	1950 3200 1950 3100
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5FE503AE
P 1550 3300
F 0 "J2" H 1468 2975 50  0000 C CNN
F 1 "Conn_01x02" H 1468 3066 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 1550 3300 50  0001 C CNN
F 3 "~" H 1550 3300 50  0001 C CNN
	1    1550 3300
	-1   0    0    1   
$EndComp
Wire Wire Line
	1750 3300 1950 3300
Wire Wire Line
	1950 3300 1950 3350
$Comp
L Mechanical:MountingHole H4
U 1 1 5FF1697B
P 6250 7600
F 0 "H4" H 6350 7646 50  0000 L CNN
F 1 "MountingHole" H 6350 7555 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6250 7600 50  0001 C CNN
F 3 "~" H 6250 7600 50  0001 C CNN
	1    6250 7600
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5FF16F3F
P 6250 7400
F 0 "H3" H 6350 7446 50  0000 L CNN
F 1 "MountingHole" H 6350 7355 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6250 7400 50  0001 C CNN
F 3 "~" H 6250 7400 50  0001 C CNN
	1    6250 7400
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5FF17B4B
P 6250 7200
F 0 "H2" H 6350 7246 50  0000 L CNN
F 1 "MountingHole" H 6350 7155 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6250 7200 50  0001 C CNN
F 3 "~" H 6250 7200 50  0001 C CNN
	1    6250 7200
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H1
U 1 1 5FF1848C
P 6250 7000
F 0 "H1" H 6350 7046 50  0000 L CNN
F 1 "MountingHole" H 6350 6955 50  0000 L CNN
F 2 "MountingHole:MountingHole_4.3mm_M4_ISO14580" H 6250 7000 50  0001 C CNN
F 3 "~" H 6250 7000 50  0001 C CNN
	1    6250 7000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x02_Top_Bottom J4
U 1 1 5FF79251
P 4700 1500
F 0 "J4" H 4750 1300 50  0000 C CNN
F 1 "Conn_02x02_Top_Bottom" H 4750 1626 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x4-RA-0901362204" H 4700 1500 50  0001 C CNN
F 3 "~" H 4700 1500 50  0001 C CNN
	1    4700 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 1500 5100 1500
Wire Wire Line
	5000 1600 5150 1600
Wire Wire Line
	5150 1600 5150 1650
Wire Wire Line
	5100 1250 5100 1500
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 602835D5
P 1300 1150
F 0 "J1" H 1300 1250 50  0000 C CNN
F 1 "Conn_01x02" H 1218 916 50  0001 C CNN
F 2 "erland-footprints:CON-MOLEX-CGRIDIII-1x2 RA-0901362202" H 1300 1150 50  0001 C CNN
F 3 "~" H 1300 1150 50  0001 C CNN
	1    1300 1150
	-1   0    0    1   
$EndComp
Wire Wire Line
	1500 1050 1650 1050
Text Label 1650 1050 0    50   ~ 0
CONTACTOR
$Comp
L power:GND #PWR03
U 1 1 60285FCA
P 3350 2600
F 0 "#PWR03" H 3350 2350 50  0001 C CNN
F 1 "GND" H 3355 2427 50  0000 C CNN
F 2 "" H 3350 2600 50  0001 C CNN
F 3 "" H 3350 2600 50  0001 C CNN
	1    3350 2600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR02
U 1 1 60286B74
P 1950 3350
F 0 "#PWR02" H 1950 3100 50  0001 C CNN
F 1 "GND" H 1955 3177 50  0000 C CNN
F 2 "" H 1950 3350 50  0001 C CNN
F 3 "" H 1950 3350 50  0001 C CNN
	1    1950 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 1150 1650 1150
$Comp
L Connector_Generic:Conn_01x01 J3
U 1 1 60287DCB
P 1850 1150
F 0 "J3" H 1930 1192 50  0000 L CNN
F 1 "Conn_01x01" H 1930 1101 50  0000 L CNN
F 2 "Connector_Wire:SolderWirePad_1x01_Drill1mm" H 1850 1150 50  0001 C CNN
F 3 "~" H 1850 1150 50  0001 C CNN
	1    1850 1150
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 602926F8
P 4250 1800
F 0 "TP2" H 4192 1826 50  0000 R CNN
F 1 "TestPoint" H 4192 1917 50  0000 R CNN
F 2 "TestPoint:TestPoint_Pad_D2.0mm" H 4450 1800 50  0001 C CNN
F 3 "~" H 4450 1800 50  0001 C CNN
	1    4250 1800
	-1   0    0    1   
$EndComp
Wire Wire Line
	4250 1800 4250 1750
Connection ~ 4250 1750
Wire Wire Line
	4250 1750 4300 1750
Text Notes 3250 3350 0    50   ~ 0
Contactor is Gigavac GV241MAB. \n”Pickup current” is 3,6 A during max of 75 ms.\n\nPickup dissipation: 28 mOhm ’ 3,6 ^2=100 mW.\n173 C/W worst casae => 17 C temp rise. No problem
Text Notes 1300 4050 0    50   ~ 0
Molex CGrid III connectors are only specified to 3A. \nThe contactor may draw 3.6A in a short burst on connect, \nonly for max 75 ms. \nI will use single pin CGrid III even though it exceeds the specification.\nIf this doesn’t work, use a 4 pin connector in a revision 2.
Wire Wire Line
	3900 1100 3900 1250
Text Notes 5800 1700 0    50   ~ 0
Contactor is Gigavac GV241MAB, with\nconnector has Amp Micro Quadlok 1-967584-3 connector.\nMates with cable receptacle 1-967640-1 with \ncrimp pins 965906-5 or 965906-9 (MOQ 9000)\n
Wire Wire Line
	3900 1250 4400 1250
Wire Wire Line
	4500 1500 4300 1500
Wire Wire Line
	4300 1500 4300 1750
Wire Wire Line
	4400 1250 4400 1600
Wire Wire Line
	4400 1600 4500 1600
Connection ~ 4400 1250
Wire Wire Line
	4400 1250 5100 1250
Wire Wire Line
	3900 1800 3350 1800
Wire Wire Line
	3350 1800 3350 1850
$Comp
L Erland's:D-CMPSH1-4 D1
U 1 1 61FBB14A
P 3900 1450
F 0 "D1" V 3896 1322 50  0000 R CNN
F 1 "D-CMPSH1-4" V 3805 1322 50  0000 R CNN
F 2 "erland-footprints:SOT23F" H 3900 1450 50  0001 C CNN
F 3 "https://my.centralsemi.com/datasheets/CMPSH1-4.PDF" H 3900 1450 50  0001 C CNN
	1    3900 1450
	0    -1   -1   0   
$EndComp
$Comp
L Erland's:Q-FET-N-PMN20EN Q1
U 1 1 61FFDCDB
P 3300 2050
F 0 "Q1" H 3455 2096 50  0000 L CNN
F 1 "Q-FET-N-PMN20EN" H 3455 2005 50  0000 L CNN
F 2 "Package_SO:TSOP-6_1.65x3.05mm_P0.95mm" H 3300 2050 50  0001 C CNN
F 3 "" H 3300 2050 50  0001 C CNN
	1    3300 2050
	1    0    0    -1  
$EndComp
$EndSCHEMATC
