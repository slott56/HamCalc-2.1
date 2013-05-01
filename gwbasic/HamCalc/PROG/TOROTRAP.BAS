10 :REM'TOROTRAP - TOROID ANTENNA TRAPS - 28 SEP 96 rev. 20 OCT 2005
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="torotrap"
40 COLOR 7,0,1
50 CLS:KEY OFF
60 COMMON EX$,PROG$,C1,L,X1,FRQ
70 PI=3.1415929794311523!
80 UL$=STRING$(80,205)
90 DIM C(47)
100 DATA 3.3,5,6,6.8,8,10,12,15,18,20,22,24,25,27,30,33,39,47,50,51,56,68,75,
110 DATA 82,100,120,130,150,180,200,220,240,250,270,300,330,360,390,400,430,470,
120 DATA 500,510,560,600,620,680,750,820,910,1000,1200,1500,1800,2000,2500,
130 DATA 2700,3000,3300,3900,4700,5000,5600,6800,8200,10000
140 FOR Z=1 TO 47:READ C(Z):NEXT Z
150 :REM'
160 :REM'.....start
170 CLS:COLOR 15,2
180 PRINT " TOROID ANTENNA TRAPS";TAB(57);"by George Murphy VE3ERP ";
190 COLOR 1,0:PRINT STRING$(80,223);
200 COLOR 7,0
210 IF WIRD<>0 THEN 1170
220 GOSUB 970      :REM'print diagram
230 PRINT UL$;
240 LN=CSRLIN
250 PRINT TAB(7);
260 PRINT "The above sketch shows a trap suitable for powers up to about 50-100"
270 PRINT TAB(7);
280 PRINT "watts, but calculations are also valid for higher power traps of"
290 PRINT TAB(7);
300 PRINT "appropriate construction. C1 and L1 should provide a reactance of"
310 PRINT TAB(7);
320 PRINT "300-450 Ω when tuned to the trap frequency. Any reactance over 100 Ω"
330 PRINT TAB(7);
340 PRINT "will work but bandwidth increases with reactance. The program uses"
350 PRINT TAB(7);
360 PRINT "an optimum reactance of 375 Ω to compute C1 and L1, selects the"
370 PRINT TAB(7);
380 PRINT "nearest standard value capacitor, and recalculates the reactance"
390 PRINT TAB(7);
400 PRINT "provided by this capacitor and L1."
410 COLOR 0,7:LOCATE 24,22
420 PRINT " Press 1 to RUN program or 0 to EXIT ";:COLOR 7,0
430 Z$=INKEY$:IF Z$=""THEN 430
440 IF Z$="0"THEN CLS:RUN EX$
450 IF Z$="1"THEN 470
460 GOTO 430
470 LOCATE 24,6:COLOR 0,7
480 PRINT " Do you want to change optimum reactance from 375 Ω ?   (y/n) ";
490 COLOR 7,0
500 Z$=INKEY$:IF Z$="" THEN 500
510 IF Z$="n"THEN X=375:GOTO 570
520 IF Z$="y"THEN 540
530 GOTO 500
540 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
550 COLOR 0,7:INPUT " ENTER: Optimum reactance..........";X:COLOR 7,0
560 :REM'
570 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
580 INPUT " ENTER: Desired resonant frequency in MHz (max. 30 MHz)......";F
590 IF F>0 AND F<=30 THEN 610
600 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 580
610 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
620 CUF=1/(2*PI*F*X)       :REM'capacitance in µF
630 CPF=CUF*10^6           :REM'capacitance in pF
640  FOR Z=1 TO 47:
650 MEAN=(C(Z)+C(Z-1))/2
660 IF CPF<MEAN THEN 690
670  NEXT Z
680 GOTO 640
690 C=C(Z-1)               :REM'capacitance in pF
700 X=1/(2*PI*F*C*10^-6)   :REM'reactance in ohms
710 L=X/(2*PI*F)           :REM'inductance in µH
720 T$=STR$(F)+" MHz TRAP "
730 LG=INT((80-LEN(T$))/2)
740 LOCATE 3,LG
750 PRINT T$
760 LOCATE 4,LG
770 PRINT STRING$(LEN(T$),"▀")
780 LOCATE LN
790 PRINT " Capacitor ................... C1=";USING "####.#";C;:PRINT " pF ";
800 PRINT "disc ceramic"
810 PRINT " Inductor .................... L1=";USING "####.#";L;:PRINT " µH ";
820 PRINT "toroid"
830 PRINT " Reactance .................... X=";USING "####.#";X;:PRINT " Ω"
840 PRINT " Resonant frequency of trap ... F=";USING "####.###";F;:PRINT " MHz"
850 PRINT UL$;
860 GOSUB 1480
870 LOCATE 25,1:PRINT STRING$(80,32);
880 LOCATE LN+5
890 COLOR 0,7
900 PRINT " Do you want to select a toroid core for L1?    (y/n) "
910 COLOR 7,0
920 Z$=INKEY$
930 IF Z$="n"THEN 160
940 IF Z$="y"THEN CLS:L=INT(L*10+0.5!)/10:FRQ=F:C1=C:X1=X:CHAIN"toroid"
950 GOTO 920
960 :REM'
970 :REM'.....diagram
980 RO=4
990 CO=28
1000 LOCATE RO+5:PRINT " Cut slots in body of pill"
1010 LOCATE RO+6:PRINT " bottle to fit around"
1020 LOCATE RO+7:PRINT " antenna wires and seal"
1030 LOCATE RO+8:PRINT " with silicone."
1040 COLOR 0,7:LOCATE RO+1
1050 LOCATE ,CO:PRINT "    ╔══════════════╗                                "
1060 LOCATE ,CO:PRINT "    ║║            ║║       ┌─ Antenna               "
1070 LOCATE ,CO:PRINT " ────╫──┐      ┌──╫──── «──┘                        "
1080 LOCATE ,CO:PRINT "     ║ ═╪══════╪═«╫──── strain relief               "
1090 LOCATE ,CO:PRINT "     ║  ├──┤├──┤  ║    (plastic overcoat button)    "
1100 LOCATE ,CO:PRINT "     ║  │  C1  │  ║                                 "
1110 LOCATE ,CO:PRINT "     ║  └─∩∩∩∩─┘  ║«─── plastic pill bottle         "
1120 LOCATE ,CO:PRINT "     ║     L1   «─║─ wound on ferrite toroid form   "
1130 LOCATE ,CO:PRINT "     ╚════════════╝                                 "
1140 COLOR 7,0
1150 RETURN
1160 :REM'
1170 :REM'.....re-display
1180 COLOR 0,7:LOCATE 3
1190 LOCATE ,32:PRINT "                  "
1200 LOCATE ,32:PRINT "        L1        "
1210 LOCATE ,32:PRINT " ────┬─∩∩∩∩─┬──── "
1220 LOCATE ,32:PRINT "     │      │     "
1230 LOCATE ,32:PRINT "     └──┤├──┘     "
1240 LOCATE ,32:PRINT "        C1        "
1250 LOCATE ,32:PRINT "                  "
1260 COLOR 7,0
1270 PRINT
1280 C=C1:X=X1:F=FRQ
1290 PRINT " Capacitor ................... C1=";USING "####.#";C;:PRINT " pF ";
1300 PRINT "silver-mica"
1310 PRINT " Inductor .................... L1=";USING "####.#";L;:PRINT " µH ";
1320 PRINT "toroid"
1330 PRINT " Reactance .................... X=";USING "####.#";X;:PRINT " Ω"
1340 PRINT " Resonant frequency of trap ... F=";USING "####.###";F;:PRINT " MHz"
1350 PRINT " Amidon or Palomar toroid core....";"     ";"T-"+CAT$;
1360 PRINT " Mix #";MX
1370 PRINT " Wire diameter....................";USING "####.#";WIRD*25.399999618530273!;
1380 PRINT " mm  (";USING" .###";WIRD;:PRINT " in.)"
1390 PRINT " No. of turns.....................";USING "####.#";NT
1400 PRINT " Turns capacity of this core......";USING "####.#";MAX
1410 IF NT<MAX THEN 1460
1420 PRINT :COLOR 0,7
1430 PRINT " No. of turns required exceeds capacity of the core. "
1440 PRINT " Select a larger core or smaller wire size . . . . . "
1450 COLOR 7,0
1460 GOSUB 1480:WIRD=0:GOTO 160
1470 :REM'
1480 :REM'PRT
1490 KEY OFF:GOSUB 1560:LOCATE 25,5:COLOR 0,2
1500 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1510 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1520 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1520 :ELSE GOSUB 1560
1530 IF Z$="3"THEN RETURN
1540 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1550 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1490
1560 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
