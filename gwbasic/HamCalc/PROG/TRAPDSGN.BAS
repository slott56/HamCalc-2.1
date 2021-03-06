10 :REM'TRAPDSGN - 07 SEP 92 - adapted from HARTRPDI, by  A.C.(AL) Buxton W8NX
20 :REM'2225 Woodpark Rd., Akron OH 44333,(216)836-3854
30 :REM'.....rev. 27 FEB 2000
40 IF EX$=""THEN EX$="EXIT"
50 CLS
60 COLOR 7,0,1
70 PI=3.141592654#
80 U$="##,###.###"
90 V$="####.#####"
100 UL$=STRING$(80,205)
110 :REM'
120 :REM'.....start
130 CLS
140 COLOR 15,2,1
150 PRINT " TRAP DIPOLE - 3 BAND SINGLE TRAP";
160 PRINT TAB(57);"by A.C.(AL) Buxton W8NX ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 PRINT " Press number in < > to:"
200 PRINT UL$;
210 PRINT "  < 1 >  RUN program"
220 PRINT "  < 0 >  EXIT"
230 PRINT UL$;
240 Z$=INKEY$
250 IF Z$="0"THEN CLS:RUN EX$
260 IF Z$="1"THEN 290
270 GOTO 240
280 :REM'
290 :REM'.....input data
300 CLS
310 D$="Date:_________________"
320 INPUT "ENTER: Lowest operating frequency in MHz..................";FL
330 IF FL=0 THEN LOCATE CSRLIN-1:GOTO 320
340 INPUT "ENTER: Medium operating frequency in MHz..................";FM
350 IF FM=0 THEN LOCATE CSRLIN-1:GOTO 340
360 INPUT "ENTER: Harmonic operating frequency in MHz................";FHAR
370 IF FHAR=0 THEN LOCATE CSRLIN-1:GOTO 360
380 INPUT "ENTER: The order of the odd harmonic frequency............";ORDER
390 IF ORDER=0 THEN LOCATE CSRLIN-1:GOTO 380
400 INPUT "ENTER: Diameter of wire radiating elements in inches......";DW
410 IF DW=0 THEN LOCATE CSRLIN-1:GOTO 400
420 PRINT "PRESS  number in < > to select:"
430 PRINT "                 <1>  Coaxial traps"
440 PRINT "                 <2>  Open Inductor-Capacitor traps"
450 Z$=INKEY$
460 IF Z$="1"THEN TT$="C":GOTO 490
470 IF Z$="2"THEN TT$="O":GOTO 490
480 GOTO 450
490 INPUT "ENTER: Estimated outside diameter of trap (inches)........";DT
500 IF DT=0 THEN LOCATE CSRLIN-1:GOTO 490
510 INPUT "ENTER: Estimated length of trap (inches)..................";LH
520 IF LH=0 THEN LOCATE CSRLIN-1:GOTO 510
530 INPUT "ENTER: Estimated Q of trap................................";QTRAP
540 IF QTRAP=0 THEN LOCATE CSRLIN-1:GOTO 530
550 FPSEUDO=FHAR      :REM'harmonic freq. antenna would have if trap were removed
560 :REM'
570 :REM'.....start of iterative loop
580 CONVCHK=0         :REM'restet convergence check flag
590 FOR AB=1 TO 16:   :REM'design goes through 10 iterations
600 KA=1              :REM'initial assumed value for dipole length factor is 1
610 FMHZ=FHAR         :REM'the subroutine iterates to the correct value
620 :REM'
630 GOSUB 3920        :REM'get KA,Z),XCE,CE
640                   :REM'KA=  length factor
650                   :REM'CE=  equivalent end capacitance
660                   :REM'XCE= equivalent end capacitve reactance
670                   :REM'ZO=  characteristic impedance of lambda/2 wire section
680 ZT=983.5700073242188!*(ORDER-1+KA)/4/FPSEUDO
690                   :REM'ZT=  total length of monopole antenna
700 FMHZ=FM           :REM'medium frequency
710 :REM'
720 GOSUB 3920        :REM'get KA,Z0,XCE,CE
730 CS=0.800000011920929!*SQR(LH*DT)          :REM'stray shunt capacity of trap to free space
740 IF TT$="O" THEN CS=1.2000000476837158!*SQR(LH*DT):Z0=1000*SQR(L/C)
750                           :REM'LH = trap length
760                           :REM'DT = trap diameter in inches
770 XCE=-Z0*TAN(KA*PI/2)      :REM'reactance of the end capacitance
780 CE=-10^6/2/PI/FM/XCE
790 CSP=CS+CE-0.18000000715255737!*SQR(LH*DT)
800 :REM' CSP IS THE COMBINED EFFECT OF THE TRAP STRAY CAPACITY IN FREE SPACE AND         THE END CAPACITANCE DUE TO FRINGING OF THE ELECTRICAL FIELD. IT ASSUMES A       9% NEGATIVE MUTUAL COUPLING COEFFICIENT
810 XCSP=-10^6/2/PI/FM/CSP
820 XCSP=-10^6/2/PI/FM/CSP
830 KAP=ATN(-XCSP/Z0)*2/PI
840   :REM'KAP = total length factor of dipole at medium frequency FM
850 Z1=983.5700073242188!*KAP/4/FM  :REM'length of inner segment
860 Z3=ZT-Z1            :REM'length of outer segment
870 FMHZ=FL
880 :REM'
890 :REM'.....convergence check
900 IF CONVCHK THEN 960
910 CLS
920 COLOR 0,7
930 PRINT " CHECKING THE DESIGN CALCULATIONS FOR CONVERGENCE......."
940 COLOR 7,0
950 CONVCHK=1     :REM'convergence check flag
960 :REM'
970 GOSUB 3920    :REM'get KA,Z0,XCE,CE
980 XCEL=XCE                         :REM'end reactance at frequency FL
990 Z0L=Z0                           :REM'chacteristic impedance at frequency FL
1000 FFUND=983.5700073242188!/4*0.949999988079071!/(Z1+Z3)       :REM'fundamental frequency the antenna would
1010                                    :REM'have if no traps were present
1020 NORLGTH=2*(Z1+Z3)*FL/983.5700073242188!      :REM'normalized physical length of the antenna
1030 RADRES=(31.040000915527344!*LOG(NORLGTH)+89.72000122070312!):REM'radiation resistance of the antenna
1040                                    :REM'referred to the current maximums
1050 L=Z3:KV=1:Z0=Z0L:FMHZ=FL:RL=0.0010000000474974513!:XL=XCEL:A=PI*RADRES/8/Z0L/(Z1+Z3)
1060 LAMBDA=983.5700073242188!*KV/FMHZ            :REM'wavelength in feet
1070 B=2*PI/LAMBDA
1080 :REM'
1090 GOSUB 3750   :REM'transmission line calculation
1100 RINOUTL=RIN:XINOUTL=XIN:XCS=-10^6/2/PI/FMHZ/CS
1110 R7=9.999999747378752e-05!:X7=XCS*2:R8=RINOUTL:X8=XINOUTL
1120 :REM'
1130 GOSUB 4020   :REM'parallel impedance calculation
1140 RINOUTLP=R9:XINOUTLP=X9
1150 L=Z1:Z0=Z0L:FMHZ=FL:RL=RADRES/2:XL=9.999999747378752e-05!:A=-PI*RADRES/8/Z0L/(Z1+Z3)
1160 LAMBDA=983.5700073242188!*KV/FMHZ:B=2*PI/LAMBDA
1170 :REM'
1180 GOSUB 3750   :REM'transmission line calculation
1190 RININL=RIN:XININL=XIN
1200 R7=9.999999747378752e-05!:X7=2*XCS:R8=RININL:X8=XININL
1210 :REM'
1220 GOSUB 4020   :REM'parallel impedance calculation
1230 RININLP=R9:XININLP=X9
1240 XTRAPLP=-XININLP-XINOUTLP
1250 LT=XTRAPLP*(1-(FL/FM)^2)/2/PI/FL :REM'trap inductance UH & CT=trap capacity pF
1260 CT=10^6/4/PI^2/FM^2/LT
1270 FGEN=FHAR:FMHZ=FGEN
1280 :REM'
1290 GOSUB 3920     :REM'get KA,Z0,XCE,CE
1300 NORLGTH=2*(Z1+Z3)*FMHZ/983.5700073242188!:RADRES=(31.040000915527344!*LOG(NORLGTH)+89.72000122070312!)
1310 RL=9.999999747378752e-05!:XL=XCE:L=Z3:A=PI*RADRES/8/Z0L/(Z1+Z3)*1.340000033378601!
1320 LAMBDA=983.5700073242188!/FMHZ*KV:B=2*PI/LAMBDA
1330 :REM'
1340 GOSUB 3750     :REM'transmission line calculation
1350 R7=RIN:X7=XIN:R8=9.999999747378752e-05!:X8=10^6/2/PI/FMHZ/(-CS/2)
1360 :REM'
1370 GOSUB 4020     :REM'parallel impedance calculation
1380 XLT=2*PI*FGEN*LT:XCT=-10^6/2/PI/FGEN/CT:RTRAP=2*PI*FGEN*LT/QTRAP
1390 MTN=SQR((XLT*XCT)^2+(RTRAP*XCT)^2):OTN=ATN(-RTRAP/XLT)
1400 MTD=SQR(RTRAP^2+(XLT+XCT)^2):OTD=ATN((XLT+XCT)/RTRAP)
1410 MT=MTN/MTD:OT=OTN-OTD
1420 RP=MT*COS(OT):XP=MT*SIN(OT)
1430 RLP=RP+R9:XLP=XP+X9
1440 R7=RLP:X7=XLP:R8=9.999999747378752e-05!:X8=10^6/2/PI/FMHZ/(-CS/2)
1450 :REM'
1460 GOSUB 4020    :REM'parallel impedance calculation
1470 RL=R9:XL=X9:L=Z1
1480 :REM'
1490 GOSUB 3750    :REM'transmissopn line calculation
1500 FPSEUDO=FPSEUDO+0.008999998681247234!*XIN/RIN*FHAR
1510 PRINT TAB(2);"LT=";USING V$;LT;:PRINT " µH │";
1520 PRINT TAB(22);"CT=";USING V$;CT;:PRINT " pF │";
1530 PRINT TAB(42);"Z1=";USING V$;Z1;:PRINT " ft.│";
1540 PRINT TAB(62);"Z3=";USING V$;Z3;:PRINT " ft."
1550 IF LT=LTX AND CT=CTX AND Z1=Z1X AND Z3=Z3X THEN 1650
1560 LTX=LT:CTX=CT:Z1X=Z1:Z3X=Z3
1570 NEXT AB
1580 :REM'
1590 :REM'.....end of reiterative loop
1600 COLOR 0,7:PRINT " VALUES DO NOT CONVERGE. THIS DESIGN IS NOT FEASIBLE "
1610 PRINT           "           Press any key to return to menu           "
1620 COLOR 7,0
1630 IF INKEY$=""THEN 1630 :ELSE 120
1640 :REM'
1650 :REM'.....convergence achieved
1660 COLOR 0,7:PRINT " CONVERGENCE ACHIEVED ":COLOR 7,0:GOTO 1670
1670 GOSUB 4170     :REM'screen dump option
1680 :REM'
1690 CLS
1700 PRINT "Do you wish impedance calculations at any operating bands of ";
1710 PRINT "frequencies? (y/n)"
1720 Z$=INKEY$
1730 IF Z$="n"OR Z$="N"THEN 2730
1740 IF Z$="y"OR Z$="Y"THEN 1770
1750 GOTO 1720
1760 :REM'
1770 :REM'.....impedance calculations
1780 PRINT
1790 INPUT "ENTER: Center freq.(MHz) of the desired band ";FCEN
1800 CLS
1810 PRINT "               TRAP DIPOLE INPUT IMPEDANCE    " :PRINT
1820 PRINT TAB(3);"FREQ.(MHz)";TAB(20);"INPUT RES.(ohms)";
1830 PRINT TAB(40);"INPUT REACT.(ohms)"
1840 PRINT
1850 FGEN=FCEN:FMHZ=FGEN:NORLGTH=2*(Z1+Z3)*FGEN/983.5700073242188!
1860 RADRES=(31.040000915527344!*LOG(NORLGTH)+89.72000122070312!):A=PI*RADRES/4/Z0L/(983.5700073242188!/FGEN/2)
1870 IF FGEN>1.2000000476837158!*FM THEN 1930
1880 IF FGEN<0.800000011920929!*FM THEN 1930
1890 NORLGTH=2*Z1*FGEN/983.5700073242188!:RADRES=(31.040000915527344!*LOG(NORLGTH)+89.72000122070312!)
1900 A=PI*RADRES/4/Z0L/(983.5700073242188!/FGEN/2)
1910 :REM'
1920 :REM'.....print loop
1930 FOR I=1 TO 10
1940 RADRES=31.040000915527344!*LOG(NORLGTH)+89.72000122070312!
1950 :REM'
1960 GOSUB 3920     :REM'get KA,Z0,XCE,CE
1970 RL=9.999999747378752e-05!:XL=XCE:L=Z3:FMHZ=FGEN:LAMBDA=983.5700073242188!/FMHZ*KV:B=2*PI/LAMBDA
1980 :REM'
1990 GOSUB 3750     :REM'transmission line calculation
2000 CS=0.800000011920929!*SQR(LH*DT):IF TT$="O" THEN CS=1.2000000476837158!*SQR(LH*DT)
2010 R7=RIN:X7=XIN:R8=9.999999747378752e-05!:X8=10^6/2/PI/FMHZ/(-CS/2)
2020 :REM'
2030 GOSUB 4020     :REM'parallel impedance calculation
2040 CS=0.800000011920929!*SQR(LH*DT):IF TT$="O" THEN CS=1.2000000476837158!*(LH*DT)^0.5!
2050 XLT=2*PI*FGEN*LT:XCT=-10^6/2/PI/FGEN/CT
2060 RTRAP=0.0010000000474974513!
2070 MTN=SQR((XLT*XCT)^2+(RTRAP*XCT)^2):OTN=ATN(-RTRAP/XLT)
2080 MTD=SQR(RTRAP^2+(XLT+XCT)^2):OTD=ATN((XLT+XCT)/RTRAP)
2090 MT=MTN/MTD:OT=OTN-OTD
2100 RP=MT*COS(OT):XP=MT*SIN(OT)
2110 RLP=RP+R9:XLP=XP+X9
2120 IF FGEN<0.800000011920929!*FM THEN 2150
2130 IF FGEN>1.2000000476837158!*FM THEN 2150
2140 CS=2*CSP
2150 R7=RLP:X7=XLP:R8=9.999999747378752e-05!:X8=10^6/2/PI/FMHZ/(-CS/2)
2160 :REM'
2170 :REM'.....parallel impedance subroutine
2180 GOSUB 4020
2190 RL=R9:XL=X9:L=Z1
2200 :REM'
2210 GOSUB 3750    :REM'transmission line calculation
2220 ERRR=(RADRES-2*RIN)/2/RIN
2230 A=A*(1+0.800000011920929!*ERRR)
2240 NEXT I
2250 :REM'
2260 FOR J=1 TO 15
2270 FGEN=FCEN+(J-8)*0.009999999776482582!*FCEN
2280 FMHZ=FGEN
2290 :REM'
2300 GOSUB 3920    :REM'get KA,Z0,XCE,CE
2310 RL=9.999999747378752e-05!:XL=XCE:L=Z3:FMHZ=FGEN:LAMBDA=983.5700073242188!/FMHZ*KV:B=2*PI/LAMBDA
2320 :REM'
2330 GOSUB 3750    :REM'transmission line calculation
2340 CS=0.800000011920929!*SQR(LH*DT)
2350 R7=RIN:X7=XIN:R8=9.999999747378752e-05!:X8=10^6/2/PI/FMHZ/(-CS/2)
2360 :REM'
2370 GOSUB 4020    :REM'parallel impedance calculation
2380 CS=0.800000011920929!*SQR(LH*DT):IF TT$="O" THEN CS=1.2000000476837158!*SQR(LH*DT)
2390 IF FGEN<0.800000011920929!*FM THEN 2420
2400 IF FGEN>1.2000000476837158!*FM THEN 2420
2410 CS=2*CSP
2420 XLT=2*PI*FGEN*LT:XCT=-10^6/2/PI/FGEN/CT
2430 RTRAP=2*PI*FGEN*LT/QTRAP
2440 MTN=SQR((XLT*XCT)^2+(RTRAP*XCT)^2):OTN=ATN(-RTRAP/XLT)
2450 MTD=SQR(RTRAP^2+(XLT+XCT)^2):OTD=ATN((XLT+XCT)/RTRAP)
2460 MT=MTN/MTD:OT=OTN-OTD
2470 RP=MT*COS(OT):XP=MT*SIN(OT)
2480 RLP=RP+R9:XLP=XP+X9
2490 R7=RLP:X7=XLP:R8=9.999999747378752e-06!:X8=10^6/2/PI/FMHZ/(-CS/2)
2500 :REM'
2510 GOSUB 4020   :REM'parallel impedance calculation
2520 RL=R9:XL=X9:L=Z1
2530 :REM'
2540 GOSUB 3750   :REM'transmission line calculation
2550 :REM'
2560 :REM'.....screen display
2570 PRINT TAB(3);USING U$;FGEN;
2580 PRINT TAB(22);USING U$;2*RIN;
2590 PRINT TAB(42);USING U$;2*XIN
2600 NEXT J
2610 :REM'
2620 :REM'.....end of impedance calculation loop
2630 :REM'
2640 GOSUB 4170     :REM'screen dump option subroutine
2650 CLS
2660 PRINT "Do you wish impedance calculations over another band of freqs.?";
2670 PRINT "  (y/n)"
2680 Z$=INKEY$
2690 IF Z$="Y"OR Z$="y"THEN 1790
2700 IF Z$="N"OR Z$="n"THEN 2730
2710 GOTO 2680
2720 :REM'
2730 CLS:PRINT TAB(28);"SUMMARY OF SPECIFICATIONS"
2740 PRINT TAB(28);"  HARMONIC TRAP DIPOLE "
2750 PRINT TAB((80-LEN(D$))/2);D$:PRINT
2760 TB=13            :REM'left margin
2770 PRINT TAB(TB);
2780 PRINT "Low operating frequency.................. ";USING U$;FL;
2790 PRINT " Mhz"
2800 PRINT TAB(TB);
2810 PRINT "Medium operating frequency................";USING U$;FM;
2820 PRINT " Mhz"
2830 PRINT TAB(TB);
2840 PRINT "Harmonic operating frequency..............";USING U$;FHAR;
2850 PRINT " Mhz"
2860 PRINT TAB(TB);
2870 PRINT "Order of harmonic.........................";USING "######";ORDER
2880 PRINT TAB(TB);
2890 PRINT "Length of inner monopole element..........";USING U$;Z1;
2900 PRINT " ft.=";USING "###.## m.";Z1*0.30480000376701355!
2910 PRINT TAB(TB);
2920 PRINT "Length of outer extension beyond trap.....";USING U$;Z3;
2930 PRINT " ft.=";USING "###.## m.";Z3*0.30480000376701355!
2940 PRINT TAB(TB);
2950 PRINT "Overall length of dipole antenna..........";USING U$;2*(Z1+Z3);
2960 PRINT " ft.=";USING "###.## m.";2*(Z1+Z3)*0.30480000376701355!
2970 PRINT TAB(TB);
2980 PRINT "Diameter of radiating elements............";USING U$;DW;
2990 PRINT " in.=";USING "###.# mm.";DW*25.399999618530273!
3000 PRINT TAB(TB);
3010 PRINT "Trap resonant frequency...................";USING U$;FM;
3020 PRINT " MHz."
3030 PRINT TAB(TB);
3040 PRINT "Trap inductance...........................";USING U$;LT;
3050 PRINT " µH"
3060 PRINT TAB(TB);
3070 PRINT "Trap capacitance..........................";USING U$;CT;
3080 PRINT " pF"
3090 CXR=1000*(LT/CT)^0.5!
3100 PRINT TAB(TB);
3110 PRINT "Trap characteristic reactance.............";USING U$;CXR;
3120 PRINT " ohms"
3130 PRINT TAB(TB);
3140 PRINT "Estimated outside diameter of trap........";USING U$;DT;
3150 PRINT " in.=";USING "###.# cm.";DT*2.5399999618530273!
3160 PRINT TAB(TB);
3170 PRINT "Estimated length of trap windings.........";USING U$;LH;
3180 PRINT " in.=";USING "###.# cm.";LH*2.5399999618530273!
3190 PRINT TAB(TB);
3200 PRINT "Estimated Q of trap.......................";USING "######";QTRAP
3210 SCI=0.6000000238418579!*SQR(LH*DT)
3220 PRINT TAB(TB);
3230 PRINT "Estimated trap stray capacity to infinite.";USING U$;SCI;
3240 PRINT " pF"
3250 L=0.005080000031739473!*(Z1+Z3)*12*(LOG(4*12*(Z1+Z3)/DW)-1)
3260 C=7.360000133514404!*(Z1+Z3)/(LOG(2*12*(Z1+Z3)/DW)/LOG(10)-0.5!)
3270 GOSUB 4170     :REM'screen dump option subroutine
3280 :REM'
3290 :REM'.....diagram
3300 CLS
3310 PRINT STRING$(79,205)
3320 LOCATE CSRLIN-1,36:PRINT " W 8 N X "
3330 PRINT TAB(26);"HARMONIC TRAP DIPOLE ANTENNA"
3340 PRINT TAB(24);"════════════════════════════════"
3350 F$="###.###"
3360 PRINT TAB(22);"Low operating freq.(MHz).....";USING F$;FL
3370 PRINT TAB(22);"Mid operating freq.(MHz).....";USING F$;FM
3380 PRINT TAB(22);"Hi  operating freq.(MHz).....";USING F$;FHAR
3390 LOCATE  8:PRINT TAB(6);STRING$(70,196)
3400 LOCATE 8,6:PRINT "│«":LOCATE 8,74:PRINT "»│"
3410 LOCATE 8,36:PRINT USING "###.# ft.";2*(Z1 + Z3)
3420 LOCATE 9,6:PRINT "│":LOCATE 9,75:PRINT "│"
3430 LOCATE 9,36:PRINT USING "###.## m.";2*(Z1 + Z3)*0.30480000376701355!
3440 LOCATE 10,6:PRINT "│":LOCATE 10,75:PRINT "│"
3450 LOCATE 11,6:PRINT "│":LOCATE 11,75:PRINT "│"
3460 LOCATE 12:PRINT TAB(2);"─ ─ ∞";STRING$(68,196);"∞ ─ ─"
3470 LOCATE 12,40:PRINT "┐┌"
3480 LOCATE 13,40:PRINT "╟┘"
3490 LOCATE 11,19:PRINT "┌─∩∩∩─┐":LOCATE 11,56:PRINT "┌─∩∩∩─┐"
3500 LOCATE 12,19:PRINT "┤     ├":LOCATE 12,56:PRINT "┤     ├"
3510 LOCATE 13,19:PRINT "└──╫──┘":LOCATE 13,56:PRINT "└──╫──┘"
3520 FOR J=14 TO 17:LOCATE J,40:PRINT "║":NEXT J
3530 LOCATE 19,33:PRINT "50-72 Ω Feedline"
3540 F$="###.#"
3550 LOCATE 10,19:PRINT USING F$;LT;:PRINT "µH"
3560 LOCATE 10,56:PRINT USING F$;LT;:PRINT "µH"
3570 LOCATE 14,19:PRINT USING F$;CT;:PRINT "pF"
3580 LOCATE 14,56:PRINT USING F$;CT;:PRINT "pF"
3590 F$="###.##"
3600 LOCATE 11,9 :PRINT USING F$;Z3;:PRINT "'"
3610 LOCATE 11,29:PRINT USING F$;Z1;:PRINT "'"
3620 LOCATE 11,46:PRINT USING F$;Z1;:PRINT "'"
3630 LOCATE 11,66:PRINT USING F$;Z3;:PRINT "'"
3640 Y=(Z1-INT(Z1))*12
3650 LOCATE 21,18:PRINT USING F$;Z1;:PRINT "' Inner elements =";
3660 PRINT USING "###";INT(Z1);:PRINT USING "'##.##";Y;:PRINT CHR$(34);
3670 PRINT USING" =###.## m.";Z1*0.30480000376701355!
3680 Y=(Z3-INT(Z3))*12
3690 LOCATE 22,18:PRINT USING F$;Z3;:PRINT "' Outer elements =";
3700 PRINT USING "###";INT(Z3);:PRINT USING "'##.##";Y;:PRINT CHR$(34);
3710 PRINT USING" =###.## m.";Z3*0.30480000376701355!
3720 GOTO 4120   :REM'end
3730 END
3740 :REM'
3750 :REM'.....transmission line subroutine
3760 US=(EXP(A*L)-EXP(-A*L))/2*COS(B*L)
3770 VS=(EXP(A*L)+EXP(-A*L))/2*SIN(B*L)
3780 UC=(EXP(A*L)+EXP(-A*L))/2*COS(B*L)
3790 VC=(EXP(A*L)-EXP(-A*L))/2*SIN(B*L)
3800 C=US-XL*VC/Z0+RL*UC/Z0
3810 D=VS+RL*VC/Z0+XL*UC/Z0
3820 E=UC+RL*US/Z0-XL*VS/Z0
3830 F=VC+RL*VS/Z0+XL*US/Z0
3840 MNN=SQR(C^2+D^2):THETAN=ATN(D/C)
3850 IF C<0 THEN THETAN=THETAN+PI
3860 MND=SQR(E^2+F^2):THETAD=ATN(F/E)
3870 IF E<0 THEN THETAD=THETAD+PI
3880 M=MNN/MND:THETA=THETAN-THETAD
3890 RIN=Z0*COS(THETA)*M:XIN=Z0*SIN(THETA)*M
3900 RETURN
3910 :REM'
3920 :REM'....KA,Z0,XCE,CE subroutine
3930 FOR W=1 TO 10
3940 ZX=983.5700073242188!/FMHZ/4*KA
3950 L=0.005080000031739473!*ZX*12*(LOG(4*12*ZX/DW)-1)
3960 C=7.360000133514404!*ZX/(LOG(2*12*ZX/DW)/LOG(10)-0.5!)
3970 KA=(ZX/SQR(L*C)*1000/983.5700073242188!)
3980 NEXT W
3990 Z0=1000*SQR(L/C):XCE=-Z0*TAN(KA*PI/2):CE=-1000000.0!/2/PI/FMHZ/XCE
4000 RETURN
4010 :REM'
4020 :REM'.....parallel impedance subroutine
4030 MN=SQR((R7*R8-X7*X8)^2+(X8*R7+X7*R8)^2)
4040 THETAN=ATN((X7*R8+X8*R7)/(R7*R8-X7*X8))
4050 IF (R7*R8-X7*X8)<-0.0010000000474974513! THEN THETAN=THETAN+PI
4060 MD=SQR((R7+R8)^2+(X7+X8)^2)
4070 THETAD=ATN((X7+X8)/(R7+R8))
4080 THETA=THETAN-THETAD:M=MN/MD
4090 R9=M*COS(THETA):X9=M*SIN(THETA)
4100 RETURN
4110 :REM'
4120 :REM'.....end
4130 GOSUB 4170
4140 GOTO 120   :REM'start
4150 END
4160 :REM'
4170 :REM'PRT
4180 KEY OFF:GOSUB 4250:LOCATE 25,5:COLOR 0,2
4190 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4200 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4210 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4210 :ELSE GOSUB 4250
4220 IF Z$="3"THEN RETURN
4230 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4240 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4180
4250 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
