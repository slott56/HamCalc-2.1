10 :REM'CENTFREQ - Centre Frequency - 16 JAN 96 rev.08 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,0
50 UL$=STRING$(80,205)
60 U$="###,###.###"
70 :REM'
80 COLOR 15,2
90 PRINT " CENTRE FREQUENCY & WAVELENGTH";TAB(57);"by George Murphy VE3ERP ";
100 COLOR 1,0
110 PRINT STRING$(80,"▀");
120 COLOR 7,0
130 :REM'
140 GOSUB 820   :REM'preface
150 PRINT UL$;
160 PRINT "      Press 1 to RUN program or 0 to EXIT.........."
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:RUN EX$
190 IF Z$="1"THEN 210
200 GOTO 170
210 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 4
220 PRINT UL$;
230 GOTO 300
240 :REM'
250 :REM'.....format input line
260 LOCATE CSRLIN-1:PRINT SPC(7);
270 LOCATE CSRLIN,31:PRINT STRING$(7,".");USING U$;ZZ;
280 RETURN
290 :REM'
300 :REM'.....input data
310 COLOR 0,7:LOCATE 3,8
320 PRINT " ENTER BOUNDARY FREQUENCIES....";
330 COLOR 7,0
340 PRINT TAB(44)"FREQUENCY";TAB(58)"WAVELENGTH"
350 LOCATE 5
360 INPUT " ENTER: HIGHEST Frequency F1....(MHz)";FH
370 ZZ=FH:GOSUB 250:PRINT " MHz";
380 WH=300/FH     :REM'wavelength of highest frequency
390 PRINT TAB(55)USING U$;WH;:PRINT " m."
400 :REM'
410 LOCATE 11
420 INPUT " ENTER: LOWEST Frequency F2.....(MHz)";FL
430 ZZ=FL:GOSUB 250:PRINT " MHz";
440 WL=300/FL     :REM'wavelength of lowest frequency
450 PRINT TAB(55)USING U$;WL;:PRINT " m."
460 IF FL<FH THEN 540
470 :REM'
480 BEEP:PRINT:COLOR 15,4
490 PRINT "        F2 must be LESS than F1 !   Press any key to start over....."
500 COLOR 7,0
510 IF INKEY$=""THEN 510
520 GOTO 30
530 :REM'
540 :REM'.....calculation
550 CFQ=SQR(FH*FL)              :REM'centre frequency
560 CFW=300/CFQ                 :REM'wavelength of centre frequency
570 :REM'
580 AMF=(FL+FH)/2               :REM'arithmetic mean frequency
590 WMF=300/AMF                 :REM'wavelength of arithmetic mean frequency
600 :REM'
610 AMW=(300/FL+300/FH)/2       :REM'arithmetic mean wavelength
620 FMW=300/AMW                 :REM'frequency of arithmetic mean wavelength
630 :REM'
640 FBW=FH-FL                   :REM'bandwidth - frequency
650 :REM'
660 LOCATE 3:PRINT STRING$(40,32)
670 LOCATE 7
680 PRINT "        Arithmetic Mean Frequency....";USING U$;AMF;:PRINT " MHz";
690 PRINT TAB(55)USING U$;WMF;:PRINT " m."
700 COLOR 0,7:LOCATE CSRLIN,8
710 PRINT " CENTRE FREQUENCY (√{F1∙F2})..";USING U$;CFQ;:PRINT " MHz";
720 PRINT TAB(55)USING U$;CFW;:PRINT " m."
730 COLOR 7,0
740 PRINT "        Arithmetic Mean Wavelength...";USING U$;FMW;:PRINT " MHz";
750 PRINT TAB(55)USING U$;AMW;:PRINT " m."
760 :REM'
770 LOCATE 12
780 PRINT UL$;
790 PRINT "        Bandwidth (F1-F2)............";USING U$;FBW;:PRINT " MHz"
800 GOTO 920  :REM'end
810 :REM'
820 :REM'.....preface
830 T=7
840 PRINT TAB(7);
850 PRINT "This program computes the Centre Frequency, Arithmetic Mean"
860 PRINT TAB(7);
870 PRINT "Frequency and Arithmetic Mean Wavelength between any two boundary"
880 PRINT TAB(7);
890 PRINT "frequencies."
900 RETURN
910 :REM'
920 :REM'.....end
930 GOSUB 970
940 GOTO 30
950 END
960 :REM'
970 :REM'PRT
980 KEY OFF:GOSUB 1050:LOCATE 25,5:COLOR 0,2
990 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1000 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1010 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1010 :ELSE GOSUB 1050
1020 IF Z$="3"THEN RETURN
1030 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1040 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 980
1050 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
