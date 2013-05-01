10 :REM'GAPLOT - Variable Capacitor Plate Designer - 30 DEC 2007
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
300 PRINT "voltage, gap "
310 PRINT "between plates, and radius of the of the shaft cutout in the fixed";
320 PRINT " stator "
330 PRINT "plates."
340 PRINT
350 PRINT "If the application is for link coupled tuners, first run the `Link ";
360 PRINT "Coupled"
370 PRINT "Tuners' program for input values required by this program."
380 PRINT
390 PRINT "If the physical size of the capacitor is not practical run Hamcalc";
400 PRINT "'s"
410 PRINT "`Capacitors - Trimmer' program to selcet an appropriate capacitor/";
420 PRINT "trimmer "
430 PRINT "combination."
440 PRINT
450 LOCATE ,20
460 COLOR 0,7:PRINT ".....Press 1 to continue or 0 to exit.....":COLOR 7,0
470 Z$=INKEY$:IF Z$=""THEN 470
480 IF Z$="0"THEN RUN GO$
490 IF Z$="1"THEN CLS:GOTO 510
500 GOTO 470
510 :REM'.....calculation
520 PRINT
530 PRINT "    Want to enter dimensions in centimetres or inches?   (c/i)"
540 Z$=INKEY$:IF Z$=""THEN 540
550 IF Z$="c"THEN M=1:M$="cm.":GOTO 580
560 IF Z$="i"THEN M=2.5399999618530273!:M$="in.":GOTO 580
570 GOTO 540
580 CLS
590 KD=1.000599980354309!  :REM'dielectric constant for air
600 Q=0
610 INPUT " ENTER: Circuit voltage ";V
620 GAP=V/21/10^3*2.5399999618530273!   :REM'centimetres (21 is dielectric value of air)
630 CLS:PRINT USING " Maximum voltage..... #####.### volts";V
640 IF Q THEN PRINT USING " New gap = ##.###";Q;:PRINT " ";M$: DLC=Q:GOTO 670
650 PRINT USING " Suggested gap between plates = ##.### ";GAP/M;:PRINT M$
660 INPUT " ENTER: Your choice of gap ";DLC
670 DLC=DLC*M
680 VM=V/1000/DLC*2.5399999618530273!
690 PRINT USING " Volts per mil (.001 in.) = ###.### ";VM
700 LN=CSRLIN:PRINT " .....Press 1 to contimue or 0 to change gap....."
710 Z$=INKEY$:IF Z$=""THEN 710
720 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 740
730 IF Z$="0"THEN CLS:INPUT " New gap ";Q:V=Q*21*10^3:GOTO 630
740 INPUT " ENTER: Capacitance of Variable Capacitor fully CLOSED (pF)";CMAX
750 INPUT " ENTER: Capacitance of Variable Capacitor fully OPEN (pF)";CMIN
760 CUCMAX=CMAX/10^12 :CUCMIN=CMIN/10^12
770 INPUT " ENTER: Inductance of tuned circuit in uH";Z
780 LUC=Z/10^6
790 FL=1/(2*PI*SQR(Z*CMAX))*1000.0! :FH=1/(2*PI*SQR(Z*CMIN))*1000.0!
800 X=2*PI*FL*Z
810 PRINT " ENTER: Radius of cutout on stator plates (";M$;")";:INPUT Z:R1=Z*M
820 CLS
830 PRINT USING " Maximun capacitance......... ####.### pF";CMAX
840 PRINT USING " Minimum capacitance......... ####.### pF";CMIN
850 PRINT USING " Inductance.................. ####.### µH";LUC*10^6
860 PRINT USING " Lowest frequency, FL........ ####.### MHz";FL
870 PRINT USING " Reactance at FL............. ####.### ohms";X
880 PRINT USING " Stator cutout radius........ ####.### ";R1/M;:PRINT M$
890 PRINT USING " Voltage..................... ####.### volts";V
900 PRINT USING " Gap between plates.......... ####.### ";DLC/M;:PRINT M$
910 PRINT USING " Volts per mil............... ####.### ";VM
920 LN=CSRLIN:INPUT " ENTER: a reasonable number of plates";N
930 IF N<2 THEN 920
940 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
950 PRINT USING " Number of plates............ ####";N
960 NLC= N-1
970 DUC=1/(2*PI*SQR(LUC))
980 FLC=DUC/SQR(CUCMAX)
990 DF=(FH-FL)*1000000.0! :CD=DF/12
1000 AM=A(1)
1010 KUC=DF/PI :REM'Forbes' K factor
1020 KLC=10^-11/(36*PI*DLC) :REM' Forbes' k factor
1030 ARE=CUCMAX/KLC/NLC
1040 GOSUB 1490
1050 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1060 PRINT USING "Frequency............... ####.### MHz";FLC/10^6
1070 PRINT USING "Capacitance............. ####.### pF";C
1080 PRINT USING "Inductance.............. ####.### µH";LUC*10^6
1090 PRINT USING "Number of plates........ ####.### ";N
1100 PRINT USING "Radius of shaft bulge... ####.### cm.";R1
1110 CLS
1120 PRINT "The program calculates plotting data for capacitor plates consis";
1130 PRINT "ting of 12";
1140 PRINT "segments, each 15°wide, radiating from the centre of the capacito";
1150 PRINT "r shaft."
1160 PRINT
1170 PRINT "RADIAL"TAB(15)M$" & ANGLE"TAB(32)"CAPACITANCE";
1180 PRINT  TAB(49)"FREQ."TAB(61)"SHAFT ROTATION"
1190 FOR H=0 TO 12
1200 B=DUC/KUC/SQR(CUCMIN)
1210 FHZ=FH*10^6-H*CD
1220 C=(1/4/PI^2/FHZ^2/LUC)*999999995904.0! :REM' Capacitance in pF
1230 F=SQR(25330.2890625!/C/LUC)/10^3  :REM' Frequency in MHz
1240 Q1=(B-A(H))^3
1250 Q2=(NLC*KLC*KUC^2*Q1)
1260 Q3=(4*DUC^2)/Q2
1270 R(H)=SQR(Q3+R1^2)
1280 PRINT "  #";H+1;
1290 LOCATE CSRLIN,10:PRINT USING" ###.## long @ ###°";R(H)/M,A(H)*180/PI;
1300 PRINT USING  "   ####.### pF";C;
1310 PRINT USING  " ####.### MHz";F;
1320 PRINT TAB(65);180-15*H;"°"
1330 NEXT H
1340 PRINT
1350 Z=DLC:IF Z<0.05000000074505806! THEN Z=0.05000000074505806!
1360 PRINT N"plates,";
1370 PRINT USING " ##.### ";DLC/M;:PRINT M$; " gap betwwen plates";
1380 PRINT " (arcing limit =";:PRINT USING " ##### volts";V;:PRINT ")"
1390 PRINT TAB(20)" To decrease plate size use more plates."
1400 PRINT TAB(20)" To increase plate size use fewer plates."
1410 PRINT
1420 LN=CSRLIN:PRINT TAB(20)" Want to change number of plates?   (y/n)"
1430 Z$=INKEY$:IF Z$=""THEN 1430
1440 IF Z$="n"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1470
1450 IF Z$="y"THEN 820
1460 GOTO 1430
1470 :REM'.....end
1480 GOSUB 1490:CLS:GOTO 120
1490 :REM'.....PRT
1500 KEY OFF:GOSUB 1570:LOCATE 25,5:COLOR 0,2
1510 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1520 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1530 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1530 :ELSE GOSUB 1570
1540 IF Z$="3"THEN RETURN
1550 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1560 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1500
1570 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
