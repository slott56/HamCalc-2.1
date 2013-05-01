10 :REM'SCHMIDT....Schmidt trigger op-amp - 15 NOV 05, corrected fig, 13 Nov 2010
20 KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 UL$=STRING$(80,205)
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,1
110 PRINT " Schmidt Trigger Circuit"TAB(63)"by Robert Dehoney ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 15,2
140 LOCATE CSRLIN-1,18:PRINT " (edited for HAMCALC by George Murphy, VE3ERP) "
150 COLOR 7,0
160 PRINT
170 PRINT " This program calculates resistor values for the Schmidt trigger ci";
180 PRINT "rcuit shown"
190 PRINT " below. It uses any op amp that can swing rail to rail."
200 PRINT UL$;
210 PRINT "                            Vdc"
220 PRINT "                            ┌──┴──┐"
230 PRINT "                  Vin───────┤-    │"
240 PRINT "                            │OPAMP├───┬───OUT"
250 PRINT "                         ┌──┤+    │   │"
260 PRINT "                         │  └──┬──┘   R3"
270 PRINT "                         │     ╧      │"
280 PRINT "                 Vdc──R1─┴────────────┤"
290 PRINT "                                      R2"
300 PRINT "                                      │"
310 PRINT "                                      ╧"
320 PRINT ""
330 LN = CSRLIN
340 PRINT "To run program....press 1"
350 PRINT "To EXIT...........press 0"
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="0"THEN RUN EX$
380 IF Z$="1"THEN 400
390 GOTO 360
400 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
410 INPUT " ENTER: Op Amp supply voltage Vdc";V
420 GOSUB 910
430 PRINT USING" Op Amp supply voltage.............. #####.#";V
440 PRINT" ENTER: Upper switching threshold less than";V;:INPUT VT1
450 GOSUB 910
460 IF VT1>=V THEN BEEP:GOTO 440
470 GOSUB 910
480 PRINT" ENTER: Lower switching threshold less than";VT1;:INPUT VT2
490 GOSUB 910
500 IF VT2>=VT1 THEN BEEP:GOTO 480
510 PRINT USING" Upper switching threshold voltage.. #####.#";VT1
520 GOSUB 910
530 PRINT USING" Lower switching threshold voltage.. #####.#";VT2
540 GOSUB 910
550 INPUT " ENTER: any value for R1";R1
560 GOSUB 910
570 A=(V-VT2)/(V-VT1)*VT1/VT2
580 B=VT1/(V-VT1)+1
590 R3=INT(B*R1/(A-1))
600 R2=INT(VT1/(V-VT1)*1/(1/R1+1/R3))
610 PRINT " Vdc=";V;" Out=";VT2;"to";VT1
620 PRINT " R1="R1" R2="R2"  R3="R3
630 PRINT:PRINT " Do you want to avoid high ohms for R3 ?  (y/n)"
640 Z$=INKEY$:IF Z$=""THEN 640
650 IF Z$="n"THEN GOSUB 950:GOTO 80
660 IF Z$="y" THEN 680
670 GOTO 640
680 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 6
690 PRINT " To avoid high ohms for R3, use the circuit below." :PRINT
700 PRINT "                              Vdc"
710 PRINT "                            ┌──┴──┐"
720 PRINT "                  Vin───────┤-    │"
730 PRINT "                            │OPAMP├───┬───OUT"
740 PRINT "                        ┌───┤+    │   │"
750 PRINT "                        │   └──┬──┘   Rc"
760 PRINT "                        │      ╧      │"
770 PRINT "              Vdc───R1──┴─────Ra──────┤"
780 PRINT "                                      Rb"
790 PRINT "                                      │"
800 PRINT "                                      ╧"
810 PRINT
820 PRINT " Vdc=";V;" Out=";VT2;"to";VT1
830 PRINT "ENTER: standard resistor less than"R3"ohms for Rc";:INPUT RC
840 GOSUB 910
850 IF RC>=R3 THEN BEEP:GOTO 830
860 RX=RC*(R2+R3)/(R3-RC):RS=R2+R3+RX
870 RA=INT(R2*R3/RS+0.5!):RB=INT(R2*RX/RS+0.5!)
880 PRINT :PRINT " R1="R1  "Ra="RA"  Rb="RB"  Rc="RC
890 GOSUB 950:GOTO 80
900 :REM'
910 :REM'.....erase previous line
920 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
930 RETURN
940 :REM'
950 :REM'.....PRT
960 KEY OFF:GOSUB 1030:LOCATE 25,5:COLOR 0,2
970 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
980 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
990 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 990 :ELSE GOSUB 1030
1000 IF Z$="3"THEN RETURN
1010 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1020 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 960
1030 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
