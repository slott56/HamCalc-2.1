10 :REM'FISHBONE - Fishbone Antenna - 13 JUL 97 rev.
20 CLS:KEY OFF
30 IF EX$=""THEN  EX$="EXIT"
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="#####.## "
70 VL=2997924.0!/10^4  :REM'velocity of light (megametres/sec.)- ISO 1992 standard
80 :REM'.....AWG calculator
90 DIM GA(40)
100 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
110 FOR Z=1 TO 40
120 N=Z+3
130 GA(Z)=0.46000000834465027!/K^N
140 NEXT Z
150 :REM'
160 COLOR 15,2
170 PRINT " FISHBONE ANTENNA";TAB(57)"by George Murphy VE3ERP ";
180 COLOR 1,0:PRINT STRING$(80,223);
190 COLOR 7,0
200 GOSUB 870   :REM'diagram
210 PRINT UL$;
220 :REM'
230 GOSUB 1050   :REM'prologue
240 COLOR 0,7:LOCATE 25,24
250 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="0"THEN CLS:RUN EX$
280 IF Z$="1"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 310
290 GOTO 260
300 :REM'
310 :REM'.....start
320 INPUT  " ENTER: Frequency of operation (MHz)";F
330 WL=VL/F   :REM'wavelength in free space
340 PRINT "   1 wavelength @";F;"MHz =";WL;"metres in free space."
350 PRINT UL$;
360 COLOR 0,7
370 PRINT " Indicate wire size: "
380 COLOR 7,0
390 PRINT
400 PRINT " For wire diameter in millimetres:"
410 PRINT "   Enter a decimal value between 1 and 7."
420 PRINT
430 PRINT " For wire diameter in inches:"
440 PRINT "   Enter a decimal value less than 1."
450 PRINT
460 PRINT " For AWG wire sizes:"
470 PRINT "   Enter an AWG size greater than 7."
480 PRINT
490 COLOR 0,7
500 INPUT " ENTER: One of the above values ";Z
510 COLOR 7,0
520 IF Z>=1 AND Z<=7 THEN W=Z/25.399999618530273!:GOTO 560
530 IF Z<1 THEN W=Z:GOTO 560
540 IF Z>7 AND Z<=40 THEN W=GA(Z):AWG=Z:GOTO 560
550 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1:GOTO 500
560 LOCATE CSRLIN-1:PRINT STRING$(80,32);:LOCATE CSRLIN-1
570 PRINT " Diameter of selected wire:"
580 PRINT USING "####.#";W*25.399999618530273!;:PRINT " mm. =";
590 PRINT USING "##.###";W;:PRINT " in.";
600 IF AWG THEN PRINT " ( AWG#";AWG;")" :ELSE PRINT ""
610 PRINT
620 COLOR 0,7:PRINT " Press any key to continue ":COLOR 7,0
630 IF INKEY$=""THEN 630
640 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:GOSUB 870  :REM'diagram
650 LS=10^(600/276)/2*W*25.399999618530273!   :REM'xmission line spacing in mm.
660 OL=WL*5      :REM'overall length in metres
670 EL=0.44999998807907104!*WL    :REM'element length in metres
680 ES=WL/4      :REM'element spacing
690 PRINT UL$;
700 PRINT " Frequency of operation............";USING "#####.###";F;
710 PRINT " MHz =";USING U$;WL;:PRINT " metres"
720 PRINT " Number of elements................";USING "#####";21
730 PRINT " Wire Diameter.....................";USING U$;W*25.399999618530273!;
740 PRINT " mm. =";USING U$;W;:PRINT " in.";
750 IF AWG THEN PRINT " ( AWG#";AWG;")" :ELSE PRINT ""
760 PRINT " Feedline Spacing...............LS=";USING U$;LS;
770 PRINT " mm. =";USING U$;LS/25.399999618530273!;:PRINT " in.";
780 PRINT " Element Spacing................ES=";USING U$;ES;
790 PRINT " m.  =";USING U$;ES/0.30480000376701355!;:PRINT " ft."
800 PRINT " Length of 1/2 Element..........EL=";USING U$;EL;
810 PRINT " m.  =";USING U$;EL/0.30480000376701355!;:PRINT " ft."
820 PRINT " Overall Length.................OL=";USING U$;OL;
830 PRINT " m.  =";USING U$;OL/0.30480000376701355!;:PRINT " ft."
840 GOTO 1260   :REM'end
850 END
860 :REM'
870 :REM'.....diagram
880 LOCATE 3:T=23
890 COLOR 0,7
900 LOCATE ,T:PRINT "                600 Ω               "
910 LOCATE ,T:PRINT "              ┌\/\/\/┐              "
920 LOCATE ,T:PRINT "              └──┐┌──┘              "
930 LOCATE ,T:PRINT "  ┌─» ∙∙∞────────┤├────────∞∙∙      "
940 LOCATE ,T:PRINT "  │   ∙∙∞───EL───┤├───EL───∞∙∙«─┐ES "
950 LOCATE ,T:PRINT "  │   ∙∙∞────────┤├────────∞∙∙«─┘   "
960 LOCATE ,T:PRINT " OL              ≈≈                 "
970 LOCATE ,T:PRINT "  │   ∙∙∞────────┤├────────∞∙∙      "
980 LOCATE ,T:PRINT "  │   ∙∙∞────────┤├────────∞∙∙      "
990 LOCATE ,T:PRINT "  └─» ∙∙∞────────┤├────────∞∙∙      "
1000 LOCATE ,T:PRINT "              ──»││«──LS            "
1010 LOCATE ,T:PRINT "      600 Ω open-wire feedline      "
1020 COLOR 7,0
1030 RETURN
1040 :REM'
1050 :REM'.....prologue
1060 T=7
1070 PRINT TAB(T);
1080 PRINT "The fishbone antenna is well suited for use at HF. This version,"
1090 PRINT TAB(T);
1100 PRINT "the English HAD antenna, obtains low-angle response primarily as a"
1110 PRINT TAB(T);
1120 PRINT "function of its height, and therefore is generally installed 18 to"
1130 PRINT TAB(T);
1140 PRINT"36 metres (60 to 120 feet) above ground. It functions very well as a"
1150 PRINT TAB(T);
1160 PRINT "transmitting antenna because of its excellent gain and broadband"
1170 PRINT TAB(T);
1180 PRINT "nature. Terminate the 600Ω line with a non-inductive resistor of"
1190 PRINT TAB(T);
1200 PRINT "sufficient wattage to suit the transmitted power."
1210 PRINT
1220 PRINT TAB(T+2);
1230 PRINT "(Ref. The ARRL ANTENNA BOOK, 17th Edition, pp. 13-17 to 13-19).";
1240 RETURN
1250 :REM'
1260 :REM'.....end
1270 GOSUB 1300
1280 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16:GOTO 230
1290 :REM'
1300 :REM'PRT
1310 KEY OFF:GOSUB 1380:LOCATE 25,5:COLOR 0,2
1320 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1330 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1340 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1340 :ELSE GOSUB 1380
1350 IF Z$="3"THEN RETURN
1360 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1370 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1310
1380 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
