10 :REM'CAPCOAX - Capacitors from Coaial Cable - 01 MAR 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PI=4*ATN(1)  :REM'3.141593
50 LF=1/LOG(10) :REM'log conversion to base 10
60 DIM C$(42,9) :REM'coax specs.
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,0
110 PRINT " CAPACITORS Made From COAXIAL CABLE";
120 PRINT TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 GOSUB 900
160 :REM'
170 :REM'.....start
180 T=9
190 PRINT
200 PRINT TAB(T);
210 PRINT "Precision capacitors from about 1 pF upwards may be made from"
220 PRINT TAB(T);
230 PRINT "short lengths of coaxial cable, with the inner conductor being"
240 PRINT TAB(T);
250 PRINT "one capacitor plate and the outer shield being the other."
260 PRINT
270 COLOR 0,7:LOCATE ,24: PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
280 PRINT
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="0"THEN CLS:CHAIN EX$
310 IF Z$="1"THEN 340
320 GOTO 290
330 :REM'
340 INPUT " ENTER: desired capacity, in pF.........";CC
350 :REM'
360 :REM'.....start
370 COLOR 7,0,1
380 PRINT STRING$(80,205);
390 OPEN"I",1,"\hamcalc\coaxfile\coaxial.fil"
400 FOR Z=1 TO 40:FOR Y=1 TO 9
410 INPUT#1,Z$
420 C$(Z,Y)=Z$
430 NEXT Y:
440 NEXT Z
450 CLOSE
460 FOR Y=1 TO 39
470 E=VAL(C$(Y,3))         :REM'dielectric constant
480 Z=VAL(C$(Y,5))         :REM'characteristic impedance
490 D=10^(Z*SQR(E)/138)
500 C=7.260000228881836!*E/(LOG(D)*LF)   :REM'µF/ft.
510 C$(Y,2)=STR$(C)
520 C$(Y,3)=C$(Y,4)
530 NEXT Y
540 :REM'
550 PRINT " Press number in < > to choose standard units of measure:"
560 PRINT UL$;
570 PRINT "   < 1 >  Metric"
580 PRINT "   < 2 >  U.S.A./Imperial"
590 K$=INKEY$
600 IF K$="1"THEN UM=25.399999618530273!:UM$="mm.":GOTO 640
610 IF K$="2"THEN UM=1:UM$="in.":GOTO 640
620 GOTO 590
630 :REM'
640 :REM'.....print coax list
650 CLS:COLOR 7,0,0
660 PRINT " LENGTHS of COAXIAL CABLE WITH A CAPACITANCE OF";CC;"pF"
670 PRINT STRING$(80,205);
680 GOSUB 900
690 IF UM=1 THEN M$="ft.":ELSE M$="m. "
700 PRINT TAB(1) "      Type         ";UM$;
710 PRINT TAB(27)"      Type         ";UM$;
720 PRINT TAB(54)"      Type         ";UM$
730 PRINT UL$;
740 IF UM=1 THEN Y$="###.###":ELSE Y$="#####.#"
750 FOR Z=1 TO 13
760 Z$=STR$(Z):Z$=RIGHT$(Z$,LEN(Z$)-1)
770 IF LEN(Z$)<2 THEN Z$=" "+Z$
780 PRINT TAB(4);C$(Z,1);TAB(17);USING Y$;CC/VAL(C$(Z,2))*12*UM;
790 PRINT TAB(26);"│   ";
800 PRINT TAB(30);C$(Z+13,1);TAB(43);USING Y$;CC/VAL(C$(Z+13,2))*12*UM;
810 PRINT TAB(53);"│   ";
820 PRINT TAB(57);C$(Z+26,1);TAB(70);USING Y$;CC/VAL(C$(Z+26,2))*12*UM
830 NEXT Z
840 PRINT UL$;
850 PRINT
860 PRINT " * denotes foam dielectric.";
870 PRINT UL$;
880 GOSUB 1000:GOTO 80
890 :REM'
900 :REM'.....diagram
910 COLOR 0,7:X=22
920 LOCATE ,X:PRINT "    ┌─ shield                         "
930 LOCATE ,X:PRINT "    └─»╤══════════════════════╤       "
940 LOCATE ,X:PRINT " +─────────inner conductor─────       "
950 LOCATE ,X:PRINT "       ╧══════════════════════╧──── - "
960 LOCATE ,X:PRINT "       │«────── length ──────»│       "
970 LOCATE ,X:PRINT "                                      "
980 COLOR 7,0:RETURN
990 :REM'
1000 :REM'.....PRT
1010 KEY OFF:GOSUB 1080:LOCATE 25,5:COLOR 0,2
1020 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1030 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1040 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1040 :ELSE GOSUB 1080
1050 IF Z$="3"THEN RETURN
1060 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1070 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1010
1080 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
