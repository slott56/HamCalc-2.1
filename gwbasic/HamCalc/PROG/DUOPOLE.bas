10 :REM'\hamcalc\prog\DUOPOLE - Dual Band Short Dipole - 16 FEB 01, rev. 22 MAY 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'
70 :REM'.....title page
80 COLOR 15,2,1
90 PRINT " DUAL BAND SHORT WIRE DIPOLE"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOSUB 900    :REM'diagram
130 PRINT
140 LN=CSRLIN
150 GOSUB 1040   :REM'preface
160 LOCATE 24,24:COLOR 0,7:PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
170 Z$=INKEY$:IF Z$="1"THEN 200
180 IF Z$="0"THEN CLS:CHAIN EX$
190 GOTO 170
200 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
210 :REM'
220 :REM'.....data input
230 L=0:A=0:B=0:W=0:FL=0:FH=0
240 COLOR 0,7:LOCATE ,10
250 PRINT " Want dimensions in (m)etric or (i)mperial/USA units?  (m/i) "
260 COLOR 7,0
270 Z$=INKEY$
280 IF Z$="m"THEN N=0.30480000376701355!:N$="m. ":GOTO 320
290 IF Z$="i"THEN N=1:    N$="ft.":GOTO 320
300 GOTO 270
310 :REM'
320 CLS:COLOR 7,0,0:LOCATE ,25:PRINT TAB(25)" DUAL BAND SHORT WIRE ANTENNA "
330 PRINT
340 GOSUB 900  :REM'diagram
350 PRINT
360 :REM'
370 IF FL*FH THEN 430
380 INPUT " ENTER: Operating frequency of lower band (MHz).....";FL
390 INPUT " ENTER: Operating frequency of higher band (MHz)....";FH
400 IF FL>FH THEN SWAP FL,FH
410 LO=233.60000610351562!/FL           :REM'Lo band wire length for 1/2 dipole
420 HI=233.60000610351562!/FH           :REM'Hi band wire length for 1/2 dipole
430 B=0.05000000074505806!*LO*2
440 IF N$="ft." THEN B=INT(B*10)/10
450 IF N$="m. " THEN B=INT(B*N*10)/10/N
460 P=LO+B/2              :REM'perimeter in feet
470 LMAX=(LO-50/25.399999618530273!/12):LMAX=INT(LMAX*1000)/1000-0.10000000149011612!
480 LMIN=INT(1.5!*B*1000)/1000-0.10000000149011612!
490 COLOR 0,7
500 PRINT USING " Maximum Dimension L = ###.### "+N$;LMAX*N
510 PRINT USING " Minimum Dimension L = ###.### "+N$;LMIN*N
520 COLOR 7,0
530 PRINT " ENTER: Your choice of dimension L (";N$;")............";
540 INPUT Z:L=Z/N       :REM'length in feet
550 IF L<=LMAX AND L>=LMIN THEN 580
560 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 530
570 :REM'
580 :REM'.....calculate
590 A=L/2
600 W=P-2*A
610 :REM'
620 :REM'.....display
630 VIEW PRINT 14 TO 24:CLS:VIEW PRINT:LOCATE 14
640 LF=LO*2*N
650 HF=HI*2*N
660 C=LF/2-HF/2
670 PRINT USING " ###.### MHz antenna length.......Lo = ###.### "+N$;FL,LF
680 PRINT USING "                  Each side......½Lo = ###.### "+N$;LF/2
690 PRINT USING " ###.### MHz antenna length.......Hi = ###.### "+N$;FH,HF
700 PRINT USING "                  Each side......½Hi = ###.### "+N$;HF/2
710 PRINT USING " L...................................= ###.### "+N$;L*N
720 PRINT USING " W...................................= ###.### "+N$;W*N;
730 IF N=1 AND W<8.333000183105469! THEN PRINT USING "= ###.### inches";W*12 :ELSE PRINT ""
740 PRINT USING " A...................................= ###.### "+N$;A*N;
750 IF N=1 AND A<8.333000183105469! THEN PRINT USING "= ###.### inches";A*12 :ELSE PRINT ""
760 PRINT USING " B...................................= ###.#   "+N$;B*N;
770 IF N=1 AND B<8.333000183105469! THEN PRINT USING "= ###.# inches";B*12 :ELSE PRINT ""
780 PRINT USING " C...................................= ###.### "+N$;C*N
790 PRINT
800 COLOR 0,7:LOCATE ,21
810 PRINT " Want to try another L and W?   (y/n) ";:COLOR 7,0
820 Z$=INKEY$:IF Z$="n"THEN 880
830 IF Z$="y"THEN 850
840 GOTO 820
850 L=0:A=0:B=0:W=0
860 VIEW PRINT 18 TO 24:CLS:VIEW PRINT:LOCATE 18:GOTO 370
870 :REM'
880 LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 1150
890 :REM'
900 :REM'.....diagram
910 COLOR 0,7:J=12
920 LOCATE ,J:PRINT "                        TOP  VIEW                        "
930 LOCATE ,J:PRINT "      *│«────── C ──────»│«─B─»│«────── C ──────»│*      "
940 LOCATE ,J:PRINT " ┌» ╔══──────────────────∞─────∞──────────────────══╗    "
950 LOCATE ,J:PRINT " │  ║    ∞=insulator                length=1/2 Lo ─»║«┐  "
960 LOCATE ,J:PRINT " W  ║    ║=twinlead or zip cord     length=1/2 Hi ──╫─┘  "
970 LOCATE ,J:PRINT " │  ║             feedpoint─┐                       ║    "
980 LOCATE ,J:PRINT " └» ╚══════════════════════╕∞╒══════════════════════╝    "
990 LOCATE ,J:PRINT "    │«───────── A ─────────»│«───────── A ─────────»│    "
1000 LOCATE ,J:PRINT "    │«───────────────────── L──────────────────────»│    "
1010 LOCATE ,J:PRINT "  At points * cut and remove C length of one conductor   "
1020 COLOR 7,0:RETURN
1030 :REM'
1040 :REM'......preface
1050 PRINT " This antenna consists of two dipoles with a common feed point, ";
1060 PRINT "folded back and"
1070 PRINT " joined by a guy wire or rope section B to provide for pruning. ";
1080 PRINT "As with most   "
1090 PRINT " dipoles it may be fed directly with 50/75 ohm coaxial cable. Th";
1100 PRINT "e use of a     "
1110 PRINT " transmatch (antenna tuner) at the station end of the feed line ";
1120 PRINT "is recommended."
1130 RETURN
1140 :REM'
1150 :REM'.....end
1160 GOSUB 1180:CLS:GOTO 70
1170 :REM'
1180 :REM'PRT
1190 KEY OFF:GOSUB 1260:LOCATE 25,5:COLOR 0,2
1200 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1210 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1220 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1220 :ELSE GOSUB 1260
1230 IF Z$="3"THEN RETURN
1240 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1250 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1190
1260 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
