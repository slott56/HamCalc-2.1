10 :REM'STAIRS - 9 SEP 86 rev. 23 MAR 2000
20 CLS:KEY OFF
30 COLOR 7,0,4
40 IF EX$=""THEN EX$="EXIT"
50 E$=STRING$(80,32)
60 U$=STRING$(80,205)
70 UL$=" "+STRING$(27,205)
80 F1$="####"
90 F2$="####.##"
100 PI=3.1415929794311523!
110 :REM'
120 :REM'.....start
130 CLS
140 T$=" STAIRS, LADDERS & RAMPS "
150 COLOR 11,1:PRINT T$;TAB(61);"by George C. Murphy ";
160 COLOR 4,0
170 PRINT STRING$(80,"▀");
180 COLOR 7,0
190 PRINT " Press number in < > to choose standard units of measure:"
200 PRINT U$;
210 PRINT "   < 1 >  Metric"
220 PRINT "   < 2 >  U.S.A./Imperial"
230 PRINT "     or"
240 PRINT "   < 0 >  to EXIT"
250 Z$=INKEY$
260 IF Z$="1"THEN UM=2.5399999618530273!:UM$="cm.":GOTO 310
270 IF Z$="2"THEN UM=1:UM$="in.":GOTO 310
280 IF Z$="0"THEN CHAIN"mechmenu"
290 GOTO 250
300 :REM'
310 :REM'.....start
320 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
330 RO=3:CO=23:GOSUB 2320     :REM'step dimension diagram
340 LOCATE 12,1
350 PRINT " ENTER: Level-to-Level height HT (";UM$;")............";
360 INPUT H:H=H/UM
370 IF H=0 THEN LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 350
380 LN=CSRLIN
390 PRINT " Has a maximum allowable spread SP been determined?   (y/n)"
400 Z$=INKEY$:IF Z$=""THEN 400
410 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
420 IF Z$="n"THEN 890
430 IF Z$="y"THEN 450
440 GOTO 400
450 VIEW PRINT LN TO 24:CLS:LOCATE LN
460 PRINT " ENTER: Maximum allowable spread SP (";UM$;").........";
470 INPUT L:L=L/UM
480 IF L=0 THEN 770
490 A=ATN(H/L)
500 IF A*180/PI>=20.450000762939453! THEN 640
510 :REM'
520 :REM'.....calculation for step ramp
530 N=INT(H/5)           :REM'no.of risers
540 IF N<=1 THEN 600
550 P=N-1                :REM'no.of treads
560 R=H/N
570 T=L/P                :REM'run
580 GOTO 1190
590 :REM'
600 :REM'.....calculation for inclined ramp
610 P=0:R=0:T=0
620 GOTO 1190
630 :REM'
640 :REM'.....calculation for restricted length
650 N=N+1                :REM'number of risers
660 R=H/N                :REM'rise
670 T=20-(4*R/3)
680 IF ((T*N-T)<=L) AND (R>=5) THEN 650
690 :REM'
700 N=N-1:P=N-1:R=H/N:T=20-(4*R/3)
710 IF R>13.5! THEN A=PI/2
720 IF T<=0 THEN A=PI/2
730 L=P*T
740 IF A=PI/2 THEN 770   :REM'vertical ladder
750 IF A>=0 THEN 1190     :REM'angle <90°
760 :REM'
770 :REM'.....vertical ladder
780 P=CINT(H/13.5!)       :REM'no. of rungs
790 N=P-1                :REM'no.of full risers
800 TBR=(H-N*13.5!)/2     :REM'top and bottom risers
810 A=PI/2               :REM'angle
820 T=0                  :REM'run
830 R=13.5!               :REM'rise
840 X=0                  :REM'string
850 Y=0                  :REM'stringer
860 L=0                  :REM'length
870 GOTO 1180
880 :REM'
890 COLOR 0,7
900 IF UM=1 THEN Q$="7.5 in.( 8.0 in.":GOTO 920
910 Q$="19 cm.( 20 cm."
920 PRINT " Recommended maximum rise = ";Q$;" for economy ";
930 PRINT "residential.)"
940 COLOR 7,0
950 PRINT " ENTER: Maximum rise desired (";UM$;")................";
960 INPUT MAX:MAX=MAX/UM
970 IF UM=1 THEN MIN$="5 in.":MAX$="13.5 in.":ELSE MIN$="12.5 cm.":MAX$="34 cm."
980 IF MAX>=5 AND MAX<= 13.5! THEN 1050
990 IF MAX<5 THEN PRINT " Minimum riser = ";MIN$;" - ";:GOTO 1010
1000 IF MAX>13.5! THEN PRINT " Maximum riser = ";MAX$;
1010 PRINT " - Press any key to continue......"
1020 IF INKEY$=""THEN 1020
1030 GOSUB 2180:LOCATE CSRLIN-2:GOTO 890
1040 :REM'
1050 :REM'.....calculation for unrestricted length
1060 R=MAX
1070 N=CINT(H/R)          :REM'number of risers
1080 P=N-1                :REM'number of treads
1090 R=H/N:IF R<5 THEN N=N-1:P=N-1:GOTO 1090
1100 IF R>MAX THEN N=N+1:P=N-1:R=H/N
1110 T=20-4*R/3           :REM'run
1120 L=P*T                :REM'length
1130 :REM'
1140 A=ATN(R/T)           :REM'angle in radians
1150 AD=A*180/PI          :REM'angle in degrees
1160 IF(AD<33)AND(AD>=17.350000381469727!)THEN T=25+(33-AD)/15.649999618530273!-2*R  :REM'stairs with low pitch
1170 GOTO 1190
1180 :REM'
1190 :REM'.....determine type
1200 AD=A*180/PI       :REM'angle in degrees
1210 IF P=0 THEN B$=" INCLINED RAMP ":GOSUB 2210:GOSUB 3100:GOTO 1320
1220 IF AD=90 THEN B$=" VERTICAL LADDER ":TR$="rungs.":GOSUB 2210:GOSUB 2840:GOTO 1320
1230 :REM'
1240 IF AD>77 THEN B$=" INCLINED LADDER ":TR$="rungs.":GOSUB 2210:GOSUB 2730:GOTO 1320
1250 :REM'
1260 IF AD>48.369998931884766! THEN B$=" OPEN-RISER STEPLADDER ":TR$="steps.":GOSUB 2210:GOSUB 2590:GOTO 1320
1270 :REM'
1280 IF AD>20.450000762939453! THEN B$=" STAIRWAY ":TR$="treads":GOSUB 2210:GOSUB 2460:GOTO 1320
1290 :REM'
1300 IF AD<=20.450000762939453! THEN B$=" STEP RAMP ":TR$="ramps.":GOSUB 2210:GOSUB 2980:GOTO 1320
1310 :REM'
1320 :REM'.....screen display
1330 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 10
1340 LOCATE CSRLIN,INT(80-LEN(B$))/2
1350 COLOR 15,1:PRINT B$
1360 IF B$="RAMP"THEN 1620
1370 COLOR 7,0
1380 IF B$<>" STAIRWAY " AND B$<>" OPEN-RISER STEPLADDER " THEN 1560
1390 PRINT " Do you want to know stairwell SW and headroom HR dimensions?";
1400 COLOR 0,7:PRINT "   (y/n) ":COLOR 7,0
1410 Z$=INKEY$:IF Z$=""THEN 1410
1420 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
1430 IF Z$="y"THEN 1460
1440 IF Z$="n"THEN 1560
1450 GOTO 1410
1460 PRINT " ENTER: Floor thickness FL (";UM$;").................=";
1470 INPUT F:F=F/UM
1480 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
1490 FOR Z=1 TO N
1500 HR=Z*R-F
1510 IF HR>=75 THEN 1530
1520 NEXT Z
1530 X=N-Z    :REM'number of runs
1540 SW=(Z-1)*T
1550 :REM'
1560 I$=" "+UM$
1570 TB=20      :REM'tab
1580 IF P=0 THEN 1620     :REM'inclined ramp
1590 PRINT TAB(TB);"Number of ";TR$;"..............";USING F1$;P
1600 IF AD=90 THEN 1770
1610 PRINT TAB(TB);"Number of risers..............";USING F1$;N
1620 PRINT TAB(TB);"Pitch Angle...............cdb=";USING F2$;AD;:PRINT "°"
1630 IF P=0 THEN 1750
1640 IF B$="RAMP"THEN 1890
1650 PRINT TAB(TB);"Run........................cd=";USING F2$;T*UM;:PRINT I$;
1660 J=T:GOSUB 3220
1670 PRINT TAB(TB);"Rise.......................bc=";USING F2$;R*UM;:PRINT I$;
1680 J=R:GOSUB 3220
1690 X=SQR(R^2+T^2)
1700 PRINT TAB(TB);"String.....................bd=";USING F2$;X*UM;:PRINT I$;
1710 J=X:GOSUB 3220
1720 Y=X*P
1730 PRINT TAB(TB);"Stringer length............ae=";USING F2$;Y*UM;:PRINT I$;
1740 J=Y:GOSUB 3220
1750 PRINT TAB(TB);"Spread.....................SP=";USING F2$;L*UM;:PRINT I$;
1760 J=L:GOSUB 3220
1770 PRINT TAB(TB);"Height.....................HT=";USING F2$;H*UM;:PRINT I$;
1780 J=H:GOSUB 3220
1790 IF F*HR=0 THEN 1860
1800 PRINT TAB(TB);"Floor thickness............FL=";USING F2$;F*UM;:PRINT I$;
1810 J=F:GOSUB 3220
1820 PRINT TAB(TB);"Headroom clearance.........HR=";USING F2$;HR*UM;:PRINT I$;
1830 J=HR:GOSUB 3220
1840 PRINT TAB(TB);"Stairwell minimum length...SW=";USING F2$;SW*UM;:PRINT I$;
1850 J=SW:GOSUB 3220
1860 IF AD=90 THEN 1960
1870 IF P=0 THEN 2040
1880 :REM'.....calculate handrails height
1890 IF A<=90 THEN B=34+(A-48.400001525878906!)/41.599998474121094!*14
1900 IF A<=48 THEN B=33+(A-39.20000076293945!)/9.199999809265137!
1910 IF A<=39.20000076293945! THEN B=33
1920 IF A<=24 THEN B=33+(24-A)/8
1930 PRINT TAB(TB);"Handrail height above nosing..";USING F2$;B*UM;:PRINT I$;
1940 J=B:GOSUB 3220
1950 GOTO 2040
1960 PRINT TAB(TB);"Bottom to lowest rung.......B=";USING F2$;TBR*UM;:PRINT I$;
1970 J=TBR:GOSUB 3220
1980 IF P=1 THEN 2010
1990 PRINT TAB(TB);"Rise.......................bc=";USING F2$;R*UM;:PRINT I$;
2000 J=R:GOSUB 3220
2010 PRINT TAB(TB);"Top to highest rung.........T=";USING F2$;TBR*UM;:PRINT I$;
2020 J=TBR:GOSUB 3220
2030 :REM'
2040 IF B$<>" STAIRWAY " THEN 2150
2050 IF R<=7.5! THEN 2150
2060 IF R>8 THEN 2080
2070 IF R>7.5! THEN 2110
2080 J$="20 cm.":IF UM=1 THEN J$="8 in."
2090 COLOR 12,0:PRINT " NOTE: Rises in excess of ";J$;" are not permitted ";
2100 PRINT "by most building codes.";:GOTO 2150
2110 Z$="19 cm.":IF UM=1 THEN Z$="7½ in."
2120 COLOR 12,0:PRINT " NOTE: Rises over ";Z$;" tend to result in ";
2130 PRINT "steep uncomfortable stairways.";:GOTO 2150
2140 :REM'
2150 COLOR 7,0:GOSUB 3480:GOTO 120
2160 END
2170 :REM'
2180 FOR I=CSRLIN-2 TO CSRLIN-1:LOCATE I:PRINT STRING$(80,32):NEXT I
2190 LOCATE CSRLIN-2:RETURN
2200 :REM'
2210 :REM'.....animate diagram
2220 CLS
2230 RO=2:CO=24
2240 GOSUB 2320
2250 PRINT E$;
2260 FOR Z=24 TO 46
2270 RO=2:CO=Z
2280 GOSUB 2320
2290 NEXT Z
2300 RETURN
2310 :REM'
2320 :REM'.....diagram
2330 REM     RO=row
2340 REM     CO=column
2350 LOCATE RO+0,CO:PRINT " FL    │«─────── SP ──────»│"
2360 LOCATE RO+1,CO:PRINT "  ├»═══╪═══╗«──── SW ─────»╔══ «┐"
2370 LOCATE RO+2,CO:PRINT " ┌┴»═══╪═══╝           ╔═══╝e   │"
2380 LOCATE RO+3,CO:PRINT " │     │           ╔═══╝        │"
2390 LOCATE RO+4,CO:PRINT " HR    │       ╔═══╝           HT"
2400 LOCATE RO+5,CO:PRINT " └─────┼» c╔═══╝d    BASIC      │"
2410 LOCATE RO+6,CO:PRINT "       ╔═══╝b       ELEMENTS    │"
2420 LOCATE RO+7,CO:PRINT "    ═══╝a «─────────────────────┘"
2430 LOCATE RO+8:PRINT U$;
2440 RETURN
2450 :REM'
2460 :REM'.....stairway diagram
2470 RO=2  :REM'row
2480 CO=8  :REM'column
2490  LOCATE RO+0,CO:PRINT "         │«── Run ──»│"
2500  LOCATE RO+1,CO:PRINT "     ┌───┼──────────»╔════"
2510  LOCATE RO+2,CO:PRINT "     │   │           ╚═╦══ «─┐"
2520  LOCATE RO+3,CO:PRINT "   Rise  │     Riser──»║     │"
2530  LOCATE RO+4,CO:PRINT "     │   │ Tread─┐     ║   Rise"
2540  LOCATE RO+5,CO:PRINT "     └──»╔═══════╪═════╣"
2550  LOCATE RO+6,CO:PRINT "         ╚═╦═══════════╝ «───┘"
2560  LOCATE RO+7,CO:PRINT "Nosing──»│ │«── Run ──»│"
2570  RETURN
2580 :REM'
2590 :REM'.....stepladder diagram
2600 RO=2  :REM'row
2610 CO=5  :REM'column
2620 D$="3"+CHR$(34)+"- 5"+CHR$(34)
2630  LOCATE RO+0,CO:PRINT "      ──»│ Run │«── "
2640  LOCATE RO+1,CO:PRINT "         │     ╔══════╗«─┐"
2650  LOCATE RO+2,CO:PRINT "         │     ╚════╪═╝  │"
2660  LOCATE RO+3,CO:PRINT "         │     Step─┘  Rise"
2670  LOCATE RO+4,CO:PRINT "         │ ┌─Step        │"
2680  LOCATE RO+5,CO:PRINT "Nosing──»╔═╪════╗«───────┘"
2690  LOCATE RO+6,CO:PRINT "         ╚══════╝"
2700  LOCATE RO+7,CO:PRINT "      ──»│      │«──";D$
2710  RETURN
2720 :REM'
2730 :REM'.....inclined ladder diagram
2740 RO=2  :REM'row
2750 CO=10 :REM'column
2760  LOCATE RO+0,CO:PRINT "   ──»│ Run │«──"
2770  LOCATE RO+1,CO:PRINT "  ┌───┼───» ▄ «──Rung"
2780  LOCATE RO+2,CO:PRINT "  │   │"
2790  LOCATE RO+3,CO:PRINT "Rise  │"
2800  LOCATE RO+4,CO:PRINT "  │   │"
2810  LOCATE RO+5,CO:PRINT "  └─» ▄ «── Rung"
2820 RETURN
2830 :REM'
2840 RO=1  :REM'row
2850 CO=10 :REM'column
2860 REM     CO=column
2870 LOCATE RO+0,CO:PRINT "  ┌─────» ┌─»┌─┐ Top"
2880 LOCATE RO+1,CO:PRINT "  │      T└─»│▄│"
2890 LOCATE RO+2,CO:PRINT "  │          │ │"
2900 LOCATE RO+3,CO:PRINT "  │       ┌─»│▄│"
2910 LOCATE RO+4,CO:PRINT " HT     Rise │ │"
2920 LOCATE RO+5,CO:PRINT "  │       └─»│▄│«─Rungs"
2930 LOCATE RO+6,CO:PRINT "  │          │ │"
2940 LOCATE RO+7,CO:PRINT "  │      B┌─»│▄│"
2950 LOCATE RO+8,CO:PRINT "  └─────» └─»└─┘ Bottom"
2960 RETURN
2970 :REM'
2980 :REM'.....step ramp diagram
2990 RO=2
3000 CO=7
3010 LOCATE RO+1,CO:PRINT "  │«──────── SP ─────────»│"
3020 LOCATE RO+2,CO:PRINT "  │                       │"
3030 LOCATE RO+3,CO:PRINT "  │       │«─Run─»│       ╔═ «─┐"
3040 LOCATE RO+4,CO:PRINT "  │Rise┌──┼──────»╔═══════╝    │"
3050 LOCATE RO+5,CO:PRINT "  │    └─»╔══╤════╝            HT"
3060 LOCATE RO+6,CO:PRINT "  ╔═══════╝  └──Ramp           │"
3070 LOCATE RO+7,CO:PRINT " ═╝ «──────────────────────────┘"
3080 RETURN
3090 :REM'
3100 :REM'.....inclined ramp diagram
3110 RO=3  :REM'row
3120 CO=10 :REM'column
3130 LOCATE RO+0,CO:PRINT "      │«───── SP ─────»│"
3140 LOCATE RO+1,CO:PRINT "      │                │"
3150 LOCATE RO+2,CO:PRINT "  ┌───┼──────────────» ▄"
3160 LOCATE RO+3,CO:PRINT " HT   │                C"
3170 LOCATE RO+4,CO:PRINT "  └─» ▄................."
3180 LOCATE RO+5,CO:PRINT "      A                B"
3190 LOCATE RO+6,CO:PRINT "Inclined ramp between A & C"
3200 RETURN
3210 :REM'
3220 :REM'.....convert decimal to fraction
3230 II=J                :REM'dimension in decimal inches
3240 FT=0                :REM'set feet to 0
3250 IF II>12 THEN FT=INT(II/12):II=II-FT*12
3260 IN=INT(II)          :REM'whole inches
3270 FR=II-IN            :REM'decimal part of inch
3280 :REM'.....calculate fraction
3290 DD=64               :REM'denominator
3300 EE=FR*DD            :REM'enumerator
3310 IF EE=0 THEN DD=0:GOTO 3360
3320 EE=CINT(EE/2):DD=DD/2
3330 IF EE=0 THEN DD=0:GOTO 3360
3340 IF EE/2=INT(EE/2)THEN 3320
3350 :REM'
3360 IF EE=1 AND DD=1 THEN IN=IN+1:EE=0:DD=0
3370 IF IN=12 THEN FT=FT+1:IN=0
3380 IN$=STR$(IN)
3390 FT$=STR$(FT)
3400 E$=STR$(EE)
3410 D$=STR$(DD):D$=RIGHT$(D$,LEN(D$)-1)
3420 PRINT "  (";FT$;"'-";IN$;
3430 IF EE=0 THEN 3450
3440 PRINT E$;"/";D$;
3450 PRINT CHR$(34);")"
3460 RETURN
3470 :REM'
3480 :REM'PRT
3490 KEY OFF:GOSUB 3560:LOCATE 25,5:COLOR 0,2
3500 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3510 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3520 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3520 :ELSE GOSUB 3560
3530 IF Z$="3"THEN RETURN
3540 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3550 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3490
3560 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
