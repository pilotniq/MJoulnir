EESchema Schematic File Version 4
LIBS:DCDC Power Control-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
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
L Transistor_FET:SiS415DNT Q?
U 1 1 602891CC
P 6900 3600
AR Path="/602891CC" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/602891CC" Ref="Q6"  Part="1" 
F 0 "Q6" V 7242 3600 50  0000 C CNN
F 1 "SQJ479EP-T1_GE3" V 7151 3600 50  0000 C CNN
F 2 "Package_SO:Vishay_PowerPAK_1212-8_Single" H 7100 3525 50  0001 L CIN
F 3 "https://www.vishay.com/docs/75129/sqj479ep.pdf" V 6900 3600 50  0001 L CNN
	1    6900 3600
	0    1    -1   0   
$EndComp
Wire Wire Line
	7200 3500 7100 3500
$Comp
L Device:R R?
U 1 1 602891D3
P 6650 3900
AR Path="/602891D3" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602891D3" Ref="R20"  Part="1" 
F 0 "R20" H 6580 3854 50  0000 R CNN
F 1 "15K" H 6580 3945 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6580 3900 50  0001 C CNN
F 3 "~" H 6650 3900 50  0001 C CNN
	1    6650 3900
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 602891D9
P 6900 4100
AR Path="/602891D9" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602891D9" Ref="R21"  Part="1" 
F 0 "R21" H 6830 4054 50  0000 R CNN
F 1 "56k" H 6830 4145 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6830 4100 50  0001 C CNN
F 3 "~" H 6900 4100 50  0001 C CNN
	1    6900 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 3800 6900 3850
Wire Wire Line
	6800 3900 6900 3900
Connection ~ 6900 3900
Wire Wire Line
	6900 3900 6900 3950
Wire Wire Line
	6500 3900 6450 3900
Wire Wire Line
	6450 3900 6450 3500
Wire Wire Line
	6700 3500 6450 3500
$Comp
L power:+BATT #PWR?
U 1 1 602891E6
P 6400 3450
AR Path="/602891E6" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/602891E6" Ref="#PWR021"  Part="1" 
F 0 "#PWR021" H 6400 3300 50  0001 C CNN
F 1 "+BATT" H 6415 3623 50  0000 C CNN
F 2 "" H 6400 3450 50  0001 C CNN
F 3 "" H 6400 3450 50  0001 C CNN
	1    6400 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3500 6400 3500
Wire Wire Line
	6400 3500 6400 3450
Connection ~ 6450 3500
Wire Wire Line
	6900 4250 6900 4300
$Comp
L Transistor_FET:BSS123 Q?
U 1 1 602891F2
P 6800 4550
AR Path="/602891F2" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/602891F2" Ref="Q5"  Part="1" 
F 0 "Q5" H 7004 4596 50  0000 L CNN
F 1 "BSS123" H 7004 4505 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 7000 4475 50  0001 L CIN
F 3 "http://www.diodes.com/assets/Datasheets/ds30366.pdf" H 6800 4550 50  0001 L CNN
	1    6800 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 4550 6500 4550
$Comp
L power:GNDPWR #PWR?
U 1 1 602891F9
P 6900 5050
AR Path="/602891F9" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/602891F9" Ref="#PWR022"  Part="1" 
F 0 "#PWR022" H 6900 4850 50  0001 C CNN
F 1 "GNDPWR" H 6904 4896 50  0000 C CNN
F 2 "" H 6900 5000 50  0001 C CNN
F 3 "" H 6900 5000 50  0001 C CNN
	1    6900 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 5050 6900 4950
$Comp
L Device:R R?
U 1 1 60289200
P 6550 4750
AR Path="/60289200" Ref="R?"  Part="1" 
AR Path="/6027BF0D/60289200" Ref="R19"  Part="1" 
F 0 "R19" H 6480 4704 50  0000 R CNN
F 1 "10k" H 6480 4795 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6480 4750 50  0001 C CNN
F 3 "~" H 6550 4750 50  0001 C CNN
	1    6550 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6550 4900 6550 4950
Wire Wire Line
	6550 4950 6900 4950
Connection ~ 6900 4950
Wire Wire Line
	6900 4950 6900 4750
Wire Wire Line
	6550 4600 6550 4550
Connection ~ 6550 4550
Wire Wire Line
	6550 4550 6600 4550
$Comp
L Device:R R?
U 1 1 6029C604
P 5350 1500
AR Path="/6029C604" Ref="R?"  Part="1" 
AR Path="/6027BF0D/6029C604" Ref="R16"  Part="1" 
F 0 "R16" H 5280 1454 50  0000 R CNN
F 1 "15K" H 5280 1545 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5280 1500 50  0001 C CNN
F 3 "~" H 5350 1500 50  0001 C CNN
	1    5350 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5200 1500 5150 1500
Wire Wire Line
	5150 1500 5150 1150
Wire Wire Line
	5500 1500 5650 1500
Wire Wire Line
	5650 1500 5650 1450
Connection ~ 5650 1500
Wire Wire Line
	5650 1500 5650 1600
$Comp
L Device:R R?
U 1 1 6029C610
P 5650 1750
AR Path="/6029C610" Ref="R?"  Part="1" 
AR Path="/6027BF0D/6029C610" Ref="R17"  Part="1" 
F 0 "R17" H 5580 1704 50  0000 R CNN
F 1 "56k" H 5580 1795 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5580 1750 50  0001 C CNN
F 3 "~" H 5650 1750 50  0001 C CNN
	1    5650 1750
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 6029C61F
P 5750 1450
AR Path="/6029C61F" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/6029C61F" Ref="TP4"  Part="1" 
F 0 "TP4" V 5704 1638 50  0000 L CNN
F 1 "TestPoint" V 5795 1638 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5950 1450 50  0001 C CNN
F 3 "~" H 5950 1450 50  0001 C CNN
	1    5750 1450
	0    1    1    0   
$EndComp
Wire Wire Line
	5750 1450 5650 1450
Wire Wire Line
	5650 1900 5650 2000
Wire Wire Line
	5650 2000 5750 2000
$Comp
L Connector:TestPoint TP?
U 1 1 6029C628
P 5750 2000
AR Path="/6029C628" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/6029C628" Ref="TP5"  Part="1" 
F 0 "TP5" V 5704 2188 50  0000 L CNN
F 1 "TestPoint" V 5795 2188 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5950 2000 50  0001 C CNN
F 3 "~" H 5950 2000 50  0001 C CNN
	1    5750 2000
	0    1    1    0   
$EndComp
$Comp
L Transistor_FET:ZXMP4A16G Q?
U 1 1 6029C634
P 5650 1250
AR Path="/6029C634" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/6029C634" Ref="Q4"  Part="1" 
F 0 "Q4" V 5992 1250 50  0000 C CNN
F 1 "MCT06P10" V 5901 1250 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 5850 1175 50  0001 L CIN
F 3 "https://www.mccsemi.com/pdf/Products/MCT06P10(SOT-223)-A.pdf" V 5650 1250 50  0001 L CNN
	1    5650 1250
	0    1    -1   0   
$EndComp
Connection ~ 5650 1450
Text Label 5650 1600 0    50   ~ 0
Q4_GATE
$Comp
L power:+BATT #PWR?
U 1 1 6029C63D
P 5150 1100
AR Path="/6029C63D" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/6029C63D" Ref="#PWR019"  Part="1" 
F 0 "#PWR019" H 5150 950 50  0001 C CNN
F 1 "+BATT" H 5165 1273 50  0000 C CNN
F 2 "" H 5150 1100 50  0001 C CNN
F 3 "" H 5150 1100 50  0001 C CNN
	1    5150 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 1100 5150 1150
Connection ~ 5150 1150
Wire Wire Line
	5150 1150 5450 1150
$Comp
L Device:R R?
U 1 1 6029C64C
P 6200 1150
AR Path="/6029C64C" Ref="R?"  Part="1" 
AR Path="/6027BF0D/6029C64C" Ref="R18"  Part="1" 
F 0 "R18" V 6050 1250 50  0000 R CNN
F 1 "150 Ohm, 45W" V 6130 1195 50  0000 C CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 6130 1150 50  0001 C CNN
F 3 "~" H 6200 1150 50  0001 C CNN
F 4 "SQMW7150RJ" H 6200 1150 50  0001 C CNN "PN"
	1    6200 1150
	0    1    1    0   
$EndComp
Wire Wire Line
	5850 1150 5950 1150
Text Label 6600 1150 0    50   ~ 0
DCDC_OUT
$Comp
L Transistor_FET:BSS123 Q?
U 1 1 6029C657
P 5550 2300
AR Path="/6029C657" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/6029C657" Ref="Q3"  Part="1" 
F 0 "Q3" H 5754 2346 50  0000 L CNN
F 1 "BSS123" H 5754 2255 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 5750 2225 50  0001 L CIN
F 3 "http://www.diodes.com/assets/Datasheets/ds30366.pdf" H 5550 2300 50  0001 L CNN
	1    5550 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR?
U 1 1 6029C65D
P 5650 2950
AR Path="/6029C65D" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/6029C65D" Ref="#PWR020"  Part="1" 
F 0 "#PWR020" H 5650 2750 50  0001 C CNN
F 1 "GNDPWR" H 5654 2796 50  0000 C CNN
F 2 "" H 5650 2900 50  0001 C CNN
F 3 "" H 5650 2900 50  0001 C CNN
	1    5650 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5650 2100 5650 2000
Connection ~ 5650 2000
Wire Wire Line
	5650 2950 5650 2800
Wire Wire Line
	5350 2300 5300 2300
$Comp
L Device:R R?
U 1 1 602BB021
P 3100 3850
AR Path="/602BB021" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602BB021" Ref="R12"  Part="1" 
F 0 "R12" H 3030 3804 50  0000 R CNN
F 1 "15K" H 3030 3895 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3030 3850 50  0001 C CNN
F 3 "~" H 3100 3850 50  0001 C CNN
	1    3100 3850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2950 3850 2900 3850
Wire Wire Line
	2900 3850 2900 3500
Wire Wire Line
	3250 3850 3400 3850
Wire Wire Line
	3400 3850 3400 3800
Connection ~ 3400 3850
Wire Wire Line
	3400 3850 3400 3950
$Comp
L Device:R R?
U 1 1 602BB02D
P 3400 4100
AR Path="/602BB02D" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602BB02D" Ref="R13"  Part="1" 
F 0 "R13" H 3330 4054 50  0000 R CNN
F 1 "56k" H 3330 4145 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 3330 4100 50  0001 C CNN
F 3 "~" H 3400 4100 50  0001 C CNN
	1    3400 4100
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 602BB03C
P 3500 3800
AR Path="/602BB03C" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/602BB03C" Ref="TP2"  Part="1" 
F 0 "TP2" V 3454 3988 50  0000 L CNN
F 1 "TestPoint" V 3545 3988 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3700 3800 50  0001 C CNN
F 3 "~" H 3700 3800 50  0001 C CNN
	1    3500 3800
	0    1    1    0   
$EndComp
Wire Wire Line
	3500 3800 3400 3800
Wire Wire Line
	3400 4250 3400 4350
Wire Wire Line
	3400 4350 3500 4350
$Comp
L Connector:TestPoint TP?
U 1 1 602BB045
P 3500 4350
AR Path="/602BB045" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/602BB045" Ref="TP3"  Part="1" 
F 0 "TP3" V 3454 4538 50  0000 L CNN
F 1 "TestPoint" V 3545 4538 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3700 4350 50  0001 C CNN
F 3 "~" H 3700 4350 50  0001 C CNN
	1    3500 4350
	0    1    1    0   
$EndComp
$Comp
L Transistor_FET:ZXMP4A16G Q?
U 1 1 602BB051
P 3400 3600
AR Path="/602BB051" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/602BB051" Ref="Q2"  Part="1" 
F 0 "Q2" V 3742 3600 50  0000 C CNN
F 1 "MCT06P10" V 3651 3600 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 3600 3525 50  0001 L CIN
F 3 "https://www.mccsemi.com/pdf/Products/MCT06P10(SOT-223)-A.pdf" V 3400 3600 50  0001 L CNN
	1    3400 3600
	0    1    -1   0   
$EndComp
Connection ~ 3400 3800
Text Label 3400 3950 0    50   ~ 0
Q2_GATE
$Comp
L power:+BATT #PWR?
U 1 1 602BB05A
P 2900 3450
AR Path="/602BB05A" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/602BB05A" Ref="#PWR017"  Part="1" 
F 0 "#PWR017" H 2900 3300 50  0001 C CNN
F 1 "+BATT" H 2915 3623 50  0000 C CNN
F 2 "" H 2900 3450 50  0001 C CNN
F 3 "" H 2900 3450 50  0001 C CNN
	1    2900 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 3450 2900 3500
Connection ~ 2900 3500
Wire Wire Line
	2900 3500 3200 3500
$Comp
L Device:R R?
U 1 1 602BB069
P 3900 3500
AR Path="/602BB069" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602BB069" Ref="R14"  Part="1" 
F 0 "R14" H 3830 3454 50  0000 R CNN
F 1 "150 Ohm, 45W" H 3830 3545 50  0000 R CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 3830 3500 50  0001 C CNN
F 3 "~" H 3900 3500 50  0001 C CNN
F 4 "SQMW7150RJ" H 3900 3500 50  0001 C CNN "PN"
	1    3900 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	3600 3500 3700 3500
$Comp
L Transistor_FET:BSS123 Q?
U 1 1 602BB074
P 3300 4650
AR Path="/602BB074" Ref="Q?"  Part="1" 
AR Path="/6027BF0D/602BB074" Ref="Q1"  Part="1" 
F 0 "Q1" H 3504 4696 50  0000 L CNN
F 1 "BSS123" H 3504 4605 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23" H 3500 4575 50  0001 L CIN
F 3 "http://www.diodes.com/assets/Datasheets/ds30366.pdf" H 3300 4650 50  0001 L CNN
	1    3300 4650
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR?
U 1 1 602BB07A
P 3400 5200
AR Path="/602BB07A" Ref="#PWR?"  Part="1" 
AR Path="/6027BF0D/602BB07A" Ref="#PWR018"  Part="1" 
F 0 "#PWR018" H 3400 5000 50  0001 C CNN
F 1 "GNDPWR" H 3404 5046 50  0000 C CNN
F 2 "" H 3400 5150 50  0001 C CNN
F 3 "" H 3400 5150 50  0001 C CNN
	1    3400 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 4450 3400 4350
Connection ~ 3400 4350
Wire Wire Line
	3400 5200 3400 5100
Wire Wire Line
	3100 4650 2850 4650
Text HLabel 4400 3500 2    50   Output ~ 0
VESC_PRECHARGE_OUT
Text HLabel 7900 2550 2    50   Output ~ 0
DCDC_OUT
Wire Wire Line
	7900 2550 7800 2550
Text Label 7200 3500 0    50   ~ 0
DCDC_OUT
Text Label 7800 2550 2    50   ~ 0
DCDC_OUT
Text HLabel 2300 4650 0    50   Input ~ 0
VESC_PRECHARGE_GATE
Text HLabel 4650 2300 0    50   Input ~ 0
DCDC_PRECHARGE_GATE
Text HLabel 6000 4550 0    50   Input ~ 0
DCDC_POWER_GATE
Wire Wire Line
	4050 3500 4100 3500
Text Notes 1400 1100 0    50   ~ 0
R3/R4 is to ensure Vgs does not go below -20V\nTransistor can handle 80V.\n15k / 56k divider gives min Vg of 63V.\nSwitch is on when base is low. Then 1 extra mA will leak to ground. OK.\n
Text Notes 7700 4050 0    50   ~ 0
72->12V DC/DC converter has output current of 20A.\nWorst case input voltage is 55V. \nWould mean 4.36A in @ 100% efficiency, 4.6A in @ 95% efficiency.\nUse SQJ479EP-T1_GE3.\nVgs max +-20V. \n15k/56k voltage divider gives min 60V @ gate=Vgs -16V @ 76V +BATT. \nAnd a power dissipation of 0.1W\n\n30 mOhm * 5A * 5A = 0.75W MOSFET dissipation. 68 C/W => 51 C temp rise. \nOn Resistance will rise 30%, temp rise up 30% = 66 C. Hot!\nThis is at 5A. Normal load will be 45 mA, neglible temp rise.\n
Text Notes 1450 2000 0    50   ~ 0
DC/DC Precharge:\nDC/DC to 12V works from 40V?\nAt 55V battery 15V over precharge R\nI = 100 mA when DC/DC is running through precharge\nP = 4W. Not be sufficient for RasPi to boot.\nRaspi can then signal precharge for DC/DC to turn off after some delay (1 second?)\nMax current through R will be 76 / 150 = 506 mA => P = 38W\n
$Comp
L Device:R R?
U 1 1 602FA026
P 2850 4900
AR Path="/602FA026" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602FA026" Ref="R11"  Part="1" 
F 0 "R11" H 2780 4854 50  0000 R CNN
F 1 "100k" H 2780 4945 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2780 4900 50  0001 C CNN
F 3 "~" H 2850 4900 50  0001 C CNN
	1    2850 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2850 4750 2850 4650
Connection ~ 2850 4650
Wire Wire Line
	2850 5050 2850 5100
Wire Wire Line
	2850 5100 3400 5100
Connection ~ 3400 5100
Wire Wire Line
	3400 5100 3400 4850
$Comp
L Device:R R?
U 1 1 602FF3D9
P 5300 2550
AR Path="/602FF3D9" Ref="R?"  Part="1" 
AR Path="/6027BF0D/602FF3D9" Ref="R15"  Part="1" 
F 0 "R15" H 5230 2504 50  0000 R CNN
F 1 "10k" H 5230 2595 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 5230 2550 50  0001 C CNN
F 3 "~" H 5300 2550 50  0001 C CNN
	1    5300 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2400 5300 2300
Connection ~ 5300 2300
Wire Wire Line
	5300 2300 5200 2300
Wire Wire Line
	5300 2700 5300 2800
Wire Wire Line
	5300 2800 5650 2800
Connection ~ 5650 2800
Wire Wire Line
	5650 2800 5650 2500
Wire Wire Line
	6350 1150 6550 1150
$Comp
L Connector:TestPoint TP?
U 1 1 60169DDE
P 6950 3850
AR Path="/60169DDE" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/60169DDE" Ref="TP13"  Part="1" 
F 0 "TP13" V 6904 4038 50  0000 L CNN
F 1 "TestPoint" V 6995 4038 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 7150 3850 50  0001 C CNN
F 3 "~" H 7150 3850 50  0001 C CNN
	1    6950 3850
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 6016A5C5
P 7000 4300
AR Path="/6016A5C5" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/6016A5C5" Ref="TP14"  Part="1" 
F 0 "TP14" V 6954 4488 50  0000 L CNN
F 1 "TestPoint" V 7045 4488 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 7200 4300 50  0001 C CNN
F 3 "~" H 7200 4300 50  0001 C CNN
	1    7000 4300
	0    1    1    0   
$EndComp
Wire Wire Line
	7000 4300 6900 4300
Connection ~ 6900 4300
Wire Wire Line
	6900 4300 6900 4350
Wire Wire Line
	6950 3850 6900 3850
Connection ~ 6900 3850
Wire Wire Line
	6900 3850 6900 3900
$Comp
L Device:R R?
U 1 1 60178D11
P 2550 4650
AR Path="/60178D11" Ref="R?"  Part="1" 
AR Path="/6027BF0D/60178D11" Ref="R22"  Part="1" 
F 0 "R22" H 2480 4604 50  0000 R CNN
F 1 "1k" H 2480 4695 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2480 4650 50  0001 C CNN
F 3 "~" H 2550 4650 50  0001 C CNN
	1    2550 4650
	0    1    1    0   
$EndComp
Wire Wire Line
	2700 4650 2800 4650
Wire Wire Line
	2300 4650 2400 4650
$Comp
L Device:R R?
U 1 1 6017ED10
P 6250 4550
AR Path="/6017ED10" Ref="R?"  Part="1" 
AR Path="/6027BF0D/6017ED10" Ref="R24"  Part="1" 
F 0 "R24" H 6180 4504 50  0000 R CNN
F 1 "1k" H 6180 4595 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6180 4550 50  0001 C CNN
F 3 "~" H 6250 4550 50  0001 C CNN
	1    6250 4550
	0    1    1    0   
$EndComp
Wire Wire Line
	6100 4550 6000 4550
$Comp
L Device:R R?
U 1 1 60180E32
P 5000 2300
AR Path="/60180E32" Ref="R?"  Part="1" 
AR Path="/6027BF0D/60180E32" Ref="R23"  Part="1" 
F 0 "R23" H 4930 2254 50  0000 R CNN
F 1 "1k" H 4930 2345 50  0000 R CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4930 2300 50  0001 C CNN
F 3 "~" H 5000 2300 50  0001 C CNN
	1    5000 2300
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 2300 4650 2300
$Comp
L Connector:TestPoint TP?
U 1 1 60182F91
P 5200 2200
AR Path="/60182F91" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/60182F91" Ref="TP11"  Part="1" 
F 0 "TP11" V 5154 2388 50  0000 L CNN
F 1 "TestPoint" V 5245 2388 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 5400 2200 50  0001 C CNN
F 3 "~" H 5400 2200 50  0001 C CNN
	1    5200 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 2200 5200 2300
Connection ~ 5200 2300
Wire Wire Line
	5200 2300 5150 2300
$Comp
L Connector:TestPoint TP?
U 1 1 60187316
P 6500 4500
AR Path="/60187316" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/60187316" Ref="TP12"  Part="1" 
F 0 "TP12" V 6454 4688 50  0000 L CNN
F 1 "TestPoint" V 6545 4688 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 6700 4500 50  0001 C CNN
F 3 "~" H 6700 4500 50  0001 C CNN
	1    6500 4500
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP?
U 1 1 60187E77
P 2800 4600
AR Path="/60187E77" Ref="TP?"  Part="1" 
AR Path="/6027BF0D/60187E77" Ref="TP10"  Part="1" 
F 0 "TP10" V 2754 4788 50  0000 L CNN
F 1 "TestPoint" V 2845 4788 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3000 4600 50  0001 C CNN
F 3 "~" H 3000 4600 50  0001 C CNN
	1    2800 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 4600 2800 4650
Connection ~ 2800 4650
Wire Wire Line
	2800 4650 2850 4650
Wire Wire Line
	6500 4500 6500 4550
Connection ~ 6500 4550
Wire Wire Line
	6500 4550 6550 4550
$Comp
L Device:R R?
U 1 1 601AD0CD
P 3900 3200
AR Path="/601AD0CD" Ref="R?"  Part="1" 
AR Path="/6027BF0D/601AD0CD" Ref="R26"  Part="1" 
F 0 "R26" H 3830 3154 50  0000 R CNN
F 1 "150 Ohm, 45W" H 3830 3245 50  0000 R CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 3830 3200 50  0001 C CNN
F 3 "~" H 3900 3200 50  0001 C CNN
F 4 "SQMW7150RJ" H 3900 3200 50  0001 C CNN "PN"
	1    3900 3200
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 601AD71A
P 3900 2900
AR Path="/601AD71A" Ref="R?"  Part="1" 
AR Path="/6027BF0D/601AD71A" Ref="R25"  Part="1" 
F 0 "R25" H 3830 2854 50  0000 R CNN
F 1 "150 Ohm, 45W" H 3830 2945 50  0000 R CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 3830 2900 50  0001 C CNN
F 3 "~" H 3900 2900 50  0001 C CNN
F 4 "SQMW7150RJ" H 3900 2900 50  0001 C CNN "PN"
	1    3900 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	3750 3200 3700 3200
Wire Wire Line
	3700 3200 3700 3500
Connection ~ 3700 3500
Wire Wire Line
	3700 3500 3750 3500
Wire Wire Line
	3750 2900 3700 2900
Wire Wire Line
	3700 2900 3700 3200
Connection ~ 3700 3200
Wire Wire Line
	4050 3200 4100 3200
Wire Wire Line
	4100 3200 4100 3500
Connection ~ 4100 3500
Wire Wire Line
	4100 3500 4400 3500
Wire Wire Line
	4050 2900 4100 2900
Wire Wire Line
	4100 2900 4100 3200
Connection ~ 4100 3200
$Comp
L Device:R R?
U 1 1 601B67EA
P 6200 850
AR Path="/601B67EA" Ref="R?"  Part="1" 
AR Path="/6027BF0D/601B67EA" Ref="R28"  Part="1" 
F 0 "R28" V 6050 900 50  0000 C CNN
F 1 "150 Ohm, 45W" V 6130 895 50  0000 C CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 6130 850 50  0001 C CNN
F 3 "~" H 6200 850 50  0001 C CNN
F 4 "SQMW7150RJ" H 6200 850 50  0001 C CNN "PN"
	1    6200 850 
	0    1    1    0   
$EndComp
Wire Wire Line
	6050 850  5950 850 
Wire Wire Line
	5950 850  5950 1150
Connection ~ 5950 1150
Wire Wire Line
	5950 1150 6050 1150
$Comp
L Device:R R?
U 1 1 601BFA03
P 6200 600
AR Path="/601BFA03" Ref="R?"  Part="1" 
AR Path="/6027BF0D/601BFA03" Ref="R27"  Part="1" 
F 0 "R27" V 6050 650 50  0000 C CNN
F 1 "150 Ohm, 45W" V 6130 645 50  0000 C CNN
F 2 "Resistor_THT:R_Radial_Power_L13.0mm_W9.0mm_P5.00mm" V 6130 600 50  0001 C CNN
F 3 "~" H 6200 600 50  0001 C CNN
F 4 "SQMW7150RJ" H 6200 600 50  0001 C CNN "PN"
	1    6200 600 
	0    1    1    0   
$EndComp
Wire Wire Line
	6050 600  5950 600 
Wire Wire Line
	5950 600  5950 850 
Connection ~ 5950 850 
Wire Wire Line
	6350 850  6550 850 
Wire Wire Line
	6550 850  6550 1150
Connection ~ 6550 1150
Wire Wire Line
	6550 1150 6600 1150
Wire Wire Line
	6350 600  6550 600 
Wire Wire Line
	6550 600  6550 850 
Connection ~ 6550 850 
Text Label 5950 700  2    50   ~ 0
DCDC_PRE_PRECHARGE
Text Label 3700 3000 2    50   ~ 0
VESC_PRE_PRECHARGE
$EndSCHEMATC
