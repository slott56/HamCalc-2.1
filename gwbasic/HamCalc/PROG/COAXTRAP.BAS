10 :REM'COAXTRAP - Antenna Trap Design - 31 JAN 94 rev. 29 AUG 09
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 UL$=STRING$(80,205)
50 ER$=STRING$(80,32)
60 U$="####.###"
70 V$="####.##"
80 Q$=CHR$(34)
90 PI=3.1415929794311523!
100 LF=1/LOG(10)  :REM'log conversion to base 10
110 DIM C$(42,9)   :REM'coax specs.
120 :REM'
130 :REM'.....start
140 COLOR 7,0,0
150 CLS
160 OPEN"I",1,"\hamcalc\coaxfile\coaxial.fil"
170 FOR Z=1 TO 42:FOR Y=1 TO 9
180 INPUT#1,Z$
190 C$(Z,Y)=Z$
200 NEXT Y:
210 NEXT Z
220 CLOSE
230 FOR Y=1 TO 42
240 E=VAL(C$(Y,3))         :REM'dielectric constant
250 Z=VAL(C$(Y,5))         :REM'characteristic impedance
260 D=10^(Z*SQR(E)/138)
270 C=7.260000228881836!*E/(LOG(D)*LF)   :REM'µF/ft.
280 C$(Y,2)=STR$(C)
290 C$(Y,3)=C$(Y,4)
300 NEXT Y
310 :REM'
320 COLOR 15,2
330 PRINT " COAXIAL CABLE TRAPS FOR MULTI-BAND ANTENNAS";
340 PRINT TAB(57);"by George Murphy VE3ERP ";
350 COLOR 1,0:PRINT STRING$(80,223);
360 COLOR 7,0
370 :REM'
380 :REM'.....text
390 PRINT TAB(7);
400 PRINT "This program is an adaptation of a program by Larry East W1HUE as ";
410 PRINT TAB(7);
420 PRINT "it appears in the ARRL Antenna Compendium, Volume 2, page 100."
430 PRINT
440 PRINT TAB(7);
450 PRINT "The program will calculate the turns required for an antenna trap"
460 PRINT TAB(7);
470 PRINT "made from coaxial cable. It also calculates and displays Inductive"
480 PRINT TAB(7);
490 PRINT "Reactance (XL), Capacitive Reactance (XC), Inductance (L), and"
500 PRINT TAB(7);
510 PRINT "Capacitance (C) values. Inputs required are coax type, coil form"
520 PRINT TAB(7);
530 PRINT "diameter and trap frequency."
540 PRINT
550 PRINT TAB(7);
560 PRINT "Cutting and trimming dimensions for the coax are also included."
570 PRINT
580 :REM'
590 :REM'.....diagram
600 T=12     :REM'tab
610 COLOR 0,7
620 LOCATE ,T:PRINT "                                                         "
630 LOCATE ,T:PRINT "       coaxial cable before winding into a coil ─┐       "
640 LOCATE ,T:PRINT "                                                 │       "
650 LOCATE ,T:PRINT " in »───────┐                                    │       "
660 LOCATE ,T:PRINT "           ╒╧═════════════shield══════════════╕«─┘       "
670 LOCATE ,T:PRINT "         ┌────────────inner conductor──────────────» out "
680 LOCATE ,T:PRINT "         │ ╘══════════════shield═════════════╤╛          "
690 LOCATE ,T:PRINT "         └───────────────────────────────────┘           "
700 LOCATE ,T:PRINT "                                                         "
710 COLOR 0,7:LOCATE 25,22
720 PRINT " Press 1 to continue or 0 to EXIT.....";
730 COLOR 7,0
740 Z$=INKEY$:IF Z$=""THEN 740
750 IF Z$="0"THEN CLS:RUN EX$
760 IF Z$="1"THEN 780
770 GOTO 740
780 GOSUB 2420
790 :REM'
800 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
810 PRINT " Press number in < > to choose standard units of measure:"
820 PRINT UL$;
830 PRINT "   < 1 >  Metric"
840 PRINT "   < 2 >  U.S.A./Imperial"
850 K$=INKEY$
860 IF K$="1"THEN UM=25.399999618530273!:UM$="mm.":GOTO 900
870 IF K$="2"THEN UM=1:UM$="in.":GOTO 900
880 GOTO 850
890 :REM'
900 :REM'.....print coax list
910 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
920 IF UM=1 THEN M$="ft.":ELSE M$="m. "
930 PRINT " No. Type       pF/";M$;" OD│";
940 PRINT " No. Type       pF/";M$;" OD │";
950 PRINT " No. Type      pF/";M$;" OD"
960 PRINT UL$;
970 LOCATE CSRLIN-1,26:PRINT "╪":LOCATE CSRLIN-1,53:PRINT "╪"
980 IF UM=1 THEN CL=1:D$=".###":ELSE CL=0.30480000376701355!:D$="##.#"
990 FOR Z=1 TO 14
1000 Z$=STR$(Z):Z$=RIGHT$(Z$,LEN(Z$)-1)
1010 IF LEN(Z$)<2 THEN Z$=" "+Z$
1020 PRINT Z$;":";
1030 PRINT TAB(4);C$(Z,1);TAB(17);USING "###.#";VAL(C$(Z,2))/CL;
1040 PRINT TAB(22);USING D$;VAL(C$(Z,3))*UM;
1050 PRINT TAB(26);"│"+RIGHT$(STR$(Z+14),2)+":";
1060 PRINT TAB(30);C$(Z+14,1);TAB(43);USING "###.#";VAL(C$(Z+14,2))/CL;
1070 PRINT TAB(49)USING D$;VAL(C$(Z+14,3))*UM;
1080 PRINT TAB(53);"│";
1090 IF Z>12 THEN PRINT "":GOTO 1150
1100 PRINT RIGHT$(STR$(Z+28),2)+":";
1110 PRINT TAB(57);C$(Z+28,1);TAB(69);USING "###.#";VAL(C$(Z+28,2))/CL;
1120 J=VAL(C$(Z+28,3))*UM:J$=D$
1130 IF J>1 AND UM=1 THEN J$="#.##":ELSE J$=D$
1140 PRINT TAB(75)USING J$;J
1150 NEXT Z
1160 PRINT UL$;
1170 LOCATE CSRLIN-1,26:PRINT "╧":LOCATE CSRLIN-1,53:PRINT "╧"
1180 IF UM=1 THEN M$="inches":ELSE M$="millimetres"
1190 PRINT " * denotes foam dielectric.      OD dimensions are in ";M$;"."
1200 PRINT UL$;
1210 :REM'
1220 :REM'.....select type of coax
1230 INPUT " ENTER: No. from above table to select type of coaxial cable";COAX
1240 IF COAX>=1 AND COAX <=40 THEN 1270
1250 BEEP:LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 1230
1260 :REM'
1270 :REM'.....display coax specs.
1280 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1290 T=10      :REM'tab
1300 COLOR 7,0
1310 :REM'
1320 INPUT "  ENTER: Resonant frequency in MHz ";F
1330 IF F=0 THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 1320
1340 W=300/F
1350 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
1360 COLOR 15,1:LOCATE CSRLIN,T-1
1370 PRINT " RESONANT FREQUENCY........... ";USING U$;F;
1380 PRINT " MHz (";USING "###.###";W;:PRINT " metres ) "
1390 RAD=2*PI*F
1400 COLOR 15,3:LOCATE CSRLIN,T-1
1410 PRINT TAB(T-1);" Coaxial cable type........... ";C$(COAX,1);" "
1420 IF RIGHT$(C$(COAX,1),1)<>")"THEN 1440
1430 LOCATE CSRLIN-1,T+34:PRINT " (foam dielectric)"
1440 COLOR 7,0
1450 CD=VAL(C$(COAX,3))     :REM'coax diameter
1460 IF UM=1 THEN M$=U$ :ELSE M$=V$
1470 PRINT TAB(T);"Coaxial cable diameter....... ";USING M$;CD*UM;
1480 PRINT " ";UM$
1490 CN=VAL(C$(COAX,8))     :REM'centre conductor diameter
1500 PRINT TAB(T);"Centre conductor diameter.... ";USING M$;CN*UM;
1510 PRINT " ";UM$
1520 CC=VAL(C$(COAX,2))     :REM'coax capacitance per foot
1530 IF UM=1 THEN CCC=CC:M$="ft.":ELSE CCC=CC/0.30480000376701355!:M$="m."
1540 PRINT TAB(T);"Coaxial cable capacitance.... ";USING U$;CCC;
1550 PRINT " pF/";M$
1560 CC=CC/12               :REM'capacitance per inch
1570 :REM'
1580 PRINT "  NOTE:  Form radius must not exceed cablw minimum bending radius!"
1590 PRINT "  ENTER: Coil form diameter (";UM$;").....";:INPUT D:D=D/UM
1600 IF D=0 THEN LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1:GOTO 1590
1610 A=D+CD                 :REM'mean winding diameter
1620 A18=18*A
1630 C40=40*CD
1640 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
1650 COLOR 15,3:LOCATE CSRLIN,T-1
1660 IF UM=1 THEN M$=U$ :ELSE M$=V$
1670 PRINT " Coil form diameter........... ";USING M$;D*UM;
1680 PRINT " ";UM$
1690 COLOR 7,0
1700 :REM'
1710 :REM'.....initial estimate of N
1720 N0=INT((570/F)*SQR(CD/(A^3*CC))+0.5!)
1730 :REM'
1740 :REM'.....first calculation loop
1750 FOR N=N0 TO N0+20 STEP 0.009999999776482582!
1760  L=A^2*N^2/(A18+C40*N)
1770  XL=RAD*L
1780  C=(A*PI*N+1)*CC
1790  XC=10^6/(RAD*C)
1800   IF XL>= XC THEN 1830
1810 NEXT N
1820 :REM'
1830 :REM'.....second calculation loop
1840 FOR N1=(N-0.5!)TO(N+0.5!) STEP 0.0010000000474974513!
1850  L=A^2*N1^2/(A18+C40*N1)
1860  XL=RAD*L
1870  C=(A*PI*N1+1)*CC
1880  XC=10^6/(RAD*C)
1890   IF XL>= XC THEN 1920
1900 NEXT N1
1910 :REM'
1920 :REM'.....display results
1930 PRINT TAB(T);"Capacitive reactance (XC).....";USING U$;XC;:PRINT " Ω"
1940 PRINT TAB(T);"Inductive reactance (XL)......";USING U$;XL;:PRINT " Ω"
1950 PRINT TAB(T);"Inductance (L)............... ";USING U$;L;:PRINT " µH"
1960 PRINT TAB(T);"Capacitance (C).............. ";USING U$;C;:PRINT " pF"
1970 COLOR 15,3:LOCATE CSRLIN,T-1
1980 PRINT " Number of turns.............. ";USING U$;N1;:PRINT " "
1990 COLOR 7,0
2000 W=INT((N1+0.5!)*CD*100+0.5!)/100
2010 IF UM=1 THEN M$=U$ :ELSE M$=V$
2020 IF UM=25.399999618530273! THEN UM=2.5399999618530273!:UM$="cm."
2030 PRINT TAB(T);"Length of close-wound coil... ";USING M$;W*UM;:PRINT " ";UM$
2040 RA=W/A
2050 IF RA<0.4000000059604645! OR RA>2 THEN COLOR 14,0 :ELSE COLOR 0,7
2060 LOCATE ,T-1
2070 PRINT TAB(T);"Length-to-diameter ratio..... ";USING U$;RA;
2080 PRINT ":1  (see note below)"
2090 COLOR 7,0
2100 SL=INT(A*PI*N1*100+0.5!)/100  :REM'shield length
2110 CL=SL+W+1
2120 PRINT TAB(T);"Length of untrimmed coax..... ";USING M$;CL*UM;:PRINT " ";UM$
2130 PRINT TAB(T);"Trimmed shield length........ ";USING M$;SL*UM;:PRINT " ";UM$
2140 IE=W+0.5!
2150 PRINT TAB(T);"Inner conductor, ";Q$;"in";Q$;" end.... ";USING M$;IE*UM;
2160 PRINT " ";UM$;" projecting"
2170 OE=CL-SL-IE
2180 PRINT TAB(T);"Inner conductor, ";Q$;"out";Q$;" end... ";USING M$;OE*UM;
2190 PRINT " ";UM$;" projecting"
2200 EL=SL*0.8799999952316284!+1
2210 PRINT TAB(T);"Effective Length............. ";USING M$;EL*UM;:PRINT " ";UM$
2220 IF RA>2 OR RA<0.4000000059604645! THEN COLOR 14,0 :ELSE COLOR 0,7
2230 PRINT " The length-to-diameter ratio should be between 0.4:1 and 2:1."
2240 COLOR 7,0
2250 IF RA>=0.4000000059604645! AND RA<=2 THEN PRINT "":GOTO 2280
2260 IF RA>2 THEN RA$="larger":ELSE RA$="smaller"
2270 COLOR 14,0:PRINT " Try a ";RA$;" coil form."
2280 COLOR 7,0
2290 PRINT " The Effective Length is the estimated amount that the next-lower-";
2300 PRINT "frequency leg"
2310 PRINT " of the trap antenna must be shortened to obtain resonance.";
2320 GOSUB 2420
2330 LOCATE 25,14:COLOR 15,2
2340 PRINT " Do you want to do another calculation?........(y/n) ";
2350 COLOR 7,0
2360 Z$=INKEY$
2370 IF Z$="n"THEN 130
2380 IF Z$="y"THEN 860
2390 GOTO 2360
2400 GOTO 130   :REM'start
2410 :REM'
2420 :REM'PRT
2430 KEY OFF:GOSUB 2500:LOCATE 25,5:COLOR 0,2
2440 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2450 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2460 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2460 :ELSE GOSUB 2500
2470 IF Z$="3"THEN RETURN
2480 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2490 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2430
2500 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
