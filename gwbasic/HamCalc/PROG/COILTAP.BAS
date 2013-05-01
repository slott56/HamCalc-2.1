10 :REM'COILTAP - RJDehoney 2006/01/22.rec. 23 JAN 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI =4*ATN(1)
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " TAPPED COIL PROPERTIES"TAB(61)"by R.J.Dehoney IEEE ";
100 COLOR 7,0
110 :REM'.....start
120 :REM'-----------------TAP.BAS, rjd 2/24/06-----------------
130 PRINT
140 PRINT " This program solves for the properties of a tapped coil. It uses Meyer's"
150 PRINT " formulas which solve for coil inductance using Nagaoka's K with corrections"
160 PRINT " for finite coil length and wire spacing."
170 PRINT " N is the number of turns"
180 PRINT " AWG is the wire size"
190 PRINT " L is the coil length to the outside of the wires in inches"
200 PRINT " DF is the coil form diameter in inches"
210 PRINT " P is the pitch which equals L/N inches per turn"
220 PRINT " T is the number of turns the tap is from one end"
230 PRINT
240 PRINT "                   *──────┐"
250 PRINT "                          ("
260 PRINT "                      N2  ("
270 PRINT "                          (  N"
280 PRINT "                 Tap *────("
290 PRINT "                      N1  ("
300 PRINT "                   *──────┘"
310 PRINT
320 LN=CSRLIN
330 PRINT " Press <1> to run or <0> to quit "
340 Z$=INKEY$:IF Z$="" THEN 340
350 IF Z$="0"THEN RUN GO$
360 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 380
370 GOTO 340
380 INPUT " ENTER: Number of turns";N
390 INPUT " ENTER: AWG wire size";AWG
400 WD=0.32485830783843994!/(1.1229317#^AWG) :D=DF+WD
410 INPUT " ENTER: Coil form diameter (inches)";DF
420 MIN=N*WD
430 PRINT " ENTER: Coil length (inches - minimum";MIN"in.)";:INPUT L
440 IF L<MIN THEN 430
450 CLS
460 P=L/N
470 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN-1
480 PRINT " Tap turn        L1           L2     Coupling Coef   Mutual L"
490 PRINT
500 FOR J=1 TO 10 :T=N/10*J/2 :IF T<1 THEN 570
510 LT1=L*T/N :N1=N*LT1/L :LT2=L-LT1 :N2=N-N1 :A=N1/N2
520 LX=L :NX=N :GOSUB 670 :DUCT=L0
530 LX=LT1 :NX=N1 :GOSUB 670 :DUCT1=L0
540 LX=LT2 :NX=N2 :GOSUB 670 :DUCT2=L0
550 C=(DUCT-DUCT1-DUCT2)/SQR(DUCT1*DUCT2)/2 :M=C*SQR(DUCT1*DUCT2)
560 PRINT USING "###.###      ";T;DUCT1;DUCT2;C;M
570 NEXT J
580 LOCATE 4,41:PRINT USING "Coil form diamter.. ####.### in.";DF
590 LOCATE 5,41:PRINT USING "Wire AWG size.......... ####.###";AWG
600 LOCATE 6,41:PRINT USING "Wire diameter...... ####.### in.";WD
610 LOCATE 7,41:PRINT USING "Number of turns........ ####.###";N
620 LOCATE 8,41:PRINT USING "Pitch.................. ####.### in.";P
630 LOCATE 9,41:PRINT USING "Coil length............ ####.### in.";L
640 LOCATE 10,41:PRINT USING "Coil inductance.... ####.### µH.";DUCT
650 LOCATE 2,28:PRINT "TAPPED COIL PROPERTIES"
660 GOTO 760
670 :REM'---------Subroutines to calculate K,G,H, & IND-------------
680 X=LX/D :Y= D/2/LX :G=5/4-LOG(2*P/WD)
690 H=0.335999995470047!*(1-2.5!/NX+3.799999952316284!/NX^2-2.5!/NX^3+0.8299999833106995!/NX^4)+0.004000000189989805!
700 KS=2*X/PI*((LOG(4/X)-0.5!)+X^2/8*(LOG(4/X)+0.125!)-X^4/64*(LOG(4/X)-2/3)+           X^6/204.5!*(LOG(4/X)-109/120))
710 KL=1-8*Y/3/PI+0.5!*Y^2-0.25!*Y^4+5*Y^6/16-35*Y^8/64+147*Y^10/128
720 IF X=<0.8690000176429749! THEN K=KS :ELSE K=KL
730 L0=5.079999923706055!*PI^2*D/2*NX^2/X*K-(10.199999809265137!*PI*NX*D/2*(G+H)) :L0=L0/1000
740 RETURN
750 :REM'
760 :REM'.....end
770 GOSUB 790:CLS:GOTO 70
780 :REM'
790 :REM'.....PRT
800 KEY OFF:GOSUB 870:LOCATE 25,5:COLOR 0,2
810 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
820 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
830 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 830 :ELSE GOSUB 870
840 IF Z$="3"THEN RETURN
850 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
860 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 800
870 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
