10 :REM'vacap8 - 23 DEC 2007
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
580 INPUT "ENTER: Volts per mil (.001 in.) ";VM
590 INPUT "ENTER: Maximum volts ";V
600 DLC=V/VM/1000
610 CLS
620 PRINT USING " Volts par mil .... #####.###";VM
630 PRINT USING " Maximum volts .... #####.###";V
640 PRINT USING " Air gap........... #####.###";DLC*M;:PRINT " ";M$
650 LN=CSRLIN:PRINT " .....Press 1 to contimue or 0 to change gap....."
660 Z$=INKEY$:IF Z$=""THEN 660
670 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 690
680 IF Z$="0"THEN CLS:GOTO 580
690 INPUT " ENTER: Capacitance of Variable Capacitor fully CLOSED (pF)";CMAX
700 INPUT " ENTER: Capacitance of Variable Capacitor fully OPEN (pF)";CMIN
710 CUCMAX=CMAX/10^12 :CUCMIN=CMIN/10^12
720 INPUT " ENTER: Inductance of tuned circuit in uH";Z
730 LUC=Z/10^6
740 FL=1/(2*PI*SQR(Z*CMAX))*1000.0! :FH=1/(2*PI*SQR(Z*CMIN))*1000.0!
750 X=2*PI*FL*Z
760 PRINT " ENTER: Radius of cutout on stator plates (";M$;")";:INPUT Z:R1=Z*M
770 CLS
780 PRINT USING " Maximun capacitance......... ####.### pF";CMAX
790 PRINT USING " Minimum capacitance......... ####.### pF";CMIN
800 PRINT USING " Inductance.................. ####.### µH";Z
810 PRINT USING " Lowest frequency, FL........ ####.### MHz";FL
820 PRINT USING " Reactance at FL............. ####.### ohms";X
830 PRINT USING " Stator cutout radius........ ####.### ";R1/M;:PRINT M$
840 PRINT USING " Gap between plates.......... ####.### ";DLC*M;:PRINT M$
850 PRINT USING " Volts per mil............... ####.### ";VM
860 PRINT USING " Arcing limit................ ####.### volts";V
870 LN=CSRLIN:INPUT " ENTER: a reasonable number of plates";N
880 IF N<2 THEN 870
890 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
900 PRINT USING " Number of plates............ ####";N
910 NLC= N-1
920 DUC=1/(2*PI*SQR(LUC))
930 FLC=DUC/SQR(CUCMAX)
940 DF=(FH-FL)*1000000.0! :CD=DF/12
950 AM=A(1)
960 KUC=DF/PI :REM'Forbes' K factor
970 KLC=10^-11/(36*PI*DLC) :REM' Forbes' k factor
980 ARE=CUCMAX/KLC/NLC
990 GOSUB 1440
1000 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1010 PRINT USING "Frequency............... ####.### MHz";FLC/10^6
1020 PRINT USING "Capacitance............. ####.### pF";C
1030 PRINT USING "Inductance.............. ####.### µH";LUC*10^6
1040 PRINT USING "Number of plates........ ####.### ";N
1050 PRINT USING "Radius of shaft bulge... ####.### cm.";R1
1060 CLS
1070 PRINT "The program calculates plotting data for capacitor plates consis";
1080 PRINT "ting of 12";
1090 PRINT "segments, each 15°wide, radiating from the centre of the capacito";
1100 PRINT "r shaft."
1110 PRINT
1120 PRINT "RADIAL"TAB(15)M$" & ANGLE"TAB(32)"CAPACITANCE";
1130 PRINT  TAB(49)"FREQ."TAB(61)"SHAFT ROTATION"
1140 FOR H=0 TO 12
1150 B=DUC/KUC/SQR(CUCMIN)
1160 FHZ=FH*10^6-H*CD
1170 C=(1/4/PI^2/FHZ^2/LUC)*999999995904.0! :REM' Capacitance in pF
1180 F=SQR(25330.2890625!/C/LUC)/10^3  :REM' Frequency in MHz
1190 Q1=(B-A(H))^3
1200 Q2=(NLC*KLC*KUC^2*Q1)
1210 Q3=(4*DUC^2)/Q2
1220 R(H)=SQR(Q3+R1^2)
1230 PRINT "  #";H+1;
1240 LOCATE CSRLIN,10:PRINT USING" ###.## long @ ###°";R(H)/M,A(H)*180/PI;
1250 PRINT USING  "   ####.### pF";C;
1260 PRINT USING  " ####.### MHz";F;
1270 PRINT TAB(65);180-15*H;"°"
1280 NEXT H
1290 PRINT
1300 Z=DLC:IF Z<0.05000000074505806! THEN Z=0.05000000074505806!
1310 PRINT N"plates,";
1320 PRINT USING " ##.### ";DLC*M;:PRINT M$; " gap betwwen plates";
1330 PRINT " (arcing limit =";:PRINT USING " ##### volts";V;:PRINT ")"
1340 PRINT TAB(20)" To decrease plate size use more plates."
1350 PRINT TAB(20)" To increase plate size use fewer plates."
1360 PRINT
1370 LN=CSRLIN:PRINT TAB(20)" Want to change number of plates?   (y/n)"
1380 Z$=INKEY$:IF Z$=""THEN 1380
1390 IF Z$="n"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1420
1400 IF Z$="y"THEN 770
1410 GOTO 1380
1420 :REM'.....end
1430 GOSUB 1440:CLS:GOTO 120
1440 :REM'.....PRT
1450 KEY OFF:GOSUB 1520:LOCATE 25,5:COLOR 0,2
1460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1470 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1480 :ELSE GOSUB 1520
1490 IF Z$="3"THEN RETURN
1500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1450
1520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
