10 :REM'BRIDGE-2   20 SEP 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS:COLOR 15,2
80 PRINT " WHEATSTONE BRIDGE #2"TAB(61)"by R.J.Dehoney IEEE "
90 COLOR 7,0
100 :REM'.....start
110 REM '---------------BRIDGE7.BAS,rjd,8/18/10-------------------
120 PRINT "Traditional Wheatstone bridges used galvanometers or current meters to measure"
130 PRINT "the error current. Modern bridge circuits use op amps to sense the error"
140 PRINT "voltage. Given the resistor values, this program calculates the sensitivity of"
150 PRINT "such a circuit. We define sensitivity at the null point as:"
160 GOSUB 170:GOTO 270
170 :REM'.....diagram
180 COLOR 0,7
190 T=16
200 LOCATE ,T:PRINT "                                 ┌─RS─┬────────┐  "
210 LOCATE ,T:PRINT "          dVm/Vs                 │    R1       R1 "
220 LOCATE ,T:PRINT "    S = ─────────               VS    ├───RM───┤  "
230 LOCATE ,T:PRINT "          dRx/R2                 │    R2 +Vm-  RX "
240 LOCATE ,T:PRINT "                                 └────┴────────┘  "
250 COLOR 7,0
260 RETURN
270 PRINT "or the change in error voltage relative to the supply voltage, divided by the"
280 PRINT "change in sensing resistance relative to its null value. We quickly find that"
290 PRINT "the sensitivity is greatest when Rs is small and RM is large, and, of course,"
300 PRINT "is independent of Vs. It is maximum when R1 equals R2. In addition to the"
310 PRINT "sensitivity, the program calculates the output voltage as a function of Rx"
320 PRINT "and also finds Rx for a desired error voltage or current."
330 PRINT
340 LN=CSRLIN
350 PRINT "Press <1> to continue or <0> to exit"
360 A$=INKEY$:IF A$=""THEN 360
370 IF A$="0"THEN RUN GO$
380 CLS:PRINT "WHEATSTONE BRIDGE #2"
390 PRINT "════════════════════"
400 GOSUB 170
410 LN=CSRLIN
420 INPUT "Enter Vs, volts ",VS
430 INPUT "Enter Rs, ohms ",RS
440 INPUT "Enter R1, ohms ",R1
450 INPUT "Enter R2, ohms ",R2
460 INPUT "Enter Rm, ohms ",RM
470 GOSUB 820
480 PRINT USING "Vs= #######,###.# volts";VS
490 PRINT USING "Rs= #######,###.# ohms";RS
500 PRINT USING "R1= #######,###.# ohms";R1
510 PRINT USING "R2= #######,###.# ohms";R2
520 PRINT USING "Rm= #######,###.# ohms";RM
530 :REM'.......calculate
540 A=R1*((2*RS+R1)*(RM+R2)+RM*R2)+RS*RM*R2 :C=A/R1/RM
550 B=R1*(R1+RM+2*(R2+RS))+RM*(R2+RS) :D=B/R1/RM
560 PC=R2/(C+D*R2)
570 PRINT USING "PC= #######,###.###";PC;:PRINT" (sensitivity)"
580 LN=CSRLIN
590 INPUT "Enter Rx, ohms       ",RX
600 LOCATE LN:PRINT USING "RX= #######,###.# ohms            ";RX
610 VM=VS*(R2-RX)/(C+D*RX)
620 PRINT USING "Vm= #######,###.### volts";VM
630 IM=VS/RM*(R2-RX)/(C+D*RX)
640 PRINT USING "IM= #######,###.### microamps";IM*10^6
650 :REM'......change values
660 PRINT :INPUT "Enter new value for Rx or, to continue, press <Enter>     ",RX
670 IF RX<>0 THEN GOSUB 820:GOTO 600
680 LN=CSRLIN-1:GOSUB 820 :LOCATE LN
690 INPUT "Enter desired error VOLTAGE Vm or, to continue, press <Enter> ",VM
700 IF VM=0 THEN GOSUB 830 :GOTO 750
710 IF VM=>VS*R2/C THEN PRINT "Vm must be less than"VS*R2/C :GOTO 690
720 IF VM=<(-VS/D) THEN PRINT "Vm must be greater than"(-VS/D) :GOTO 690
730 RX=(VS*R2-VM*C)/(VM*D+VS):LOCATE LN-1: PRINT "Rx="RX :GOSUB 820 :GOTO 690
740 PRINT
750 INPUT "Enter desired error CURRENT Im or, to continue, just <Enter> ",IM
760 IF IM=0 THEN 800
770 IF IM=>VS*R2/C/RM THEN PRINT "Im must be less than"VS*R2/C/RM :GOTO 750
780 IF IM=<(-VS/D/RM) THEN PRINT "Im must be greater than"(-VS/D/RM) :GOTO 750
790 RX=(VS*R2-IM*RM*C)/(IM*RM*D+VS) :LOCATE LN-1: PRINT "Rx="RX :GOSUB 820:GOTO 750
800 :REM'......end
810 GOSUB 820:GOSUB 840:GOTO 60
820 :REM'...... clear screen
830 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
840 :REM'.....PRT
850 KEY OFF:GOSUB 920:LOCATE 25,5:COLOR 0,2
860 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
870 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
880 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 880 :ELSE GOSUB 920
890 IF Z$="3"THEN RETURN
900 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
910 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 850
920 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
