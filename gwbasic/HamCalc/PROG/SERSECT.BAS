10 :REM'SERISECT - Series Section Matching Transformer - 31 JAN 94 rev. 07 AUG 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="serisect"
60 COMMON EX$,PROG$,FRQ,ZP   :REM'chained from ocfdipol.bas - off-centre-fed dipole
70 UL$=STRING$(80,205)
80 ER$=STRING$(80,32)
90 U1$="####.###"
100 U2$="####.##"
110 Q$=CHR$(34)
120 UM=0.30480000376701355!:UM$=" metres "
130 PI=3.1415929794311523!
140 DIM C$(52,9)   :REM'coax specs.
150 :REM'
160 :REM'.....start
170 OPEN"I",1,"\hamcalc\coaxfile\coaxial.fil"
180 FOR Z=1 TO 51:FOR Y=1 TO 9
190 INPUT#1,Z$
200 C$(Z,Y)=Z$
210 NEXT Y
220 NEXT Z
230 CLOSE
240 :REM'.....compile transmission line data base
250 FOR Z=1 TO 40
260 C$(Z,2)=C$(Z,5)                     :REM'char.impedance
270 C$(Z,3)=STR$(1/SQR(VAL(C$(Z,3))))   :REM'velocity factor
280 NEXT Z
290 FOR Z=1 TO 4
300 C$(47+Z,1)="Twin Wire":C$(39+Z,2)=STR$(150*Z):C$(39+Z,3)=".97"
310 NEXT Z
320 :REM'
330 :REM'.....start
340 CLS:COLOR 15,2,1
350 PRINT " SERIES-SECTION MATCHING TRANSFORMER";
360 PRINT TAB(57);"by George Murphy VE3ERP ";
370 COLOR 1,0:PRINT STRING$(80,223);
380 COLOR 7,0
390 T=20:GOSUB 2620    :REM'print diagram 1
400 GOSUB 2910   :REM'preface
410 COLOR 0,7
420 LOCATE ,28:PRINT "  Press number in ( ) to:  ":COLOR 7,0
430 PRINT TAB(18)"(1)  RUN program"
440 PRINT TAB(18)"(2)  REVIEW coaxial cable characteristics"
450 PRINT TAB(18)"(0)  EXIT";
460 LOCATE 25,14:COLOR 0,7
470 PRINT " (ref. The ARRL ANTENNA BOOK, 17th edition, p. 26-15) ";:COLOR 7,0
480 Z$=INKEY$:IF Z$=""THEN 480
490 IF Z$="1"THEN 540
500 IF Z$="2"THEN CLS:CHAIN "coaxchar"
510 IF Z$="0"THEN CLS:RUN EX$
520 GOTO 480
530 :REM'
540 :REM'.....select main feed line
550 CLS
560 GOSUB 2240      :REM'print data base
570 LN=CSRLIN
580 COLOR 15,4:LOCATE 23
590 COLOR 15,2
600 :REM'
610 INPUT " ENTER: No. from above table to select type of MAIN FEED LINE ";MF
620 COLOR 7,0
630 IF MF>=1 AND MF<=48 THEN 650
640 BEEP:LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 590
650 MF$=C$(MF,1)        :REM'name of main feed line
660 Z0=VAL(C$(MF,2))    :REM'impedance of main feed line
670 VF1=VAL(C$(MF,3))   :REM'vel.factor of main feed line
680 :REM'
690 :REM'.....select matching section
700 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
710 COLOR 15,4:LOCATE ,32:PRINT " MATCHING SECTION ":COLOR 7,0
720 COLOR 15,2:LOCATE 22
730 PRINT " "+MF$+" was selected for MAIN FEED LINE "
740 COLOR 7,0:LOCATE 23
750 :REM'
760 COLOR 0,7
770 PRINT " Want a (s)ingle line or (p)arallel line matching section? (s/p) "
780 COLOR 7,0
790 L$=INKEY$:IF L$=""THEN 790
800 IF L$="s"OR L$="p"THEN 820
810 GOTO 790
820 COLOR 15,4:LOCATE 23
830 :REM'
840 INPUT " ENTER: No. from above table to select type of MATCHING SECTION ";MS
850 COLOR 7,0
860 IF MS>=1 AND MS<=48 THEN 880
870 BEEP:LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 820
880 MS$=C$(MS,1)       :REM'name of matching section
890 Z1=VAL(C$(MS,2))   :REM'impedance of matching section
900 IF L$="p"THEN Z1=Z1/2
910 VF2=VAL(C$(MS,3))  :REM'vel.factor of matching section
920 :REM'
930 CLS:COLOR 0,7:LOCATE ,27:PRINT " SERIES-SECTION TRANSFORMER "
940 COLOR 7,0:PRINT UL$;
950 :REM'
960 F=0:PRINT " ENTER: Frequency of operation............(MHz)";
970 IF FRQ THEN F=FRQ:PRINT "":GOTO 1000
980 INPUT F
990 IF F=0 THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 960
1000 WFT=984/F          :REM'wavelength in feet
1010 LOCATE CSRLIN-1:PRINT STRING$(7,32)
1020 LOCATE CSRLIN-1,42:PRINT "......";USING U1$;F;:PRINT " MHz"
1030 LN=CSRLIN
1040 IF ZP THEN RL=ZP:PRINT "":GOTO 1080
1050 RL=0:PRINT " ENTER: Antenna load, resistive component......(ohms)";
1060 INPUT RL
1070 IF RL=0 THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 1050
1080 LOCATE CSRLIN-1:PRINT STRING$(7,32)
1090 IF ZP THEN Z$="n":GOTO 1160
1100 COLOR 0,7
1110 PRINT " Is the reactive component (i)nductive, (c)apacitive or (n)il?";
1120 PRINT "   (i/c/n)"
1130 COLOR 7,0:Z$=INKEY$:IF Z$=""THEN 1130
1140 IF Z$="i"THEN X$="inductive component..":XS=+1:XS$="+j":GOTO 1180
1150 IF Z$="c"THEN X$="capacitive component.":XS=-1:XS$="-j":GOTO 1180
1160 IF Z$="n"THEN XS=+1:XS$="-j":XL=0:Z=0:GOTO 1200
1170 VIEW PRINT LN+1 TO 24:CLS:VIEW PRINT:LOCATE LN+1:GOTO 1100
1180 Z=0:PRINT " ENTER: Value of ";X$;".....(ohms)";:INPUT Z
1190 XL=ABS(Z)*XS
1200 ANT$=STR$(RL)+XS$+RIGHT$(STR$(Z),LEN(STR$(Z))-1)+" Ω"
1210 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1220 PRINT "        Impedance of antenna................... ";ANT$
1230 :REM'
1240 PRINT "        Impedance of main feed line............";USING U2$;Z0;
1250 PRINT " Ω ";MF$;:LOCATE ,69:PRINT "Vf= ";USING "#.###";VF1
1260 :REM'
1270 PRINT "        Impedance of matching section..........";USING U2$;Z1;
1280 PRINT " Ω ";MS$;:LOCATE ,69:PRINT "Vf= ";USING "#.###";VF2
1290 :REM'
1300 :REM'.....normalize impedances
1310 N=Z1/Z0
1320 R=RL/Z0
1330 X=XL/Z0
1340 P=SQR(((RL-Z0)^2+XL^2)/((RL+Z0)^2+XL^2))
1350 SWR=(1+P)/(1-P):IF SWR<1 THEN SWR=R
1360 PRINT "        SWR....................................";USING "###.##";SWR;
1370 PRINT ":1"
1380 :REM'
1390 :REM'.....calculation
1400 LOZ=Z0/SQR(SWR)
1410 HIZ=Z0*SQR(SWR)
1420 IF Z1<LOZ OR Z1>HIZ THEN 1590
1430 :REM'
1440 :REM'.....inappropriate impedances
1450 PRINT:BEEP
1460 COLOR 14,4
1470 LOCATE CSRLIN,8
1480 PRINT " Matching section impedance must be either more than";USING U1$;HIZ;
1490 PRINT " Ω  "
1500 LOCATE CSRLIN,8
1510 PRINT "                                        or less than";USING U1$;LOZ;
1520 PRINT " Ω  "
1530 COLOR 7,0
1540 PRINT
1550 PRINT TAB(9);"Press any key to start over........."
1560 IF INKEY$=""THEN 1560
1570 GOTO 160   :REM'start
1580 :REM'
1590 IF RL=Z0 THEN L1=0:L2=0:GOTO 1750
1600 EQ1=(R-1)^2+X^2
1610 EQ2=R*(N-1/N)^2
1620 EQ3=(R-1)^2-X^2
1630 :REM'
1640 B=SQR(EQ1/(EQ2-EQ3))
1650 IF SGN(B)=-1 THEN B=B*-1
1660  L2=ATN(B)*180/PI
1670 EQ4=(N-R/N)*B+X
1680 EQ5=R+X*N*B-1
1690 :REM'
1700 A=EQ4/EQ5
1710  L1=ATN(A)*180/PI
1720  IF SGN(L1)=-1 THEN L1=L1+180
1730 :REM'
1740 W=WFT*VF1:L1FT=L1*W/360
1750 W=WFT*VF2:L2FT=L2*W/360
1760 DIF=LEN(C$(MS,1))-LEN(C$(MF,1))
1770 :REM'
1780 LOCATE CSRLIN,7
1790 PRINT "  Line from antenna to matching section..";USING U1$;L1;
1800 PRINT "° length of ";MF$;
1810 IF SGN(DIF)=1 THEN PRINT STRING$(DIF+1," "):ELSE PRINT " "
1820 :REM'
1830 LOCATE CSRLIN,7
1840 PRINT "  Matching section.......................";USING U1$;L2;
1850 PRINT "° length of ";MS$;
1860 IF SGN(DIF)=-1 THEN PRINT STRING$(ABS(DIF)+1," "):ELSE PRINT " "
1870 PRINT UL$;
1880 :REM'
1890 T=21:LOCATE 11:GOSUB 2730   :REM'print diagram 2
1900 COLOR 0,7
1910 LOCATE 13,T+7:PRINT USING "###.#";Z0;:PRINT " Ω"
1920 LOCATE 17,T+2:PRINT USING "###.#";Z1;:PRINT " Ω"
1930 LOCATE 21,T+7:PRINT USING "###.#";Z0;:PRINT " Ω"
1940 :REM'
1950 COLOR 0,7
1960 LOCATE 13,T+26:PRINT MF$
1970 COLOR 7,0
1980 LOCATE 12,T+42:PRINT "┌";USING " ####.###°";L1
1990 LOCATE 13,T+40:PRINT "«─┤";USING "=####.### m.";L1FT*0.30480000376701355!
2000 LOCATE 14,T+42:PRINT "└";USING "=####.### ft.";L1FT
2010 :REM'
2020 COLOR 0,7
2030 LOCATE 17,T+30:PRINT MS$
2040 IF L$="s"THEN 2090
2050  LOCATE 18,T+22:PRINT "2 in parallel"
2060  LOCATE 16,T+19:PRINT "┌┐"
2070  LOCATE 17,T+19:PRINT "││"
2080  LOCATE 18,T+19:PRINT "└┘"
2090 COLOR 7,0
2100 LOCATE 16,T+42:PRINT "┌";USING " ####.###°";L2
2110 LOCATE 17,T+40:PRINT "«─┤";USING "=####.### m.";L2FT*0.30480000376701355!
2120 LOCATE 18,T+42:PRINT "└";USING "=####.### ft.";L2FT
2130 :REM'
2140 COLOR 0,7
2150 LOCATE 21,T+26:PRINT MF$
2160 COLOR 7,0
2170 LOCATE 24:PRINT UL$;
2180 :REM'
2190 :REM'.....end
2200 GOSUB 3190
2210 GOTO 330   :REM'start
2220 END
2230 :REM'
2240 :REM'.....print coax list
2250 CLS
2260 FOR Z=1 TO 3:PRINT "No.  Type       Zo(Ω) Vf ";
2270 IF Z<3 THEN PRINT "│";
2280 NEXT Z:PRINT ""
2290 :REM'
2300    FOR Z=1 TO 15
2310 IF RIGHT$(C$(Z,1),1)="*" THEN COLOR 4,0 :ELSE COLOR 7,0
2320 Z$=STR$(Z):IF LEN(Z$)<3 THEN Z$=" "+Z$
2330 Z$=RIGHT$(Z$,2)+":":PRINT Z$;
2340 PRINT TAB(4);C$(Z,1);TAB(16);USING "###.#";VAL(C$(Z,2));
2350 PRINT TAB(22);USING ".###";VAL(C$(Z,3));
2360 COLOR 7,0
2370 PRINT TAB(26);"│";
2380 :REM'
2390 IF RIGHT$(C$(Z+15,1),1)="*" THEN COLOR 4,0 :ELSE COLOR 7,0
2400 Z$=STR$(Z+15)
2410 Z$=RIGHT$(Z$,2)+":":PRINT Z$;
2420 PRINT TAB(30);C$(Z+15,1);TAB(42);USING "###.#";VAL(C$(Z+15,2));
2430 PRINT TAB(48)USING ".###";VAL(C$(Z+15,3));
2440 COLOR 7,0
2450 PRINT TAB(52);"│";
2460 IF Z>13 THEN PRINT "":GOTO 2550
2470 :REM'
2480 IF RIGHT$(C$(Z+30,1),1)="*" THEN COLOR 4,0 :ELSE COLOR 7,0
2490 Z$=STR$(Z+30)
2500 Z$=RIGHT$(Z$,2)+":":PRINT Z$;
2510 PRINT TAB(56);C$(Z+30,1);
2520 IF Z+30<40 THEN V$="##.#":ELSE V$="###"
2530 PRINT TAB(69);USING V$;VAL(C$(Z+30,2));
2540 PRINT TAB(74)USING ".###";VAL(C$(Z+30,3))
2550    NEXT Z
2560 :REM'
2570 COLOR 0,7:LOCATE ,10
2580 PRINT " * denotes foam type - DO NOT USE         Vf=Velocity Factor "
2590 COLOR 7,0
2600 RETURN
2610 :REM'
2620 :REM'.....diagram 1
2630 COLOR 0,7
2640 LOCATE ,T:PRINT "             matching section       load "
2650 LOCATE ,T:PRINT "                ┌────────┐          ┌──┐ "
2660 LOCATE ,T:PRINT " ═══════Z0══════╡   Z1   ╞════Z0════╡ZL│ "
2670 LOCATE ,T:PRINT "    main line   └────────┘ main line└──┘ "
2680 LOCATE ,T:PRINT "                │«─ L2 ─»│«── L1 ──»│    "
2690 LOCATE ,T:PRINT "                                         "
2700 COLOR 7,0
2710 RETURN
2720 :REM'
2730 :REM'......diagram 2
2740 COLOR 0,7
2750 LOCATE CSRLIN,T:PRINT "           antenna ┬┬ feed point        "
2760 LOCATE CSRLIN,T:PRINT "                   ││                   "
2770 LOCATE CSRLIN,T:PRINT "               Main││Line:              "
2780 LOCATE CSRLIN,T:PRINT "                   ││                   "
2790 LOCATE CSRLIN,T:PRINT "                  ┌┘└┐                  "
2800 LOCATE CSRLIN,T:PRINT "                  │  │                  "
2810 LOCATE CSRLIN,T:PRINT "          Matching│  │Section:          "
2820 LOCATE CSRLIN,T:PRINT "                  │  │                  "
2830 LOCATE CSRLIN,T:PRINT "                  └┐┌┘                  "
2840 LOCATE CSRLIN,T:PRINT "                   ││                   "
2850 LOCATE CSRLIN,T:PRINT "               Main││Line:              "
2860 LOCATE CSRLIN,T:PRINT "                   ││ (any length)      "
2870 LOCATE CSRLIN,T:PRINT "              from station              "
2880 COLOR 7,0
2890 RETURN
2900 :REM'
2910 :REM'.....preface
2920 TB=8
2930 PRINTTAB(TB);
2940 PRINT "  The series-section transformer has the following advantages over";
2950 PRINT TAB(TB);
2960 PRINT "stub tuning or the ¼-wave transformer:"
2970 PRINT TAB(TB);
2980 PRINT " - The matching section need not be located exactly at the load."
2990 PRINT TAB(TB);
3000 PRINT " - The matching section may be less than ¼-wavelength long."
3010 PRINT TAB(TB);
3020 PRINT " - The matching section can have ANY impedance not too close to"
3030 PRINT TAB(TB);
3040 PRINT "   that of the main line (the program rejects too-close choices)."
3050 PRINT TAB(TB);
3060 PRINT "  The matching section may be a single length of line, or two equal"
3070 PRINT TAB(TB);
3080 PRINT "parallel lengths to provide a net characteristic impedance one-half"
3090 PRINT TAB(TB);
3100 PRINT "that of a single length."
3110 PRINT TAB(TB);
3120 PRINT "  Avoid using foam type cable. Inherent manufacturing limitations"
3130 PRINT TAB(TB);
3140 PRINT "can cause significant variance in electrical properties between"
3150 PRINT TAB(TB);
3160 PRINT "different production runs, and between different manufacturers."
3170 RETURN
3180 :REM'
3190 :REM'PRT
3200 GOSUB 3260:LOCATE 25,18:COLOR 0,2
3210 PRINT " Press #»▌1=Print▌2=Print/Form Feed▌3=Continue";:COLOR 7,0
3220 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3220 :ELSE GOSUB 3260
3230 IF Z$="3"THEN RETURN
3240 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3250 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3200
3260 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
3270 EXT Y:NEXT Z
