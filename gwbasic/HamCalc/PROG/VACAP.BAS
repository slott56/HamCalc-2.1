10 :REM'VACAP - 21 DEC 2007
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
290 PRINT "Required inputs are gap between plates, capacitances in pF, inducta";
300 PRINT "nce in µH"
310 PRINT "and radius of the shaft cutout in the fixed stator plates."
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
580 G=7.196699880296364e-05!
590 GAP=G*V-0.01269999984651804!  :REM'air gap
600 IF GAP<0.007000000216066837! THEN GAP=0.007000000216066837!
610 PRINT USING " Minimum gap between plates = ##.### ";GAP/M;:PRINT M$
620 INPUT " ENTER: Your choice of gap (not less than the above)";DLC
630 IF DLC<GAP/M THEN 620
640 ARC=(M*DLC+0.01269999984651804!)/G
650 PRINT USING " Maximum allowable voltage = ##### volts";ARC
660 LN=CSRLIN:PRINT " .....Press 1 to contimue or 0 to change gap....."
670 Z$=INKEY$:IF Z$=""THEN 670
680 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 700
690 IF Z$="0"THEN CLS:GOTO 580
700 INPUT " ENTER: Capacitance of Variable Capacitor fully CLOSED (pF)";CMAX
710 INPUT " ENTER: Capacitance of Variable Capacitor fully OPEN (pF)";CMIN
720 CUCMAX=CMAX/10^12 :CUCMIN=CMIN/10^12
730 INPUT " ENTER: Inductance of tuned circuit in uH";Z
740 LUC=Z/10^6
750 FL=1/(2*PI*SQR(Z*CMAX))*1000.0! :FH=1/(2*PI*SQR(Z*CMIN))*1000.0!
760 X=2*PI*FL*Z
770 PRINT " ENTER: Radius of cutout on stator plates (";M$;")";:INPUT Z:R1=Z*M
780 CLS
790 PRINT USING " Maximun capacitance......... ####.### pF";CMAX
800 PRINT USING " Minimum capacitance......... ####.### pF";CMIN
810 PRINT USING " Inductance.................. ####.### µH";Z
820 PRINT USING " Lowest frequency, FL........ ####.### MHz";FL
830 PRINT USING " Reactance at FL............. ####.### ohms";X
840 PRINT USING " Stator cutout radius........ ####.### ";R1/M;:PRINT M$
850 PRINT USING " Gap between plates.......... ####.### ";DLC*M;:PRINT M$
860 LN=CSRLIN:INPUT " ENTER: a reasonable number of plates";N
870 IF N<2 THEN 860
880 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
890 PRINT USING " Number of plates............ ####";N
900 NLC= N-1
910 DUC=1/(2*PI*SQR(LUC))
920 FLC=DUC/SQR(CUCMAX)
930 DF=(FH-FL)*1000000.0! :CD=DF/12
940 AM=A(1)
950 KUC=DF/PI :REM'Forbes' K factor
960 KLC=10^-11/(36*PI*DLC) :REM' Forbes' k factor
970 ARE=CUCMAX/KLC/NLC
980 GOSUB 1430
990 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1000 PRINT USING "Frequency............... ####.### MHz";FLC/10^6
1010 PRINT USING "Capacitance............. ####.### pF";C
1020 PRINT USING "Inductance.............. ####.### µH";LUC*10^6
1030 PRINT USING "Number of plates........ ####.### ";N
1040 PRINT USING "Radius of shaft bulge... ####.### cm.";R1
1050 CLS
1060 PRINT "The program calculates plotting data for capacitor plates consis";
1070 PRINT "ting of 12";
1080 PRINT "segments, each 15°wide, radiating from the centre of the capacito";
1090 PRINT "r shaft."
1100 PRINT
1110 PRINT "RADIAL"TAB(15)M$" & ANGLE"TAB(32)"CAPACITANCE";
1120 PRINT  TAB(49)"FREQ."TAB(61)"SHAFT ROTATION"
1130 FOR H=0 TO 12
1140 B=DUC/KUC/SQR(CUCMIN)
1150 FHZ=FH*10^6-H*CD
1160 C=(1/4/PI^2/FHZ^2/LUC)*999999995904.0! :REM' Capacitance in pF
1170 F=SQR(25330.2890625!/C/LUC)/10^3  :REM' Frequency in MHz
1180 Q1=(B-A(H))^3
1190 Q2=(NLC*KLC*KUC^2*Q1)
1200 Q3=(4*DUC^2)/Q2
1210 R(H)=SQR(Q3+R1^2)
1220 PRINT "  #";H+1;
1230 LOCATE CSRLIN,10:PRINT USING" ###.## long @ ###°";R(H)/M,A(H)*180/PI;
1240 PRINT USING  "   ####.### pF";C;
1250 PRINT USING  " ####.### MHz";F;
1260 PRINT TAB(65);180-15*H;"°"
1270 NEXT H
1280 PRINT
1290 Z=DLC:IF Z<0.05000000074505806! THEN Z=0.05000000074505806!
1300 PRINT N"plates,";
1310 PRINT USING " ##.### ";DLC;:PRINT M$; " gap betwwen plates";
1320 PRINT " (arcing limit =";:PRINT USING " ##### volts";ARC;:PRINT ")"
1330 PRINT TAB(20)" To decrease plate size use more plates."
1340 PRINT TAB(20)" To increase plate size use fewer plates."
1350 PRINT
1360 LN=CSRLIN:PRINT TAB(20)" Want to change number of plates?   (y/n)"
1370 Z$=INKEY$:IF Z$=""THEN 1370
1380 IF Z$="n"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1410
1390 IF Z$="y"THEN 780
1400 GOTO 1370
1410 :REM'.....end
1420 GOSUB 1430:CLS:GOTO 120
1430 :REM'.....PRT
1440 KEY OFF:GOSUB 1510:LOCATE 25,5:COLOR 0,2
1450 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1460 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1470 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1470 :ELSE GOSUB 1510
1480 IF Z$="3"THEN RETURN
1490 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1500 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1440
1510 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
