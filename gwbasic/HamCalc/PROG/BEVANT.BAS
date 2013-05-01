10 :REM'BEVANT - Beverage Antenna Equations - 23 JUL 1998 rev.
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,0
50 LF=1/LOG(10)  :REM'conversion factor - natural log to log base 10
60 UL$=STRING$(80,205)
70 GOTO 130
80 :REM'
90 :REM'.....clear window
100 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
110 RETURN
120 :REM'
130 :REM'.....start
140 CLS
150 F=0:W=0:K=0:PH=0:H=0:HM=0:D=0:SM=0:Z=0:L=0
160 COLOR 15,2
170 PRINT " BEVERAGE ANTENNA EQUATIONS"TAB(57)"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 :REM'
210 GOSUB 1540
220 PRINT
230 PRINT " This program solves the Beverage Antenna equations in the ARRL ";
240 PRINT "ANTENNA BOOK,"
250 PRINT " 17th Edition, pp 13-15 to 13-17."
260 PRINT UL$;
270 PRINT " Press number in < > to:"
280 PRINT UL$;
290 PRINT "   < 1 > Find phase shift"
300 PRINT "   < 2 > Find characteristic impedance of a single-wire Beverage"
310 PRINT "   < 3 > Find maximum effective length"
320 PRINT "   < 4 > Find characteristic impedance of a two-wire Beverage"
330 PRINT
340 PRINT "   < 0 > EXIT"
350 Z$=INKEY$:IF Z$=""THEN 350
360 IF Z$="0"THEN CLS:RUN EX$
370 IF Z$="1"THEN 430
380 IF Z$="2"THEN 520
390 IF Z$="3"THEN 640
400 IF Z$="4"THEN 760
410 GOTO 350
420 :REM'
430 :REM'.....phase shift
440 LN=3:GOSUB 90
450 PRINT " PHASE SHIFT"
460 PRINT UL$;
470 GOSUB 910
480 IF K THEN 490 :ELSE 440
490 PH=360*(100/K-1)
500 GOTO 1240
510 :REM'
520 :REM'.....Zo of single wire
530 LN=3:GOSUB 90
540 PRINT " CHARACTERISTIC IMPEDANCE OF A SINGLE-WIRE BEVERAGE ANTENNA"
550 PRINT UL$;
560 GOSUB 1120
570 IF H THEN 580 :ELSE 560
580 GOSUB 1150
590 IF DD THEN 600 :ELSE 580
600 Z=138*LOG(4*H/D)*LF
610 HM=H:HF=HM/0.30480000376701355!:D=D*10^3:DI=D/25.399999618530273!
620 GOTO 1240
630 :REM'
640 :REM'.....length
650 LN=3:GOSUB 90
660 PRINT " MAXIMUM EFFECTIVE LENGTH"
670 PRINT UL$;
680 IF K THEN 710
690 GOSUB 910
700 IF K THEN 710 :ELSE 650
710 GOSUB 1180
720 IF F THEN 730 :ELSE 650
730 L=W/(4*(100/K-1))
740 GOTO 1240
750 :REM'
760 :REM'.....Zo of two-wire
770 LN=3:GOSUB 90
780 PRINT " CHARACTERISTIC IMPEDANCE OF A TWO-WIRE BEVERAGE ANTENNA"
790 PRINT UL$;
800 GOSUB 1120
810 IF H THEN 820 :ELSE 800
820 GOSUB 1150
830 IF DD THEN 840 :ELSE 820
840 GOSUB 1210
850 IF SS THEN 860 :ELSE 840
860 Z=69*LOG(4*H/D*SQR(1+(2*H)^2/S))
870 HM=H:HF=H/0.30480000376701355!:D=D*10^3:DI=D/25.399999618530273!:SM=S*100:SI=SM/2.5399999618530273!
880 GOTO 1240
890 :REM'
900 :REM'.....inputs
910 PRINT " Velocity factor of a signal travelling along a Beverage antenna ";
920 PRINT "varies with"
930 PRINT " height above ground, to a maximum of about 4 metres (13 ft.). For";
940 PRINT " a typical"
950 PRINT " 1.8 MHz antenna the following approximate velocity factors may be";
960 PRINT " assumed:"
970 PRINT
980 PRINT "   Height above ground   Velocity Factor"
990 PRINT "     0.5m ( 1.6 ft.)          72%"
1000 PRINT "     1.0m ( 3.3 ft.)          77%"
1010 PRINT "     1.5m ( 4.9 ft.)          82%"
1020 PRINT "     2.0m ( 6.6 ft.)          85%"
1030 PRINT "     2.5m ( 8.2 ft.)          87%"
1040 PRINT "     3.0m ( 9.8 ft.)          89%"
1050 PRINT "     3.5m (11.5 ft.)          91%"
1060 PRINT "     4.0m (13.1 ft.)          92%"
1070 PRINT
1080 :REM'
1090 INPUT " ENTER: Velocity factor of antenna, as a percent........%=";K
1100 RETURN
1110 :REM'
1120 INPUT " ENTER: Wire height above ground, in metres...............";H
1130 RETURN
1140 :REM'
1150 INPUT " ENTER: Wire diameter, in millimetres.....................";DD
1160 D=DD/10^3:RETURN
1170 :REM'
1180 INPUT " ENTER: Frequency of operation, in MHz....................";F
1190 W=300/F:RETURN
1200 :REM'
1210 INPUT " ENTER: Wire spacing, in centimetres......................";SS
1220 S=SS/100:RETURN
1230 :REM'
1240 :REM'.....display
1250 LN=5:GOSUB 90:
1260 IF F=0 THEN 1290
1270 PRINT USING " Frequency of operation     #####.### MHz";F
1280 PRINT USING " Wavelength                 #####.### metres";W
1290 IF K=0 THEN 1310
1300 PRINT USING " Velocity factor of antenna #####.##%";K
1310 IF PH=0 THEN 1330
1320 PRINT USING " Phase shift per wavelength #####.##°";PH
1330 IF HM=0 THEN 1350
1340 PRINT USING " Wire Height above ground   #####.## m.=###.## ft.";HM,HF
1350 IF D=0 THEN 1370
1360 PRINT USING " Wire diameter              #####.# mm.=###.### in.";D,DI
1370 IF SM=0 THEN 1390
1380 PRINT USING " Wire spacing               #####.# cm.=###.### in.";SM,SI
1390 IF Z=0 THEN 1420
1400 PRINT USING " Characteristic impedance   #####.# ohms";Z
1410 PRINT USING " Terminating resistor       #####.# ohms";Z
1420 IF L=0 THEN 1500
1430 LF=L/0.30480000376701355!
1440 PRINT USING " Maximum effective length   #####.## m.=#####.# ft.";L,LF;
1450 PRINT "  (single-wire Beverage)"
1460 L2=1.2000000476837158!*L:LF2=1.2000000476837158!*LF
1470 PRINT USING " Maximum effective length   #####.## m.=#####.# ft.";L2,LF2;
1480 PRINT "  (two-wire Beverage)"
1490 :REM'
1500 :REM'.....end
1510 PRINT UL$;:GOSUB 1540
1520 GOSUB 1680:GOTO 130
1530 :REM'
1540 :REM'.....diagram
1550 T=13:COLOR 0,7
1560 LOCATE ,T:PRINT "               BEVERAGE RECEIVING ANTENNA               "
1570 LOCATE ,T:PRINT "         │«───────────── Length ─────────────»│         "
1580 LOCATE ,T:PRINT "         ┌────────────────────────────────────┐         "
1590 LOCATE ,T:PRINT "  ┌──┐ ┌─┴─┐   Rx = Receiver                  >         "
1600 LOCATE ,T:PRINT "  │Rx╞═╡ T │   T  = Transmatch                < R       "
1610 LOCATE ,T:PRINT "  └──┘ └─┬─┘   R  = Terminating Resistor      >         "
1620 LOCATE ,T:PRINT "       \\┴\\  (R  = Zo of Antenna)     \\───G─┴─G───\\  "
1630 LOCATE ,T:PRINT "               G  = Ground Radial System                "
1640 LOCATE ,T:PRINT " (The Beverage is not an efficient transmitting antenna)"
1650 COLOR 7,0
1660 RETURN
1670 :REM'
1680 :REM'.....PRT
1690 KEY OFF:GOSUB 1760:LOCATE 25,5:COLOR 0,2
1700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1720 :ELSE GOSUB 1760
1730 IF Z$="3"THEN RETURN
1740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1690
1760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
