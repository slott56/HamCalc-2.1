10 :REM'YAGI3EL - YAGI 3-element beam - 13 AUG 95 rev.25 AUG 2007
20 CLS:KEY OFF
30 IF EX$="" THEN EX$="EXIT"
40 COMMON EX$,PROG$,DIMN$,A,B,C
50 COLOR 7,0,1
60 UL$=STRING$(80,205)
70 U1$="####.###"
80 U2$="###.##"
90 U3$="####.#"
100 :REM'
110 :REM'...start
120 CLS
130 COLOR 15,2
140 PRINT " YAGI Wide-Spaced 3-Element Beam";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 :REM'
180 :REM'.....standard antenna disclaimer
190 :REM'OPEN"I",1,"\hamcalc\docfiles\antenna.doc"
200 :REM'IF EOF(1)THEN 220
210 :REM'INPUT#1,Z$:PRINT "   ";Z$:GOTO 200
220 :REM'CLOSE
230 PRINT
240 PRINT "   This program is based on design data from the 1994 ARRL ";
250 PRINT "HANDBOOK for the";
260 PRINT "   RADIO AMATEUR, pages 17-15 and 17-16."
270 PRINT UL$;
280 COLOR 0,7:LOCATE CSRLIN,22
290 PRINT " Press 1 to continue or 0 to EXIT....."
300 COLOR 7,0
310 Z$=INKEY$:IF Z$=""THEN 310
320 IF Z$="0"THEN CLS:RUN EX$
330 IF Z$="1"THEN 350
340 GOTO 310
350 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
360 :REM'
370 :REM'.....data input
380 INPUT " ENTER: Desired optimum frequency (MHz) ";F
390 PRINT UL$;
400 T=6
410 PRINT TAB(T);
420 PRINT "Optimum element spacing is between 0.15 and 0.25 wavelength. Best";
430 PRINT TAB(T);
440 PRINT "overall choice is 0.2 wavelength, but due to space or other reasons";
450 PRINT TAB(T);
460 PRINT "you may wish to choose another spacing."
470 PRINT
480 PRINT TAB(T);
490 PRINT "Press number in < > to choose element spacing:"
500 PRINT UL$;
510 PRINT "     < 1 >  .15 wavelength"
520 PRINT "     < 2 >  .20 wavelength (best choice)"
530 PRINT "     < 3 >  .25 wavelength"
540 Z$=INKEY$
550 IF Z$="1"THEN J=0.15000000596046448!:GOTO 590
560 IF Z$="2"THEN J=0.20000000298023224!:GOTO 590
570 IF Z$="3"THEN J=0.25!:GOTO 590
580 GOTO 540
590 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
600  W = 300/F           :REM'wavelength
610  S = J*W/0.30480000376701355!
620  L = 2*S
630  IF J=0.15000000596046448! THEN V1=495:V2=473:V3=460
640  IF J=0.20000000298023224! THEN V1=490:V2=471:V3=452
650  IF J=0.25! THEN V1=485:V2=469.5!:V3=443
660  R = V1/F            :REM'reflector
670  D = V2/F            :REM'driven element
680  H = V3/F            :REM'director
690  K = L*0.30480000376701355!
700  M = S*0.30480000376701355!
710  O = R*0.30480000376701355!
720  P = D*0.30480000376701355!
730  Q = H*0.30480000376701355!
740  Y=X*0.30480000376701355!
750 LOCATE 3
760 T=25
770 PRINT TAB(T);"Centre Frequency........";USING U1$;F;:PRINT " MHz"
780 PRINT TAB(T);"Wavelength..............";USING U1$;W;:PRINT " metres"
790 PRINT TAB(T);"Element Spacing.........";USING U1$;J;:PRINT " x Wavelength"
800 PRINT TAB(T);"Director to Reflector...";USING U1$;K;
810 PRINT " m.(";USING U2$;L;:PRINT " feet )"
820 PRINT TAB(T);"Feed Point Impedance....  35 Ω (approx.) @";F;"MHz"
830 IF J=0.20000000298023224! THEN JJ=7.099999904632568! :ELSE JJ=7
840 PRINT TAB(T);"Gain....................";USING U3$;JJ;:PRINT " (approx.)"
850 PRINT TAB(T);"Front-to-Back ratio.....  30:1 maximum"
860 PRINT
870 :REM'
880 :REM'.....diagram
890 RO=10:CO=5
900 COLOR 0,7
910 LOCATE RO+ 1,CO:PRINT "                   "
920 LOCATE RO+ 2,CO:PRINT "   ──────╫──────   "
930 LOCATE RO+ 3,CO:PRINT "         ║         "
940 LOCATE RO+ 4,CO:PRINT "  ───────╫───────  "
950 LOCATE RO+ 5,CO:PRINT "         ║         "
960 LOCATE RO+ 6,CO:PRINT " ────────╫──────── "
970 LOCATE RO+ 7,CO:PRINT "                   "
980 COLOR 7,0
990 LOCATE RO+ 2,CO+20:PRINT "«─── DIRECTOR...........";USING U1$;Q;
1000 PRINT " m.(";USING U2$;H;:PRINT " ft.) Long"
1010 LOCATE RO+ 3,CO+20:PRINT "«───  element spacing...";USING U1$;M;
1020 PRINT " m.(";USING U2$;S;:PRINT " ft.)"
1030 LOCATE RO+ 4,CO+20:PRINT "«─── DRIVEN ELEMENT.....";USING U1$;P;
1040 PRINT " m.(";USING U2$;D;:PRINT " ft.) Long"
1050 LOCATE RO+ 5,CO+20:PRINT "«───  element spacing...";USING U1$;M;
1060 PRINT " m.(";USING U2$;S;:PRINT " ft.)"
1070 LOCATE RO+ 6,CO+20:PRINT "«─── REFLECTOR..........";USING U1$;O;
1080 PRINT " m.(";USING U2$;R;:PRINT " ft.) Long"
1090 LOCATE RO+ 7,CO+20:PRINT "      Boom Length (min.)";USING U1$;2*M;
1100 PRINT " m.(";USING U2$;2*S;:PRINT " ft.)"
1110 LOCATE RO+ 8:PRINT UL$;
1120 GOSUB 1260
1130 CLS:LOCATE 12:PRINT " Want to find minimum turning radius?   (y/n)"
1140 Z$=INKEY$:IF Z$=""THEN 1140
1150 IF Z$="n"THEN 1230
1160 IF Z$="y"THEN 1180
1170 GOTO 1140
1180 PROG$="yagi3el":DIMN$="feet"
1190 A=2*M/0.30480000376701355!:B=O/2/0.30480000376701355!:C=Q/2/0.30480000376701355!:CHAIN"turnrad"
1200 :REM'
1210 :REM'.....end
1220 GOSUB 1260
1230 CLS:GOTO 110   :REM'start
1240 END
1250 :REM'
1260 :REM'....PRT
1270 KEY OFF:GOSUB 1340:LOCATE 25,5:COLOR 0,2
1280 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1290 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1300 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1300 :ELSE GOSUB 1340
1310 IF Z$="3"THEN RETURN
1320 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1330 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1270
1340 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
1350 PRINT " Want to find minimum turning radius?   (y/n)"
