10 :REM'VFOFREQ - VFO Frequency - 19 APR 95 rev.13 APR 97
20 CLS: KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="vfofreq"
50 COMMON EX$,PROG$,U,UH
60 COLOR 7,0,1
70 U1$="####.###"
80 U2$="####.#"
90 U3$="####"
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " VFO Frequency Calculator";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 510
180 :REM'
190 :REM'.....inputs
200 COLOR 0,7:LOCATE 3,22
210 PRINT " Press 1 to RUN program or 0 to EXIT "
220 COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN RUN EX$
250 IF Z$="1"THEN 270
260 GOTO 230
270 LOCATE 3
280 INPUT " ENTER: Minimum Frequency of VFO.........................(MHz)";F
290 INPUT " ENTER: Maximum Capacitance of tuning capacitor C1........(pF)";C
300 VIEW PRINT 3 TO 4:CLS:VIEW PRINT
310 U=25330/F^2/C
320 LOCATE 3,5:PRINT "VARIABLE FREQUENCY OSCILLATORS"
330 PRINT TAB(4);STRING$(32,223)
340 MARG=48
350 LOCATE 3,MARG:PRINT "L1 = ";USING U1$;U;:PRINT " µH"
360 LOCATE 4,MARG:PRINT "C1 = ";USING U3$;C;:PRINT " pF (variable)"
370 LOCATE 5,MARG:PRINT STRING$(23,205)
380 LOCATE 6,MARG+2:PRINT "Sample Frequencies:"
390 LOCATE 7,MARG:PRINT STRING$(23,205)
400 LOCATE 8,MARG+1:PRINT " C1 set @    Freq."
410 LOCATE 9,MARG+1:PRINT " ───────────────────"
420 K=14   :REM'number of samples
430 FOR VAR=1 TO K
440 PF=INT(C*VAR/K):FQC=SQR(25330/PF/U)
450 LOCATE 9+VAR,MARG+2
460 PRINT USING U3$;PF;:PRINT " pF";
470 PRINT USING U1$;FQC;:PRINT " MHz"
480 NEXT VAR
490 GOTO 780
500 :REM'
510 :REM'.....diagram
520 RO=4:CO=4
530 COLOR 0,7
540 LOCATE RO+ 1,CO:PRINT "            ┌───┐               "
550 LOCATE RO+ 2,CO:PRINT "  ┌─────┬───┤VFO├─ ≈ Freq.(MHz) "
560 LOCATE RO+ 3,CO:PRINT "  │     │   └───┘               "
570 LOCATE RO+ 4,CO:PRINT "  L1    C1 (variable)           "
580 LOCATE RO+ 5,CO:PRINT "  │     │                       "
590 LOCATE RO+ 6,CO:PRINT "  └──┬──┘                       "
600 LOCATE RO+ 7,CO:PRINT "     │                          "
610 LOCATE RO+ 8,CO:PRINT "   \\┴\\                        "
620 LOCATE RO+ 9,CO:PRINT "                                "
630 COLOR 7,0
640 LOCATE RO+10,CO:PRINT "           ─- O R ──            "
650 COLOR 0,7
660 LOCATE RO+11,CO:PRINT "            ┌───┐               "
670 LOCATE RO+12,CO:PRINT "     ┌──────┤VFO├─ ≈ Freq.(MHz) "
680 LOCATE RO+13,CO:PRINT "     │      └───┘               "
690 LOCATE RO+14,CO:PRINT "     L1                         "
700 LOCATE RO+15,CO:PRINT "     │                          "
710 LOCATE RO+16,CO:PRINT "     C1 (variable)              "
720 LOCATE RO+17,CO:PRINT "     │                          "
730 LOCATE RO+18,CO:PRINT "   \\┴\\                        "
740 LOCATE RO+19,CO:PRINT "                                "
750 COLOR 7,0
760 RETURN
770 :REM'
780 :REM'.....end
790 GOSUB 990
800 LOCATE 25,1:PRINT STRING$(80,32);
810 LOCATE 24,10:COLOR 14,6
820 PRINT " Would you like to design a coil for this VFO?    (y/n) ";
830 Z$=INKEY$
840 IF Z$="N"OR Z$="n"THEN 870
850 IF Z$="Y"OR Z$="y"THEN 890
860 GOTO 830
870 COLOR 7,0,0:GOTO 110   :REM'start
880 :REM'
890 COLOR 7,0:VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
900 PRINT " Press number in < > to:"
910 PRINT UL$;
920 PRINT "   < 1 >  Select a suitable B & W coil"
930 PRINT "   < 2 >  Design your own coil"
940 Z$=INKEY$:IF Z$=""THEN 940
950 IF Z$="1"THEN CHAIN"aircore"
960 IF Z$="2"THEN UH=U:CHAIN"coildsgn"
970 GOTO 940
980 :REM'
990 :REM'.....PRT
1000 KEY OFF:GOSUB 1070:LOCATE 25,5:COLOR 0,2
1010 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1020 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1030 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1030 :ELSE GOSUB 1070
1040 IF Z$="3"THEN RETURN
1050 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1060 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1000
1070 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
