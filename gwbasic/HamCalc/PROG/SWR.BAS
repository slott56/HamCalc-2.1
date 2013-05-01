10 :REM'SWR - 11 JAN 94 rev. 10 DEC 2003
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""OR PROG$="swr"THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,1
70 UL$=STRING$(80,205)
80 U1$="####.###"
90 E$=STRING$(80,32)
100 :REM'
110 :REM'.....start
120 CLS:FWD=0:REF=0:SWR=0:P=0:VF=0:VR=0:FQ=0:FA=0:PX=0
130 COLOR 15,2
140 PRINT " SWR (Standing Wave Ratio) CALCULATOR";
150 PRINT TAB(57);"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,223);
170 COLOR 7,0:PRINT " Press letter in < > for:"
180 PRINT UL$;
190 PRINT "   < a > SWR as a function of forward/reverse voltage"
200 PRINT "   < b > SWR as a function of forward/reflected power"
210 PRINT "   < c > SWR as a function of complex load impedance R ± jX"
220 PRINT "   < d > SWR as a factor in Conjugate Match calculations"
230 PRINT "   < e > SWR as a factor in Transmission Line Loss calculations"
240 :REM'PRINT "   < f > SWR vs. Power Loss (TNX to Art Blick, VE3AHU)"
250 PRINT "   < f > SWR vs. Attenuation"
260 PRINT "   < g > SWR vs. Line Loss"
270 PRINT "   < h > SWR formulae"
280 PRINT
290 PRINT "   < z > EXIT"
300 COLOR 7,0
310 Z$=INKEY$:IF Z$=""THEN 310
320 IF Z$="z"THEN CLS:CHAIN GO$
330 IF Z$="a"THEN 430
340 IF Z$="b"THEN 690
350 IF Z$="c"THEN 1060
360 IF Z$="d"THEN CLS:PROG$="swr":CHAIN"conjumat"
370 IF Z$="e"THEN CLS:PROG$="swr":CHAIN"lineloss"
380 :REM'IF Z$="f"THEN 1350
390 IF Z$="f"THEN CLS:PROG$="swr":CHAIN"attenu"
400 IF Z$="g"THEN CLS:PROG$="swr":CHAIN"lossy"
410 IF Z$="h"THEN CLS:PROG$="swr":CHAIN"formulae"
420 :REM'
430 :REM'.....SWR as a function of forward/reflected voltage
440 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
450 IF SWR THEN 470
460 INPUT "    ENTER: SWR, if known................ ";SWR:GOSUB 540
470 IF VF THEN 500
480 INPUT "    ENTER: Forward Voltage, if known.... ";VF:GOSUB 540
490 IF SWR=1 THEN 520
500 IF VR THEN 520
510 INPUT "    ENTER: Reverse Voltage, if known.... ";VR:GOSUB 540
520 GOTO 440
530 :REM'
540 :REM'.....calculate
550 IF SWR=1 AND VF<>0 THEN VR=10^-8
560 IF SWR=0 AND VF*VR<>0 THEN SWR=(VF+VR)/(VF-VR):GOTO 540
570 IF VF=0 AND VR*SWR<>0 THEN VF=(-(SWR*VR)-VR)/(1-SWR):GOTO 540
580 IF VR=0 AND VF*SWR<>0 THEN VR=((SWR*VF)-VF)/(1+SWR):GOTO 540
590 IF VF*VR*SWR<>0 THEN 620
600 RETURN
610 :REM'
620 :REM'.....display
630 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
640 PRINT "    FORWARD voltage.....................";USING U1$;VF
650 PRINT "    REVERSE voltage.....................";USING U1$;VR
660 PRINT "    SWR.................................";USING U1$;SWR;:PRINT ":1"
670 GOTO 2030
680 :REM'
690 :REM'.....SWR as a function of forward/reflected power
700 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
710 IF FWD THEN 740
720 INPUT " ENTER: Forward power (watts), if known........";FWD
730 GOSUB 820
740 IF REF THEN 770
750 INPUT " ENTER: Reflected power (watts), if known......";REF
760 GOSUB 820
770 IF SWR THEN 800
780 INPUT " ENTER: Standing Wave Ratio (SWR), if known....";SWR
790 GOSUB 820
800 IF FWD*REF*SWR THEN 930 :ELSE 710
810 :REM'
820 :REM'.....calculation
830 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
840 FOR Z=1 TO 2
850 IF SWR>0 AND SWR<1.0000001# THEN SWR=1.0000001#
860 IF P=0 THEN IF SWR THEN P=(SWR-1)/(SWR+1)
870 IF FWD*REF THEN X=SQR(REF/FWD):SWR=(1+X)/(1-X):GOTO 900
880 IF SWR*FWD THEN REF=FWD*P^2:GOTO 900
890 IF SWR*REF THEN FWD=REF/P^2:GOTO 900
900 NEXT Z
910 RETURN
920 :REM'
930 :REM'.....display data
940 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
950 ATT=-4.342949867248535!*LOG(1-P^2)    :REM'attenuation
960 RLO=-8.685890197753906!*LOG(P)        :REM'return loss
970 PRINT "    FORWARD power...................";USING U1$;FWD;:PRINT " watts"
980 PRINT "    REFLECTED power.................";USING U1$;REF;:PRINT " watts"
990 PRINT "    S.W.R. .........................";USING U1$;SWR;:PRINT ":1"
1000 PRINT "    Reflection Coefficient..........";USING U1$;P
1010 PRINT "    Attenuation.....................";USING U1$;ATT;:PRINT " dB"
1020 PRINT "    Return Loss.....................";USING U1$;RLO;:PRINT " dB"
1030 PRINT UL$;
1040 GOTO 2030
1050 :REM'
1060 :REM'.....SWR as a function of complex load impedance
1070 :REM'ref. M.W.Maxwell's book "Reflections", page 23-5
1080 :REM'data provided by Goran Hosinsky, EA8YU
1090 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1100 PRINT " Complex load impedance = R ± jX ohms"
1110 INPUT " ENTER: Value of resistive component R (ohms)...............";R
1120 COLOR 0,7
1130 PRINT " Is the reactive component X (i)nductive or (c)apacitive?  (i/c) "
1140 COLOR 7,0
1150 Z$=INKEY$:IF Z$=""THEN 1150
1160 IF Z$="i"THEN J$="+ j":X$="inductive component (ohms).":GOTO 1190
1170 IF Z$="c"THEN J$="- j":X$="capacitive component (ohms)":GOTO 1190
1180 GOTO 1150
1190 LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1
1200 PRINT " ENTER: Value of ";X$;"................";:INPUT X
1210 INPUT " ENTER: Characteristic impedance of transmission line (ohms)";ZC
1220 R=R/ZC:X=X/ZC
1230 B=((X^2+1)/R)+R
1240 SWR=(B+SQR(B^2-4))/2
1250 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1260 X$=STR$(ABS(X*ZC)):X$=RIGHT$(X$,LEN(X$)-1)
1270 PRINT " Complex load impedance..............";R*ZC;J$;X$;" ohms"
1280 PRINT " Characteristic impedance of line....";ZC;"ohms"
1290 PRINT " SWR on line.........................";USING "###.###";SWR;
1300 PRINT ":1"
1310 P=(SWR-1)/(SWR+1)   :REM'reflection coefficient
1320 PRINT " Reflection Coefficient..............";USING "###.###";P
1330 GOTO 2030
1340 :REM'
1350 :REM'.....power loss
1360 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1370 U$="#####.###"
1380 N=0
1390 GOTO 1460
1400 :REM'.....format input line
1410 N=N+1
1420 LOCATE CSRLIN-1:PRINT USING "###.   ";N;
1430 LOCATE CSRLIN,47:PRINT STRING$(7,".");USING U$;ZZ;
1440 RETURN
1450 :REM'.....input data
1460 INPUT " ENTER: Frequency of Operation..................(MHz)";FQ
1470 ZZ=FQ:GOSUB 1400:PRINT " MHz"
1480 INPUT " ENTER: SWR at the feeder input......................";SWR
1490 ZZ=SWR:GOSUB 1400:PRINT ":1"
1500 INPUT " ENTER: Attenuation loss of feeder..............(-dB)";FA
1510 IF FA=0 THEN FA=-0.0010000000474974513!
1520 IF FA>0 THEN FA=-FA
1530 ZZ=FA:GOSUB 1400:PRINT " dB"
1540 INPUT " ENTER: Power output of transmitter...........(watts)";PX
1550 ZZ=PX:GOSUB 1400:PRINT " watts"
1560 P=(SWR-1)/(SWR+1)
1570 PRINT "        Reflection coefficient at Transmatch........."
1580 ZZ=P:GOSUB 1400
1590 PV=1-P^2:PF=PX/PV
1600 PRINT "        Forward power at transmatch output..........."
1610 ZZ=PF:GOSUB 1400:PRINT " watts"
1620 A=1/EXP(FA*LOG(10)/10)
1630 PRINT "        Attenuation factor..........................."
1640 ZZ=A:GOSUB 1400
1650 PUP=PF*A
1660 PRINT "        Power delivered to antenna..................."
1670 ZZ=PUP:GOSUB 1400:PRINT " watts"
1680 PRINT
1690 PRINT " SWR CALCULATION"
1700 PA=P/A
1710 PRINT "        Reflection coefficient at antenna..........."
1720 ZZ=PA:GOSUB 1400
1730 SWRANT=(1+PA)/(1-PA)
1740 PRINT "        SWR at antenna feedpoint...................."
1750 ZZ=SWRANT:GOSUB 1400:PRINT ":1"
1760 PF=PUP*PA^2
1770 PRINT "        Power reflected............................."
1780 ZZ=PF:GOSUB 1400:PRINT " watts"
1790 SWRA=PA^2-P^2
1800 PRINT "        SWR loss factor............................."
1810 ZZ=SWRA:GOSUB 1400
1820 SWRDB=ABS(10*LOG((1-PA^2)/(1-P^2))/LOG(10))
1830 PRINT "        SWR loss...................................."
1840 ZZ=SWRDB:GOSUB 1400:PRINT " dB"
1850 AT=FA+SWRDB
1860 PRINT "        Total line loss............................."
1870 ZZ=AT:GOSUB 1400:PRINT " dB"
1880 PAB=PX/(EXP(AT*LOG(10)/10))
1890 PRINT
1900 PRINT "        Power absorbed by antenna..................."
1910 ZZ=PAB:GOSUB 1400:PRINT " watts"
1920 LL=PX-(PX*A)
1930 PRINT "        Line loss..................................."
1940 ZZ=LL:GOSUB 1400:PRINT " watts"
1950 SWRL=PX-PAB-LL
1960 PRINT "        SWR loss...................................."
1970 ZZ=SWRL:GOSUB 1400:PRINT " watts"
1980 TOT=PAB+LL+SWRL
1990 PRINT "        Total dissipation (lines 15+16+17).........."
2000 ZZ=TOT:GOSUB 1400:PRINT " watts"
2010 GOTO 2030
2020 :REM'
2030 :REM'.....end
2040 GOSUB 2080
2050 GOTO 110
2060 END
2070 :REM'
2080 :REM'PRT
2090 KEY OFF:GOSUB 2160:LOCATE 25,5:COLOR 0,2
2100 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2110 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2120 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2120 :ELSE GOSUB 2160
2130 IF Z$="3"THEN RETURN
2140 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2150 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2090
2160 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
