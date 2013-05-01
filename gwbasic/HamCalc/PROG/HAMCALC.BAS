10 :REM'\hamcalc\prog\COAXCHAR - Coaxial Cable - 02 MAY 94 rev. 05 SEP 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="coaxchar"
60 COMMON EX$,PROG$
70 ON ERROR  GOTO 100
80 GOTO 170
90 :REM'
100 IF ERR=70 OR ERR=75 OR ERR=76 AND ERL=1520 THEN 120
110 BEEP:PRINT "Error";ERR;"in line";ERL:END
120 CLS:BEEP:PRINT " Error";ERR;" Path or File Access Error."
130 PRINT " You may be trying to write to a Read Only disc."
140 PRINT " Press F2 to start over, or F10 to EXIT."
150 END
160 :REM'
170 LF=1/LOG(10)    :REM'log factor to convert to base 10
180 PI=3.1415929794311523!
190 DIM C$(51,9)    :REM'coax data
200 UL$=STRING$(80,205)
210 U$="###.##"
220 V$="####.###"
230 W$="####.##"
240 :REM'
250 :REM'.....start
260 CLS:COLOR 7,0,1
270 B=0:C=0:E=0:I=0:O=0:U=0:V=0:ZO=0
280 GOSUB 1510      :REM'read data
290 COLOR 15,2
300 PRINT " COAXIAL CABLE CHARACTERISTICS";TAB(57);"by George Murphy VE3ERP ";
310 COLOR 1,0:PRINT STRING$(80,223);
320 COLOR 7,0
330 LOCATE 3,35:COLOR 0,7:PRINT " CONTENTS ":COLOR 7,0
340 PRINT "       - Coaxial Cable Equations"
350 PRINT "       - Coaxial Cable Primer"
360 PRINT "       - Coaxial cable physical dimensions"
370 PRINT "       - Characteristics of commonly used coaxial cables"
380 PRINT "       - Attenuation in dB of commonly used coaxial cables"
390 PRINT "       - Characteristics of an unidentified coaxial cable"
400 PRINT "       - Find dielectric constant from published coaxial cable ";
410 PRINT "data"
420 PRINT "       - Transmission line length - physical vs. electrical"
430 PRINT "       - Transmission line stubs (coaxial cable)"
440 PRINT "       - Transmission line - square coaxial"
450 PRINT UL$;
460 PRINT " This program uses equations listed in Table 2, page 24-18 of the";
470 PRINT " ARRL Antenna "
480 PRINT " Book, 18th edition, to calculate characteristics of transmission";
490 PRINT " lines listed "
500 PRINT " on page 19.2 of the ARRL 2000 Handbook for Radio Amateurs."
510 PRINT UL$;
520 COLOR 0,7
530 PRINT " Press number in <   > to choose standard units of measure:"
540 COLOR 7,0
550 PRINT "                 < 1 >  Metric"
560 PRINT "                 < 2 >  U.S.A./Imperial"
570 COLOR 0,7:LOCATE ,10:PRINT " or Press 0 to EXIT ":COLOR 7,0
580 LOCATE 25,10
590 PRINT "This program is based on a concept by Göran Hosinsky, EA8YU";
600 Z$=INKEY$:IF Z$=""THEN 600
610 IF Z$="0"THEN CLS:CHAIN GO$
620 IF Z$="1"THEN UM=0.30480000376701355!:UM$="m.":GOTO 650
630 IF Z$="2"THEN UM=1:UM$="ft":GOTO 650
640 GOTO 600
650 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 3
660 COLOR 0,7:PRINT " Press letter in < > for:";:COLOR 7,0:PRINT STRING$(40,32)
670 FOR Z=1 TO 10:LOCATE Z+3,3:PRINT "<";CHR$(96+Z);"> ":NEXT Z
680 PRINT UL$;:GOSUB 5610   :REM'preface
690 Z$=INKEY$
700 IF Z$="a"THEN 5810
710 IF Z$="b"THEN CLS:CHAIN"coaxspec"
720 IF Z$="c"THEN 4780
730 IF Z$="d"THEN 1700
740 IF Z$="e"THEN 2480
750 IF Z$="f"THEN 3010
760 IF Z$="g"THEN 3960
770 IF Z$="h"THEN 4380
780 IF Z$="i"THEN CLS:CHAIN"coaxstub"
790 IF Z$="j"THEN CLS:CHAIN"sqcoax"
800 GOTO 690
810 :REM'
820 :REM'.....data
830 :REM'                          dielectric                        centre
840 :REM'  type    no.  dielectric  constant  OD      Z(Ω)    volts  conductor
850 :REM'------    ---  ----------  -------- ----     ----    -----  ------inches
860 DATA RG-6/8215,    PE,       2.355,  .275,    75.0,   2700,  21s,  .0285,M1
870 :REM'
880 DATA RG-8/9913,    ASPE,     1.507,  .405,    50.0,    600,  10s,  .1019,M1
890 DATA RG-8/102,     ASPE,     1.434,  .405,    50.0,    600,  9.5s, .1080,M3
900 DATA RG-8/DRF-BF*, FPE,      1.494,  .405,    50.0,    600,  9.5s, .1080,M4
910 DATA RG-8/WM CQ*,  FPE,      1.494,  .405,    50.0,    600,  9.5s, .1080,M3
920 DATA RG-8/9914,    TFE,      1.531,  .405,    50.0,   3700,  10s,  .1019,M1
930 DATA RG-8/8237,    PE,       2.344,  .405,    52.0,   3700,  13f,  .0820,M1
940 :REM'
950 DATA RG-8X/118*,   FPE,      1.556,  .242,    50.0,    300,  16f,  .0576,M3
960 DATA RG-8X/9258,   TFE,      1.594,  .242,    50.0,    300,  16f,  .0576,M1
970 :REM'
980 DATA RG-9/8242,    PE,       2.332,  .420,    51.0,   3700,  13f,  .0820,M1
990 :REM'
1000 DATA RG-11/8213*,  FPE,      1.677,  .405,    75.0,    600,  14s,  .0641,M1
1010 DATA RG-11/8238,   PE,       2.355,  .405,    75.0,    600,  18f,  .0456,M1
1020 :REM'
1030 DATA RG-58/124,    PE,       2.316,  .195,    53.5,   1400,  20s,  .0320,M3
1040 DATA RG-58/8240,   PE,       2.316,  .193,    53.5,   1400,  20s,  .0320,M1
1050 DATA RG-58A/8219*, FPE,      1.750,  .198,    50.0,    300,  20f,  .0363,M1
1060 DATA RG-58A/8259,  PE,       2.362,  .193,    50.0,   1400,  20f,  .0363,M1
1070 DATA RG-58C/8262,  PE,       2.362,  .195,    50.0,   1400,  20f,  .0363,M1
1080 :REM'
1090 DATA RG-59/8212,   TFE,      1.677,  .242,    75.0,    300,  20s,  .0320,M1
1100 DATA RG-59B/8263,  PE,       2.355,  .242,    75.0,   1700,  23s,  .0226,M1
1110 :REM'
1120 DATA RG-62A/9269,  ASPE,     1.570,  .260,    93.0,    750,  22s,  .0253,M1
1130 DATA RG-62B/8255,  ASPE,     1.570,  .260,    93.0,    750,  24s,  .0201,M1
1140 DATA RG-62B/9857,  ASPE,     1.464,  .405,   125.0,    750,  22s,  .0253,M1
1150 :REM'
1160 DATA RG-142B/83242,TFE,      2.123,  .195,    50.0,   1400,  18s,  .0403,M1
1170 DATA RG-174/8216,  PE,       2.362,  .101,    50.0,   1100,  26s,  .0159,M1
1180 DATA RG-213/8267,  PE,       2.362,  .405,    50.0,   3700,  13f,  .0820,M1
1190 DATA RG-214/8268,  PE,       2.362,  .425,    50.0,   3700,  13f,  .0820,M1
1200 DATA RG-216/9850,  PE,       2.355,  .425,    75.0,   3700,  18f,  .0456,M1
1210 :REM'
1220 DATA RG-217/217,   PE,       2.362,  .545,    50.0,   7000,  9.5s, .1080,M5
1230 DATA RG-218/218,   PE,       2.167,  .870,    50.0,  11000,  4.5s, .1928,M6
1240 DATA RG-223/9273,  PE,       2.362,  .212,    50.0,   1700,  19s,  .0359,M1
1250 DATA RG-303/84303, TFE,      2.123,  .170,    50.0,   1400,  18s,  .0403,M1
1260 DATA RG-316/84316, TFE,      2.094,  .098,    50.0,    900,  26s,  .0159,M1
1270 :REM'
1280 DATA RG-393/393,   TFE,      2.152,  .390,    50.0,   5000,  12s,  .0808,M7
1290 DATA RG-400/400,   TFE,      2.152,  .195,    50.0,   1900,  20s,  .0320,M8
1300 DATA LMR200*,      FPE,      1.494,  .195,    50.0,    300,  17s,  .0453,M2
1310 DATA LMR240*,      FPE,      1.458,  .242,    50.0,    300,  15s,  .0571,M2
1320 DATA LMR400*,      FPE,      1.422,  .405,    50.0,    600,  10s,  .1019,M2
1330 DATA LMR500*,      FPE,      1.422,  .500,    50.0,   2500,  7s,   .1443,M2
1340 DATA LMR600*,      FPE,      1.363,  .590,    50.0,   4000,  5.5s, .1717,M2
1350 DATA LMR1200*,     FPE,      1.330, 1.200,    50.0,   4500,  1/0s, .3249,M2
1360 :REM'
1370 DATA Alum 1/2in*, FPE,       1.556,  .500,    50.0,   2500,  5.5s, .1717,M9
1380 DATA Alum 1/2in*, FPE,       1.562,  .500,    75.0,   2500,  11.5, .0856,M9
1390 DATA Alum 7/8in*, FPE,       1.556,  .875,    50.0,   4000,  1s,   .2893,M9
1400 DATA Alum 7/8in*, FPE,       1.562,  .875,    75.0,   4000,  5.5s, .1717,M9
1410 :REM'
1420 DATA LDF4-50A*,   FPE,       1.670,  .630,    50.0,   1400,  5s,  .1819,M0
1430 DATA LDF5-50A*,   FPE,       1.670, 1.090,    50.0,   2100,  ---, .3550,M0
1440 DATA LDF6-50A*,   FPE,       1.670, 1.550,    50.0,   3200,  ---, .5160,M0
1450 :REM'
1460 DATA TV receiving,   300, 80, 5.8, 20s, .0320,  ---
1470 DATA Xmit.Tubular,   300, 80, 5.8, 20s, .0320,  8000
1480 DATA Window line,    450, 91, 4.0, 18s, .0403, 10000
1490 DATA Openwire line,  600, 92, 1.1, 12s, .0808, 1200
1500 :REM'
1510 :REM'.....read data
1520 OPEN"O",1,"\hamcalc\coaxfile\coaxial.fil"
1530 N=47    :REM'no.of coaxial cable data groups above
1540  FOR Z=1 TO N
1550    FOR Y=1 TO 9
1560   READ C$(Z,Y)
1570    NEXT Y
1580   WRITE#1,C$(Z,1);C$(Z,2);C$(Z,3);C$(Z,4);C$(Z,5);C$(Z,6);C$(Z,7);C$(Z,8)
1590   WRITE#1,C$(Z,9)
1600  NEXT Z
1610 FOR Z=N+1 TO N+4
1620    FOR Y=1 TO 7
1630   READ C$(Z,Y)
1640    NEXT Y
1650   WRITE#1,C$(Z,1);C$(Z,2);C$(Z,3);C$(Z,4);C$(Z,5);C$(Z,6);C$(Z,7)
1660  NEXT Z
1670 CLOSE
1680 RETURN
1690 :REM'
1700 :REM'.....display table
1710 COLOR 7,0,0:CLS:PRINT STRING$(79,205)
1720 T$=" COAXIAL CABLE CHARACTERISTICS (HAMCALC) "
1730 COLOR 0,7:LOCATE CSRLIN-1,19:PRINT T$:COLOR 7,0
1740 T1=34:T2=65
1750 PRINT "  * = foam dielectric"TAB(T1)"s = solid conductor";
1760 PRINT TAB(T2)"M5 = M17/79-RG"
1770 PRINT " Zo = characteristic impedance";
1780 PRINT TAB(T1)"f = flex.(stranded) conductor"TAB(T2)"M6 = M17/78-RG"
1790 PRINT " VF = velocity factor"TAB(T1)"M1 = Belden"TAB(T2)"M7 = M17/127-RG"
1800 PRINT "  Σ = dielectric factor"TAB(T1)"M2 = TMS"TAB(T2)"M8 = M17/128-RG"
1810 PRINT "  ß = D/d factor"TAB(T1)"M3 = WM CQ"TAB(T2)"M9 = CATV"
1820 PRINT " TM = Trademark/Brand"TAB(T1)"M4 = DRF-BF"TAB(T2)"M0 = Heliax"
1830 PRINT " ═════════════╤═════╤════╤═════╤════╤═════";
1840 PRINT "╤═════╤═════╤══════════╤═════╤════╤═══";
1850 M$=UM$:D$="in.":IF UM$="m."THEN M$="m.":D$="mm."
1860 PRINT "              │ Zo  │ VF │ pF  │ µH │ O.D.│ nom.│ nom.│  Centre  ";
1870 PRINT "│ Max.│Diel│"
1880 PRINT " Type/Cat.#   │ohms │ %  │ /";M$;" │/";M$;" │ ";D$;" │  Σ  │ ";
1890 PRINT " ß  │  Wire    │ RMS │Matl│TM";
1900 PRINT " ═════════════╪═════╪════╪═════╪════╪═════";
1910 PRINT "╪═════╪═════╪══════════╪═════╪════╪═══"
1920 LOCATE CSRLIN-2,56:PRINT " "+D$+"/ AWG "
1930 LN=11
1940 :REM'
1950 FOR Y=1 TO N
1960 LN=LN+1
1970  PRINT TAB(2);C$(Y,1);               :REM'cable type
1980   E=VAL(C$(Y,3))                     :REM'dielectric constant
1990   Z=VAL(C$(Y,5))                     :REM'impedance
2000   D=10^(Z*SQR(E)/138)                :REM'D/d factor
2010   V=1/SQR(E)                         :REM'velocity factor
2020   C=(7.260000228881836!*E/(LOG(D)*LF))             :REM'capacitance
2030   U=0.14000000059604645!*LOG(D)*LF                    :REM'inductance
2040   OD=VAL(C$(Y,4))                    :REM'O.D. of jacket
2050 PRINT TAB(15)USING "│###.#│##.#│###.#│.###│";Z,V*100,C/UM,U/UM;
2060 IF UM=1 THEN Q$="#.###│":ELSE OD=OD*25.399999618530273!:Q$="###.#│"
2070  PRINT USING Q$;OD;
2080 DD=VAL(C$(Y,8))
2090 IF D>=10 THEN Q$="#.###│##.##│":ELSE Q$="#.###│#.###│"
2100 PRINT USING Q$;E,D;
2110 IF UM=1 THEN Q$=".#### ":ELSE DD=DD*25.399999618530273!:Q$="##.## "
2120 PRINT USING Q$;DD;
2130 PRINT C$(Y,7);
2140 RMS=VAL(C$(Y,6))
2150  PRINT TAB(66)USING "│#####│";RMS;
2160  PRINT C$(Y,2);              :REM'dielectric material
2170 PRINT TAB(77)"│";C$(Y,9);
2180  IF LN<24 THEN PRINT "":GOTO 2200
2190  GOSUB 6260:CLS:LN=0:GOTO 2200
2200 NEXT Y
2210 T$="###.#│##.#│###.#│"+STRING$(7,32)+"Twinlead"+STRING$(7,32)+"│#.### "
2220  FOR X=N+1 TO N+4
2230 PRINT " ";C$(X,1)TAB(15)"│";
2240 IF UM=1 THEN M=1 :ELSE M=25.399999618530273!
2250 PRINT USING T$;VAL(C$(X,2)),VAL(C$(X,3)),VAL(C$(X,4))/UM,VAL(C$(X,6))*M;
2260 PRINT C$(X,5);TAB(66)"│";
2270 IF VAL(C$(X,7))=0 THEN PRINT " --- │":GOTO 2290
2280 PRINT USING "#####│";VAL(C$(X,7))
2290  NEXT X
2300 PRINT UL$;
2310 PRINT " ASPE = Air Spaced Polyethylene"
2320 PRINT " PE =   Polyethylene,        temp.range  -65° to  +80°C ";
2330 PRINT "( -85° to +176°F)"
2340 PRINT " FPE =  Foamed polyethylene, temp.range  -65° to  +80°C ";
2350 PRINT "( -85° to +176°F)"
2360 PRINT " TFE =  TEFLON,              temp.range -250° to +250°C ";
2370 PRINT "(-418° to +482°F)"
2380 PRINT " NOTE: The values for Zo, VF, pF and Σ for foam cables are approx";
2390 PRINT "imate due to "
2400 PRINT " practical limitations in controlling the ratio of air to dielect";
2410 PRINT "ric in the   "
2420 PRINT " foam during manufacture. Actual values can vary between producti";
2430 PRINT "on runs, and "
2440 PRINT " particularly between different manufacturers.";
2450 GOTO 6210
2460 :REM'
2470 :REM'
2480 :REM'.....line loss in standard cables
2490 CLS:COLOR 7,0,0
2500 PRINT TAB(17)" ATTENUATION IN COMMONLY USED COAXIAL CABLES "
2510 PRINT UL$;
2520 GOSUB 5260    :REM'preface
2530 PRINT UL$;
2540 PRINT " ENTER: Length of line (";UM$;")....";:INPUT LG:LG=LG/UM
2550 INPUT " ENTER: Frequency (MHz)....";F
2560 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2570 PRINT " Attenuation in dB @";USING V$;F;:PRINT " MHz";
2580 LOCATE ,55:PRINT "* denotes foam dielectic"
2590 PRINT " Cable Length:";USING W$;LG*0.30480000376701355!;:PRINT " m. =";
2600 PRINT USING W$;LG;:PRINT " feet"
2610 PRINT UL$;
2620 Q$="┌─Zo────dB─┐"
2630 LOCATE ,15:PRINT Q$;
2640 LOCATE ,42:PRINT Q$;
2650 LOCATE ,69:PRINT Q$;
2660 FOR X=1 TO 41
2670  ZO=VAL(C$(X,5))         :REM'impedance
2680  D=VAL(C$(X,4))          :REM'ID of outer conducter
2690  E=VAL(C$(X,3))          :REM'dielectric constant
2700  B=10^(ZO*SQR(E)/138)    :REM'D/d constant
2710   IF RIGHT$(C$(X,7),1)="f"THEN K1= 0.9390000104904175! :ELSE K1=1
2720  K2=1:K=K1+K2
2730 A=0.4350000023841858!/ZO/D*B*K*SQR(F)
2740 C$(X,6)=STR$(A)          :REM'atten.constant array
2750 NEXT X
2760 :REM'
2770 FOR Y=1 TO 14
2780 PRINT TAB(2)C$(Y,1);
2790 PRINT TAB(15)USING "###.#";VAL(C$(Y,5));
2800 PRINT USING "###.##";VAL(C$(Y,6));
2810 :REM'
2820 PRINT " │"+C$(Y+14,1);
2830 IF VAL(C$(Y+14,5))<100 THEN U$="###.#":ELSE U$="#### "
2840 PRINT TAB(42)USING U$;VAL(C$(Y+14,5));
2850 PRINT USING "###.##";VAL(C$(Y+14,6));
2860 IF Y>=13 THEN PRINT "":GOTO 2910
2870 :REM'
2880 PRINT " │"+C$(Y+28,1);
2890 PRINT TAB(69)USING "###.#";VAL(C$(Y+28,5));
2900 PRINT USING "###.##";VAL(C$(Y+28,6));
2910 NEXT Y
2920 COLOR 0,7
2930 PRINT "     D (outer conducter ID)"TAB(52)"0.435┌        ┐              ";
2940 PRINT " ß= ───";TAB(33)"Attenuation in dB= ─────│ß(K1+K2)│√ƒ+2.78√Σ*P*ƒ ";
2950 PRINT "     d (inner conductor OD)"TAB(52)" Zo*D└        ┘              ";
2960 COLOR 7,0
2970 PRINT " K1=strand factor, K2=braid factor, ƒ=frequency in MHz,";
2980 PRINT " P=power factor";
2990 GOTO 6210
3000 :REM'
3010 :REM'.....unidentified cable
3020 T$=" UNIDENTIFIED COAXIAL CABLE "
3030 GOTO 3070
3040 :REM'.....clear screen
3050 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
3060 RETURN
3070 :REM'.....start
3080 CLS
3090 Z=0:C=0:L=0:E=0:V=0:B=0
3100 LOCATE ,26:COLOR 0,7,0:PRINT T$:COLOR 7,0
3110 PRINT UL$;
3120 PRINT "If a requested value is unknown, press <ENTER> to by-pass the ";
3130 PRINT "request."
3140 PRINT UL$;
3150 :REM'
3160 :REM'.....data input
3170  IF Z THEN 3200
3180 INPUT "ENTER: Impedance (ohms)...............";Z
3190 IF Z THEN GOSUB 3400
3200  IF C THEN 3230
3210 INPUT "ENTER: Capacitance in pF/ft...........";C
3220 IF C THEN GOSUB 3400
3230  IF L THEN 3260
3240 INPUT "ENTER: Inductance in µH/ft............";L
3250 IF L THEN B=EXP(L*LOG(10)/0.14000000059604645!):GOSUB 3400
3260  IF E THEN 3290
3270 INPUT "ENTER: Dielectric constant Σ..........";E
3280 IF E THEN V=1/SQR(E):GOSUB 3400
3290  IF V THEN 3330
3300 INPUT "ENTER: Velocity factor (decimal)......";V
3310 IF V>1 THEN BEEP:GOTO 3300
3320 IF V THEN E=(1/V)^2:GOSUB 3400
3330  IF B THEN 3370
3340 PRINT " D/d factor = (I.D. of outer conductor) ÷ (O.D. of inner conductor)"
3350 INPUT "ENTER: D/d factor.....................";B
3360 IF B THEN L=0.14000000059604645!*LOG(B)/LOG(10):GOSUB 3400
3370  IF Z*C*L*E*V*B THEN 3860
3380 GOTO 3160
3390 :REM'
3400 :REM'.....calculate
3410 IF E=0 AND Z*C THEN GOSUB 3770:GOTO 3400
3420 IF C=0 AND E*B THEN C=7.260000228881836!*E/(LOG(B)/LOG(10)):GOTO 3400
3430 IF E=0 AND C*B THEN E=C*LOG(B)/LOG(10)/7.260000228881836!:GOTO 3400
3440 IF B=0 AND C*E THEN B=10^(7.260000228881836!*E/C):GOTO 3400
3450 IF Z=0 AND E*B THEN Z=138/SQR(E)*LOG(B)/LOG(10):GOTO 3400
3460 IF E=0 AND Z*B THEN E=(138/Z*LOG(B)/LOG(10))^2:GOTO 3400
3470 IF B=0 AND Z*E THEN B=EXP(Z*SQR(E)*LOG(10)/138):GOTO 3400
3480 :REM'
3490 IF L=0 AND B THEN L=0.14000000059604645!*LOG(B)/LOG(10)
3500 IF B=0 AND L THEN B=EXP(L*LOG(10)/0.14000000059604645!)
3510 IF V=0 AND E THEN V=1/SQR(E)
3520 IF E=0 AND V THEN E=(1/V)^2
3530 :REM'
3540 :REM'.....display
3550 LN=5:GOSUB 3040
3560 IF Z*C*L*E*V*B THEN LN=3:GOSUB 3040
3570 :REM'
3580 IF Z THEN PRINT USING "Characteristic impedance...Zo= ###.### ohms";Z
3590 IF C THEN PRINT USING "Capacitance................ C= ###.### pF/ft";C;
3600 IF C THEN PRINT USING " = ###.### pF/metre";C/0.30480000376701355!
3610 IF L THEN PRINT USING "Inductance..................L= ###.### µH/ft";L;
3620 IF L THEN PRINT USING " = ###.### µH/metre";L/0.30480000376701355!
3630 IF E THEN PRINT USING "Dielectric factor...........Σ= ###.###";E
3640 IF V THEN PRINT USING "Velocity factor.............V= ###.# %";V*100
3650 IF B THEN PRINT USING "D/d factor..................ß= ###.###";B
3660 PRINT UL$;
3670 IF FLAG OR Z*C*L*E*V*B THEN 3880
3680 COLOR 0,7:PRINT " Press 1 to continue or 0 to quit ":COLOR 7,0
3690 LN=CSRLIN-1
3700 FLAG=0
3710 Z$=INKEY$:IF Z$=""THEN 3710
3720 PRINT USING " = ###.### pF/metre";C/0.30480000376701355!
3730 IF Z$="0"THEN GOSUB 3040:FLAG=1:GOTO 3870
3740 IF Z$="1"THEN GOSUB 3040:RETURN
3750 GOTO 3710
3760 :REM'
3770 :REM'.....iteration
3780 EC=0.10000000149011612!:N=0.10000000149011612!
3790 EC=EC+N
3800 EZ=((7.260000228881836!*EC*138)/(C*Z))^2
3810 IF ABS(EC-EZ)<9.999999747378752e-05! THEN 3840
3820 IF EZ>EC THEN EC=EC-N:N=N/10:GOTO 3790
3830 GOTO 3790
3840 E=EC:RETURN
3850 :REM'
3860 :REM'.....end
3870 LN=3:GOSUB 3040:GOTO 3580
3880 GOSUB 6040:GOSUB 6260:GOSUB 3040:COLOR 0,7
3890 LOCATE 13,28:PRINT " Want another?    (y/n) ":COLOR 7,0
3900 Z$=INKEY$:IF Z$=""THEN 3900
3910 IF Z$="n"THEN 3940
3920 IF Z$="y"THEN FLAG=0:GOTO 3070
3930 GOTO 3900
3940 GOTO 6230  :REM'end
3950 :REM'
3960 :REM'.....DIELECTRIC CONSTANT
3970 COLOR 7,0,0:CLS:PRINT UL$;:COLOR 0,7
3980 LOCATE CSRLIN-1,16
3990 PRINT " COAXIAL CABLE - CALCULATED DIELECTRIC CONSTANT "
4000 COLOR 7,0:PRINT
4010 PRINT" Many coaxial cable equations stem from the dielectric constant Σ."
4020 PRINT" Most published coaxial cable tables do not show this constant."
4030 PRINT" Most published coaxial cable tabular data appear to be rounded off."
4040 PRINT" The least rounding-off appears to be in the listed Zo and pF/ft. ";
4050 PRINT "values."
4060 PRINT" This program calculates Σ based on published Zo and pF/ft. values."
4070 PRINT " Using Σ it re-calculates the characteristic impedance & velocity";
4080 PRINT " factor."
4090 PRINT UL$;
4100 LN=CSRLIN
4110 INPUT " ENTER: Nominal characteristic impedance (ohms)...";Z
4120 IF Z=0 THEN 4110
4130 INPUT " ENTER: Published capacity (pF/ft.)...............";C
4140 IF C=0 THEN 4130
4150 :REM'.....iteration
4160 EC=0.10000000149011612!:N=0.10000000149011612!
4170 EC=EC+N
4180 EZ=((7.260000228881836!*EC*138)/(C*Z))^2
4190 IF ABS(EC-EZ)<9.999999747378752e-05! THEN 4230
4200 IF EZ>EC THEN EC=EC-N:N=N/10:GOTO 4170
4210 GOTO 4170
4220 :REM'
4230 VV=100/SQR(EC)
4240 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
4250 PRINT USING " Published impedance................. ####.### ohms";Z
4260 PRINT USING " Published capacitance............... ####.### pF/ft";C
4270 PRINT
4280 PRINT USING " Calculated Dielectric Constant...... ####.###";EC
4290 PRINT USING " Calculated velocity factor.......... ####.### %";VV
4300 PRINT UL$;
4310 COLOR 0,7:PRINT " Do another?  (y/n) ":COLOR 7,0
4320 Z$=INKEY$:IF Z$=""THEN 4320
4330 IF Z$="n"THEN 6230
4340 IF Z$="y"THEN 3960
4350 GOTO 4320
4360 GOTO 6210
4370 :REM'
4380 :REM'.....line length - physical vs. electrical
4390 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4400 :REM'
4410 :REM'.....cable table
4420 FOR Z=1 TO 12
4430 PRINT TAB(1)USING "##:";Z;:PRINT C$(Z,1);
4440 PRINT TAB(21)USING "##:";Z+12;:PRINT C$(Z+12,1);
4450 PRINT TAB(41)USING "##:";Z+24;:PRINT C$(Z+24,1);
4460 IF Z=12 THEN 4480
4470 PRINT TAB(61)USING "##:";Z+36;:PRINT C$(Z+36,1)
4480 NEXT Z
4490 PRINT UL$;
4500 INPUT " ENTER: An item number from above list to select coaxial cable";N
4510 IF N>=1 AND N<=47 THEN 4530
4520 BEEP:GOTO 4500
4530 E=VAL(C$(N,3))
4540 VF=1/SQR(E)
4550 INPUT " ENTER: Frequency in MHz..........................";F
4560 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
4570 PRINT TAB(9);C$(N,1);
4580 PRINT " Transmission Line Physical Length vs. Electrical Length"
4590 PRINT UL$;
4600 W=299.7925109863281!/F  :REM'length of wavelength in free space
4610 L=W*VF        :REM'electrical length in metres
4620 PRINT "        Frequency.................................";USING V$;F;
4630 PRINT " MHz"
4640 PRINT "        Velocity factor...........................";USING V$;VF;
4650 PRINT USING " (##.#%)";VF*100
4660 PRINT "        Length of one wavelength in free space....";USING V$;W;
4670 PRINT " m. =";USING V$;W/0.30480000376701355!;:PRINT " ft."
4680 PRINT "        Length of full wavelength line............";USING V$;L;
4690 PRINT " m. =";USING V$;L/0.30480000376701355!;:PRINT " ft."
4700 PRINT "        Length of  1/2 wavelength line............";USING V$;L/2;
4710 PRINT " m. =";USING V$;L/2/0.30480000376701355!;:PRINT " ft."
4720 PRINT "        Length of  1/4 wavelength line............";USING V$;L/4;
4730 PRINT " m. =";USING V$;L/4/0.30480000376701355!;:PRINT " ft."
4740 PRINT "        Length of  1/8 wavelength line............";USING V$;L/8;
4750 PRINT " m. =";USING V$;L/8/0.30480000376701355!;:PRINT " ft."
4760 GOTO 6210
4770 :REM'
4780 :REM'.....physical dimensions
4790 CLS
4800 PRINT UL$;:LOCATE CSRLIN-1,22
4810 COLOR 0,7,0:PRINT " COAXIAL CABLE PHYSICAL DIMENSIONS ":COLOR 7,0
4820 T=53
4830 PRINT "  A = Outside diameter of jacket";
4840 PRINT TAB(T)"NOTE: Dimensions may vary"
4850 PRINT "  B = Inside diameter of outer conductor (shield)";
4860 PRINT TAB(T+6)"from manufacturer to"
4870 PRINT "  C = Wall thickness of outer conductor plus jacket";
4880 PRINT TAB(T+6)"manufacturer."
4890 PRINT "  D = Outside diameter of inner conductor";
4900 PRINT TAB(T)"* denotes foam dielectric"
4910 PRINT UL$;
4920 T$=" Dimensions in "
4930 IF UM=1 THEN T$=T$+"inches ":ELSE T$=T$+" millimetres "
4940 T=LEN(T$):LOCATE CSRLIN-1,(80-T)/2:COLOR 0,7:PRINT T$:COLOR 7,0
4950 T$="A    B    C    D"
4960 PRINT TAB(20)T$;TAB(39)"│";TAB(60)T$
4970 FOR Z=1 TO 20
4980 E=VAL(C$(Z,3))     :REM'dielectric constant
4990 E1=VAL(C$(Z+20,3)) :REM'dielectric constant
5000 A$=C$(Z,1)         :REM'type
5010 A1$=C$(Z+20,1)     :REM'type
5020 B=VAL(C$(Z,5))     :REM'impedance
5030 B1=VAL(C$(Z+20,5)) :REM'impedance
5040 C=VAL(C$(Z,4))     :REM'jacket O.D.
5050 C1=VAL(C$(Z+20,4)) :REM'jacket O.D.
5060 DD=10^(B*SQR(E)/138)    :REM'D/d factor
5070 DD1=10^(B1*SQR(E1)/138) :REM'D/d factor
5080 ID=VAL(C$(Z,8))      :REM'inner conductor diameter
5090 ID1=VAL(C$(Z+20,8))  :REM'inner conductor diameter
5100 D=DD*ID              :REM'dielectric OD
5110 D1=DD1*ID1           :REM'dielectric OD
5120 W=(C-D)/2
5130 W1=(C1-D1)/2
5140 IF UM=1     THEN X=1:   Q$="###.### .### .### .####"
5150 IF UM=0.30480000376701355! THEN X=25.399999618530273!:Q$="####.## ##.# ##.# ##.##"
5160 PRINT " ";A$;
5170 PRINT TAB(15)USING Q$;C*X,D*X,W*X,ID*X;
5180 PRINT " ";
5190 PRINT TAB(39);"│ ";A1$;
5200 PRINT TAB(55)USING Q$;C1*X,D1*X,W1*X,ID1*X;
5210 IF Z<>17 THEN PRINT "":GOTO 5230
5220 GOSUB 6270:CLS
5230 NEXT Z
5240 GOTO 6210
5250 :REM'
5260 :REM'.....line loss preface
5270 T=7
5280 PRINT TAB(T);
5290 PRINT "Line loss in any type of coaxial cable can vary considerably from"
5300 PRINT TAB(T);
5310 PRINT "values shown in most published graphs because characteristics can"
5320 PRINT TAB(T);
5330 PRINT "vary in the same type of cable from different manufacturers. Also,"
5340 PRINT TAB(T);
5350 PRINT "age and condition of the cable can effect the inherent loss, as can"
5360 PRINT TAB(T);
5370 PRINT "the installation environment. Therefore any theoretical loss values"
5380 PRINT TAB(T);
5390 PRINT "(including those computed by this program) must be considered as"
5400 PRINT TAB(T);
5410 PRINT "approximate only. The only reliable way to determine line loss is"
5420 PRINT TAB(T);
5430 PRINT "by actual measurement. However, the values computed by this program"
5440 PRINT TAB(T);
5450 PRINT "should be accurate enough for most Amateur Radio applications."
5460 PRINT TAB(T);
5470 PRINT
5480 PRINT TAB(T);
5490 PRINT "The equations used in this program those published in the ARRL"
5500 PRINT TAB(T);
5510 PRINT "ANTENNA BOOK, 18th edition, page 24-18, Table 2, assuming power"
5520 PRINT TAB(T);
5530 PRINT "factor P=0, strand factor K1=0.939 for stranded wire, 1.0 for solid"
5540 PRINT TAB(T);
5550 PRINT "wire, and braid factor K2=1."
5560 PRINT
5570 PRINT TAB(T);
5580 PRINT "Calculated values are only for properly matched transmission lines."
5590 RETURN
5600 :REM'
5610 :REM'.....note
5620 PRINT " The values of Zo (impedance), VF (velocity factor) and capacity ";
5630 PRINT "per unit of   "
5640 PRINT " length shown in many published data sheets are nominal values on";
5650 PRINT "ly, because   "
5660 PRINT " these values are functions of Σ (dielectric factor) and ß (insid";
5670 PRINT "e diameter of "
5680 PRINT " outer conductor ÷ outside diameter of inner conductor). Σ ad ß c";
5690 PRINT "an vary       "
5700 PRINT " between production runs and different manufacturers, and rarely ";
5710 PRINT "appear in data"
5720 PRINT " sheets. This program computes the nominal values of Σ and ß requ";
5730 PRINT "ired for the  "
5740 PRINT " generally accepted nominal values of Zo and pF/ft published by t";
5750 PRINT "he ARRL, and  "
5760 PRINT " re-calculates VF and other values that are functions of Σ and ß,";
5770 PRINT " using the    "
5780 PRINT " equations published by the ARRL (Item <a> in the above menu).";
5790 RETURN
5800 :REM'
5810 :REM'.....equations
5820 CLS
5830 PRINT TAB(27)" COAXIAL CABLE EQUATIONS "
5840 PRINT UL$;
5850 GOSUB 6040
5860 PRINT TAB(16)"ß = D/d factor"
5870 PRINT TAB(16)"Σ = dielectric constant"
5880 PRINT TAB(16)"C = capacity in pF/ft"
5890 PRINT TAB(16)"L = inductance in µH/ft"
5900 PRINT TAB(16)"Zo= characteristic impedance in ohms"
5910 PRINT TAB(16)"V = velocity factor (% of speed of light)"
5920 PRINT TAB(16)"and"
5930 PRINT TAB(16)"    0.435┌        ┐"
5940 PRINT TAB(16)"A = ─────│ß(K1+K2)│√ƒ+2.78√Σ*P*ƒ"
5950 PRINT TAB(16)"     Zo*D└        ┘"
5960 PRINT TAB(16)"where"
5970 PRINT TAB(16)"A = attenuation in dB/100 feet"
5980 PRINT TAB(16)"K1= manufacturer's strand factor"
5990 PRINT TAB(16)"K2= manufacturer's braid factor"
6000 PRINT TAB(16)"ƒ = frequency in MHz"
6010 PRINT TAB(16)"P = power factor";
6020 GOTO 6210
6030 :REM'
6040 :REM'.....equation graphics
6050 T=11:N=CSRLIN-1:LOCATE N
6060 LOCATE ,T:PRINT "╤══════"
6070 LOCATE ,T:PRINT "│    D "
6080 LOCATE ,T:PRINT "│ ß= ─ "
6090 LOCATE ,T:PRINT "│    d "
6100 LOCATE ,T:PRINT "└──────"
6110 T=18:LOCATE N
6120 LOCATE ,T:PRINT "╤══════════╤═══════════════╤═══════════════╤════════╤"
6130 LOCATE ,T:PRINT "│    7.26Σ │               │     138       │    100 │"
6140 LOCATE ,T:PRINT "│ C= ───── │ L= 0.14 log ß │ Zo= ─── log ß │ V= ─── │"
6150 LOCATE ,T:PRINT "│    log ß │               │     √Σ        │    √Σ  │"
6160 LOCATE ,T:PRINT "┴──────────┴───────────────┴───────────────┴────────┘"
6170 PRINT TAB(16)"D = inner diameter of outer conductor"
6180 PRINT TAB(16)"d = outer diameter of inner conductor"
6190 RETURN
6200 :REM'
6210 :REM'.....end
6220 GOSUB 6260
6230 RESTORE:GOTO 250   :REM'start
6240 END
6250 :REM'
6260 :REM'PRT
6270 KEY OFF:GOSUB 6340:LOCATE 25,5:COLOR 0,2
6280 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
6290 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
6300 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 6300 :ELSE GOSUB 6340
6310 IF Z$="3"THEN RETURN
6320 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
6330 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 6270
6340 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
