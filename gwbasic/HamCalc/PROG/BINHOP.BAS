10 :REM'BINHOP - 11 OCT 86 rev. 10 MAR 2006
20 KEY OFF:UL$=STRING$(80,205):E$=STRING$(80,32)
30 PI=4*ATN(1):T=55
40 COMMON EX$
50 IF EX$=""THEN EX$="exit"
60 :REM'
70 :REM'.....start
80 CLS:COLOR 7,0,0
90 PRINT " HOPPERED BIN ANALYSIS"TAB(56)"by George Murphy, VE3ERP"
100 PRINT UL$;
110 GOSUB 1190  :REM'diagram
120 LN=CSRLIN
130 PRINT " This program calculates dimensions and cubic capacity of hoppered ";
140 PRINT "rectangular"
150 PRINT " or round bins and tanks. Dimensions can be entered in any units of";
160 PRINT " measure, "
170 PRINT " bearing in mind that the calculated results will be in the same un";
180 PRINT "its."
190 PRINT UL$;
200 PRINT " To analyze an existing bin......press 1"
210 PRINT " To design a new bin.............press 2"
220 PRINT " To EXIT.........................press 0"
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="1"THEN GOSUB 1340:GOTO 290
250 IF Z$="2"THEN CLS:CHAIN"binvol"
260 IF Z$="0"THEN CLS:CHAIN EX$
270 GOTO 230
280 :REM'
290 :REM'.....start
300 GOSUB 1340
310 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
320 PRINT "  Press number in ( ) to indicate shape of bin:";
330 PRINT TAB(T)"(1) Round"
340 IF Z$="0"THEN CLS:RUN EX$
350 PRINT TAB(T)"(2) Rectangular"
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="1"THEN GOSUB 1340:B=1:Q$=" ROUND":GOTO 420
380 IF Z$="2"THEN GOSUB 1340:B=0:Q$=" RECTANGULAR":GOTO 420
390 BEEP
400 GOTO 360
410 :REM'
420 :REM'.....analyze existing bin
430 GOSUB 1340:GOSUB 550
440 INPUT "ENTER: Hopper height H.................=";H
450 IF B=0 THEN 480
460 INPUT "ENTER: Bin diameter F..................=";F
470 X=PI*F^2/4:GOTO 510
480 INPUT "ENTER: Bin width F.....................=";F
490 INPUT "ENTER: Bin length F....................=";G
500 X=F*G:IF F>G THEN SWAP F,G
510 INPUT "ENTER: Bin wall height J...............=";J
520 Z=H/3*(V+X+SQR(V*X))+X*J:M=H+J
530 GOSUB 1030:GOTO 710
540 :REM'
550 :REM'.....common inputs
560 IF B=0 THEN 590
570 INPUT "ENTER: Outlet D...............diameter =";D
580 V=PI*D^2/4:GOTO 620
590 INPUT "ENTER: Outlet D..................width =";D
600 INPUT "ENTER: Outlet D.................length =";E
610 V=D*E:IF D>E THEN SWAP D,E
620 PRINT "Press number in ( ) to indicate hopper discharge:";
630 PRINT TAB(T)"(1) Side draw"
640 PRINT TAB(T)"(2) Center draw"
650 Y$=INKEY$:IF Y$=""THEN 650
660 IF Y$="1"THEN GOSUB 1340:C$="SIDE":R=1:RETURN
670 IF Y$="2"THEN GOSUB 1340:C$="CENTER":R=0:RETURN
680 BEEP
690 GOTO 650
700 :REM'
710 :REM'.....screen display
720 CLS
730 PRINT Q$;" BIN, ";C$;" DRAW HOPPER"
740 PRINT UL$;
750 GOSUB 1190
760 P$="#####,###.###":CA=0
770 IF B=0 THEN 800
780 PRINT " Bin diameter ..................F=";USING P$;F
790 GOTO 820
800 PRINT " Bin width .....................F=";USING P$;F
810 PRINT " Bin length ....................G=";USING P$;G
820 PRINT " Bin wall height ...............J=";USING P$;J
830 PRINT " Hopper height .................H=";USING P$;H
840 PRINT " Overall height ................M=";USING P$;M
850 IF B=0 THEN 880
860 PRINT " Outlet diameter ...............D=";USING P$;D
870 GOTO 900
880 PRINT " Outlet width ..................D=";USING P$;D
890 PRINT " Outlet length .................D=";USING P$;E
900 PRINT " Bin cross-section area ..........";USING P$;X
910 PRINT " Cubic capacity ..................";USING P$;Z
920 PRINT " Min. hopper slope";USING "###.#°";N
930 COLOR 0,7
940 PRINT " Want to change hopper height and slope angle?  (y/n) ":COLOR 7,0
950 Z$=INKEY$: IF Z$=""THEN 950
960 IF Z$="n"THEN 1010
970 IF Z$="y"THEN 990
980 GOTO 1010
990 INPUT " ENTER: new hopper height H";H
1000 GOTO 520
1010 LN=CSRLIN-1:GOSUB 1340:GOTO 1380
1020 :REM'
1030 IF C$="SIDE" THEN N=ATN(H/(F-D))*180/PI:RETURN
1040 IF C$="CENTER" THEN N=ATN(2*H/(F-D))*180/PI:RETURN
1050 :REM'
1060 :REM'.....calculate dimensions
1070 IF R THEN H=TAN(N)*((F-D)/2):GOTO 1090
1080 H=TAN(N)*(F-D)
1090 IF A THEN RETURN
1100 IF M<(H+J)THEN 1120 THEN 1120
1110 IF H<=M THEN 1140
1120 CLS:PRINT "NOT POSSIBLE !.....Press any key to continue..."
1130 IF INKEY$=""THEN 1130 :ELSE 430
1140 Z=X*M-X*H+H/3*(V+X+SQR(V*X))
1150 Y=K-Z:LOCATE CSRLIN-1,17:PRINT Y
1160 IF (Z>=K) OR (F=W) THEN J=M-H:G=F:GOTO 710
1170 W=F:F=(F*K/Z+W)/2:RETURN
1180 :REM'
1190 :REM'.....diagram
1200 COLOR 0,7:C=30
1210 LOCATE ,C:PRINT "                  "
1220 LOCATE ,C:PRINT "  │«─ F ─»│       "
1230 LOCATE ,C:PRINT "  ┌───────┐«─┐«─┐ "
1240 LOCATE ,C:PRINT "  │  bin  │  J  │ "
1250 LOCATE ,C:PRINT "  └───────┤«─┤  │ "
1260 LOCATE ,C:PRINT "   \hopper│  H  M "
1270 LOCATE ,C:PRINT "    \     │  │  │ "
1280 LOCATE ,C:PRINT "     └────┘──┘«─┘ "
1290 LOCATE ,C:PRINT "   ─»│ D  │«─     "
1300 COLOR 7,0
1310 PRINT UL$;
1320 RETURN
1330 :REM'
1340 :REM'.....clear bottom of screen
1350 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1360 RETURN
1370 :REM'
1380 :REM'.....end
1390 GOSUB 1430
1400 A=0:B=0:C=O:D=0:E=0:F=0:H=0:J=0:K=0:L=0:M=0:N=0:V=0:X=0:Z=0
1410 GOTO 70
1420 :REM'
1430 :REM'.....PRT
1440 KEY OFF:GOSUB 1510:LOCATE 25,5:COLOR 0,2
1450 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1460 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1470 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1470 :ELSE GOSUB 1510
1480 IF Z$="3"THEN RETURN
1490 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1500 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1440
1510 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
