10 :REM'COILCPL  - Coaxially Coupled Coils - 10 JUL 07 rev.14 OCT 07
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 X$=STRING$(79,32)
70 PI=4*ATN(1)
80 :REM'.....title page
90 CLS
100 SP=0:D=0:UINN=0:UOUT=0:PINN=0:POT=0
110 COLOR 15,2,1
120 PRINT " COILS - Coaxially Coupled"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 15,2:LOCATE CSRLIN-1,24:PRINT " (suggested by Chuck Pool AA5WG) "
150 COLOR 7,0,0
160 PRINT
170 GOSUB 180:GOTO 330
180 :REM'.....diagram
190 COLOR 0,7:T=27
200 LOCATE ,T:PRINT " ooooooooooooooooooooooooo "
210 LOCATE ,T:PRINT " │   xxxxxxxxxxxxxxxxx   │ "
220 LOCATE ,T:PRINT " │   │  ooooooooooo  │   │ "
230 LOCATE ,T:PRINT " │   │  │         │  │   │ "
240 LOCATE ,T:PRINT " │   │  ooooooooooo  │   │ "
250 LOCATE ,T:PRINT " │   xxxxxxxxxxxxxxxxx   │ "
260 LOCATE ,T:PRINT " ooooooooooooooooooooooooo "
270 LOCATE ,T:PRINT "      ooo=windings         "
280 LOCATE ,T:PRINT "      xxx=dielectric       "
290 PRINT
300 LN=CSRLIN
310 COLOR 7,0
320 RETURN
330 PRINT
340 PRINT TAB(13)"This program designs coaxial coils, one inside the other."
350 PRINT TAB(27)"  Reference: Terman, page 71"
360 PRINT
370 COLOR 0,7,0:LOCATE ,24
380 PRINT " Press 1 to continue or 0 to exit ":COLOR 7,0
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="0"THEN RUN EX$
410 IF Z$="1"THEN 430
420 GOTO 390
430 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
440 PRINT
450 PRINT " Before you start run Coil Designer for both coils to find the coil";
460 PRINT " form     "
470 PRINT " diameters for use in this progaram."
480 PRINT
490 PRINT "....Press 1 to continue, 2 to run Coil Designer or 0 to Exit."
500 Z$=INKEY$:IF Z$=""THEN 500
510 IF Z$="1"THEN 540
520 IF Z$="2"THEN RUN"coildsgn"
530 IF Z$="0"THEN RUN EX$
540 :REM'.....start
550 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
560 CLS:PRINT TAB(28)" COAXIALLY COUPLED COILS"
570 PRINT
580 UINN=0:UOUT=0:PINN=0:POUT=0:D=0:SP=0:T1=0:T2=0
590 PRINT " ..Air gap is the linear space between adjacent conductors."
600 PRINT " ..Dielectric space is the radial space separating the coils."
610 PRINT " ..Coil pitch is the centre-to-centre distance between turns."
620 PRINT " ..Length of conductor is the amount of conductor required."
630 PRINT :LN=CSRLIN
640 INPUT " ENTER: Maximum peak voltage in the circuit";V
650 MIN=V/21/10^3
660 INPUT " ENTER: Diameter of conductors (in.)          ";D
670 COLOR 0,7
680 PRINT " For maximum Q air gap should be";D;" otherwise enter your choice."
690 COLOR 7,0
700 PRINT " MINIMUM air gap is";MIN";inches"
710 INPUT " ENTER: Air Gap (in.)                         ";AG
720 PRINT  " Enter diameter of conductor including enamel or other covering."
730 COLOR 0,7
740 PRINT " For maximum Q pitch should be";2*D;" otherwise enter your choice. "
750 COLOR 7,0
760 INPUT " ENTER: Coil pitch (in.)                      ";SP
770 INPUT " ENTER: Coil form diameter of INNER coil (in.)";CIN
780 RINN=CIN/2:PINN=2*RINN+D
790 INPUT " ENTER: Coil form diameter of OUTER coil (in.)";COUT
800 ROUT=COUT/2:POUT=2*ROUT+D
810 INPUT " ENTER: Inductance in µH of INNER coil        ";UINN
820 INPUT " ENTER: Inductance in µH of OUTER coil        ";UOUT
830 T1=1/(2*D):T2=T1
840 :REM'.....Terman equations
850 QINN=RINN^2*T1^2/UINN
860 QOUT=ROUT^2*T2^2/UOUT
870 LINN=ABS(-10-SQR(100+36*RINN*QINN))/2/QINN
880 NINN=(SQR(UINN*(9*RINN+10*LINN)))/RINN
890 LOUT=ABS(-10-SQR(100+36*ROUT*QOUT))/2/QOUT
900 NOUT=(SQR(UOUT*(9*ROUT+10*LOUT)))/ROUT
910 :REM'.....mutual inductance
920 A1=RINN:A2=ROUT
930 N1=NINN:N2=NOUT
940 L1=LINN:L2=LOUT
950 IF L2>=L1 THEN G=SQR(A2^2+L2^2/4) :ELSE G=SQR(A2^2+L1^2/4)
960 F=1+A2^2*A1^2/8/G^4*(3-4*L1^2/4/A1^2) :REM'F is a factor in the formula for M.
970 M=0.05009999871253967!*A1^2*N1*N2/G*F :REM'uH
980 CC=M/SQR(UINN*UOUT)
990 :REM'.....screen display
1000 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN-1
1010 PRINT " INNER COIL"TAB(41)"OUTER COIL"
1020 PRINT USING " Inductance.......... ###.### µH";UINN;
1030 LOCATE ,40:PRINT USING " Inductance.......... ###.### µH";UOUT
1040 PRINT USING " Conductor diameter.. ###.### in.";D;
1050 LOCATE ,40:PRINT USING " Conductor diameter.. ###.### in.";D
1060 PRINT USING " Pitch diameter...... ###.### in.";PINN;
1070 LOCATE ,40:PRINT USING " Pitch diameter...... ###.### in.";POUT
1080 PRINT USING " Air gap............. ###.### in.";AG;
1090 LOCATE ,40:PRINT USING " Air gap............. ###.### in.";AG
1100 X=ABS(POUT-PINN-D)
1110 PRINT USING " Dielectric space.... ###.### in.";X;
1120 LOCATE ,40:PRINT USING " Dielectric space.... ###.### in.";X
1130 PRINT USING " Coil form diameter.. ###.### in.";CIN;
1140 LOCATE ,40:PRINT USING " Coil form diameter.. ###.### in.";COUT
1150 PRINT USING " Coil pitch.......... ###.### in.";SP;
1160 LOCATE ,40:PRINT USING " Coil pitch.......... ###.### in.";SP
1170 PRINT USING " Turns per inch...... ###.###";T1;
1180 LOCATE ,40:PRINT USING " Turns per inch...... ###.###";T2
1190 PRINT USING " Number of turns..... ###.###";NINN;
1200 LOCATE ,40:PRINT USING " Number of turns..... ###.###";NOUT
1210 PRINT USING " Turn spacing c.c.    ###.### in.";1/T1;
1220 LOCATE ,40:PRINT USING " Turn spacing c.c.    ###.### in.";1/T2
1230 PRINT USING " Length of coil...... ###.### in.";LINN;
1240 LOCATE ,40:PRINT USING " Length of coil...... ###.### in.";LOUT
1250 W1=PINN*NINN*PI:W2=POUT*NOUT*PI
1260 PRINT USING " Length of conductor. ###.### in.";W1;
1270 LOCATE ,40:PRINT USING " Length of conductor. ###.### in.";W2
1280 PRINT
1290 PRINT USING "###.###";M;:PRINT " µH mutual inductance";
1300 PRINT USING ".....coupling coefficient approx. ##.###";CC
1310 PRINT TAB(18)"....To run again or quit, press 3...."
1320 :REM'.....end
1330 GOSUB 1340:GOTO 80
1340 :REM'.....PRT
1350 GOSUB 1420:LOCATE 25,5:COLOR 0,2
1360 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1370 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1380 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1380 :ELSE GOSUB 1420
1390 IF Z$="3"THEN RETURN
1400 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1410 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1350
1420 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
