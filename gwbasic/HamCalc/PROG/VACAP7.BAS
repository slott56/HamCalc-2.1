10 :REM'vacap7 - 22 DEC 2007
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
580 G=7.196699880296364e-05!
590 GAP=G*V-0.01269999984651804!  :REM'air gap
600 IF GAP<0.007000000216066837! THEN GAP=0.007000000216066837!
610 PRINT USING " Minimum gap between plates = ##.### ";GAP/M;:PRINT M$
620 INPUT " ENTER: Your choice of gap (not less than the above)";DLC
630 IF DLC<GAP/M THEN 620
640 DLC=DLC*M
650 ARC=(M*DLC/M+0.01269999984651804!)/G
660 PRINT USING " Maximum allowable voltage = ##### volts";ARC
670 VM=ARC/DLC*2.5399999618530273!/10^3   :REM'volts per mil
680 PRINT " Volts per mil (.001 in.)=";VM
690 LN=CSRLIN:PRINT " .....Press 1 to contimue or 0 to change gap....."
700 Z$=INKEY$:IF Z$=""THEN 700
710 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 730
720 IF Z$="0"THEN CLS:GOTO 580
730 INPUT " ENTER: Capacitance of Variable Capacitor fully CLOSED (pF)";CMAX
740 INPUT " ENTER: Capacitance of Variable Capacitor fully OPEN (pF)";CMIN
750 CUCMAX=CMAX/10^12 :CUCMIN=CMIN/10^12
760 INPUT " ENTER: Inductance of tuned circuit in uH";Z
770 LUC=Z/10^6
780 FL=1/(2*PI*SQR(Z*CMAX))*1000.0! :FH=1/(2*PI*SQR(Z*CMIN))*1000.0!
790 X=2*PI*FL*Z
800 PRINT " ENTER: Radius of cutout on stator plates (";M$;")";:INPUT Z:R1=Z*M
810 CLS
820 PRINT USING " Maximun capacitance......... ####.### pF";CMAX
830 PRINT USING " Minimum capacitance......... ####.### pF";CMIN
840 PRINT USING " Inductance.................. ####.### µH";Z
850 PRINT USING " Lowest frequency, FL........ ####.### MHz";FL
860 PRINT USING " Reactance at FL............. ####.### ohms";X
870 PRINT USING " Stator cutout radius........ ####.### ";R1/M;:PRINT M$
880 PRINT USING " Gap between plates.......... ####.### ";DLC/M;:PRINT M$
890 LN=CSRLIN:INPUT " ENTER: a reasonable number of plates";N
900 IF N<2 THEN 890
910 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
920 PRINT USING " Number of plates............ ####";N
930 NLC= N-1
940 DUC=1/(2*PI*SQR(LUC))
950 FLC=DUC/SQR(CUCMAX)
960 DF=(FH-FL)*1000000.0! :CD=DF/12
970 AM=A(1)
980 KUC=DF/PI :REM'Forbes' K factor
990 KLC=10^-11/(36*PI*DLC) :REM' Forbes' k factor
1000 ARE=CUCMAX/KLC/NLC
1010 GOSUB 1460
1020 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1030 PRINT USING "Frequency............... ####.### MHz";FLC/10^6
1040 PRINT USING "Capacitance............. ####.### pF";C
1050 PRINT USING "Inductance.............. ####.### µH";LUC*10^6
1060 PRINT USING "Number of plates........ ####.### ";N
1070 PRINT USING "Radius of shaft bulge... ####.### cm.";R1
1080 CLS
1090 PRINT "The program calculates plotting data for capacitor plates consis";
1100 PRINT "ting of 12";
1110 PRINT "segments, each 15°wide, radiating from the centre of the capacito";
1120 PRINT "r shaft."
1130 PRINT
1140 PRINT "RADIAL"TAB(15)M$" & ANGLE"TAB(32)"CAPACITANCE";
1150 PRINT  TAB(49)"FREQ."TAB(61)"SHAFT ROTATION"
1160 FOR H=0 TO 12
1170 B=DUC/KUC/SQR(CUCMIN)
1180 FHZ=FH*10^6-H*CD
1190 C=(1/4/PI^2/FHZ^2/LUC)*999999995904.0! :REM' Capacitance in pF
1200 F=SQR(25330.2890625!/C/LUC)/10^3  :REM' Frequency in MHz
1210 Q1=(B-A(H))^3
1220 Q2=(NLC*KLC*KUC^2*Q1)
1230 Q3=(4*DUC^2)/Q2
1240 R(H)=SQR(Q3+R1^2)
1250 PRINT "  #";H+1;
1260 LOCATE CSRLIN,10:PRINT USING" ###.## long @ ###°";R(H)/M,A(H)*180/PI;
1270 PRINT USING  "   ####.### pF";C;
1280 PRINT USING  " ####.### MHz";F;
1290 PRINT TAB(65);180-15*H;"°"
1300 NEXT H
1310 PRINT
1320 Z=DLC:IF Z<0.05000000074505806! THEN Z=0.05000000074505806!
1330 PRINT N"plates,";
1340 PRINT USING " ##.### ";DLC/M;:PRINT M$; " gap betwwen plates";
1350 PRINT " (arcing limit =";:PRINT USING " ##### volts";ARC;:PRINT ")"
1360 PRINT TAB(20)" To decrease plate size use more plates."
1370 PRINT TAB(20)" To increase plate size use fewer plates."
1380 PRINT
1390 LN=CSRLIN:PRINT TAB(20)" Want to change number of plates?   (y/n)"
1400 Z$=INKEY$:IF Z$=""THEN 1400
1410 IF Z$="n"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:GOTO 1440
1420 IF Z$="y"THEN 810
1430 GOTO 1400
1440 :REM'.....end
1450 GOSUB 1460:CLS:GOTO 120
1460 :REM'.....PRT
1470 KEY OFF:GOSUB 1540:LOCATE 25,5:COLOR 0,2
1480 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1490 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1500 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1500 :ELSE GOSUB 1540
1510 IF Z$="3"THEN RETURN
1520 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1530 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1470
1540 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
