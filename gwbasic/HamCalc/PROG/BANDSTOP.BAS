10 :REM'BANDSTOP - Band Reject Filter - 26 JUN 94 rev. 08 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 UL$=STRING$(80,205)
50 U$="##,###.##"
60 :REM'
70 :REM'.....start
80 COLOR 15,2,0
90 PRINT " BAND-REJECT FILTER";TAB(57);"by George Murphy VE3ERP ";
100 COLOR 1,0
110 PRINT STRING$(80,"▀");
120 COLOR 7,0
130 :REM'
140 :REM'.....diagram
150 RO=0     :REM'row
160 CO=17    :REM'column
170 COLOR 0,7
180 LOCATE RO+3, CO:PRINT "            ┌── C2 ──┐   ┌── C2 ──┐            "
190 LOCATE RO+4, CO:PRINT "            │        │   │        │            "
200 LOCATE RO+5, CO:PRINT "     ┌────┬─┴── L2 ──┴─┬─┴── L2 ──┴─┬────┐     "
210 LOCATE RO+6, CO:PRINT "   ──┘    L1           L3           L1   └──   "
220 LOCATE RO+7, CO:PRINT " Z Ω -»   │            │            │   ─» Z Ω "
230 LOCATE RO+8, CO:PRINT "   ──┐    C1           C3           C1   ┌──   "
240 LOCATE RO+9, CO:PRINT "     └────┴──────┬─────┴────────────┴────┘     "
250 LOCATE RO+10,CO:PRINT "               \\┴\\ «──station RF ground      "
260 COLOR 7,0
270 LOCATE RO+12,3
280 PRINT UL$;
290 COLOR 0,7:LOCATE CSRLIN,22
300 PRINT " Press 1 to continue or 0 to exit...."
310 COLOR 7,0
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="0"THEN CLS:RUN EX$
340 IF Z$="1"THEN 360
350 GOTO 320
360 LOCATE CSRLIN-2:PRINT STRING$(80,32);:LOCATE CSRLIN-2
370 PRINT " House filter in an RF-tight metal box, placed in the receiver ";
380 PRINT "antenna line"
390 PRINT UL$;
400 GOTO 470
410 :REM'
420 :REM'.....re-format input line
430 LOCATE CSRLIN-1:PRINT STRING$(8,32);
440 LOCATE CSRLIN,60:PRINT USING U$;X;:PRINT " "+Y$
450 RETURN
460 :REM'
470 :REM'.....inputs
480 INPUT " ENTER: Frequency of LOW  end of unwanted band..........F1= (MHz)";X
490 Y$="MHz":GOSUB 420:F1=X
500 INPUT " ENTER: Frequency of HIGH end of unwanted band..........F2= (MHz)";X
510 Y$="MHz":GOSUB 420:F2=X
520 INPUT " ENTER: Impedance of transmission line...................Z=(ohms)";X
530 Y$="Ω":GOSUB 420:R=X
540 :REM'.....calculate
550 L1=0.3179999887943268!*R/(F2-F1)
560 L2=0.07959999889135361!*(F2-F1)*R/(F1*F2)
570 L2 =L2*2
580 L3=L1/2
590 C1=7.960000038146973!*(F2-F1)*10^4/(F1*F2*R)
600 C2=3.180000066757202!*10^5/((F2-F1)*R)
610 C2=C2/2
620 C3=C1*2
630 :REM'.....print
640 PRINT TAB(57);"L1=";USING U$;L1;:PRINT " µH"
650 PRINT TAB(57);"L2=";USING U$;L2;:PRINT " µH"
660 PRINT TAB(57);"L3=";USING U$;L3;:PRINT " µH"
670 PRINT TAB(57);"C1=";USING U$;C1;:PRINT " pF"
680 PRINT TAB(57);"C2=";USING U$;C2;:PRINT " pF"
690 PRINT TAB(57);"C3=";USING U$;C3;:PRINT " pF"
700 PRINT UL$;
710 GOSUB 740
720 CLS:GOTO 70
730 :REM'
740 :REM'PRT
750 KEY OFF:GOSUB 820:LOCATE 25,5:COLOR 0,2
760 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
770 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
780 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 780 :ELSE GOSUB 820
790 IF Z$="3"THEN RETURN
800 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
810 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 750
820 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
