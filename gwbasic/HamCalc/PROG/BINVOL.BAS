10 :REM'BINVOL - 11 OCT 86 rev. 12 MAR 2006
20 KEY OFF:UL$=STRING$(80,205)
30 PI=4*ATN(1)
40 COMMON EX$
50 IF EX$=""THEN EX$="EXIT"
60 :REM'
70 :REM'.....start
80 VIEW PRINT
90 A=0:B=0:C=0:F=0:G=0:H=0:J=0:M=0:V=0:VHOP=0:VBIN=0
100 CLS:COLOR 7,0,0
110 PRINT " HOPPERED BIN DESIGN"TAB(64)"by George Murphy"
120 PRINT UL$;
130 GOSUB 1040  :REM'diagram
140 PRINT UL$;
150 LN=CSRLIN
160 PRINT " This program calculates dimensions of hoppered bins and tanks of ";
170 PRINT "any cubic  "
180 PRINT " capcacity. Dimensions can be entered in any units of measure, bea";
190 PRINT "ring in mind"
200 PRINT " that the calculated results will be in the same units."
210 PRINT UL$;
220 PRINT " To run design a bin..........press 1"
230 PRINT " To analyze an existing bin...press 2"
240 PRINT " To EXIT......................press 0"
250 Z$=INKEY$
260 IF Z$="0"THEN CLS:CHAIN EX$
270 IF Z$="1"THEN 310
280 IF Z$="2"THEN CLS:CHAIN"binhop"
290 GOTO 250
300 :REM'
310 :REM'.....start
320 VIEW PRINT LN TO 24:CLS
330 T=49  :REM'tab
340 PRINT "  Press number in ( ) to indicate shape of bin:";
350 PRINT TAB(T)"(1) Round"
360 PRINT TAB(T)"(2) Square"
370 Z$=INKEY$:IF Z$=""THEN 370
380 IF Z$="1"THEN B$="rnd":Q$=" ROUND":GOTO 430
390 IF Z$="2"THEN B$="sqr":Q$=" SQUARE":GOTO 430
400 BEEP
410 GOTO 370
420 :REM'
430 :REM'.....data inputs
440 VIEW PRINT LN TO 24
450 CLS:                 INPUT " ENTER: Required cubic capacity.......";V
460 CLS:                 INPUT " ENTER: Hopper slope angle (degrees)..";DEG
470 RAD=DEG*PI/180
480 IF B$="rnd"THEN Z$="Dia."
490 IF B$="sqr"THEN Z$="Size"
500 CLS:PRINT " ENTER: ";Z$+" of hopper opening D";:INPUT D
510 :REM'.....calculate hopper
520 Z=1 :REM'increment
530 H=1
540 E=H/TAN(RAD)
550 F=2*E+D
560 IF B$="rnd"THEN VHOP=PI/12*H*(F^2+(F*D)+D^2)
570 IF B$="sqr"THEN VHOP=H/3*(F^2+D^2+SQR(F^2*D^2))
580 DIF=ABS(V-VHOP):IF DIF<0.0010000000474974513! THEN 620
590 IF VHOP>V THEN H=H-Z:Z=Z/10:GOTO 540
600 H=H+Z:GOTO 540
610 :REM'
620 :REM'.....hopper
630 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
640 PRINT " Minimum height M=";H
650 PRINT " ENTER: Desired height greater than";H;:INPUT M
660 IF M<=H THEN BEEP:GOTO 630
670 :REM'
680 :REM'.....add bin
690 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
700 Z=1     :REM'increment
710 K=0
720 :REM'.....calculate bin & hopper
730 H=H-Z
740 E=H/TAN(RAD)
750 F=2*E+D
760 IF B$="rnd"THEN AREA=PI*(F/2)^2
770 IF B$="sqr"THEN AREA=F^2
780 IF B$="rnd"THEN VHOP=PI/12*H*(F^2+(F*D)+D^2)
790 IF B$="sqr"THEN VHOP=H/3*(F^2+D^2+SQR(F^2*D^2))
800 VBIN=V-VHOP:J=VBIN/AREA
810 K=H+J
820 VTOT=VHOP+VBIN
830 IF K>M THEN H=H+1:Z=Z/10:GOTO 720
840 DIF=ABS(M-K):IF DIF<0.0010000000474974513! THEN 880
850 GOTO 720
860 END
870 :REM'
880 :REM'.....bin with hopper
890 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
900 LOCATE 1:PRINT Q$;" HOPPERED BIN                "
910 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
920 PRINT Q$;(VHOP);"hopper";" +";(VBIN);"bin =";
930 PRINT (VBIN+VHOP);"Cubic Capacity of Bin and Hopper"
940 PRINT UL$;
950 PRINT USING " Bin cross section area.............= ###.###";AREA
960 PRINT USING " Top opening.......................F= ###.###";F
970 PRINT USING " Bottom opening................... D= ###.###";D
980 PRINT USING " Bin height........................J= ###.###";J
990 PRINT USING " Hopper height.....................H= ###.###";H
1000 PRINT USING " Overall height....................M= ###.###";M
1010 PRINT USING " Hopper slope angle.................= ###.#°";DEG
1020 GOTO 1200
1030 :REM'
1040 :REM'.....diagram
1050 COLOR 0,7:C=29
1060 LOCATE ,C:PRINT "                       "
1070 LOCATE ,C:PRINT "     │«─── F ───»│     "
1080 LOCATE ,C:PRINT "  ┌─»┌───────────┐«─┐  "
1090 LOCATE ,C:PRINT "  │  │    bin    │  J  "
1100 LOCATE ,C:PRINT "  │  └───────────┘«─┤  "
1110 LOCATE ,C:PRINT "  M   \         /   │  "
1120 LOCATE ,C:PRINT "  │    \hopper /    H  "
1130 LOCATE ,C:PRINT "  │     \     /     │  "
1140 LOCATE ,C:PRINT "  └─────»└───┘«─────┘  "
1150 LOCATE ,C:PRINT "         │«D»│         "
1160 COLOR 7,0
1170 PRINT
1180 RETURN
1190 :REM'
1200 :REM'.....end
1210 GOSUB 1240:GOTO 70
1220 GOTO 70
1230 :REM'
1240 :REM'.....PRT
1250 KEY OFF:GOSUB 1320:LOCATE 25,5:COLOR 0,2
1260 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1270 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1280 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1280 :ELSE GOSUB 1320
1290 IF Z$="3"THEN RETURN
1300 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1310 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1250
1320 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
