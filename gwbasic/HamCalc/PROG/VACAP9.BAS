10 :REM'vacap9 - 23 DEC 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 U1$="#####.###"
90 DIM A(13)
100 DIM B(13)
110 DIM R(13)
120 :REM'.....title page
130 CUC=0:LUC=0:DUC=0:FLC=0:CD=0:AM=0:KUC=0:DLC=0:KLC=0:NLC=0:ARE=0:R1=0
140 COLOR 15,2,0
150 PRINT " VARIABLE CAPACITOR PLATE DESIGNER"TAB(57)"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,223);
170 COLOR 15,2:LOCATE CSRLIN-1,25:PRINT " Algorithm by R.J. Dehoney IEEE "
180 COLOR 7,0
190 FOR J=0 TO 12 :A(J)=PI/12*J :NEXT J
200 :REM'.....start
210 PRINT
220 PRINT "This program calculates plotting data for straight line frequency ";
230 PRINT "variable"
240 PRINT "capacitor plates in an L/C network tuned circuit."
250 PRINT
260 PRINT "Ref. Terman - page 123 (plate shapes)"
270 PRINT "Ref. Forbes - Proceedings of the IRE Aug 1925 vol.13 issue 4."
280 PRINT
290 PRINT "Required inputs are inductance in µH, capacitances in pF, maximum ";
300 PRINT "voltage and "
310 PRINT "radius of the shaft cutout in the fixed stator plates."
320 PRINT
330 PRINT "If the application is for link coupled tuners, first run the `Link ";
340 PRINT "Coupled"
350 PRINT "Tuners' program for input values required by this program."
360 PRINT
370 PRINT "If the physical size of the capacitor is not practical run Hamcalc";
380 PRINT "'s"
390 PRINT "`Capacitors - Trimmer' program to selcet an appropriate capacitor/";
400 PRINT "trimmer "
410 PRINT "combination."
420 PRINT
430 LOCATE ,20
440 COLOR 0,7:PRINT ".....Press 1 to continue or 0 to exit.....":COLOR 7,0
450 Z$=INKEY$:IF Z$=""THEN 450
460 IF Z$="0"THEN RUN EX$
470 IF Z$="1"THEN CLS:GOTO 490
480 GOTO 450
490 :REM'.....calculate area
500 PRINT
510 PRINT "    Want to enter dimensions in centimetres or inches?   (c/i)"
520 Z$=INKEY$:IF Z$=""THEN 520
530 IF Z$="c"THEN M=1:M$="cm.":GOTO 560
540 IF Z$="i"THEN M=2.5399999618530273!:M$="in.":GOTO 560
550 GOTO 520
560 CLS
570 KD=1.000599980354309!  :REM'dielectric constant for air
580 PRINT "Volts per mil should be in the range of 20 (large gap) to 40 (sma";
590 PRINT "ll gap):"
600 PRINT
610 INPUT "ENTER: Volts per mil (.001 in.) ";VM
620 INPUT "ENTER: Maximum volts ";V
630 DLC=V/1000/VM
640 CLS
650 PRINT USING " Volts per mil .... #####.###";VM
660 PRINT USING " Maximum volts .... #####.###";V
670 PRINT USING " Air gap........... #####.###";DLC*M;:PRINT " ";M$
680 LN=CSRLIN:PRINT " .....Press 1 to contimue or 0 to change gap....."
690 Z$=INKEY$:IF Z$=""THEN 690
700 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 720
710 IF Z$="0"THEN CLS:GOTO 570
720 INPUT " ENTER: Capacitance of Variable Capacitor fully CLOSED (pF)";CMAX
730 INPUT " ENTER: Capacitance of Variable Capacitor fully OPEN (pF)";CMIN
740 CUCMAX=CMAX/10^12 :CUCMIN=CMIN/10^12
750 INPUT " ENTER: Inductance of tuned circuit in uH";Z
760 LUC=Z/10^6
770 FL=1/(2*PI*SQR(Z*CMAX))*1000.0! :FH=1/(2*PI*SQR(Z*CMIN))*1000.0!
780 X=2*PI*FL*Z
790 PRINT " ENTER: Radius of cutout on stator plates (";M$;")";:INPUT Z:R1=Z*M
800 CLS
810 PRINT USING " Maximun capacitance......... ####.### pF";CMAX
820 PRINT USING " Minimum capacitance......... ####.### pF";CMIN
830 PRINT USING " Inductance.................. ####.### µH";Z
840 PRINT USING " Lowest frequency, FL........ ####.### MHz";FL
850 PRINT USING " Reactance at FL............. ####.### ohms";X
860 PRINT USING " Stator cutout radius........ ####.### ";R1/M;:PRINT M$
870 PRINT USING " Gap between plates.......... ####.### ";DLC*M;:PRINT M$
880 PRINT USING " Volts per mil............... ####.### ";VM
890 PRINT USING " Arcing limit................ ####.### volts";V
900 LN=CSRLIN:INPUT " ENTER: a reasonable number of plates";N
910 IF N<2 THEN 900
920 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
930 PRINT USING " Number of plates............ ####";N
940 NLC= N-1
950 DUC=1/(2*PI*SQR(LUC))
960 FLC=DUC/SQR(CUCMAX)
970 DF=(FH-FL)*1000000.0! :CD=DF/12
980 AM=A(1)
990 KUC=DF/PI :REM'Forbes' K factor
1000 KLC=10^-11/(36*PI*DLC) :REM' Forbes' k factor
1010 ARE=CUCMAX/KLC/NLC
1020 GOSUB 1470
1030 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1040 PRINT USING "Frequency............... ####.### MHz";FLC/10^6
1050 PRINT USING "Capacitance............. ####.### pF";C
1060 PRINT USING "Inductance.............. ####.### µH";LUC*10^6
1070 PRINT USING "Number of plates........ ####.### ";N
1080 PRINT USING "Radius of shaft bulge... ####.### cm.";R1
1090 CLS
1100 PRINT "The program calculates plotting data for capacitor plates consis";
1110 PRINT "ting of 12";
1120 PRINT "segments, each 15°wide, radiating from the centre of the capacito";
1130 PRINT "r shaft."
1140 PRINT
1150 PRINT "RADIAL"TAB(15)M$" & ANGLE"TAB(32)"CAPACITANCE";
1160 PRINT  TAB(49)"FREQ."TAB(61)"SHAFT ROTATION"
1170 FOR H=0 TO 12
1180 B=DUC/KUC/SQR(CUCMIN)
1190 FHZ=FH*10^6-H*CD
1200 C=(1/4/PI^2/FHZ^2/LUC)*999999995904.0! :REM' Capacitance in pF
1210 F=SQR(25330.2890625!/C/LUC)/10^3  :REM' Frequency in MHz
1220 Q1=(B-A(H))^3
1230 Q2=(NLC*KLC*KUC^2*Q1)
1240 Q3=(4*DUC^2)/Q2
1250 R(H)=SQR(Q3+R1^2)
1260 PRINT "  #";H+1;
1270 LOCATE CSRLIN,10:PRINT USING" ###.## long @ ###°";R(H)/M,A(H)*180/PI;
1280 PRINT USING  "   ####.### pF";C;
1290 PRINT USING  " ####.### MHz";F;
1300 PRINT TAB(65);180-15*H;"°"
1310 NEXT H
1320 PRINT
1330 Z=DLC:IF Z<0.05000000074505806! THEN Z=0.05000000074505806!
1340 PRINT N"plates,";
1350 PRINT USING " ##.### ";DLC*M;:PRINT M$; " gap betwwen plates";
1360 PRINT " (arcing limit =";:PRINT USING " ##### volts";V;:PRINT ")"
1370 PRINT TAB(20)" To decrease plate size use more plates."
1380 PRINT TAB(20)" To increase plate size use fewer plates."
1390 PRINT
1400 LN=CSRLIN:PRINT TAB(20)" Want to change number of plates?   (y/n)"
1410 Z$=INKEY$:IF Z$=""THEN 1410
1420 IF Z$="n"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1450
1430 IF Z$="y"THEN 800
1440 GOTO 1410
1450 :REM'.....end
1460 GOSUB 1470:CLS:GOTO 120
1470 :REM'.....PRT
1480 KEY OFF:GOSUB 1550:LOCATE 25,5:COLOR 0,2
1490 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1500 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1510 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1510 :ELSE GOSUB 1550
1520 IF Z$="3"THEN RETURN
1530 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1540 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1480
1550 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
