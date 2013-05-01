10 :REM'THEVININ Voltage Divider - 22 MAR 2006
20 IF EX$=""THEN EX$="exit"
30 COMMON EX$
40 CLS:KEY OFF:COLOR 7,0,0
50 UL$=STRING$(80,205)
60 PRINT  " VOLTAGE DIVIDER"TAB(57)"by George murphy VE3ERP ";
70 PRINT UL$;
80 LOCATE CSRLIN-1,24:PRINT " (algorithm by Ralph Dieter K1RD) "
90 COLOR 0,7
100 Q=20
110 LOCATE ,Q:PRINT " + ────V1────R1────V3────R2────V2──── - "
120 LOCATE ,Q:PRINT " pos              output            neg "
130 COLOR 7,0
140 PRINT
150 PRINT " This program finds R1 and R2 in a voltage divider, using 1% valu";
160 PRINT  "es. Given"
170 PRINT " info is V1 (most pos), V2 (most neg), V3 (desired output), and I";
180 PRINT "mA (desired"
190 PRINT " current thru R1 & R2 in mA). Output displays exact values, 1% va";
200 PRINT "lues and"
210 PRINT " Thevinin equivalent circuit for load analysis."
220 PRINT UL$;
230 LN=CSRLIN:LOCATE LN,20
240 COLOR 0,7:PRINT " Press <1> to run program or <0> to EXIT ":COLOR 7,0
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="0"THEN CLS:CHAIN EX$
270 IF Z$="1"THEN GOSUB 890:GOTO 300
280 GOTO 250
290 :REM'
300 :REM'.....start
310 LN=CSRLIN:INPUT " ENTER: Most positive voltage";V1
320 GOSUB 890:PRINT " Most positive voltage................ V1=";V1;"volts"
330 LN=CSRLIN:INPUT " ENTER: Most negative voltage";V2
340 GOSUB 890:PRINT " Most negative voltage................ V2=";V2;"volts"
350 LN=CSRLIN:INPUT " ENTER: Desired output voltage";V3
360 GOSUB 890:PRINT " Desired output voltage............... V3=";V3;"volts"
370 IF V2>V1 THEN 700
380 IF V3<=V2 OR V3>=V1 THEN 700
390 LN=CSRLIN:INPUT " ENTER: Desired curremt thru R1 and R2(mA)";IMA
400 GOSUB 890:PRINT " Desired current thru R1 & R2.........";IMA;"mA"
410 LN=CSRLIN:GOSUB 890
420 :REM'
430 :REM'.....calculation
440 IMA=IMA/10^3
450 VTOT = V1 - V2
460 X = (VTOT - V3 + V2) / (V3 - V2)
470 RT=VTOT/IMA
480 R2=(V3-V2)/IMA
490 R1=X*R2
500 PRINT " Exact R1......";R1;"ohms"
510 PRINT " Exact R2......";R2;"ohms"
520 T = R1
530 GOSUB 730
540 R4 = R3
550 PRINT " 1% R1.........";R4"ohms"
560 T = R2
570 GOSUB 730
580 R5 = R3
590 PRINT " 1% R2.........";R5"ohms"
600 RT1 = R4 + R5
610 INEW = VTOT / RT1
620 VOUT = (INEW * R5) + V2
630 PRINT " New V3........";VOUT
640 PRINT
650 RTHEV=1/(1/R4+1/R5)
660 PRINT " Thevinin circuit:"
670 PRINT VOUT; "-------"; RTHEV; "-----o"
680 PRINT
690 GOTO 860
700 PRINT " V3 must be less than V1 and greater than V2.....press any key....."
710 Z$=INKEY$:IF Z$=""THEN 710 :ELSE GOSUB 890:GOTO 350
720 :REM'
730 :REM'.....calculate
740 N = INT(96 * 0.4343000054359436! * LOG(T))
750 FOR J = 1 TO 2
760 R(J) = 10 ^ ((N + J - 1) / 96)
770 V = 0.4343000054359436! * LOG(R(J))
780 V = INT(V) - 2
790 R(J) = INT(R(J) / (10 ^ V) + 0.5!)
800 R(J) = R(J) * 10 ^ V
810 NEXT J
820 R3 = R(1)
830 IF T > (R(1) + R(2)) / 2 THEN R3 = R(2)
840 RETURN
850 :REM'
860 :REM'.....end
870 GOSUB 930:GOTO 40
880 :REM'
890 :REM'.....clear to bottom of screen
900 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
910 RETURN
920 :REM'
930 :REM'.....PRT
940 KEY OFF:GOSUB 1010:LOCATE 25,5:COLOR 0,2
950 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
960 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
970 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 970 :ELSE GOSUB 1010
980 IF Z$="3"THEN RETURN
990 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1000 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 940
1010 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
