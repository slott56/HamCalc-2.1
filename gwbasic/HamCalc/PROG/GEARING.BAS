10 :REM'GEARING : 2 DEC 85 rev. 22 MAR 2000
20 IF EX$=""THEN EX$="exit"
30 COMMON EX$
40 CLS:KEY OFF
50 UL$=STRING$(80,205)
60 DIM A(50)
70 ON ERROR  GOTO 100
80 GOTO 150
90 :REM'
100 CLS:PRINT "Error";ERR;"in line";ERL;". Please re-run program....."
110 END
120 :REM'
130 LOCATE C1,1:FOR U=C2 TO C3:LOCATE U,1:PRINT STRING$(80,32):NEXT U:RETURN
140 :REM'
150 :REM'.....start
160 CLS:COLOR 11,1,4
170 PRINT " GEARING DESIGN";TAB(57)"by George Murphy VE3ERP ";
180 COLOR 4,0:PRINT STRING$(80,"▀");
190 COLOR 7,0
200 PRINT TAB(24)"  Press number in ( ) to select program"
210 PRINT UL$;
220 PRINT TAB(19)"  (1)  Gears known"
230 PRINT TAB(19)"  (2)  Gears unknown, R.P.M.'s known"
240 PRINT TAB(19)"  (3)  Exit"
250 Z$=INKEY$
260 IF Z$="1"THEN CLS:GOTO 330
270 IF Z$="2"THEN CLS:GOTO 330
280 ON ERROR  GOTO 310
290 IF Z$="3"THEN CHAIN"mechmenu"
300 GOTO 250
310 CLS:END
320 :REM'
330 :REM'.....start
340 COLOR 7,0,0
350 INPUT "ENTER: Diametrical pitch ............";P
360 IF P=0 THEN CLS:GOTO 320
370 IF Z$="1"THEN 770
380 INPUT "ENTER: Known  R.P.M. ................";L
390 INPUT "ENTER: Sought R.P.M. ................";S
400 INPUT "ENTER: Desired c.c. distance (in.) ..";C
410 C1=1:C2=1:C3=4:GOSUB 130:LOCATE 1,1
420 PRINT "Diametrical pitch ............";P
430 PRINT "Known  R.P.M. ................";L
440 PRINT "Sought R.P.M. ................";S
450 PRINT "Desired c.c. distance (in.) ..";C
460 K=L:IF K<S THEN SWAP S,K:X=1
470 R=K/S:A=CINT(2*P*C/(1+R))
480 IF A>=8 THEN 540
490 PRINT:PRINT "You will have to choose a finer diametrical pitch "
500 PRINT "or a larger c.c. distance."
510 PRINT:PRINT "Press any key to continue."
520 Z$=INKEY$:IF Z$<>""THEN CLS:GOTO 320
530 GOTO 520
540 PRINT:PRINT "Combinations of gear teeth and sought R.P.M.:":PRINT
550 PRINT TAB(6)"Gear A";TAB(14)"Gear B";TAB(22)"c.c.(in.)";TAB(35);"R.P.M."
560 PRINT
570 U$=STRING$(39,45)
580 FOR Y=A-4 TO A+4
590 B=CINT(Y*R):C= CINT(((Y+B)/(2*P))*100)/100
600 N=N+1:IF X=1 THEN Z=B*S/Y :ELSE Z=K*Y/B
610 IF Y=A THEN PRINT U$
620 PRINT "(";N;")";TAB(8);USING "####";Y;
630 PRINT USING "########";B;:PRINT USING"######.##";C;
640 PRINT USING "####,###.##";Z:A(N)=Z
650 IF Y=A THEN PRINT U$
660 NEXT Y:PRINT
670 PRINT "Press number in ( ) to indicate your selection"
680 Z$=INKEY$:IF Z$>="1" AND Z$<="9"THEN 700
690 GOTO 680
700 N=VAL(Z$):S=A(N):IF S>L THEN SWAP S,L
710 A=A-5+N:B=CINT(A*R):D=A/P:E=B/P:C=CINT((D+E)/2*1000)/1000
720 CLS:PRINT "( Press [ENTER] if not applicable )"
730 INPUT "ENTER: (if applicable) Horsepower.........";H
740 IF H=0 THEN 760
750 I=63025.0!*H/K:J=63025.0!*H/S
760 GOTO 810
770 INPUT "ENTER: No. of teeth - Gear A ........";A
780 INPUT "ENTER: No. of teeth - Gear B ........";B
790 D=A/P:E=B/P:C=(D+E)/2
800 :REM'
810 CLS:PRINT "GEARING SPECIFICATIONS"
820 A$="######":B$="##,###.###"
830 LOCATE 5,1
840 PRINT "Diametrical pitch ...............";USING A$;P
850 PRINT "Gear A - No. of teeth ...........";USING A$;A
860 PRINT "       - Pitch diameter (in.) ...";USING B$;D
870 IF L=0 THEN 890
880 PRINT "       - R.P.M. .................";USING B$;L
890 IF I=0 THEN 910
900 PRINT "       - Shaft torque (in./lb)...";USING A$;I
910 PRINT "Gear B - No. of teeth ...........";USING A$;B
920 PRINT "       - Pitch diameter (in.) ...";USING B$;E
930 IF S=0 THEN 950
940 PRINT "       - R.P.M. .................";USING B$;S
950 IF J=0 THEN 970
960 PRINT "       - Shaft torque (in./lb)...";USING A$;J
970 PRINT "C.C. (inches) ...................";USING B$;C
980 IF A/B >1 THEN R=A/B :ELSE R=B/A
990 PRINT "Ratio ...........................";USING B$;R;:PRINT ":1"
1000 IF H=0 THEN 1030
1010 PRINT "Horsepower ......................";USING B$;H
1020 :REM'
1030 :REM'.....end
1040 GOSUB 1060:GOTO 150
1050 :REM'
1060 :REM'PRT
1070 KEY OFF:GOSUB 1140:LOCATE 25,5:COLOR 0,2
1080 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1090 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1100 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1100 :ELSE GOSUB 1140
1110 IF Z$="3"THEN RETURN
1120 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1130 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1070
1140 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
