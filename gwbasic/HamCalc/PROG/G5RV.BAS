10 :REM'G5RV - G5RV Antenna - 22 DEC 95 rev. 21 SEP 1999
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="g5rv"
40 RA=51
50 COMMON EX$,PROG$,RA
60 CLS:KEY OFF
70 COLOR 7,0,1
80 UL$=STRING$(80,205)
90 U$="####.##"
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " G5RV MULTIBAND ANTENNA";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 630   :REM'preface
180 PRINT UL$;
190 PRINT " Press number in < >to:"
200 PRINT UL$;
210 PRINT "   < 1 > Display G5RV diagram"
220 PRINT "   < 2 > Design an open-wire feed line"
230 PRINT "   < 3 > Design an Inverted-Vee configuration"
240 PRINT "   < 4 > Run ZEPP EDZ ANTENNA program"
250 PRINT "   < 0 > EXIT";
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="0"THEN CLS:RUN EX$
280 IF Z$="1"THEN 330
290 IF Z$="2"THEN CLS:CHAIN"openwire"
300 IF Z$="3"THEN CLS:CHAIN"invee"
310 IF Z$="4"THEN CLS:CHAIN"zeppdbl"
320 GOTO 260
330 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
340 GOSUB 370
350 GOTO 960
360 :REM'
370 :REM'.....diagram
380 LOCATE 3:C=16
390 COLOR 0,7
400 LOCATE ,C:PRINT "                                                 "
410 LOCATE ,C:PRINT "    │«───────────── 102'(31m) ─────────────»│    "
420 LOCATE ,C:PRINT "    │«─── 51'(15.5m)───»│«─── 51'(15.5m)───»│    "
430 LOCATE ,C:PRINT " - -∞──────────────────┬∞┬──────────────────∞- - "
440 LOCATE ,C:PRINT "                       │ │                       "
450 LOCATE ,C:PRINT " 300-600 Ω balanced    ├∞┤                       "
460 LOCATE ,C:PRINT " line matching section │ │                       "
470 LOCATE ,C:PRINT " 34'(10.36m) long ────»├∞┤                       "
480 LOCATE ,C:PRINT "                       │ │                       "
490 LOCATE ,C:PRINT "                       ├∞┤                       "
500 LOCATE ,C:PRINT "                       └┐│                       "
510 LOCATE ,C:PRINT "                        ╟┘                       "
520 LOCATE ,C:PRINT "          50-75Ω coax ─»║                        "
530 LOCATE ,C:PRINT "          any length    ║                        "
540 LOCATE ,C:PRINT "                      ┌─╨─┐                      "
550 LOCATE ,C:PRINT "           Transmatch │ T │                      "
560 LOCATE ,C:PRINT "                      └───┘                      "
570 COLOR 7,0
580 PRINT
590 PRINT TAB(10);
600 PRINT "(ref. The ARRL ELECTRONICS DATA BOOK, 2nd Edition, page 7-8).";
610 RETURN
620 :REM'
630 :REM'.....preface
640 T=7
650 PRINT TAB(T);
660 PRINT "  The G5RV is easy to build and requires no pruning. The dimensions"
670 PRINT TAB(T);
680 PRINT "were developed by Louis Varney G5RV to provide a low feed-point"
690 PRINT TAB(T);
700 PRINT "impedance on amateur bands from 80-10 metres. It also performs well"
710 PRINT TAB(T);
720 PRINT "as an inverted vee on 80 and 40 metres if the apex angle is within"
730 PRINT TAB(T);
740 PRINT "90°-110°. It is essentially a multiband antenna efficient on all HF"
750 PRINT TAB(T);
760 PRINT "bands from 3.5-28 MHz, consisting of a 3/2 wavelength centre-fed"
770 PRINT TAB(T);
780 PRINT "LONGWIRE at 14 MHz, with the matching section functioning as a 1:1"
790 PRINT TAB(T);
800 PRINT "impedance transformer. On other bands the matching section becomes "
810 PRINT TAB(T);
820 PRINT "a series-section impedance transformer."
830 PRINT TAB(T);
840 PRINT "  The antenna is fed with coaxial cable at the bottom end of the"
850 PRINT TAB(T);
860 PRINT "matching section. A transmatch is required for efficient operation."
870 PRINT TAB(T);
880 PRINT "  Unlike some other antennas, the G5RV is NOT scalable to other"
890 PRINT TAB(T);
900 PRINT "dimensions. Attempts at scaling will produce only a centre-fed"
910 PRINT TAB(T);
920 PRINT "random wire. (See also HAMCALC's ";CHR$(34);"ZEPP EDZ ANTENNA";
930 PRINT CHR$(34);" program)."
940 RETURN
950 :REM'
960 :REM'.....end
970 GOSUB 1010
980 GOTO 110
990 END
1000 :REM'
1010 :REM'PRT
1020 KEY OFF:GOSUB 1090:LOCATE 25,5:COLOR 0,2
1030 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1040 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1050 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1050 :ELSE GOSUB 1090
1060 IF Z$="3"THEN RETURN
1070 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1080 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1020
1090 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
