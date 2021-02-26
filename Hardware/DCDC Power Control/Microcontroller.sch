EESchema Schematic File Version 4
LIBS:DCDC Power Control-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 2 3
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
L Regulator_Linear:AP2204R-3.3 U2
U 1 1 6024AC13
P 2650 1650
F 0 "U2" H 2650 1892 50  0000 C CNN
F 1 "NCP785AH33T1G" H 2650 1801 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-89-3" H 2650 1875 50  0001 C CNN
F 3 "" H 2650 1650 50  0001 C CNN
F 4 "" H 2650 1650 50  0001 C CNN "Fält4"
	1    2650 1650
	1    0    0    -1  
$EndComp
Text HLabel 1250 1650 0    50   Input ~ 0
VBATT
Wire Wire Line
	1250 1650 2000 1650
$Comp
L Device:C C2
U 1 1 6024B6AE
P 2000 1900
F 0 "C2" H 2115 1946 50  0000 L CNN
F 1 "1 uF / 80V " H 2115 1855 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric_Pad1.42x1.75mm_HandSolder" H 2038 1750 50  0001 C CNN
F 3 "" H 2000 1900 50  0001 C CNN
F 4 "CL31B105KCHSNNE" H 2000 1900 50  0001 C CNN "PN"
	1    2000 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 1750 2000 1650
Connection ~ 2000 1650
Wire Wire Line
	2000 1650 2350 1650
$Comp
L power:GNDPWR #PWR012
U 1 1 6024BE88
P 2450 2200
F 0 "#PWR012" H 2450 2000 50  0001 C CNN
F 1 "GNDPWR" H 2454 2046 50  0000 C CNN
F 2 "" H 2450 2150 50  0001 C CNN
F 3 "" H 2450 2150 50  0001 C CNN
	1    2450 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2000 2150 2450 2150
Wire Wire Line
	2650 2150 2650 2100
Wire Wire Line
	2000 2050 2000 2150
Wire Wire Line
	2450 2200 2450 2150
Connection ~ 2450 2150
Wire Wire Line
	2450 2150 2650 2150
$Comp
L power:+3.3V #PWR014
U 1 1 6024CB0A
P 3100 1550
F 0 "#PWR014" H 3100 1400 50  0001 C CNN
F 1 "+3.3V" H 3115 1723 50  0000 C CNN
F 2 "" H 3100 1550 50  0001 C CNN
F 3 "" H 3100 1550 50  0001 C CNN
	1    3100 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:C C3
U 1 1 6024CE2A
P 3100 1850
F 0 "C3" H 3215 1896 50  0000 L CNN
F 1 "22 uF/3.3V" H 3215 1805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3138 1700 50  0001 C CNN
F 3 "~" H 3100 1850 50  0001 C CNN
F 4 "CL21X226MRQNNNE" H 3100 1850 50  0001 C CNN "PN"
	1    3100 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 1650 3100 1650
Wire Wire Line
	3100 1650 3100 1700
Wire Wire Line
	3100 1650 3100 1600
Connection ~ 3100 1650
Wire Wire Line
	2650 2100 3100 2100
Wire Wire Line
	3100 2100 3100 2000
Connection ~ 2650 2100
Wire Wire Line
	2650 2100 2650 1950
$Comp
L MCU_Microchip_ATtiny:ATtiny414-SS U3
U 1 1 6024E203
P 5000 3450
F 0 "U3" H 5000 4331 50  0000 C CNN
F 1 "ATtiny414-SS" H 5000 4240 50  0000 C CNN
F 2 "Package_SO:SOIC-14_3.9x8.7mm_P1.27mm" H 5000 3450 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/40001912A.pdf" H 5000 3450 50  0001 C CNN
	1    5000 3450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR015
U 1 1 6024F759
P 5000 2450
F 0 "#PWR015" H 5000 2300 50  0001 C CNN
F 1 "+3.3V" H 5015 2623 50  0000 C CNN
F 2 "" H 5000 2450 50  0001 C CNN
F 3 "" H 5000 2450 50  0001 C CNN
	1    5000 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2750 5000 2450
$Comp
L power:GNDPWR #PWR016
U 1 1 6024FDF7
P 5000 4300
F 0 "#PWR016" H 5000 4100 50  0001 C CNN
F 1 "GNDPWR" H 5004 4146 50  0000 C CNN
F 2 "" H 5000 4250 50  0001 C CNN
F 3 "" H 5000 4250 50  0001 C CNN
	1    5000 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 4300 5000 4150
Wire Wire Line
	5600 3450 5800 3450
Text HLabel 5800 3550 2    50   Input ~ 0
ON
Text HLabel 5800 3450 2    50   Input ~ 0
VESC_PRECHARGE
Wire Wire Line
	5800 3550 5600 3550
Wire Wire Line
	5600 3250 5800 3250
Text HLabel 5800 3650 2    50   Output ~ 0
VESC_PRECHARGE_GATE
Wire Wire Line
	5600 3350 5800 3350
Text HLabel 5800 3350 2    50   Output ~ 0
DCDC_PRECHARGE_GATE
Text HLabel 1800 3050 0    50   Input ~ 0
SWITCH_A
Text HLabel 5800 3250 2    50   Input ~ 0
SWITCH_B
$Comp
L power:GNDPWR #PWR011
U 1 1 60252462
P 1900 3150
F 0 "#PWR011" H 1900 2950 50  0001 C CNN
F 1 "GNDPWR" H 1904 2996 50  0000 C CNN
F 2 "" H 1900 3100 50  0001 C CNN
F 3 "" H 1900 3100 50  0001 C CNN
	1    1900 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 3050 1900 3050
Wire Wire Line
	1900 3050 1900 3150
Wire Wire Line
	5800 3650 5600 3650
Text Notes 4350 1600 0    50   ~ 0
Power Consumption:\nMCU will always have power\nUses 1.6 mA when active with 3V\nUses 0.7 uA when in sleep mode\nLDO has typ 7.5 uA quiescent current.\nADC voltage divider will draw \nBattery draw when in sleep mode (woken \nby pin change interrupt) will be about \n10 uA * 76V = 760 uW. Acceptable
Text HLabel 4200 3050 0    50   Output ~ 0
DCDC_GATE
Wire Wire Line
	5600 3050 5800 3050
Text Label 5800 3050 0    50   ~ 0
UDPI
Text HLabel 1250 3750 0    50   Input ~ 0
VBATT
$Comp
L Device:R R7
U 1 1 602550FD
P 1500 4750
F 0 "R7" H 1570 4796 50  0000 L CNN
F 1 "10M" H 1570 4705 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1430 4750 50  0001 C CNN
F 3 "~" H 1500 4750 50  0001 C CNN
F 4 "2019-RK73H1JTTD1005FCT-ND" H 1500 4750 50  0001 C CNN "PN"
	1    1500 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R8
U 1 1 60255A19
P 1500 5150
F 0 "R8" H 1570 5196 50  0000 L CNN
F 1 "1.33M" H 1570 5105 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1430 5150 50  0001 C CNN
F 3 "~" H 1500 5150 50  0001 C CNN
F 4 "2019-RK73H1JTTD1334FCT-ND" H 1500 5150 50  0001 C CNN "PN"
	1    1500 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 5000 1500 4950
$Comp
L power:GNDPWR #PWR09
U 1 1 6025627A
P 1500 5400
F 0 "#PWR09" H 1500 5200 50  0001 C CNN
F 1 "GNDPWR" H 1504 5246 50  0000 C CNN
F 2 "" H 1500 5350 50  0001 C CNN
F 3 "" H 1500 5350 50  0001 C CNN
	1    1500 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 5400 1500 5350
Connection ~ 1500 4950
Wire Wire Line
	1500 4950 1500 4900
Text Label 2050 4950 0    50   ~ 0
VBATT_ADC
Text HLabel 2800 3700 0    50   Input ~ 0
V_DCDC
$Comp
L Device:R R9
U 1 1 602574AC
P 2900 3900
F 0 "R9" H 2970 3946 50  0000 L CNN
F 1 "300k" H 2970 3855 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2830 3900 50  0001 C CNN
F 3 "~" H 2900 3900 50  0001 C CNN
	1    2900 3900
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 60257DF7
P 2900 4300
F 0 "R10" H 2970 4346 50  0000 L CNN
F 1 "13.3k" H 2970 4255 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 2830 4300 50  0001 C CNN
F 3 "~" H 2900 4300 50  0001 C CNN
	1    2900 4300
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR013
U 1 1 60258439
P 2900 4550
F 0 "#PWR013" H 2900 4350 50  0001 C CNN
F 1 "GNDPWR" H 2904 4396 50  0000 C CNN
F 2 "" H 2900 4500 50  0001 C CNN
F 3 "" H 2900 4500 50  0001 C CNN
	1    2900 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 4150 2900 4100
Wire Wire Line
	2800 3700 2900 3700
Wire Wire Line
	2900 3700 2900 3750
Wire Wire Line
	2900 4100 3250 4100
Connection ~ 2900 4100
Wire Wire Line
	2900 4100 2900 4050
Text Label 3450 4100 0    50   ~ 0
DCDC_ADC
Text Label 4200 3150 2    50   ~ 0
VBATT_ADC
Text Label 5850 3750 0    50   ~ 0
DCDC_ADC
Wire Wire Line
	4200 3150 4400 3150
$Comp
L Device:C C1
U 1 1 6025B8DF
P 1950 5150
F 0 "C1" H 2065 5196 50  0000 L CNN
F 1 "100 nF/3.3V" H 2065 5105 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 1988 5000 50  0001 C CNN
F 3 "~" H 1950 5150 50  0001 C CNN
F 4 "CL21X226MRQNNNE" H 1950 5150 50  0001 C CNN "PN"
	1    1950 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:C C4
U 1 1 6025C3BE
P 3300 4300
F 0 "C4" H 3415 4346 50  0000 L CNN
F 1 "100 nF/3.3V" H 3415 4255 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric_Pad1.15x1.40mm_HandSolder" H 3338 4150 50  0001 C CNN
F 3 "~" H 3300 4300 50  0001 C CNN
F 4 "CL21X226MRQNNNE" H 3300 4300 50  0001 C CNN "PN"
	1    3300 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1950 4950 1950 5000
Wire Wire Line
	1500 4950 1900 4950
Wire Wire Line
	1950 5300 1950 5350
Wire Wire Line
	1950 5350 1500 5350
Connection ~ 1500 5350
Wire Wire Line
	1500 5350 1500 5300
Wire Wire Line
	1950 4950 2050 4950
Connection ~ 1950 4950
Text Notes 650  6900 0    50   ~ 0
100 nF for ADC input caps is from discussion here: \nhttps://www.avrfreaks.net/forum/adc-input-impedance\n10M resistors are much cheaper than larger ones.\nThis combo gives 2.4 uA current through divider.\nInput pin leakage is < 0.05 uA.\nTime constant is 3 seconds, so sampling should not be done more often than 10 seconds? But input voltag should not need sampling often.\nOutput voltage will vary between:\n76V -> 3.226 V\n55V -> 2.335 V.\n10 bit ADC = 1 bit is approx 3 mV.\n\nOut voltage sampling will need to be done more often, but leakage is not so important, since Raspberry pi will consume at last 3.5W = 46 mA @ 76V\nThese values give 243 uA. Which give a time constant of 30 ms.\n\n5 time constants give 99.3% of max. 15s for battery volage, 150 ms for DCDC voltage. OK.
Wire Wire Line
	3300 4150 3300 4100
Connection ~ 3300 4100
Wire Wire Line
	3300 4100 3450 4100
Wire Wire Line
	3300 4450 3300 4500
Wire Wire Line
	3300 4500 2900 4500
Wire Wire Line
	2900 4450 2900 4500
Connection ~ 2900 4500
Wire Wire Line
	2900 4500 2900 4550
$Comp
L Device:R R5
U 1 1 6026691E
P 1500 4000
F 0 "R5" H 1570 4046 50  0000 L CNN
F 1 "10M" H 1570 3955 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1430 4000 50  0001 C CNN
F 3 "~" H 1500 4000 50  0001 C CNN
F 4 "2019-RK73H1JTTD1005FCT-ND" H 1500 4000 50  0001 C CNN "PN"
	1    1500 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 60267123
P 1500 4350
F 0 "R6" H 1570 4396 50  0000 L CNN
F 1 "10M" H 1570 4305 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1430 4350 50  0001 C CNN
F 3 "~" H 1500 4350 50  0001 C CNN
F 4 "2019-RK73H1JTTD1005FCT-ND" H 1500 4350 50  0001 C CNN "PN"
	1    1500 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 3750 1500 3850
Wire Wire Line
	1250 3750 1500 3750
Wire Wire Line
	1500 4150 1500 4200
Wire Wire Line
	1500 4500 1500 4600
Text Notes 8300 3150 0    50   ~ 0
Algorithm:\nAt boot: Ensure\n* DC_DC gate is off\n* VESC_PRECHARGE_GATE is off\n* DCDC_precharge gate is off\n* set pull-up on switch pin\n* listen to pin change events on switch\n* if switch is not on, go to sleep\n\nWhen switch is pushed:\n* set DCDC_precharge to ON\n* sample in voltage.\nin loop: sample out voltage until output voltage is within 5V? of output.\n\n* set DC_DC gate on\n* set DC_DC precharge gate off\n* enable pin change interrupt on ON\n* enable pin change interrupt on VESC_PRECHARGE\n\ngo to sleep\n\nWhen ON goes low:\n* set DCDC_gate off\n* listen for pin change events on switch\n* go to sleep\n\nWhen VESC_PRECHARGE goes high\n* turn on VESC_PRECHARGE\ngo to sleep\n\nWhen VESC_PRECHARGE goes low\n* turn off VESC_PRECHARGE\n
Text Notes 5800 2350 0    50   ~ 0
TODO: UPDI connector
$Comp
L Connector:TestPoint TP9
U 1 1 6018D4B6
P 3400 1550
F 0 "TP9" H 3458 1668 50  0000 L CNN
F 1 "TestPoint" H 3458 1577 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3600 1550 50  0001 C CNN
F 3 "~" H 3600 1550 50  0001 C CNN
	1    3400 1550
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP8
U 1 1 6018E0D5
P 3250 3950
F 0 "TP8" H 3308 4068 50  0000 L CNN
F 1 "TestPoint" H 3308 3977 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 3450 3950 50  0001 C CNN
F 3 "~" H 3450 3950 50  0001 C CNN
	1    3250 3950
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP7
U 1 1 6018E9EB
P 1900 4800
F 0 "TP7" H 1958 4918 50  0000 L CNN
F 1 "TestPoint" H 1958 4827 50  0000 L CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 2100 4800 50  0001 C CNN
F 3 "~" H 2100 4800 50  0001 C CNN
	1    1900 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 4800 1900 4950
Connection ~ 1900 4950
Wire Wire Line
	1900 4950 1950 4950
Wire Wire Line
	3250 3950 3250 4100
Connection ~ 3250 4100
Wire Wire Line
	3250 4100 3300 4100
Text HLabel 8150 3650 2    50   Output ~ 0
DCDC_GATE
Text HLabel 8150 3950 2    50   Output ~ 0
VESC_PRECHARGE_GATE
Text HLabel 8150 4250 2    50   Output ~ 0
DCDC_PRECHARGE_GATE
$Comp
L Connector:TestPoint TP17
U 1 1 60192541
P 8050 3650
F 0 "TP17" V 8245 3722 50  0000 C CNN
F 1 "TestPoint" V 8154 3722 50  0000 C CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 8250 3650 50  0001 C CNN
F 3 "~" H 8250 3650 50  0001 C CNN
	1    8050 3650
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP18
U 1 1 60193CD7
P 8050 3950
F 0 "TP18" V 8245 4022 50  0000 C CNN
F 1 "TestPoint" V 8154 4022 50  0000 C CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 8250 3950 50  0001 C CNN
F 3 "~" H 8250 3950 50  0001 C CNN
	1    8050 3950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8150 3950 8050 3950
$Comp
L Connector:TestPoint TP19
U 1 1 60194FF2
P 8050 4250
F 0 "TP19" V 8245 4322 50  0000 C CNN
F 1 "TestPoint" V 8154 4322 50  0000 C CNN
F 2 "TestPoint:TestPoint_Loop_D2.50mm_Drill1.0mm_LowProfile" H 8250 4250 50  0001 C CNN
F 3 "~" H 8250 4250 50  0001 C CNN
	1    8050 4250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8050 4250 8150 4250
Wire Wire Line
	8050 3650 8150 3650
Wire Wire Line
	3100 1600 3400 1600
Wire Wire Line
	3400 1600 3400 1550
Connection ~ 3100 1600
Wire Wire Line
	3100 1600 3100 1550
$Comp
L power:GNDPWR #PWR0101
U 1 1 602BE7C7
P 1750 2750
F 0 "#PWR0101" H 1750 2550 50  0001 C CNN
F 1 "GNDPWR" H 1754 2596 50  0000 C CNN
F 2 "" H 1750 2700 50  0001 C CNN
F 3 "" H 1750 2700 50  0001 C CNN
	1    1750 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 2700 1750 2700
Wire Wire Line
	1750 2700 1750 2750
Wire Wire Line
	1600 2600 1900 2600
Text Label 1900 2600 0    50   ~ 0
UDPI
$Comp
L Device:C C5
U 1 1 602C2A34
P 4150 2350
F 0 "C5" H 4265 2396 50  0000 L CNN
F 1 "100 nF/3.3V" H 4265 2305 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 4188 2200 50  0001 C CNN
F 3 "~" H 4150 2350 50  0001 C CNN
F 4 "CL21X226MRQNNNE" H 4150 2350 50  0001 C CNN "PN"
	1    4150 2350
	1    0    0    -1  
$EndComp
$Comp
L power:GNDPWR #PWR0102
U 1 1 602C306A
P 4150 2600
F 0 "#PWR0102" H 4150 2400 50  0001 C CNN
F 1 "GNDPWR" H 4154 2446 50  0000 C CNN
F 2 "" H 4150 2550 50  0001 C CNN
F 3 "" H 4150 2550 50  0001 C CNN
	1    4150 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 2600 4150 2500
$Comp
L power:+3.3V #PWR0103
U 1 1 602C5FDB
P 4150 2050
F 0 "#PWR0103" H 4150 1900 50  0001 C CNN
F 1 "+3.3V" H 4165 2223 50  0000 C CNN
F 2 "" H 4150 2050 50  0001 C CNN
F 3 "" H 4150 2050 50  0001 C CNN
	1    4150 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 2050 4150 2200
$Comp
L Connector:Conn_01x03_Female J6
U 1 1 602C7DFB
P 1400 2600
F 0 "J6" H 1292 2275 50  0000 C CNN
F 1 "Conn_01x03_Female" H 1292 2366 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x03_P2.54mm_Vertical" H 1400 2600 50  0001 C CNN
F 3 "~" H 1400 2600 50  0001 C CNN
	1    1400 2600
	-1   0    0    1   
$EndComp
$Comp
L power:+3.3V #PWR0104
U 1 1 602CDFD0
P 1950 2400
F 0 "#PWR0104" H 1950 2250 50  0001 C CNN
F 1 "+3.3V" H 1965 2573 50  0000 C CNN
F 2 "" H 1950 2400 50  0001 C CNN
F 3 "" H 1950 2400 50  0001 C CNN
	1    1950 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 2500 1950 2500
Wire Wire Line
	1950 2500 1950 2400
Wire Wire Line
	5600 3750 5850 3750
Wire Wire Line
	4400 3050 4200 3050
$EndSCHEMATC
