10 :REM'QTRAP - HI Q TRAPS - 18 FEB 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="trapq"
60 COMMON EX$,PROG$
70 PI=4*ATN(1)
80 GOTO 120
90 :REM'.....erase line
100 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
110 RETURN
120 :REM'.....title page
130 COLOR 7,0,0
140 PRINT " High Q Antenna Traps"TAB(57)"by George Murphy VE3ERP ";
150 PRINT STRING$(80,205);
160 LN=CSRLIN
170 PRINT " A trap consists of a parallel combination of L and C that is res";
180 PRINT "onant at a  "
190 PRINT " desired blocking frequency. Trap Q decreases and bandwidth incre";
200 PRINT "ases with the "
210 PRINT " reactance of the trap. Most amateur radio antenna traps are desi";
220 PRINT "gned for a    "
230 PRINT " reactance within the range of 250-450 ohms."
240 PRINT
250 PRINT " For maximum Q the trap coil length/diameter ratio should be clos";
260 PRINT "e to but not  "
270 PRINT " less than 0.5:1, with turns spaced within the range of 1.4 to 2.";
280 PRINT "2 times the   "
290 PRINT " diameter of the conductor (Radiotron Designer's Handbook, chapte";
300 PRINT "r 11.4, Sect. "
310 PRINT " 5, page 463)."
320 PRINT
330 PRINT " This program designs traps with single-layer coils wound on low ";
340 PRINT "loss forms    "
350 PRINT " within these design parameters."
360 PRINT
370 PRINT " High Q coils have relatively few turns so rounding-off even a ";
380 PRINT "fraction of a "
390 PRINT " turn can result in a significant change in coil properties."
400 PRINT
410 PRINT " The number of turns is critical so the program calculates an End";
420 PRINT "s Offset Angle"
430 PRINT " e.g. for 9.75 turns wind 9 full turns then continue a .75 turn f";
440 PRINT "or 270°.     "
450 PRINT STRING$(80,205);
460 COLOR 0,7:LOCATE ,20:PRINT " .....Press 1 to continue or 0 to exit..... "
470 COLOR 7,0
480 Z$=INKEY$:IF Z$=""THEN 480
490 IF Z$="0"THEN CLS:RUN EX$
500 IF Z$="1"THEN GOSUB 90:GOTO 520
510 GOTO 480
520 :REM'.....data input
530 LN=CSRLIN:INPUT " ENTER: Blocking frequency in MHz";F:GOSUB 90
540 LN=CSRLIN
550 PRINT USING " Blocking frequency................... ###.### MHz";F;
560 W=300/F :REM'approx. wavelength
570 PRINT " (";INT(W)" metres )"
580 XOPT=350   :REM'optimum reactance
590 MIN=INT(10^6/(2*PI*F*450))
600 MAX=INT(10^6/(2*PI*F*250))
610 LN=CSRLIN:PRINT:COLOR 0,7
620 PRINT " A standard trap capacitor between"MIN"pF and"MAX"pF is required."
630 COLOR 7,0:PRINT
640 INPUT " ENTER: Value in pF of the standard capacitor";C:GOSUB 90
650 PRINT USING " Value of trap capacitor.............. ###.### pF";C
660 U=25330/F^2/C
670 PRINT USING " Trap inductance...................... ###.### µH";U
680 XT=10^6/(2*PI*F*C)
690 PRINT " Recommended range of trap reactances  250-450 Ω"
700 PRINT USING " Reactance of this trap............... ###.### Ω";XT
710 LN=CSRLIN:INPUT "ENTER: Wire diameter in inches";WD:GOSUB 90
720 PRINT USING " Wire diameter........................ ###.### in.";WD;
730 PRINT USING " (###.# mm";WD*25.399999618530273!;:PRINT " )"
740 P=WD*2   :REM'pitch
750 COLOR 15,0
760 PRINT USING " Pitch (turn spacing c.c.)............ ###.### in.";P;
770 PRINT USING " (###.# mm";P*25.399999618530273!;:PRINT " )"
780 COLOR 7,0
790 T=1/P  :REM'turns per inch
800 PRINT USING " Turns per inch....................... ###.###";T
810 :REM'.....calculate form diameter
820 R=0.5!       :REM'coil length/diameter ratio
830 D=10:X=1   :REM'D=pitch diameter, X= increment
840 D=D+X:L=R*D:N=L*T
850 Y=SQR(U*(18*D+40*L))/D :REM'number of turns
860 IF ABS(N-Y)<9.999999747378752e-05! THEN 890
870 IF SGN(Y-N)<>SGN(X)THEN X=-X/10
880 D=D+X:GOTO 840
890 PD=D
900 PRINT USING " Coil Pitch diameter................... ###.### in.";PD;
910 CF=PD-WD:COLOR 0,7
920 LN=CSRLIN
930 PRINT " You need a coil form with a diameter less than";CF;"inches "
940 COLOR 7,0
950 INPUT " ENTER: Coil form diameter (inches)";CF:GOSUB 90
960 PRINT USING " Coil form diameter................... ###.### in.";CF;
970 PRINT USING " (###.# mm";CF*25.399999618530273!;:PRINT " )"
980 PD=CF+WD
990 PRINT USING " Coil pitch diameter.................. ###.### in.";PD;
1000 PRINT USING " (###.# mm";PD*25.399999618530273!;:PRINT " )"
1010 LG=N*P:L=(PD^2)*N^2/(18*PD+(40*LG))
1020 LN=CSRLIN
1030 PRINT USING " Coil length.......................... ###.### in.";LG;
1040 PRINT USING " (###.# mm";LG*25.399999618530273!;:PRINT " )"
1050 PRINT USING " Number of turns...................... ###.###";N
1060 EO=ABS(N-INT(N))*360:REM'ends offset angle
1070 EI=EO/360*PI*PD
1080 LOCATE CSRLIN-1,48:PRINT USING "(ends offset ###° - ##.## in.)";EO,EI
1090 W=PI*PD*(N+1)
1100 PRINT USING " Amount of wire required.............. ###.### in.";W;
1110 PRINT USING " (###.# cm";W*2.5399999618530273!;:PRINT " )"
1120 R=LG/PD
1130 COLOR 15,0
1140 PRINT USING " Coil length/diameter ratio........... ###.###";R;:PRINT" : 1"
1150 COLOR 7,0
1160 IF R>=0.5! THEN 1200
1170 PRINT :COLOR 12,0
1180 PRINT " L/D ratio is less than 0.5:1!  Try a smaller coil form!":COLOR 7,0
1190 GOTO 1390
1200 :REM'.....self resonance
1210 SW=P/WD     :REM'pitch/wire diameter
1220 A=PD/2*2.5399999618530273!:B=LG*2.5399999618530273!:JJ=25330.2890625! :REM'A=radius in cm. B=length in cm.
1230 IHC=LOG(SW+SQR(SW^2-1))  :REM' inverse hyperbolic cosince
1240 CO=PI*PD*2.5399999618530273!/(3.5999999046325684!*IHC)
1250 FS=SQR((JJ/(CO*LG*2.5399999618530273!)))  :REM'self resonant frequency
1260 PRINT USING " Self-resonant frequency............. ####.### MHz";FS
1270 CR=JJ/(F^2*U)            :REM'capacitance required to resonate
1280 Q=SQR(F)*10^3/(6.900000095367432!/A+4.5!/B)  :REM'true Q
1290 BW=F/Q*10^3
1300 COLOR 15,0
1310 PRINT USING " Q of trap........................... ####";Q
1320 COLOR 7,0
1330 LOCATE CSRLIN-1,44:PRINT "(Apparent Q may be less)"
1340 PRINT USING " Approximate bandwidth............... ####.# kHz";BW
1350 PRINT:COLOR 15,0
1360 PRINT " High Q turn spacing should be about twice the conductor diam";
1370 PRINT "eter and the "
1380 PRINT " coil length/diameter ratio not less than 0.5:1 ":COLOR 7,0
1390 :REM'.....end
1400 GOSUB 1410:GOTO 10
1410 :REM'.....PRT
1420 KEY OFF:GOSUB 1490:LOCATE 25,5:COLOR 0,2
1430 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1440 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1450 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1450 :ELSE GOSUB 1490
1460 IF Z$="3"THEN RETURN
1470 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1480 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1420
1490 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
