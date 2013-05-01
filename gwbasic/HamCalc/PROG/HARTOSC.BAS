10 :REM'HARTOSC - Hartly FET oscillator - 4 APRIL 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 CLS
80 COLOR 15,2
90 PRINT " HARTLY FET OSCILLATOR";TAB(61);"by R.J.Dehoney,IEEE ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOSUB 240  :REM'print diagram
130 LN=CSRLIN
140 PRINT " This program calculates frequency and minimum gm for this circuit."
150 PRINT
160 PRINT " Press <1> to run program"
170 PRINT " Press <2> for theory"
180 PRINT " Press <0> to EXIT"
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="1"THEN LN=3:GOSUB 1640:GOSUB 240:GOTO 360
210 IF Z$="2"THEN CLS:GOSUB 1430:GOSUB 1660:GOTO 60
220 IF Z$="0"THEN RUN GO$
230 GOTO 200
240 :REM'.....diagram
250 PRINT " HARTLY OSCILLATOR   ╟──── +Vdc"
260 PRINT "          ┌───┬──┬───╢ FET"
270 PRINT "          │  L2  │   ╟───┐"
280 PRINT "          │   │  │       │"
290 PRINT " Note:    │  R2  └─Cgs─┬─┴──┐"
300 PRINT " C2      C2   ├───C1───┤    │"
310 PRINT " includes │  L1        │    │"
320 PRINT " Cgd      │   │       Cds  RL"
330 PRINT "          │  R1        │    │"
340 PRINT "          ╧   ╧        ╧    ╧"
350 RETURN
360 :REM'......enter data
370 LN=CSRLIN
380 PRINT :TP=8*ATN(1) :K=9.999999974752427e-07!
390 COLOR 0,7:PRINT " RL 50 to 500 Ω RECOMMENDED ":COLOR 7,0
400 INPUT "Enter RL ",RL :IF RL=0 THEN 400
410 GOSUB 1640:INPUT "Enter desired frequency, MHz";F :W=F*TP
420 IF W=0 THEN 410 :ELSE GOSUB 1640
430 L1=(937+40.79999923706055!*F-0.1599999964237213!*F^2)/(1-2.2799999713897705!*F+8.524998664855957!*F^2) :Q1=50
440 L2=2*L1 :Q2=50 :C2=1/W^2/(L1+L2) :C1=10*C2 :CGS=5*K :CDS=5*K
450 Y=1+L1/L2 :MAG1=1000 :R1=W*L1/Q1 :R2=W*L2/Q2
460 WW0=1/C2/(L1+L2) :W=0.8999999761581421!*SQR(WW0)
470 W=W*(1.0010000467300415!) :GOSUB 960
480 RE=-W^6*AX+W^4*CX-W^2*EX+GX :IM=W*(W^4*BX-W^2*DX+FX) :MAG=SQR(RE^2+IM^2)
490 SLOPE=2*RE*(-6*W^5*AX+4*W^3*CX-2*W*EX)+2*IM*(5*W^4*BX-3*W^2*DX+FX)
500 IF SLOPE<0 THEN W1=W :SLOPE1=SLOPE :GOTO 470
510 IF SLOPE>0 THEN W2=W :SLOPE2=SLOPE :W=(W1*SLOPE2-W2*SLOPE1)/(SLOPE2-SLOPE1)
520 RE=-W^6*AX+W^4*CX-W^2*EX+GX :IM=W*(W^4*BX-W^2*DX+FX) :MAG=SQR(RE^2+IM^2)
530 IF MAG<MAG1 THEN MAG1=MAG :Y=Y+0.0010000000474974513!*RL :GOTO 460
540 Y=Y-0.00019999999494757503!*RL :GM=(Y-1)/RL :W=W/1.000499963760376!
550 :REM'.....display values
560 B=50
570 LOCATE 3,B:PRINT USING " F (frequency).. ####.### MHz";W/TP
580 LOCATE 4,B:PRINT USING " L1............. ####.### µH";L1
590 LOCATE 5,B:PRINT USING " L2............. ###.### µH";L2
600 LOCATE 6,B:PRINT USING " R1............. ####.### Ω";W*L1/Q1
610 LOCATE 7,B:PRINT USING " R2............. ####.### Ω";W*L2/Q2
620 LOCATE 8,B:PRINT USING " RL............. ####.### Ω";RL
630 LOCATE 9,B:PRINT USING " Q1............. ####.### ";Q1
640 LOCATE 10,B:PRINT USING " Q2............. ####.### ";Q2
650 LOCATE 11,B:PRINT USING " C1............. ####.### pF";C1/K
660 LOCATE 12,B:PRINT USING " C2............. ####.### pF";C2/K
670 LOCATE 13,8:PRINT USING " gm (minimum)... #.#### Mho";GM
680 LOCATE 13,B:PRINT USING " Cds............ ####.### pF";CDS/K
690 LOCATE 14,B:PRINT USING " Cgs............ ####.### pF";CGS/K
700 PRINT
710 LN=CSRLIN
720 PRINT " Press <1> to change a value or <0> to QUIT"
730 Z$=INKEY$ :IF Z$=""THEN 730
740 IF Z$="0"THEN GOSUB 1640 :GOSUB 1660 :GOTO 10
750 IF Z$="1"THEN GOSUB 1640 :GOTO 770
760 GOTO 720
770 INPUT "ENTER Name (e.g. c1,q1,cds)";A$ :IF A$="" THEN 770
780 IF A$="r1" OR A$="R1" OR A$="r2" OR A$="R2" THEN 790 :ELSE 830
790 COLOR 0,7 :PRINT " R1 & R2 cannot be changed with these values of F and RL "
800 COLOR 7,0 :PRINT ".....Press any key....."
810 Z$=INKEY$ :IF Z$=""THEN 810
820 GOSUB 1640 :GOTO 720
830 PRINT "ENTER new value for "A$; :INPUT X
840 GOSUB 1640
850 IF A$="F" OR A$="f" THEN F=X :W=X*TP :GOTO 430
860 IF A$="RL" OR A$="rl" OR A$="Rl" THEN RL=X :GOTO 450
870 IF A$="L1" OR A$="l1" THEN L1=X :W=1/SQR(C2*(L1+L2)) :GOTO 450
880 IF A$="L2" OR A$="l2" THEN L2=X :W=1/SQR(C2*(L1+L2)) :GOTO 450
890 IF A$="Q1" OR A$="q1" THEN Q1=X :GOTO 450
900 IF A$="Q2" OR A$="q2" THEN Q2=X :GOTO 450
910 IF A$="C1" OR A$="c1" THEN C1=X*K :GOTO 450
920 IF A$="C2" OR A$="c2" THEN C2=X*K :W=1/SQR(C2*(L1+L2)) :GOTO 450
930 IF A$="CGS" OR A$="cgs" OR A$="Cgs" THEN CGS=X*K :GOTO 450
940 IF A$="CDS" OR A$="cds" OR A$="Cds" THEN CDS=X*K :GOTO 450
950 GOTO 450
960 :REM'.....subroutine to find Ax through Gx
970 AX=-RL*C1*L1*L2^2*CGS*(CGS*CDS+CGS*C2+CDS*C2)
980 BX1=-C1*CGS^2*L1*L2^2-RL*C1*CGS^2*CDS*R1*L2^2-RL*C1*CGS^2*CDS*L1*L2*R2
990 BX2A=RL*C1^2*CGS*CDS*L1*L2*R2 :REM'-C1*CGS*L1*L2^2*C2*Y
1000 BX2B=-C1*CGS*L1*L2^2*C2*Y
1010 BX3=-RL*C1*CGS^2*R1*L2^2*C2-RL*C1*CGS*CDS*R1*L2^2*C2+RL*C1^2*CGS*L1*L2*R2*C2
1020 BX4=-RL*C1*CGS^2*L1*L2*R2*C2-RL*C1*CGS*CDS*L1*L2*R2*C2+RL*C1^2*CDS*L1*L2*R2*C2
1030 BXA=BX1+BX2A+BX3+BX4 :BXB=BX2B/Y
1040 CX1=-RL*CGS^2*CDS*L1*L2-RL*C1*CGS*CDS*L1*L2-RL*C1*CGS^2*L2^2
1050 CX2=-RL*CGS^2*CDS*L2^2-C1*CGS^2*R1*L2^2-C1*CGS^2*L1*L2*R2+C1^2*CGS*L1*L2*R2
1060 CX3=-RL*C1*CGS^2*CDS*R1*L2*R2+RL*C1^2*CGS*CDS*R1*L2*R2+RL*C1^2*CGS*CDS*L1*R2^2
1070 CX4=-RL*C1*CGS*L1*L2*C2-RL*CGS^2*L1*L2*C2-RL*CGS*CDS*L1*L2*C2
1080 CX5=-RL*C1*CGS*L2^2*C2-RL*CGS^2*L2^2*C2-RL*CGS*CDS*L2^2*C2
1090 CX6=-C1*CGS*R1*L2^2*C2*Y + C1^2*L1*L2*R2*C2*Y - C1*CGS*L1*L2*R2*C2*Y
1100 CX7=+RL*C1^2*CGS*R1*L2*R2*C2
1110 CX8=-RL*C1*CGS^2*R1*L2*R2*C2-RL*C1*CGS*CDS*R1*L2*R2*C2+RL*C1^2*CDS*R1*L2*R2*C2
1120 CX9=RL*C1^2*CGS*L1*R2^2*C2+RL*C1^2*CDS*L1*R2^2*C2
1130 CXA=CX1+CX2+CX3+CX4+CX5+CX7+CX8+CX9 :CXB=CX6/Y
1140 DX1=-CGS^2*L1*L2-C1*CGS*L1*L2-RL*CGS^2*CDS*R1*L2-RL*C1*CGS*CDS*R1*L2
1150 DX2=-CGS^2*L2^2+RL*C1*CGS*CDS*L1*R2+RL*C1^2*CDS*L1*R2+RL*C1^2*CGS*L2*R2
1160 DX3=-RL*C1*CGS^2*L2*R2-RL*CGS^2*CDS*L2*R2+RL*C1*CGS*CDS*L2*R2-C1*CGS^2*R1*L2*R2
1170 DX4A=C1^2*CGS*R1*L2*R2+C1^2*CGS*L1*R2^2+RL*C1^2*CGS*CDS*R1*R2^2 :REM'- CGS*L1*L2*C2*Y
1180 DX4B=-CGS*L1*L2*C2*Y
1190 DX5A=-RL*C1*CGS*R1*L2*C2-RL*CGS^2*R1*L2*C2-RL*CGS*CDS*R1*L2*C2 :REM'CGS*L2^2*C2*Y
1200 DX5B=-CGS*L2^2*C2*Y
1210 DX6=RL*C1^2*L1*R2*C2+RL*C1*CGS*L1*R2*C2+RL*C1*CDS*L1*R2*C2
1220 DX7=RL*C1^2*L2*R2*C2-RL*CGS^2*L2*R2*C2-RL*CGS*CDS*L2*R2*C2+RL*C1*CDS*L2*R2*C2
1230 DX8=(C1^2*R1*L2*R2*C2 - C1*CGS*R1*L2*R2*C2 + C1^2*L1*R2^2*C2)*Y
1240 DX9=RL*C1^2*CGS*R1*R2^2*C2+RL*C1^2*CDS*R1*R2^2*C2
1250 DXA=DX1+DX2+DX3+DX4A+DX5A+DX6+DX7+DX9 :DXB=(DX4B+DX5B+DX8)/Y
1260 EX1=-RL*C1*CGS*L2-RL*CGS^2*L2-RL*CGS*CDS*L2-CGS^2*R1*L2-C1*CGS*R1*L2
1270 EX2=C1*CGS*L1*R2+C1^2*L1*R2+RL*C1*CGS*CDS*R1*R2+RL*C1^2*CDS*R1*R2
1280 EX3=C1*CGS*L2*R2-CGS^2*L2*R2+RL*C1^2*CGS*R2^2+RL*C1*CGS*CDS*R2^2
1290 EX4A=C1^2*CGS*R1*R2^2
1300 EX4B=(-CGS*R1*L2*C2+C1*L1*R2*C2)*Y
1310 EX5=RL*C1^2*R1*R2*C2+RL*C1*CGS*R1*R2*C2+RL*C1*CDS*R1*R2*C2
1320 EX6=(C1*L2*R2*C2-CGS*L2*R2*C2)*Y
1330 EX7A=RL*C1^2*R2^2*C2+RL*C1*CGS*R2^2*C2+RL*C1*CDS*R2^2*C2 :REM'C1^2*R1*R2^2*C2*Y
1340 EX7B=C1^2*R1*R2^2*C2*Y
1350 EXA=EX1+EX2+EX3+EX4A+EX5+EX7A :EXB=(EX4B+EX6+EX7B)/Y
1360 FX1A=RL*C1^2*R2+RL*C1*CGS*R2+RL*C1*CDS*R2+C1*CGS*R1*R2
1370 FX1B=-CGS*L2*Y
1380 FX2A=C1^2*R1*R2+C1*CGS*R2^2
1390 FX2B=(C1*R1*R2*C2+C1*R2^2*C2)*Y
1400 FXA=FX1A+FX2A :FXB=(FX1B+FX2B)/Y
1410 BX=BXA+BXB*Y :CX=CXA+CXB*Y :DX=DXA+DXB*Y :EX=EXA+EXB*Y :FX=FXA+FXB*Y
1420 GX=C1*R2*Y :RETURN
1430 :REM'                ---------------Theory---------------------
1440 PRINT : PRINT TAB(30)"THEORY OF OPERATION":PRINT
1450 PRINT "In order to find the gm value required for oscillation, we break the loop"
1460 PRINT "at some fictitious location where we see only the gm, with all the circuit"
1470 PRINT "elements on one side of the gap and only the gm on the other side. This"
1480 PRINT "avoids the loading problem we face when the loop is broken elsewhere. We"
1490 PRINT "apply voltage to the gm and calculate the voltage across the gap. When"
1500 PRINT "the voltage becomes zero, the circuit will oscillate. To find the value of"
1510 PRINT "gm resulting in oscillation and the frequency of oscillation, we note that"
1520 PRINT "below Fosc, the slope of the gap voltage magnitude is negative, and at Fosc,"
1530 PRINT "with the proper value of gm, the gap voltage magnitude approaches zero."
1540 PRINT "So, we start with a low value of gm and find the frequency and magnitude"
1550 PRINT "where the slope goes from minus to plus. We note this value, increase gm and"
1560 PRINT "again find where the slope goes from minus to plus. When the gap voltage stops"
1570 PRINT "decreasing, we consider this close enough to the actual resonant frequency."
1580 PRINT "The trial values are based on XL1 being about 1000 ohms at 1 MHz and about"
1590 PRINT "25 ohms at 100 MHz, and XL2 being 2*XL1. We assume a Q of 50 for both"
1600 PRINT "coils. We calculate C2 using an approximate formula and make C1 = 10*C2."
1610 PRINT "The calculated frequency is somewhat different than the desired frequency, but"
1620 PRINT "slight changes in the value of C2 or the inductors can correct that."
1630 RETURN
1640 :REM'.....clear to bottom
1650 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
1660 :REM'.....PRT
1670 KEY OFF:GOSUB 1740:LOCATE 25,5:COLOR 0,2
1680 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1690 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1700 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1700 :ELSE GOSUB 1740
1710 IF Z$="3"THEN RETURN
1720 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1730 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1670
1740 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
