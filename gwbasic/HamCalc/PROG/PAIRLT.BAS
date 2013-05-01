10 :REM'PAIRLT- LONG-TAILED PAIR - 08 JUL 2009 - rev 27 MAR 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " LONG-TAILED PAIR"TAB(60)" by R.J.DeHoney IEEE ";
90 COLOR 7,0:PRINT STRING$(80,205);
100 T=20:GOSUB 280
110 PRINT
120 PRINT " This program analyzes the performance of a long tailed pair circuit."
130 PRINT
140 PRINT " This circuit consists of two bipolar transistors whose emitters are connected"
150 PRINT " together and the input applied across their bases. The output is usually taken"
160 PRINT " across their collectors. It is widely used in linear difference amplifiers."
170 :REM'.....launch
180 PRINT
190 PRINT " Press (1) to continue, (2) for theory, or (0) to exit....."
200 Z$=INKEY$:IF Z$=""THEN 200
210 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
220 IF Z$="1"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 260
230 IF Z$="2"THEN 850
240 IF Z$="0"THEN CLS:RUN GO$
250 GOTO 200
260 PRINT
270 T=19:GOSUB 280:GOTO 410
280 :REM'.....diagram
290 LOCATE ,T:PRINT "                   Vpos"
300 LOCATE ,T:PRINT "                 ┌──┴──┐"
310 LOCATE ,T:PRINT "                RC1   RC2"
320 LOCATE ,T:PRINT "                 │     │"
330 LOCATE ,T:PRINT "               │/c     c\│"
340 LOCATE ,T:PRINT "     Vin──RS───┤         ├──V2"
350 LOCATE ,T:PRINT "               │\─R1┬R2─/│"
360 LOCATE ,T:PRINT "                    │"
370 LOCATE ,T:PRINT "                    Re"
380 LOCATE :REM't:PRINT "                    │
390 LOCATE ,T:PRINT "                   Vneg"
400 RETURN
410 :REM'.....data input
420 K=1000 :C=39.5! :I0=9.999999960041972e-12! :INPUT "Enter Vpos, volts ",VPOS
430 INPUT "Enter Vneg, volts ",VNEG :IF VNEG>0 THEN VNEG=-VNEG
440 INPUT "Enter V2, volts ",V2
450 INPUT "Enter RC1, ohms ",RC1 :RC1=RC1/K
460 INPUT "Enter RC2, ohms ",RC2 :RC2=RC2/K
470 INPUT "Enter R1, ohms ",R1 :R1=R1/K
480 INPUT "Enter R2, ohms ",R2 :R2=R2/K
490 INPUT "Enter Re, ohms ",RE :RE=RE/K
500 INPUT "Enter Rs, ohms ",RS :RS=RS/K
510 INPUT "Enter transistor current gain, beta ",B
520 CLS
530 PRINT TAB(60)"LONG-TAILED PAIR"
540 PRINT TAB(60)"════════════════"
550 LOCATE 1
560 PRINT "   Vin      VC       VC2    Ie2    Ie1   Gain"
570 FOR N=4 TO 15:IE2=(V2-0.6299999952316284!-VNEG)/2/RE*(N/10):IC2=IE2/(1+1/B):VC2=VPOS-IC2*RC2
580 IF VC2<1+V2 THEN CLS :PRINT "Vc2 too small - Increase Re !" :PRINT :GOTO 730
590 VBE2=1/C*LOG(IE2/I0) :VE=V2-VBE2-IE2*R2 :IE=(VE-VNEG)/RE :IE1=IE-IE2
600 IF IE1<0 THEN CLS :PRINT "Ie1<0 - Decrease Re !" :PRINT :GOTO 730
610 VBE1=1/C*LOG(IE1/I0) :IB1=IE1/(B+1) :IC1=B*IB1 :VIN=VE+IE1*R1+VBE1+IB1*RS
620 VC1=VPOS-IC1*RC1
630 DVIN=VINOLD-VIN :VINOLD=VIN :DVOUT=VC2OLD-VC2 :VC2OLD=VC2 :G=DVOUT/DVIN
640 IF N>4 THEN PRINT USING "##.####  ##.####  ##.#### ##.##  ##.##  ##.##";VIN;VC1;VC2;IE2;IE1;G
650 NEXT N
660 LOCATE 3:T=48:GOSUB 280
670 PRINT :PRINT " Want to change anything? (y/n)"
680 Z$=INKEY$:IF Z$=""THEN 680
690 IF Z$="y"THEN LOCATE CSRLIN-1:GOTO 720
700 IF Z$="n"THEN 1020
710 GOTO 680
720 :REM'.....new inputs
730 PRINT"Vpos="VPOS;:INPUT ",Enter new Vpos or <ENTER> ",X :IF X<>0 THEN VPOS=X
740 PRINT"Vneg="VNEG;:INPUT ",Enter new Vneg or <ENTER> ",X :IF X<>0 THEN VNEG=X
750 IF VNEG>0 THEN VNEG=-VNEG
760 PRINT"V2="V2;:INPUT ",Enter new V2 or <ENTER> ",X :IF X<>0 THEN V2=X
770 PRINT "RC1="RC1*K;:INPUT ",Enter new RC1 or <ENTER> ",X:IF X<>0 THEN RC1=X/K
780 PRINT "RC2="RC2*K;:INPUT ",Enter new RC2 or <ENTER> ",X:IF X<>0 THEN RC2=X/K
790 PRINT "R1="R1*K;:INPUT ",Enter new R1 or <ENTER> ",X :IF X<>0 THEN R1=X/K
800 PRINT "R2="R2*K;:INPUT ",Enter new R2 or <ENTER> ",X :IF X<>0 THEN R2=X/K
810 PRINT "Re="RE*K;:INPUT ",Enter new Re or <ENTER> ",X :IF X<>0 THEN RE=X/K
820 PRINT "Rs="RS*K;:INPUT ",Enter new Rs or <ENTER> ",X :IF X<>0 THEN RS=X/K
830 PRINT "Beta="B;:INPUT ",Enter new Beta or <ENTER> ",X :IF X<>0 THEN B=X
840 GOTO 520
850 :REM'         --------------------Theory----------------------
860 LOCATE 3
870 PRINT " We need the DC voltages, the transistors' Beta, and the resistor values."
880 PRINT " We start by assuming a value for the emitter current of T2, Ie2. Then,"
890 PRINT " using the diode equation, we get Vbe2. Then Ve2=V2-Vbe2. Knowing Ie2, the"
900 PRINT " drop across R2 is Ie2*R2. This gives us Ve, the voltage at the top of Re."
910 PRINT " Knowing Vneg, we can find the current through Re, Ie, then Ie1 must be"
920 PRINT " Ie-Ie2. Using Ie1, we can find Vbe1 and the drop across R1, giving us the"
930 PRINT " voltage on V1's base. Knowing Beta, we can find Ib1, then Vin=Vb1+Ib1*Rs."
940 PRINT " Since we know the emitter currents and the Betas, we can find the collector"
950 PRINT " currents, which gives us collector voltages. Line 270 which defines the"
960 PRINT " range of Ie2, tries to make Ie1 and Ie2 about equal at N=10."
970 PRINT " Our version of the diode equation is Vbe=C*log(Ie/I0) where C is 39.5 and"
980 PRINT " I0=1e-11. This gives a Vbe which matches measurements fairly well."
990 PRINT :PRINT" .....press an key....."
1000 Z$=INKEY$:IF Z$=""THEN 1000
1010 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 190
1020 :REM'......end
1030 GOSUB 1040:CLS:GOTO 60
1040 :REM'.....PRT
1050 KEY OFF:GOSUB 1120:LOCATE 25,5:COLOR 0,2
1060 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1070 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1080 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1080 :ELSE GOSUB 1120
1090 IF Z$="3"THEN RETURN
1100 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1110 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1050
1120 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
