10 :REM'CHOKBAL - Coax chokes & Baluns - 22 FEB 08, rev. 20 MAR 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="chokbal"
60 COMMON EX$,PROG$,C$
70 PI=4*ATN(1)  :REM'3.141593
80 ER$=STRING$(79,32)
90 :REM'.....title page
100 IF C$ <>"" THEN 660
110 CLS
120 COLOR 15,2,1
130 PRINT " COAXIAL CABLE RF CHOKES & BALUNS"TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 15,2:LOCATE CSRLIN-1,26:PRINT " Concept by Erik Madsen OZ8EM "
160 PRINT:COLOR 7,0,0
170 PRINT " An effective coaxial cable transmission line RF choke can be made";
180 PRINT " by winding"
190 PRINT " some of the cable in a coil around a plastic tube, pipe, pail, bu";
200 PRINT "cket, etc."
210 PRINT " The number of turns should be calculated so that the reactance of";
220 PRINT " the cable is"
230 PRINT " within the range  of 200 - 450 ohms. These baluns may also be use";
240 PRINT " with open   "
250 PRINT " wire transmission lines."
260 PRINT
270 PRINT " In multi-band applications self-resonance due to distributed capa";
280 PRINT "citance may  "
290 PRINT " degrade the performance of the device."
300 PRINT
310 :REM'.....start
320 LN=CSRLIN:COLOR 0,7
330 LOCATE,21:PRINT " ....Press 1 to continue or 0 to exit.... ":COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-1
360 IF Z$="0"THEN RUN EX$
370 IF Z$="1"THEN 390
380 GOTO 340
390 LOCATE LN:COLOR 0,7
400 LOCATE ,18:PRINT " Want dimensions in (i)nches or (c)entimetres?   (i/c) "
410 COLOR 7,0
420 Z$=INKEY$:IF Z$=""THEN 420
430 LOCATE CSRLIN-1:PRINT ER$
440 IF Z$<>"i"AND Z$<>"c"THEN 390
450 IF Z$="i"THEN M=1:Y$= "INCHES ":GOTO 480
460 IF Z$="c"THEN M=2.5399999618530273!:Y$="CENTIMETRES ":GOTO 480
470 GOTO 420
480 LOCATE LN:INPUT " ENTER: Coaxial cable designation (e.g. RG-8)......";C$
490 LOCATE CSRLIN-1:PRINT ER$
500 LOCATE LN
510 PRINT " Before continuing, the following coaxial cable data must be known:"
520 PRINT
530 PRINT " a) Desired reactance of the choke"
540 PRINT " b) MEASURED outside diameter of shield"
550 PRINT "   (most data sheets list only the shield I.D or dielectric O.D.)"
560 PRINT " c) Outside diameter of the jacket"
570 PRINT
580 PRINT " If a), b) and c) known..............press 1"
590 PRINT " For Coaxial Cable Characteristics...press 2"
600 Z$=INKEY$:IF Z$=""THEN 600
610 LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-1
620 IF Z$="1"THEN 650
630 IF Z$="2"THEN CLS:CHAIN "coaxchar"
640 GOTO 600
650 :REM'.....data input
660 CLS
670 PRINT " ";C$;" COAXIAL CABLE CHOKE/BALUN "
680 PRINT
690 LN=CSRLIN
700 PRINT " (for multi-band applications enter the lowest applicable freqency)"
710 PRINT
720 INPUT " Lowest operating frequency............. ###.### MHz";F
730 GOSUB 1390
740 PRINT USING " Lowest operating frequency............. ###.### MHz";F
750 NF=F*1.0299999713897705!  :REM'for calculations
760 LN=CSRLIN:INPUT " ENTER: Reactance (200-450Ω) (450 suggested)";X:GOSUB 1390
770 U=X/(2*PI*F)  :REM'initial inductance
780 PRINT USING " Coil inductance........................ ###.### Ω";U
790 PRINT USING " Coil reactance......................... ###.### Ω";X
800 LOCATE 23,10:COLOR 0,7:PRINT " ENTER ALL DIMENSIONS IN ";Y$:COLOR 7,0
810 LOCATE LN+2
820 INPUT " ENTER: Outside diameter of coax jacket";J:J=J/M
830 LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-1
840 PRINT USING " Operating frequency.................... ###.### MHz.";F
850 PRINT USING " Outside diameter of jacket............. ###.### in.";J;
860 PRINT USING " ( ###.### cm.)";J*2.5399999618530273!
870 INPUT " ENTER: Outside diameter of coax shield";S:S=S/M
880 LOCATE CSRLIN-1:PRINT ER$:LOCATE CSRLIN-1
890 PRINT USING " Outside diameter of shield............. ###.### in.";S;
900 PRINT USING " ( ###.### cm.)";S*2.5399999618530273!
910 MIN=INT(J*15)+0.5!
920 LN=CSRLIN
930 PRINT USING " Minimum diameter of coil form.......... ###.###";MIN*M
940 INPUT " ENTER: Your choice of coil form diameter";DIA:DIA=DIA/M
950 GOSUB 1390
960 PRINT USING " Coil form diameter..................... ###.### in.";DIA;
970 PRINT USING " ( ###.### cm.)";DIA*2.5399999618530273!
980 PD=DIA+J:P=J*M
990 LN=CSRLIN
1000 GOSUB 1390
1010 T=1/P  :REM'turns per inch (close wound)
1020 PRINT USING " Pitch (turn spacing)................... ###.### in.";P;
1030 PRINT USING " ( ###.### cm.)";P*2.5399999618530273!
1040 LN=CSRLIN:GOSUB 1390
1050 :REM'.....comvergence iteration
1060 N=0:Y=0.0010000000474974513!
1070 N=N+Y:LG=N*P
1080 L=(PD^2*N^2)/(18*PD+40*LG)
1090 IF ABS(L-U)<0.0005000000237487257! THEN 1110
1100 IF L<U THEN 1070
1110 LG=N*P: L=(PD^2)*N^2/(18*PD+(40*LG))
1120 :REM'.....self resonance
1130 SW=P/S     :REM'pitch/shield O.D.
1140 A=PD/2*2.5399999618530273!:B=LG*2.5399999618530273!:JJ=25330.2890625! :REM'A=radius in cm. B=length in cm.
1150 IHC=LOG(SW+SQR(SW^2-1))     :REM'inverse hyperbolic cosince
1160 CO=PI*PD*2.5399999618530273!/(3.5999999046325684!*IHC)     :REM'capacity to resonate
1170 FS=SQR((JJ/(CO*LG*2.5399999618530273!)))   :REM'self resonant frequency
1180 CR=JJ/(F^2*U)               :REM'capacitance required to resonate
1190 Q=SQR(F)*10^3/(6.900000095367432!/A+4.5!/B) :REM'true Q
1200 BW=F/Q*10^3
1210 :REM'.....continue display
1220 PRINT USING " Coil pitch diameter.................... ###.### in.";PD;
1230 PRINT USING " ( ###.### cm.)";PD*2.5399999618530273!
1240 PRINT USING " Number of turns........................ ###";N
1250 PRINT USING " Coil Length............................ ###.### in.";LG;
1260 PRINT USING " ( ###.### cm.)";LG*2.5399999618530273!
1270 PRINT USING " Amount of cable in coil................ ###.### in.";N*PI*PD;
1280 PRINT USING " ( ###.### cm.)";N*PI*PD*2.5399999618530273!
1290 PRINT USING " Design frequency....................... ###.### MHz";NF
1300 PRINT USING " Design reactance....................... ###.### Ω";L*2*PI*F
1310 PRINT USING " Design inductance...................... ###.### µH";L
1320 PRINT USING " Distributed capacity................... ###.### pF";CO
1330 PRINT USING " Self-resonant frequency................ ###.### Mhz";FS
1340 PRINT USING " True Q................................. ####";Q
1350 PRINT " (Apparent Q, as read by a meter, may be lower)"
1360 PRINT:COLOR 0,7
1370 PRINT " THIS DEVICE MAY NOT BE EFFECTIVE ABOVE";INT (FS);"MHz ":COLOR 7,0
1380 GOTO 1420
1390 :REM'.....erase line
1400 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1410 RETURN
1420 :REM'.....end
1430 GOSUB 1440:CLS:C$="":GOTO 90
1440 :REM'.....PRT
1450 KEY OFF:GOSUB 1520:LOCATE 25,5:COLOR 0,2
1460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1470 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1480 :ELSE GOSUB 1520
1490 IF Z$="3"THEN RETURN
1500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1450
1520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
1530 PRINT USING " Coil pitch diameter.................... ###.### in.";PD;
