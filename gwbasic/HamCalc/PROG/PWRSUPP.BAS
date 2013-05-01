10 :REM'PWRSUPP - Design Program - 01 JUL 91 rev. 12 APR 2000
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN PROG$="pwrsupp"
40 COMMON EX$,PROG$,EO,OV         :REM'voltages for chaining to LM317 program
50 SCREEN 0,0,0:COLOR 7,0,1
60 KEY OFF:PI=3.1415929794311523!
70 COLOR 7,0,1
80 X$=STRING$(80,32)
90 UL$=STRING$(80,205)
100 U$="###,###.##"
110 U1$="###.##":U2$="##"
120 DIM RES(12)       :REM'standard resistors
130 :REM'
140 DATA 10,12,15,18,22,27,33,39,47,56,68,82
150 FOR Z=1 TO 12:READ RES(Z):NEXT Z
160 :REM'
170 :REM'.....start
180 CLS
190 COLOR 15,2
200 PRINT " POWER SUPPLY DESIGN";
210 PRINT TAB(57)"by George Murphy VE3ERP ";
220 COLOR 1,0:PRINT STRING$(80,223);
230 COLOR 7,0
240 GOSUB 2070      :REM'preface
250 COLOR 0,7:LOCATE 25,24
260 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN CLS:RUN EX$
290 IF Z$="1"THEN 310
300 GOTO 270
310 GOSUB 2720      :REM'screen dump
320 GOSUB 2540      :REM'ripple note
330 GOSUB 2720      :REM'screen dump
340 CLS:GOTO 390
350 :REM'
360 :REM'.....erase line
370 LOCATE 1:PRINT X$;:LOCATE 1:RETURN
380 :REM'
390 :REM'.....print diagram
400 LN=18               :REM'start line
410 CN=13               :REM'start column
420 GOSUB 1950          :REM'print diagram
430 :REM'
440 :REM'.....transformer
450 COLOR 1,7:LOCATE 1,1
460 INPUT " ENTER: Intended DC output voltage..............";EO
470 COLOR 7,0
480 IF EO=0 THEN 460
490 OV=EO               :REM'desired regulated voltage, if required
500 LOCATE 4:AC=117
510 PRINT" Transformer T1 primary..........";USING U$;AC;:PRINT" v.AC"
520 LOCATE 9
530 PRINT" Output voltage..................";USING U$;EO;:PRINT" v.DC";
540 PRINT "  (intended output =";OV;"v.DC)"
550 LOCATE 5:ES=(EO+1.399999976158142!)/1.409999966621399!
560 PRINT" Transformer T1 secondary........";USING U$;ES;:PRINT" v.AC"
570 LOCATE 8:NL=ES*1.409999966621399!
580 PRINT" No Load output..................";USING U$;NL;:PRINT" v.DC"
590 LOCATE 9
600 COLOR 0,7
610 PRINT" Full Load output................";USING U$;EO;:PRINT" v.DC"
620 COLOR 7,0
630 LOCATE 10:VR=100*(NL-EO)/EO
640 PRINT" Voltage regulation..............";USING U$;VR;:PRINT" %"
650 GOSUB 360
660 COLOR 1,7
670 PRINT " Do you want to re-do, using another transformer? (y/n)"
680 COLOR 7,0
690 Z$=INKEY$:IF Z$="n"OR Z$="N"THEN 790
700 IF Z$="y"OR Z$="Y"THEN 710 :ELSE 690
710 LOCATE 5:PRINT X$;:LOCATE 8:PRINT X$;:LOCATE 9:PRINT X$;:LOCATE 10:PRINT X$;
720 GOSUB 360
730 COLOR 1,7
740 INPUT " ENTER: secondary voltage.......................";ES
750 COLOR 7,0
760 IF ES=0 THEN 720
770 EO=1.409999966621399!*ES-1.399999976158142!:GOTO 520
780 :REM'
790 :REM'.....current
800 GOSUB 360
810 COLOR 1,7
820 INPUT " ENTER: Required output current (amps)..........";IO
830 COLOR 7,0
840 IF IO=0 THEN 800
850 VA=CINT(ES*IO)
860 LOCATE 6:PRINT" Transformer T1 minimum rating...";USING U$;VA;:PRINT " VA."
870 RV=CINT(ES*2*1.409999966621399!):D1=2*IO
880 LOCATE 7
890 PRINT" Rect.Diodes D1-D4 min.rating....";USING U$;RV;
900 PRINT " PRV";
910 LOCATE 7,50:PRINT USING U1$;D1;:PRINT" amp Full-Wave Bridge"
920 IT1=VA/117:IT2=VA/ES
930 LOCATE 4,50:PRINT USING U1$;IT1;:PRINT" amps"
940 LOCATE 5,50:PRINT USING U1$;IT2;:PRINT" amps"
950 LOCATE 11
960 PRINT" Output current..................";USING U$;IO;:PRINT" amps"
970 LOCATE 12:RO=EO/IO
980 PRINT" Load resistance & dissipation...";USING U$;RO;:PRINT" Ω"
990 PO=EO*IO
1000 LOCATE 12,46:PRINT USING U$;PO;:PRINT" watts"
1010 F1=(IO*EO/117)*1.2000000476837158!:IF F1<0.10000000149011612! THEN F1=0.10000000149011612!
1020 COLOR 0,7
1030 LOCATE 3:PRINT" 117 volt AC input";
1040 COLOR 7,0
1050 PRINT" fuse F1 ......";USING U$;F1;:PRINT " amps, or nearest smaller"
1060 :REM'
1070 :REM'.....filter capacitor
1080 GOSUB 360
1090 COLOR 1,7
1100 INPUT " ENTER: Maximum ripple % .......................";RP
1110 IF RP>100 OR RP=0 THEN COLOR 7,0:GOTO 1080
1120 COLOR 7,0
1130 T=1/120:ER=RP/100*EO*2.799999952316284!
1140 C=INT((IO*T/ER)*10^6)
1150 WV=CINT(1.399999976158142!*EO)
1160 LOCATE 13
1170 PRINT" Filter capacitor C1.............";USING U$;C;:PRINT" µF"
1180 LOCATE 13,50:PRINT USING U1$;WV;:PRINT" WVDC minimum"
1190 LOCATE 14
1200 PRINT" Ripple..........................";USING U$;RP;:PRINT" %"
1210 GOSUB 360
1220 COLOR 1,7
1230 PRINT " Do you want to re-do, using another capacitor? (y/n) "
1240 COLOR 7,0
1250 Z$=INKEY$:IF Z$="n"OR Z$="N"THEN 1340
1260 IF Z$="y"OR Z$="Y"THEN 1270 :ELSE 1250
1270 GOSUB 360:COLOR 1,7
1280 INPUT " ENTER: Standard capacitor µF ..................";C
1290 COLOR 7,0
1300 IF C=0 THEN 1270
1310 LOCATE 13:PRINT X$;:LOCATE 14:PRINT X$;
1320 ER=IO*T*10^6/C:RP=ER*100/EO/2.799999952316284!:GOTO 1150
1330 :REM'
1340 :REM'.....bleeder resistor
1350 RB=100*NL                   :REM'RB=resistance  NL=no-load voltage
1360 M=1      :REM'multiplier
1370 FOR Z=1 TO 12               :REM'RES(1) to RES(12) are standard resistors
1380 IF RB>RES(Z)*M THEN 1410
1390 IF Z=1 THEN Z=13:M=M/10     :REM'backup 1 step to allow z-1 in next line
1400 RB=RES(Z-1)*M:GOTO 1430
1410 NEXT Z
1420 M=M*10:GOTO 1370
1430 IB=NL/RB:PB=IB^2*RB:W=INT(5*PB+0.5!)
1440 IF W<1 THEN W=1
1450 LOCATE 15
1460 PRINT" Bleeder resistor R1 ............";USING U$;RB;:PRINT" Ω"
1470 LOCATE 15,21:PRINT "(";USING U2$;W;:PRINT " watt )"
1480 LOCATE 15,50:PRINT USING U1$;IB*1000;:PRINT " ma.(typical)"
1490 :REM'
1500 :REM'.....pilot light
1510 EPL=EO-2:IPL=0.009999999776482582!:RPL=EPL/IPL
1520 M=10^5       :REM'multiplier
1530 FOR Z=12 TO 1 STEP -1
1540 IF RPL<RES(Z)*M THEN 1560
1550 GOTO 1590
1560 NEXT Z
1570 M=M/10:GOTO 1530
1580 :REM'
1590 ID5=EPL/(RES(Z)*M)*1000
1600 LOCATE 16:PRINT" LED pilot light D5..............";USING U$;2;
1610 PRINT " volts @"
1620 LOCATE 16,50:PRINT USING U1$;ID5;:PRINT " ma.(typical)"
1630 LOCATE 17:PRINT" LED resistor R2.................";USING U$;RES(Z)*M;
1640 PRINT " Ω"
1650 :REM'
1660 :REM'.....finish
1670 LOCATE 1
1680 COLOR 15,2
1690 PRINT" UNREGULATED POWER SUPPLY";TAB(57);"by George Murphy VE3ERP ";
1700 COLOR 1,0:PRINT STRING$(80,223);
1710 COLOR 7,0
1720 GOSUB 2720
1730 LOCATE 25,1:PRINT X$;
1740 :REM'
1750 :REM'.....LM317 diagram
1760 COLOR 14,0
1770 NC=CN+36:LOCATE LN
1780 LOCATE ,NC:PRINT "                         "
1790 LOCATE ,NC:PRINT "  ┌─────┐                "
1800 LOCATE ,NC:PRINT "─┬┤LM317├─┬───┬─ + «┐    "
1810 LOCATE ,NC:PRINT " │└──┬──┘ R3  │     │    "
1820 LOCATE ,NC:PRINT " C2  └────┤  C3  REG. DC "
1830 LOCATE ,NC:PRINT " │        R4  │     │    "
1840 LOCATE ,NC:PRINT "─┴────────┴───┴─ - «┘    ";
1850 :REM'
1860 COLOR 14,6
1870 LOCATE 25,5
1880 PRINT " Do you want to run the LM317 voltage regulator ";
1890 PRINT "design program?   (y/n) ";
1900 COLOR 7,0
1910 Z$=INKEY$:IF Z$="n"THEN CLS:CHAIN PROG$
1920 IF Z$="y"THEN CLS:CHAIN"LM317"
1930 GOTO 1910
1940 :REM'
1950 :REM'.....diagram
1960 COLOR 0,7:LOCATE LN
1970 LOCATE ,CN:PRINT "   F1  S1  ┌──┐ ┌───┬───┐              "
1980 LOCATE ,CN:PRINT " ──≈≈──/ ──┤  ├─┘   D1  D2             "
1990 LOCATE ,CN:PRINT " AC  on/off│T1│   ┌─┤   ├──┬──┬──┬── + "
2000 LOCATE ,CN:PRINT " ──────────┤  ├─┐ │ D3  D4 │  │  R2    "
2010 LOCATE ,CN:PRINT "           └──┘ └─│─┴───┘  C1 R1 │  DC "
2020 LOCATE ,CN:PRINT "                  │        │  │  D5»   "
2030 LOCATE ,CN:PRINT "                  └────────┴──┴──┴── - ";
2040 COLOR 7,0
2050 RETURN
2060 :REM'
2070 :REM'.....preface
2080 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2090 TB=7    :REM'tab for text
2100 PRINT TAB(TB);
2110 PRINT "  When you enter the intended output voltage of your power supply"
2120 PRINT TAB(TB);
2130 PRINT "the computer will display the basic specifications of the power"
2140 PRINT TAB(TB);
2150 PRINT "transformer required."
2160 PRINT TAB(TB);
2170 PRINT "  More than likely the secondary winding will be some oddball"
2180 PRINT TAB(TB);
2190 PRINT "voltage. The program gives you the option of selecting a standard"
2200 PRINT TAB(TB);
2210 PRINT "transformer with a secondary voltage higher than that specified."
2220 PRINT TAB(TB);
2230 PRINT "The output of the power supply will be higher than intended but"
2240 PRINT TAB(TB);
2250 PRINT "can be regulated to the exact intended voltage if you wish, by"
2260 PRINT TAB(TB);
2270 PRINT "adding an LM317 voltage regulator as part of the program. This is"
2280 PRINT TAB(TB);
2290 PRINT "much simpler than re-winding a surplus transformer, as we had to"
2300 PRINT TAB(TB);
2310 PRINT "do in the Goode Olde Dayes....."
2320 PRINT TAB(TB);
2330 PRINT "  The size of the filter capacitor depends on the maximum tolerable"
2340 PRINT TAB(TB);
2350 PRINT "DC ripple, ranging from about 0.01% for critical audio applications"
2360 PRINT TAB(TB);
2370 PRINT "(e.g. VFOs, receivers) to 100% where DC smoothing is not required."
2380 PRINT TAB(TB);
2390 PRINT "Low ripple power supplies require large filter capacitors."
2400 PRINT TAB(TB);
2410 PRINT "  The computer will probably specify a filter capacitor with a non-"
2420 PRINT TAB(TB);
2430 PRINT "standard value. You have the option of changing this to a standard"
2440 PRINT TAB(TB);
2450 PRINT "value close to the computed value. Capacitors can be ganged in"
2460 PRINT TAB(TB);
2470 PRINT "parallel to obtain capacitances greater than the highest value"
2480 PRINT TAB(TB);
2490 PRINT "available in a single standard capacitor (e.g if 10,500 pF is"
2500 PRINT TAB(TB);
2510 PRINT "needed, five 2200 pF capacitors can be ganged to make 11,000 pF)."
2520 RETURN
2530 :REM'
2540 :REM'.....ripple notes
2550 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2560 PRINT TAB(TB)"Typical recommended ripple levels:"
2570 PRINT TAB(TB)"══════════════════════════════════"
2580 PRINT
2590 PRINT TAB(TB)"CW transmitter multipliers & amplifiers........ 5% max."
2600 PRINT
2610 PRINT TAB(TB)"Linear amplifier plate voltage................. 3% max."
2620 PRINT
2630 PRINT TAB(TB)"Linear amplifier bias supply................... 1% max."
2640 PRINT
2650 PRINT TAB(TB)"VFOs, speech amplifiers and receivers.......... 0.01% - 0.1%"
2660 PRINT
2670 PRINT TAB(TB)"Non-critical audio devices..................... 1% - 10%"
2680 PRINT
2690 PRINT TAB(TB)"Devices not requiring DC smoothing............. 10% - 100%"
2700 RETURN
2710 :REM'
2720 :REM'PRT
2730 KEY OFF:GOSUB 2800:LOCATE 25,5:COLOR 0,2
2740 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2750 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2760 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2760 :ELSE GOSUB 2800
2770 IF Z$="3"THEN RETURN
2780 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2790 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2730
2800 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
