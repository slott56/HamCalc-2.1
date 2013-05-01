10 :REM'INDULOOP - Inductance of Single Loops - 15 DEC 1997, rev. 20 DEC 1997
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="#####.####"
70 PI=3.1415929794311523!
80 TB=7
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2
130 PRINT " INDUCTANCE of SINGLE LOOPS";TAB(57)"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 :REM'
170 PRINT TAB(TB);
180 PRINT "This program calculates the inductance of a single ( one turn)"
190 PRINT TAB(TB);
200 PRINT "circular or square loop."
210 PRINT
220 COLOR 0,7:LOCATE ,24:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:RUN EX$
250 IF Z$="1"THEN 270
260 GOTO 230
270 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
280 PRINT TAB(TB);
290 PRINT "from: BREAK-IN magazine (New Zealand), October 1997, page 15."
300 PRINT
310 PRINT TAB(TB);
320 PRINT "ref. F.W.Grover, 'Inductance Calculations, Working Formulas and"
330 PRINT TAB(TB);
340 PRINT "Tables', Dover, 1946, pp. 60-61"
350 PRINT UL$;
360 PRINT
370 PRINT " Want to enter size of loop in (c)entimeters or (i)nches?  (c/i)"
380 Z$=INKEY$:IF Z$="c"OR Z$="i"THEN 390 :ELSE 380
390 IF Z$="c"THEN L$="(cm.)":ELSE L$="(in.)"
400 PRINT " ENTER: diameter of circular loop or side of square loop...";L$;
410 INPUT X:IF Z$="i"THEN X=X*2.5399999618530273!
420 R=X/2  :REM'radius of loop
430 S=X    :REM'side of square
440 PRINT
450 PRINT " Want to enter size of wire in (m)illimetres or (i)nches?  (m/i)"
460 Z$=INKEY$:IF Z$="m"OR Z$="i"THEN 470 :ELSE 460
470 IF Z$="m"THEN D$="(mm.)":ELSE D$="(in.)"
480 PRINT " ENTER: diameter of conductor (wire , tube, etc)...........";D$;
490 INPUT D:IF Z$="i"THEN D=D*25.399999618530273!
500 C=D/2/10 :REM'radius of conductor in cm.
510 :REM'
520 :REM'.....circular loop
530 LC=4*PI*R*10^-3*(LOG(R/C)+0.3294000029563904!)    :REM'µH
540 :REM'.....square loop
550 LS=8*S*10^-3*(LOG(S/C)-0.5239999890327454!)        :REM'µH
560 :REM'
570 VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 8
580 PRINT " CONDUCTOR"
590 PRINT "-----------"
600 PRINT " Diameter of conductor.........";USING U$;D;:PRINT " mm =";
610 PRINT USING U$;D/25.399999618530273!;:PRINT " in."
620 PRINT " Radius of conductor...........";USING U$;C;:PRINT " cm =";
630 PRINT USING U$;C/2.5399999618530273!;:PRINT " in."
640 PRINT
650 PRINT " CIRCULAR LOOP"
660 PRINT "---------------"
670 PRINT " Diameter of circular loop.....";USING U$;X;:PRINT " cm =";
680 PRINT USING U$;X/2.5399999618530273!;:PRINT " in."
690 PRINT " Radius of circular loop.......";USING U$;X/2;:PRINT " cm =";
700 PRINT USING U$;X/2/2.5399999618530273!;:PRINT " in."
710 PRINT " Inductance of circular loop...";USING U$;LC;:PRINT " µH"
720 PRINT
730 PRINT " SQUARE LOOP"
740 PRINT "-------------"
750 PRINT " Side of square loop...........";USING U$;X;:PRINT " cm =";
760 PRINT USING U$;X/2.5399999618530273!;:PRINT " in."
770 PRINT " Inductance of square loop.....";USING U$;LS;:PRINT " µH"
780 :REM'
790 :REM'.....end
800 GOSUB 820:GOTO 100
810 :REM'
820 :REM'PRT
830 KEY OFF:GOSUB 900:LOCATE 25,5:COLOR 0,2
840 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
850 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
860 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 860 :ELSE GOSUB 900
870 IF Z$="3"THEN RETURN
880 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
890 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 830
900 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
