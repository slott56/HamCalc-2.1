10 :REM'FILSTRIP - Filter, Stripline Bandpass - 08 FEB 96 rev.03 FEB 2010
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 U$="####.###"
60 :REM'
70 :REM'.....start
80 CLS:A=0:B=0:C=0:D=0:F=0
90 COLOR 15,2
100 PRINT " FILTERS, Stripline Bandpass for VHF/UHF";
110 PRINT TAB(57);"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
130 LN=3:GOSUB 820   :REM'¼ wave diagram
140 LN=3:GOSUB 1010   :REM'½ wave diagram
150 PRINT
160 GOSUB 1190        :REM'preface
170 PRINT
180 COLOR 0,7:LOCATE ,24
190 PRINT " Press 1 to continue or 0 to EXIT...."
200 COLOR 7,0
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CLS:RUN EX$
230 IF Z$="1"THEN 260
240 GOTO 210
250 :REM'
260 :REM'.....inputs
270 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
280 PRINT "   Do you want dimensions in (c)entimetres or (i)nches?    (c/i)"
290 Y$=INKEY$:IF Y$=""THEN 290
300 IF Y$="i"THEN M=1:M$="in.":GOTO 340
310 IF Y$="c"THEN M=2.5399999618530273!:M$="cm.":GOTO 340
320 GOTO 290
330 :REM'
340 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
350 PRINT "   One of the dimensions a,b,c,d must be predetermined:"
360 PRINT "   Press a letter to indicated which one..........."
370 X$=INKEY$:IF X$=""THEN 370
380 IF X$="a"OR X$="b"OR X$="c"OR X$="d"THEN 390 :ELSE 370
390 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
400 IF X$="a"OR X$="b"THEN E$="Enclosure ":ELSE E$="Conductor "
410 PRINT " ENTER: ";E$;"Dimension (";X$;").........(";M$;")";:INPUT Z
420 Z=Z/M
430 IF X$="a"THEN A=Z
440 IF X$="b"THEN B=Z
450 IF X$="c"THEN C=Z
460 IF X$="d"THEN D=Z
470 :REM'.....calculate
480 IF C=0 AND A<>0 THEN C=A*0.25!:GOTO 470
490 IF A=0 AND C<>0 THEN A=C/0.25!:GOTO 470
500 IF D=0 AND A<>0 THEN D=A*0.4000000059604645! :GOTO 470
510 IF A=0 AND D<>0 THEN A=D/0.4000000059604645! :GOTO 470
520 IF B=0 AND A<>0 THEN B=A*2  :GOTO 470
530 IF A=0 AND B<>0 THEN A=B/2  :GOTO 470
540 :REM'
550 :REM'.....print results
560 VIEW PRINT 16 TO 24:CLS:VIEW PRINT:LOCATE 16
570 J=4:K=42
580 PRINT TAB(J)"Enclosure dim.(a)...";USING U$;A*M;:PRINT " ";M$;
590 PRINT TAB(K)"Enclosure dim.(a)...";USING U$;A*M;:PRINT " ";M$
600 PRINT TAB(J)"Enclosure dim.(b)...";USING U$;B*M;:PRINT " ";M$;
610 PRINT TAB(K)"Enclosure dim.(b)...";USING U$;B*M;:PRINT " ";M$
620 PRINT TAB(J)"Conductor dim.(c)...";USING U$;C*M;:PRINT " ";M$;
630 PRINT TAB(K)"Conductor dim.(c)...";USING U$;C*M;:PRINT " ";M$
640 PRINT TAB(J)"Conductor dim.(d)...";USING U$;D*M;:PRINT " ";M$;
650 PRINT TAB(K)"Conductor dim.(d)...";USING U$;D*M;:PRINT " ";M$
660 :REM'
670 INPUT " ENTER: Centre Frequency (MHz) of desired passband ";F
680 VIEW PRINT 20 TO 24:CLS:VIEW PRINT:LOCATE 20
690 PRINT TAB(J)"Centre Frequency....";USING U$;F;:PRINT " Mhz";
700 PRINT TAB(K)"Centre Frequency....";USING U$;F;:PRINT " Mhz"
710 :REM'
720 :REM'.....conductor dimensions
730 L3A=2808/F*0.6499999761581421!:LA=L3A*0.25!
740 L3B=11803/F*0.5!:LB=L3B*0.5!
750 PRINT TAB(J)"Length L3...........";USING U$;L3A*M;:PRINT " ";M$;
760 PRINT TAB(K)"Length L3...........";USING U$;L3B*M;:PRINT " ";M$
770 PRINT TAB(J)"Length L1, L2.......";USING U$;LA*M;:PRINT " ";M$;
780 PRINT TAB(K)"Length L1, L2.......";USING U$;LB*M;:PRINT " ";M$
790 GOTO 1320   :REM'end
800 END
810 :REM'
820 :REM'.....diagrams
830 LOCATE LN
840 T=4
850 COLOR 0,7
860 LOCATE ,T:PRINT "                  in                "
870 LOCATE ,T:PRINT "    a             ┌┴┐               "
880 LOCATE ,T:PRINT " ╔═════╗    ╔═════╡ ╞═════════════╗ "
890 LOCATE ,T:PRINT " ║     ║    ║     └┬┘             ║ "
900 LOCATE ,T:PRINT " ║  c  ║    ╟──L1──┘   L3     C1  ║ "
910 LOCATE ,T:PRINT " ║ d█  ║b   ▐███████████████──┤├──╢ "
920 LOCATE ,T:PRINT " ║     ║    ╟──L2──┐              ║ "
930 LOCATE ,T:PRINT " ║     ║    ║     ┌┴┐             ║ "
940 LOCATE ,T:PRINT " ╚══╤══╝    ╚═════╡ ╞═════════════╝ "
950 LOCATE ,T:PRINT "    │             └┬┘               "
960 LOCATE ,T:PRINT "   \\\            out               "
970 LOCATE ,T:PRINT "   QUARTER-WAVE STRIPLINE FILTER    "
980 COLOR 7,0
990 RETURN
1000 :REM'
1010 LOCATE LN
1020 T=42
1030 COLOR 0,7
1040 LOCATE ,T:PRINT "                  in                "
1050 LOCATE ,T:PRINT "    a             ┌┴┐               "
1060 LOCATE ,T:PRINT " ╔═════╗    ╔═════╡ ╞═════════════╗ "
1070 LOCATE ,T:PRINT " ║     ║    ║     └┬┘             ║ "
1080 LOCATE ,T:PRINT " ║  c  ║    ╟──L1──┘   L3         ║ "
1090 LOCATE ,T:PRINT " ║ d█  ║b   ▐█████████████████████▌ "
1100 LOCATE ,T:PRINT " ║     ║    ║          │   ┌──L2──╢ "
1110 LOCATE ,T:PRINT " ║     ║    ║       C1═╪═ ┌┴┐     ║ "
1120 LOCATE ,T:PRINT " ╚══╤══╝    ╚══════════╧══╡ ╞═════╝ "
1130 LOCATE ,T:PRINT "    │                     └┬┘       "
1140 LOCATE ,T:PRINT "   \\\                    out       "
1150 LOCATE ,T:PRINT "     HALF-WAVE STRIPLINE FILTER     "
1160 COLOR 7,0
1170 RETURN
1180 :REM'
1190 :REM'.....preface
1200 T=8
1210 PRINT TAB(T);
1220 PRINT "This program does the calculations associated with the discussion"
1230 PRINT TAB(T);
1240 PRINT CHR$(34);"VHF and UHF Bandpass Filters";CHR$(34);" in the ARRL ";
1250 PRINT "ELECTRONICS DATA BOOK,"
1260 PRINT TAB(T);
1270 PRINT "2nd Edition, pages 5-14 and 5-15. The discussion describes other"
1280 PRINT TAB(T);
1290 PRINT "critical design factors and selection of capacitor C1."
1300 RETURN
1310 :REM'
1320 :REM'.....end
1330 GOSUB 1370
1340 GOTO 70
1350 END
1360 :REM'
1370 :REM'PRT
1380 KEY OFF:GOSUB 1450:LOCATE 25,5:COLOR 0,2
1390 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1400 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1410 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1410 :ELSE GOSUB 1450
1420 IF Z$="3"THEN RETURN
1430 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1440 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1380
1450 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
