10 :REM'QUARTWAV - Quarter-Wave Transformer - 27 DEC 1998
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 PI=4*ATN(1)  :REM'3.141593
60 UL$=STRING$(80,205)
70 U1$="#####.###"
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2
120 PRINT " Quarter-Wave Transformer"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 :REM'.....start
170 GOSUB 1050  :REM'diagram
180 LN=21
190 LOCATE LN,9
200 PRINT "(ref. The ARRL ANTENNA BOOK, 17th edition, pp. 24-14 and 26-14)"
210 PRINT :LOCATE ,23:COLOR 0,7
220 PRINT " Press 1 to continue, or 0 to EXIT ":COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:RUN EX$
250 IF Z$="1"THEN GOSUB 1280:GOTO 280
260 GOTO 230
270 :REM'
280 LOCATE LN
290 INPUT " ENTER: Frequency of operation, in MHz";F
300 IF F=0 THEN GOSUB 1280:GOTO 190
310 COLOR 0,7:LOCATE 3,23
320 PRINT USING "Frequency of operation: ###.### MHz";F
330 LG=468/F:LOCATE 4,30
340 PRINT USING "###.## m.(###.## ft.)";LG*0.30480000376701355!,LG
350 :REM'.....antenna impedance
360 COLOR 7,0:GOSUB 1280
370 COLOR 0,7:LOCATE 6,39:PRINT "╖A╓":COLOR 7,0:LOCATE LN
380 ZL=0:INPUT " ENTER: Antenna load, resistive component......(ohms)";RL
390 IF RL=0 THEN GOSUB 1280:LOCATE LN:GOTO 380
400 GOSUB 1280:LOCATE LN
410 PRINT " Is reactive component (i)nductive, (c)apacitive or (n)il?  (i/c/n) "
420 Z$=INKEY$:IF Z$=""THEN 420
430 IF Z$="i"THEN X$="inductive component..":XS=+1:XS$="+j":GOTO 470
440 IF Z$="c"THEN X$="capacitive component.":XS=-1:XS$="-j":GOTO 470
450 IF Z$="n"THEN X$="reactive component...":XS=+1:XS$="+j":GOTO 470
460 GOTO 400
470 GOSUB 1280
480 IF Z$="n"THEN 500
490 LOCATE LN:PRINT " ENTER: Value of ";X$;".....(ohms)";:INPUT Z:Z=ABS(Z)
500 XL=ABS(Z)*XS:ZL=RL+XL
510 ANT$=STR$(RL)+XS$+RIGHT$(STR$(Z),LEN(STR$(Z))-1)+" ohms"
520 COLOR 0,7:LOCATE 16,20
530 PRINT " Antenna impedance    = "+ANT$
540 COLOR 7,0:GOSUB 1280
550 COLOR 0,7:LOCATE 17,21
560 PRINT USING "Impedance at point A =####.## ohms";ZL
570 :REM'.....line impedance
580 COLOR 7,0:GOSUB 1280:LOCATE LN
590 INPUT " ENTER: Characteristic impedance of transmission line, in ohms";ZI
600 GOSUB 1280
610 COLOR 0,7:LOCATE 12,39:PRINT "╜B╙"
620 LOCATE 18,21:PRINT USING "Impedance at point B =####.## ohms";ZI
630 LOCATE 14,43
640 PRINT USING "«──####.# Ω line";ZI
650 :REM'.....matching section
660 Z0=SQR(ZI*ZL)
670 COLOR 0,7:LOCATE 8,42
680 PRINT USING "«──####.# Ω line";Z0
690 L=234/F
700 LOCATE 9,45:PRINT USING "####.## m. long";L*0.30480000376701355!
710 LOCATE 10,45:PRINT USING "(###.## ft.)";L
720 :REM'.....open-wire calculation
730 COLOR 7,0:GOSUB 1280:LOCATE LN
740 COLOR 0,7
750 PRINT " Wire dia.: AWG #16= 1.31mm,";
760 PRINT " #14= 2.08mm, #12= 3.3mm, #10= 5.26mm, #8= 8.37mm  "
770 PRINT " Tube dia.: 1/4in.= 6.35mm,";
780 PRINT " 1/2in.= 12.7mm, 3/4in.= 19.1mm, 1 in.= 25.4mm      "
790 COLOR 7,0
800 INPUT " ENTER: Matching Section conductor diameter, in mm";D
810 COLOR 7,0:GOSUB 1280
820 X=Z0/276:Q=10^X:S=Q/2*D
830 LOCATE 5,37:COLOR 0,7
840 PRINT "-»│C│«─ cntr.to cntr."
850 LOCATE 10,18:PRINT "Conductor diameter="
860 LOCATE 11,18:PRINT USING "##.##mm (#.### in.)";D,D/25.399999618530273!
870 LOCATE 19,21
880 PRINT USING "Conductor spacing  C =####.##mm (##.### in.)";S,S/25.399999618530273!
890 IF S>D THEN FLAG=0:GOTO 950 :ELSE FLAG =1
900 BEEP:COLOR 14,4:LOCATE LN-1,4
910 PRINT " NOT POSSIBLE! Conductor spacing cannot be less than conductor";
920 PRINT " diameter! "
930 LOCATE ,19:PRINT " Try a higher impedance transmission line. "
940 :REM'
950 LOCATE LN+1,13:COLOR 0,7
960 PRINT " Do you want to try another conductor diameter?  (y/n) "
970 COLOR 7,0
980 Z$=INKEY$:IF Z$=""THEN 980
990 IF Z$="n"OR Z$="y"THEN VIEW PRINT LN-1 TO 24:CLS:VIEW PRINT
1000 IF Z$="y"THEN 720
1010 IF Z$="n"AND FLAG=0 THEN 1320 :ELSE 570
1020 GOTO 980
1030 COLOR 7,0:STOP
1040 :REM'
1050 :REM'.....diagram
1060 LOCATE 3
1070 T=16:COLOR 0,7
1080 LOCATE ,T:PRINT "                                                 "
1090 LOCATE ,T:PRINT "     │«───────────── ANTENNA──────────────»│     "
1100 LOCATE ,T:PRINT "     │                                     │     "
1110 LOCATE ,T:PRINT " ─ - ∞─────────────────╥∞╥─────────────────∞ - - "
1120 LOCATE ,T:PRINT "                       ║ ║                       "
1130 LOCATE ,T:PRINT "  1/4 Wavelength       ╟∞╢                       "
1140 LOCATE ,T:PRINT "  Matching Section ───>║ ║                       "
1150 LOCATE ,T:PRINT "  (Tubing or wire)     ╟∞╢                       "
1160 LOCATE ,T:PRINT "                       ║ ║                       "
1170 LOCATE ,T:PRINT "                      ┌╨∞╨┐                      "
1180 LOCATE ,T:PRINT " High Impedance       ╞═══╡                      "
1190 LOCATE ,T:PRINT " Transmission Line ──>╞═══╡                      "
1200 LOCATE ,T:PRINT "                      ╞═══╡                      "
1210 LOCATE ,T:PRINT "                                                 "
1220 LOCATE ,T:PRINT "                                                 "
1230 LOCATE ,T:PRINT "                                                 "
1240 LOCATE ,T:PRINT "                                                 "
1250 COLOR 7,0
1260 RETURN
1270 :REM'
1280 :REM'.....clear bottom of screen
1290 VIEW PRINT LN TO 24:CLS:VIEW PRINT
1300 RETURN
1310 :REM'
1320 :REM'.....end
1330 GOSUB 1360
1340 GOTO 90
1350 :REM'
1360 :REM'PRT
1370 KEY OFF:GOSUB 1440:LOCATE 25,5:COLOR 0,2
1380 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1390 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1400 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1400 :ELSE GOSUB 1440
1410 IF Z$="3"THEN RETURN
1420 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1430 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1370
1440 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
