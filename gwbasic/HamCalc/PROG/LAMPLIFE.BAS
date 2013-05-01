10 :REM'LAMPLIFE - Lamp life ratings - 25 MAY 97 rev. 20 MAR 2000
20 IF EX$=""THEN EX$="EXIT"
30 KEY OFF
40 U$=STRING$(57,205)
50 U1$=" @####.## volts is about"
60 U2$="#####.## x rated life expectancy "
70 U3$=" =####,### hours"
80 COLOR 7,0,1
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2
130 PRINT " LAMP LIFE EXPECTANCY";
140 PRINT TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 780   :REM'preface
180 PRINT
190 COLOR 0,7:LOCATE CSRLIN,22
200 PRINT " Press 1 to continue or 0 to EXIT....."
210 COLOR 7,0
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="0"THEN CLS:RUN EX$
240 IF Z$="1" THEN 260
250 GOTO 220
260 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 4
270 INPUT " ENTER: Operating voltage of lamp circuit........";OV
280 PRINT
290 PRINT " Lamps rated at from";INT(OV*1.100000023841858!*10+0.5!)/10;"volts to";
300 PRINT INT(OV*2*10+0.5!)/10;"volts are recommended for this circuit."
310 PRINT
320 INPUT " ENTER: Your choice of lamp voltage rating.......";VR
330 PRINT
340 LR=0:PRINT " Do you know the life rating of the lamp chosen?  (y/n)"
350 Z$=INKEY$:IF Z$=""THEN 350
360 IF Z$="n"THEN 430
370 IF Z$="y"THEN 390
380 GOTO 350
390 PRINT
400 INPUT " ENTER: Life rating, in hours ..................";LR
410 :REM'
420 :REM'.....screen display
430 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
440 IF LR THEN LR$=STR$(LR)+" hr. ":ELSE LR$=" "
450 COLOR 15,6
460 VR$=STR$(VR)
470 Y$=VR$+" v."+LR$+"incandescent lamp real life expectancy "
480 LG=LEN(Y$)
490 PRINT:PRINT Y$
500 COLOR 7,0
510 IF LR THEN LOCATE CSRLIN-1,LG+1:PRINT STRING$(66-LG,196);"┐"
520 PRINT U$
530 IF LR THEN LOCATE CSRLIN-1,61:PRINT STRING$(6,205);"╧";STRING$(6,205)
540   FOR X=1.4666659832000732! TO 0.46000000834465027! STEP -0.06666666269302368!
550 VD=VR*X:LD=(VR/VD)^12
560 IF X=<1.0099999904632568! AND X>0.9900000095367432! THEN COLOR 15,6 :ELSE COLOR 7,0
570 PRINT USING U1$;VD,
580 IF X<>1.4666659832000732! THEN 600
590 PRINT USING "#####.##";0;:PRINT " (expect early burn-out)":GOTO 650
600 PRINT USING U2$;LD
610 IF LR=0 THEN 650
620 LOCATE CSRLIN-1,58:IF LD*LR<876*10^3 THEN 640
630 PRINT " = a very long time":GOTO 650
640 PRINT USING U3$;LD*LR
650   NEXT X
660 PRINT U$
670 LD=(VR/OV)^12
680 COLOR 15,6
690 PRINT USING U1$;OV,
700 PRINT USING U2$;LD
710 IF LR=0 THEN 750
720 LOCATE CSRLIN-1,58:IF LD*LR<876*10^3 THEN 740
730 PRINT " = a very long time":GOTO 750
740 PRINT USING U3$;LD*LR
750 COLOR 7,0
760 GOTO 1190  :REM'end
770 :REM'
780 :REM'.....preface
790 LOCATE 2,22
800 COLOR 15,2:PRINT " ( with TNX to Bob Eldridge, VE7BS ) ":COLOR 7,0
810 PRINT
820 TB=7
830 PRINT TAB(TB);
840 PRINT "  The life expectancy of an incandescent lamp can be greatly"
850 PRINT TAB(TB);
860 PRINT "increased by operating it at a voltage less than its rated voltage."
870 PRINT TAB(TB);
880 PRINT "(In North America so-called Long Life lamp bulbs found in stores"
890 PRINT TAB(TB);
900 PRINT "are actually 130 volt lamps sold for applications where the standard"
910 PRINT TAB(TB);
920 PRINT "voltage is in the range of 110-117 volts)."
930 PRINT TAB(TB);
940 PRINT "  In amateur radio equipment, depending upon how much reduction in"
950 PRINT TAB(TB);
960 PRINT "illumination can be tolerated, lamps rated at from about 1.1 to 2"
970 PRINT TAB(TB);
980 PRINT "times the circuit operating voltage can be used to provide lighting"
990 PRINT TAB(TB);
1000 PRINT "ranging from about normally bright to moderately dim."
1010 PRINT TAB(TB);
1020 PRINT "  You can also reduce the operating voltage of lamps rated at the"
1030 PRINT TAB(TB);
1040 PRINT "same voltage as the operating circuit by inserting a resistor in"
1050 PRINT TAB(TB);
1060 PRINT "series with the lamp. This is desirable because it reduces the"
1070 PRINT TAB(TB);
1080 PRINT "inrush current. However, the resistance of a lamp filament varies"
1090 PRINT TAB(TB);
1100 PRINT "with the current passing through it so it is difficult to calculate"
1110 PRINT TAB(TB);
1120 PRINT "the resistance and wattage of the dropping resistor. Using a lamp"
1130 PRINT TAB(TB);
1140 PRINT "rated at a voltage higher than that of the operating circuit is"
1150 PRINT TAB(TB);
1160 PRINT "easier and does not require any re-wiring of the circuit."
1170 RETURN
1180 :REM'
1190 :REM'.....end
1200 GOSUB 1220:GOTO 100
1210 :REM'
1220 :REM'PRT
1230 KEY OFF:GOSUB 1300:LOCATE 25,5:COLOR 0,2
1240 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1250 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1260 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1260 :ELSE GOSUB 1300
1270 IF Z$="3"THEN RETURN
1280 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1290 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1230
1300 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
