10 :REM'WHEATSTO - 27 NOV 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 DIM R(5),C(3),S(3),B(3,3)
70 A$="#####.###"
80 :REM'.....title page
90 CLS
100 COLOR 15,2,1
110 PRINT " WHEATSTONE BRIDGE VALCULATOR"TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 15,2:LOCATE CSRLIN-1,24:PRINT " Algorithm by Dr. Donald Simanek "
140 COLOR 7,0,0
150 PRINT
160 PRINT " This program calculates component values of a Wheatstone bridge a";
170 PRINT "t a given"
180 PRINT " voltage. Press 1 to continue or 0 to exit."
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="0"THEN RUN EX$
210 IF Z$="1"THEN 230
220 GOTO 190
230 VIEW PRINT 4 TO 24:CLS:VIEW PRINT
240 :REM'WHEATS, Wheatstone bridge calculation, version 5.1
250 :REM'By Dr. Donald Simanek, Lock Haven University 9/14/89, 2/1/90, 1/23/92
260 :REM'With direct calculation of balanced bridge, input of V.
270 KEY OFF
280 DEFINT I-N :DEFDBL A-H,O-Z
290 :REM'.....begin the program
300 LOCATE 5:GOSUB 730 ::REM'Draw the screen
310 GOSUB 900::REM'Input R subroutine
320 NZ=0::REM'Initialize count of zero values
330 FOR I=1 TO 4
340   IF R(I)=1.4693679385278594e-39! THEN NZ=NZ+1:IX=I
350 NEXT I
360 IF NZ=0 GOTO 460::REM'No zero values, do unbalanced bridge.
370 IF NZ>1 THEN GOTO 380 :ELSE 410::REM'Must balance the bridge if one zero value.
380 LOCATE 20:PRINT " You must enter at least 3 resistance values.  Press any key to restart.";
390 K$=INKEY$:IF K$="" THEN 390
400 CLS:GOTO 290
410 GOSUB 990 ::REM'Direct calculation to balance the bridge.
420 LOCATE 19,12
430 PRINT USING " R#=";IX;
440 PRINT USING A$;R(IX);:PRINT " (balances the bridge)"
450 :REM'
460 :REM'.....begin calculation of currents in balanced or unbalanced bridge.
470 B(1,1)=R(1)+R(3)+R(5)
480 B(2,2)=R(2)+R(4)+R(5)
490 B(3,3)=R(3)+R(4)
500 B(1,2)=-R(5) :B(2,1)=-R(5)
510 B(2,3)=-R(4) :B(3,2)=-R(4)
520 B(1,3)=-R(3) :B(3,1)=-R(3)
530 GOSUB 1100 ::REM'Cramer's rule subroutine
540 D1=D
550 FOR I=1 TO 3
560  FOR J=1 TO 3
570   S(J)=B(I,J) :B(I,J)=0
580  NEXT J
590   B(I,3)= V
600   GOSUB 1100 ::REM'Cramer's rule
610   C(I)=D/D1
620  FOR K=1 TO 3 :B(I,K)=S(K) :NEXT K
630 NEXT I
640 C1=C(1) :C2=C(2) :C3=C(3)-C(1) :C4=C(3)-C(2) :C5=C(1)-C(2)
650 LOCATE 7,20 :PRINT USING A$; C1
660 LOCATE 7,44 :PRINT USING A$; C2
670 LOCATE 11,44 :PRINT USING A$; C5
680 LOCATE 15,20:PRINT USING A$; C3
690 LOCATE 15,44:PRINT USING A$; C4
700 GOTO 1160
710 CLS :IF R$="N" OR R$="n" THEN 1160 :ELSE 290
720 :REM'
730 :REM'.....subroutine to draw the screen graphics
740 PRINT"                R1=                     R2="
750 PRINT"         ┌──────/\/\/\/\/\/──────┬──────/\/\/\/\/\/──────┐"
760 PRINT"         │      I1=              │      I2=              │"
770 PRINT"         │                   ┌───┼───┐                   │"
780 PRINT"         │      GALVANOMETER │   /   │  R5=              │"
790 PRINT"    ┌────┤    (Null detector)│   \   │                   ├─────┐"
800 PRINT"    │    │                   │   /   │  I5=              │     │"
810 PRINT"    │    │                   └───┼───┘                   │     │"
820 PRINT"    │    │      R3=              │      R4=              │     │"
830 PRINT"    │    └──────/\/\/\/\/\/──────┴──────/\/\/\/\/\/──────┘     │"
840 PRINT"    │           I3=                     I4=                    │"
850 PRINT"    │                         + │   -                          │"
860 PRINT"    └───────────────────────────┤ ├────────────────────────────┘"
870 PRINT"                                │"
880 PRINT"            Volts ="
890 RETURN ::REM'from screen drawing subroutine
900 :REM'
910 :REM'.....data input subroutine, LINE 1,13,18, COL 20,44
920 LOCATE 5,20 :INPUT R(1):IF R(1)<>0 THEN LOCATE 5,20 :PRINT USING A$; R(1);
930 LOCATE 5,44 :INPUT R(2):IF R(2)<>0 THEN LOCATE 5,44 :PRINT USING A$; R(2);
940 LOCATE 9,44 :INPUT R(5):LOCATE 9,44 :PRINT USING A$; R(5);
950 LOCATE 13,20:INPUT R(3):IF R(3)<>0 THEN LOCATE 13,20:PRINT USING A$; R(3);
960 LOCATE 13,44:INPUT R(4):IF R(4)<>0 THEN LOCATE 13,44:PRINT USING A$; R(4);
970 LOCATE 19,20:INPUT V   :IF V=0 THEN V=2:LOCATE 19,20:PRINT USING A$; V;
980 RETURN ::REM'From data input subroutine
990 :REM'
1000 :REM'Subroutine to balanced the bridge.
1010 :REM'Needs IX, the number of the missing resistor.
1020 :REM'
1030 ONIX GOTO 1040,1050,1060,1070
1040 R(1)=R(3)*R(2)/R(4):GOTO 1080
1050 R(2)=R(1)*R(4)/R(3):GOTO 1080
1060 R(3)=R(1)*R(4)/R(2):GOTO 1080
1070 R(4)=R(2)*R(3)/R(1):GOTO 1080
1080 RETURN ::REM'From direct calculation subroutine
1090 :REM'
1100 :REM'.....find determinant of a 3x3 matrix by Cramers' rule, for unbalanced bridge
1110 :REM'
1120 D=B(1,1)*(B(2,2)*B(3,3)-B(3,2)*B(2,3))
1130 D=D-B(1,2)*(B(2,1)*B(3,3)-B(3,1)*B(2,3))
1140 D=D+B(1,3)*(B(2,1)*B(3,2)-B(3,1)*B(2,2))
1150 RETURN ::REM'From determinant subroutine
1160 :REM'.....end
1170 GOSUB 1180:GOTO 80
1180 :REM'.....PRT
1190 KEY OFF:GOSUB 1260:LOCATE 25,5:COLOR 0,2
1200 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1210 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1220 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1220 :ELSE GOSUB 1260
1230 IF Z$="3"THEN RETURN
1240 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1250 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1190
1260 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
