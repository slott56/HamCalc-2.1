10 :REM'WINDING - 03 FEB 90 rev.13 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 DIM AWG(40,2)
60 U3$="####.###"
70 UL$=STRING$(80,205)
80 ER$=STRING$(80,32)
90 PI=3.1415929794311523!
100 X=96        :REM'chr$ counter
110 :REM'
120 :REM'.....wire diameter
130 DATA .2893,.2576,.2294,.2043,.1819,.1620,.1443,.1285,.1144,.1019
140 DATA .0907,.0808,.0720,.0641,.0571,.0508,.0453,.0403,.0359,.0320
150 DATA .0285,.0253,.0226,.0201,.0179,.0159,.0142,.0126,.0113,.0100
160 DATA .00893,.00795,.00708,.00630,.00561,.005,.00445,.00396,.00353,.00314
170 FOR Z=1 TO 40:READ AWG(Z,1):NEXT Z
180 :REM'
190 :REM'.....ohms per 1000 ft.
200 DATA .1264,.1593,.2009,.2533,.3195,.4028,.5080,.6405,.8077,1.018
210 DATA 1.284,1.619,2.042,2.575,3.247,4.094,5.163,6.510,8.210,10.35
220 DATA 13.05,16.46,20.76,26.17,33.00,41.62,52.48,66.17,83.44,105.2
230 DATA 132.7,167.3,211.0,266.0,335.0,423.0,533.0,673.0,848.0,1070
240 DATA 41.62,66.17,105.2,167.3,266,423,673,1070
250 FOR Z=1 TO 40:READ AWG(Z,2):NEXT Z
260 :REM'
270 T$=" POWER TRANSFORMER WINDINGS"+STRING$(29,32)+"by GEORGE MURPHY VE3ERP "
280 :REM'
290 :REM'.....start
300 CLS
310 COLOR 15,2
320 PRINT T$;
330 COLOR 1,0:PRINT STRING$(80,223);
340 COLOR 7,0
350 GOSUB 1240      :REM'print text
360 COLOR 0,7:LOCATE 25,22
370 PRINT " Press 1 to continue or 0 to EXIT.....";
380 COLOR 7,0
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="0"THEN CLS:RUN EX$
410 IF Z$="1"THEN 430
420 GOTO 390
430 GOSUB 1660      :REM'screen dump
440 :REM'
450 :REM'.....start
460 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
470 :REM'.....input voltages
480 INPUT " ENTER: Voltage of High Voltage winding.....................";HV
490 IF HV=0 THEN LOCATE CSRLIN-1:GOTO 480
500 LOCATE CSRLIN-1:PRINT STRING$(7,32)
510 LOCATE CSRLIN-1,61:PRINT USING U3$;HV;:PRINT " volts"
520 INPUT " ENTER: Voltage of Low Voltage winding......................";LV
530 IF LV=0 THEN LOCATE CSRLIN-1:GOTO 520
540 LOCATE CSRLIN-1:PRINT STRING$(7,32)
550 LOCATE CSRLIN-1,61:PRINT USING U3$;LV;:PRINT " volts"
560 HL=HV/LV                  :REM'HL=ratio
570 PRINT TAB(9);"Turns ratio................................................"
580 LOCATE CSRLIN-1:PRINT STRING$(7,32)
590 LOCATE CSRLIN-1,61:PRINT USING U3$;HL;:PRINT " : 1"
600 INPUT " ENTER: Measured diameter of wire in High Voltage Winding...";W
610 LOCATE CSRLIN-1:PRINT STRING$(7,32)
620 LOCATE CSRLIN-1,61:PRINT USING U3$;W;:PRINT " inches"
630 FOR Z=40 TO 1 STEP-1
640 IF AWG(Z,1)>=W THEN GA=Z:GOTO 660
650 NEXT Z
660 GOSUB 730
670 FOR Z=1 TO 40
680 IF AWG(Z,1)<=W THEN GA=Z:GOTO 700
690 NEXT Z
700 GOSUB 730
710 GOTO 830
720 :REM'
730 :REM'.....display
740 X=X+1     :REM'chr$ counter
750 GA(X-96)=GA
760 PRINT "   (";CHR$(X);")  ";
770 PRINT "AWG";USING "###";GA;
780 DI=AWG(GA,1)
790 PRINT " is ";USING ".####";DI;
800 PRINT CHR$(34);" dia."
810 RETURN
820 :REM'
830 PRINT " Press letter in ( ) to select probable actual gauge of wire..."
840 Z$=INKEY$
850 IF Z$="a"OR Z$="A"THEN GA=GA(1):GOTO 880
860 IF Z$="b"OR Z$="B"THEN GA=GA(2):GOTO 880
870 GOTO 840
880 LOCATE CSRLIN-1:PRINT ER$;:LOCATE CSRLIN-1
890 FOR Z=CSRLIN-2 TO CSRLIN-1:LOCATE Z:PRINT STRING$(6,32):NEXT Z
900 PRINT TAB(9);"The gauge of wire is probably AWG";GA
910 PRINT TAB(9);"AWG";GA;"copper wire resistance......................";
920 PRINT TAB(61);USING U3$;AWG(GA,2);:PRINT " ohms/M ft."
930 CM=(AWG(GA,1)*1000)^2              :REM'circular mils
940 CAP=CM/700                         :REM'capacity @ 700 CM/amp
950 VA=HV*CAP
960 PRINT TAB(8);" Approximate volt/ampere rating..........................."
970 LOCATE CSRLIN-1,61:PRINT USING "####.#";VA;:PRINT "   VA."
980 :REM'
990 INPUT " ENTER: Measured resistance of High Voltage winding...(ohms)";RH
1000 LOCATE CSRLIN-1:PRINT STRING$(7,32)
1010 LOCATE CSRLIN-1,61:PRINT USING U3$;RH;:PRINT " ohms"
1020 PRINT UL$;
1030 LH=1000/AWG(GA,2)*RH*12
1040 PRINT " HIGH VOLTAGE WINDING: Estimated length of wire..................."
1050 LOCATE CSRLIN-1,61:PRINT USING U3$;LH;:PRINT " inches"
1060 PRINT TAB(60);"=";USING U3$;LH/12;:PRINT " feet"
1070 PRINT TAB(23);"Current capacity @ 700 circ.mils/amp =";
1080 PRINT USING U3$;CAP;:PRINT " amps"
1090 PRINT TAB(44);"Inches per volt =";USING U3$;LH/HV;:PRINT " inches"
1100 PRINT UL$;
1110 LL=LH/HL
1120 PRINT " LOW VOLTAGE WINDING: Estimated length of wire...................."
1130 LOCATE CSRLIN-1,61:PRINT USING U3$;LL;:PRINT " inches"
1140 PRINT TAB(60);"=";USING U3$;LL/12;:PRINT " feet"
1150 CAP=CAP*HL
1160 PRINT TAB(23);"Current capacity @ 700 circ.mils/amp =";
1170 PRINT USING U3$;CAP;:PRINT " amps"
1180 PRINT TAB(44);"Inches per volt =";USING U3$;LL/LV;:PRINT " inches"
1190 PRINT UL$;
1200 GOSUB 1660
1210 GOTO 290   :REM'start
1220 END
1230 :REM'
1240 :REM'.....text block
1250 TB=7     :REM'tab for text
1260 PRINT TAB(TB);
1270 PRINT "This program estimates the lengths of transformer windings. To use"
1280 PRINT TAB(TB);
1290 PRINT "the program you will need two precision instruments:"
1300 PRINT
1310 PRINT TAB(TB);
1320 PRINT "  - a micrometer or vernier caliper capable of measuring wire"
1330 PRINT TAB(TB);
1340 PRINT "diameters to within .001 in. accuracy....."
1350 PRINT
1360 PRINT TAB(TB);
1370 PRINT "  - a high quality digital ohmeter capable of measuring resistances"
1380 PRINT TAB(TB);
1390 PRINT "of less than 1Ω to two or three decimal places....."
1400 PRINT
1410 PRINT TAB(TB);
1420 PRINT "You can check your meter by measuring the resistance of a long"
1430 PRINT TAB(TB);
1440 PRINT "length of wire and, by using the HAMCALC copper wire programs,"
1450 PRINT TAB(TB);
1460 PRINT "calculate what the resistance should be. For instance, the #14"
1470 PRINT TAB(TB);
1480 PRINT "conductors in a 50 metre spool of house wiring at your local"
1490 PRINT TAB(TB);
1500 PRINT "builders' supply store should have a resistance of 0.42 ohms."
1510 PRINT
1520 PRINT TAB(TB);
1530 PRINT "The program assumes the length of one turn of wire to be the same"
1540 PRINT TAB(TB);
1550 PRINT "for both windings and all turns contain the same length of wire."
1560 PRINT TAB(TB);
1570 PRINT "This is rarely the actual case, therefore the calculations made by"
1580 PRINT TAB(TB);
1590 PRINT "the program must be considered as approximate only, but adequate"
1600 PRINT TAB(TB);
1610 PRINT "enough to affect your decision whether or not to open up the"
1620 PRINT TAB(TB);
1630 PRINT "transformer to see what is REALLY inside !"
1640 RETURN
1650 :REM'
1660 :REM'PRT
1670 KEY OFF:GOSUB 1740:LOCATE 25,5:COLOR 0,2
1680 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1690 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1700 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1700 :ELSE GOSUB 1740
1710 IF Z$="3"THEN RETURN
1720 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1730 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1670
1740 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
