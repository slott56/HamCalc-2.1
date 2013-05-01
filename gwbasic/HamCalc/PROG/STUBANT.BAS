10 :REM'STUBANT - Stub Match for Antennas - 19 FEB 95 rev.25 OCT 2000
20 IF EX$=""THEN EX$="EXIT"      :REM'if ex$ not chained from previous program
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF:COLOR 7,0,1
60 UL$=STRING$(80,205)
70 U1$="#####.###"
80 U2$="##.###"
90 U3$="####.##"
100 PI=3.1415929794311523!
110 :REM'
120 :REM'.....start
130 CLS
140 COLOR 15,2
150 PRINT " STUB MATCH for ANTENNAS";
160 PRINT TAB(61);"by ";CHR$(34);"LB";CHR$(34);" Cebik W4RNL ";
170 PRINT STRING$(80,32);
180 LOCATE CSRLIN-1,20:PRINT "edited for HAMCALC by George Murphy VE3ERP"
190 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
200 MARGIN=7
210 PRINT TAB(MARGIN);
220 PRINT "A Stub Matching system for any given Antenna Load Resistance (R),"
230 PRINT TAB(MARGIN);
240 PRINT "Antenna Load Reactance (X), and Matchline, Stub and Feedline"
250 PRINT TAB(MARGIN);
260 PRINT "Impedances (Zo)."
270 :REM'
280 :REM'.....schematic
290 COLOR 0,7:VIEW PRINT 7 TO 17:CLS:VIEW PRINT:LOCATE 7
300 LOCATE 25:PRINT STRING$(80,219);
310 LOCATE 7
320 PRINT
330 TB=27    :REM'tab
340 PRINT TAB(TB-16);"∞─────────────────────────┬∞∞┬─── ANTENNA──────────────∞"
350 PRINT TAB(TB);"          │  │«── MATCHLINE to stub junction"
360 PRINT TAB(TB);"          ├┐┌┤«── stub junction"
370 PRINT TAB(TB);"          │││«─── STUB"
380 PRINT TAB(TB);"          ││││"
390 PRINT TAB(TB);"          │██«─── shorting bar (optional)"
400 PRINT TAB(TB);"          ││││"
410 PRINT TAB(TB);"          │  │«── FEEDLINE to stub junction"
420 PRINT TAB(TB);"          │  │"
430 PRINT
440 LN=CSRLIN:LOCATE LN-8
450 PRINT " Feedline and Matchline should be"
460 PRINT " as near horizontal as possible at"
470 PRINT " the stub junction, with the stub"
480 PRINT " hanging vertically."
490 COLOR 7,0
500 LOCATE LN
510 PRINT TAB(MARGIN);
520 PRINT "For any antenna load R and X, this program finds the Matchline and"
530 PRINT TAB(MARGIN);
540 PRINT "Stub lengths needed to match any feedline Zo if a match is possible"
550 PRINT TAB(MARGIN);
560 PRINT "with the proposed Line, Stub, and Feed Zo values."
570 PRINT UL$;
580 COLOR 14,4
590 LOCATE CSRLIN,14
600 PRINT "........Press <1> to CONTINUE or <0> to EXIT........."
610 COLOR 7,0
620 Z$=INKEY$
630 IF Z$="0"THEN CLS:CHAIN GO$
640 IF Z$="1"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 660
650 GOTO 620
660 GOSUB 1990      :REM'screen dump
670 :REM'
680 :REM'.....data input
690 VIEW PRINT 2 TO 24:CLS:VIEW PRINT:LOCATE 2:PRINT UL$;
700 GOTO 770
710 :REM'
720 :REM'.....format entry
730 LOCATE CSRLIN-1:PRINT "       ";
740 LOCATE CSRLIN,58:PRINT USING U1$;Y;
750 RETURN
760 :REM'
770 INPUT " ENTER: Antenna Load Resistance..........................(ohms) ";RL
780 Y=RL:GOSUB 720:PRINT " Ω    "
790 INPUT " ENTER: Antenna Load Reactance...........................(ohms) ";XL
800 Y=XL:GOSUB 720:PRINT " Ω    "
810 INPUT " ENTER: Frequency.........................................(MHz) ";FQ
820 Y=FQ:GOSUB 720:PRINT " MHz  "
830 INPUT " ENTER: Impedance of MATCHLINE (Stub to Antenna).........(ohms) ";ZL
840 Y=ZL:GOSUB 720:PRINT " Ω    "
850 INPUT " ENTER: Velocity Factor of MATCHLINE (decimal)................. ";VFL
860 Y=VFL:GOSUB 720:PRINT "      "
870 INPUT " ENTER: Impedance of FEEDLINE (Stub to Rig)..............(ohms) ";ZF
880 Y=ZF:GOSUB 720:PRINT " Ω    "
890 INPUT " ENTER: Velocity Factor of FEEDLINE (decimal).................. ";VFF
900 Y=VFF:GOSUB 720:PRINT "      "
910 INPUT " ENTER: Impedance of STUB................................(ohms) ";ZS
920 Y=ZS:GOSUB 720:PRINT " Ω    "
930 INPUT " ENTER: Velocity Factor of STUB (decimal)...................... ";VFS
940 Y=VFS:GOSUB 720:PRINT "      "
950 :REM'
960 :REM'.....calculate
970 RLS=RL^2:XLS=XL^2:ZLS=ZL^2:RIS=RI^2
980 RHOS=((RL-ZL)^2+XLS)/((RL+ZL)^2+XLS)
990 RT=(ZL^2*(1-RHOS))/(ZF*(RHOS-1)+2*ZL*(RHOS+1))
1000 RI=RT
1010 A=XLS/ZLS+RLS/ZLS-RL/RI
1020  IF A=0 THEN A=9.99999993922529e-09!
1030 B=2*XL/ZL
1040 C=1-RL/RI
1050 NUM=B^2-4*A*C
1060  IF NUM<0 THEN 1390
1070 TLP=(B+SQR(B^2-4*A*C))/(2*A)
1080 TLM=(B-SQR(B^2-4*A*C))/(2*A)
1090 LP=ATN(TLP)
1100 LM=ATN(TLM)
1110 LPD=LP*180/PI
1120  IF LPD<0 THEN LPD=180+LPD
1130 LMD=LM*180/PI
1140  IF LMD<0 THEN LMD=180+LMD
1150 LPF=LPD*VFL/(0.3660131096839905!*FQ)
1160 LMF=LMD*VFL/(0.3660131096839905!*FQ)
1170 PRINT " MATCHLINE Option A: Length..............................";
1180 PRINT USING U1$;LPF;:PRINT " ft.=";USING U2$;LPF*0.30480000376701355!;:PRINT "m"
1190 LOCATE CSRLIN+5
1200 PRINT " MATCHLINE Option B: Length..............................";
1210 PRINT USING U1$;LMF;:PRINT " ft.=";USING U2$;LMF*0.30480000376701355!;:PRINT "m"
1220 LR=LP:GOTO 1440
1230 RIA=RI:XIA=XI
1240 LOCATE CSRLIN-6
1250 PRINT TAB(9);"Series resistance before stub installation.......";
1260 PRINT USING U1$;RI;:PRINT " Ω"
1270 PRINT TAB(9);"Series reactance before stub installation........";
1280 PRINT USING U1$;XI;:PRINT " Ω"
1290 LR=LM:GOTO 1440
1300 RIB=RI
1310 XIB=XI
1320 LOCATE CSRLIN+4
1330 PRINT TAB(9);"Series resistance before stub installation.......";
1340 PRINT USING U1$;RI;:PRINT " Ω"
1350 PRINT TAB(9);"Series reactance before stub installation........";
1360 PRINT USING U1$;XI;:PRINT " Ω"
1370 GOTO 1640
1380 :REM'
1390 PRINT"   There are no possible solutions with this combination of antenna"
1400 PRINT"   impedance and line impedance. Resistance along the line does not"
1410 PRINT"   reach the value of the characteristic impedance of the feed line."
1420 GOTO 1960
1430 :REM'
1440 IF RL=0 THEN RL=9.99999993922529e-09!
1450 RA=RL/ZL
1460 XA=XL/ZL
1470 T=TAN(LR)
1480 TS=T*T
1490 DA=(1-XA*T)*(1-XA*T)
1500 DB=(RA*T)^2
1510 DN=DA+DB
1520 RS=RA^2
1530 XS=XA^2
1540 RN=RA*(1+TS)
1550 XK=XA*(1-TS)
1560 XM=((1-RS)-XS)*T
1570 XN=XK+XM
1580 RZ=RN/DN
1590 XZ=XN/DN
1600 RI=ZL*RZ
1610 XI=ZL*XZ
1620 IF LR=LP THEN GOTO 1230
1630 IF LR=LM THEN GOTO 1300
1640 LOCATE CSRLIN-6
1650 XPA=(RIA^2+XIA^2)/XIA:XCOMPA=(-1*XPA)
1660 PRINT "        Required parallel stub reactance to compensate...";
1670 PRINT USING U1$;XCOMPA;:PRINT " Ω"
1680 LRL=ATN(XCOMPA/ZS):LDL=ABS(LRL)*180/PI
1690 IF XCOMPA<0 THEN LDL=180-LDL
1700 LFL=LDL*VFS/(0.3660131096839905!*FQ)
1710 LRC=ATN(ZS/XCOMPA):LDC=ABS(LRC)*180/PI
1720 IF XCOMPA>0 THEN LDC=180-LDC
1730 LFC=LDC*VFS/(0.3660131096839905!*FQ)
1740 PRINT "        SHORTED STUB length is";USING U3$;LDL;
1750 PRINT "° or................";USING U1$;LFL;:PRINT " ft.=";
1760 PRINT USING U2$;LFL*0.30480000376701355!;:PRINT "m"
1770 PRINT "        OPEN STUB length is   ";USING U3$;LDC;
1780 PRINT "° or................";USING U1$;LFC;:PRINT " ft.=";
1790 PRINT USING U2$;LFC*0.30480000376701355!;:PRINT "m"
1800 LOCATE CSRLIN+3
1810 XPB=(RIB^2+XIB^2)/XIB:XCOMPB=(-1*XPB)
1820 PRINT "        Required parallel stub reactance to compensate...";
1830 PRINT USING U1$;XCOMPB;:PRINT " Ω"
1840 LRL=ATN(XCOMPB/ZS):LDL=ABS(LRL)*180/PI
1850 IF XCOMPB<0 THEN LDL=180-LDL
1860 LFL=LDL*VFS/(0.3660131096839905!*FQ)
1870 LRC=ATN(ZS/XCOMPB):LDC=ABS(LRC)*180/PI
1880 IF XCOMPB>0 THEN LDC=180-LDC
1890 LFC=LDC*VFS/(0.3660131096839905!*FQ)
1900 PRINT "        SHORTED STUB length is";USING U3$;LDL;
1910 PRINT "° or................";USING U1$;LFL;:PRINT " ft.=";
1920 PRINT USING U2$;LFL*0.30480000376701355!;:PRINT "m"
1930 PRINT "        OPEN STUB length is   ";USING U3$;LDC;
1940 PRINT "° or................";USING U1$;LFC;:PRINT " ft.=";
1950 PRINT USING U2$;LFC*0.30480000376701355!;:PRINT "m"
1960 GOSUB 1990
1970 GOTO 120   :REM'start
1980 :REM'
1990 :REM'PRT
2000 KEY OFF:GOSUB 2070:LOCATE 25,5:COLOR 0,2
2010 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2020 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2030 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2030 :ELSE GOSUB 2070
2040 IF Z$="3"THEN RETURN
2050 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2060 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2000
2070 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
