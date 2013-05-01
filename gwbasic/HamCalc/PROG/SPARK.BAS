10 :REM'SPARK - voltage breakdown calculator - 02 JAN 07
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 15,2,1
70 PRINT " BREAKDOWN VOLTAGE"TAB(57)"by George Murphy VE3ERP ";
80 COLOR 1,0:PRINT STRING$(80,223);
90 COLOR 7,0,0
100 :REM'.....start
110 PRINT " This program calculates breakdown voltage and dielectric space be";
120 PRINT "tween two flat";
130 PRINT " or curved surfaces, such as rotary capacitor plates or coaxial me";
140 PRINT "tal tubes."
150 PRINT
160 PRINT " Ref. www.gcronline.com/cbrauda"
170 PRINT
180 PRINT " .....Press 1 to continue or 0 to exit....."
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="0"THEN RUN EX$
210 IF Z$="1"THEN 230
220 GOTO 190
230 CLS:GOSUB 470
240 PRINT
250 INPUT " ENTER: volts per mil value of dielectric ";MV
260 PRINT
270 PRINT " Volts per Mil = ";MV
280 PRINT " Do you want to find dielectric (s)pace or (v)olts?    (s/v)"
290 Z$=INKEY$:IF Z$=""THEN 290
300 IF Z$="v"THEN INPUT " ENTER: Space in inches";S:V=S*MV*10^3:GOTO 330
310 IF Z$="s"THEN INPUT " ENTER: Volts ";V:S=V/MV/10^3:GOTO 330
320 GOTO 290
330 CLS
340 PRINT " BREAKDOWN VOLTAGE"
350 PRINT
360 PRINT USING " Dielectric value........ ###,###.### volts per .001 in.";MV
370 PRINT USING " Dielectric thickness.... ###,###.### in.";S;
380 PRINT USING " (##.# mm.";S*25.399999618530273!;:PRINT " )"
390 PRINT USING " Dielectric breakdown.... ###,###.### volts";V
400 PRINT
410 PRINT  " These values are for design purposes only. Actual breakdown vol";
420 PRINT "tages may be"
430 PRINT " much lower depending on atmospheric conditions, physical conditi";
440 PRINT "on of the"
450 PRINT " surfaces, mechanical alignment of the elements, etc."
460 GOTO 660
470 :REM'.....table
480 T=22
490 PRINT " DIELECTRIC VALUES:"
500 PRINT " MATERIAL    BREAKDOWN VOLTS PER MIL (.001 in.)"
510 PRINT
520 PRINT " Air";TAB(T);21
530 PRINT " Bakelite";TAB(T);300
540 PRINT " Cellulose ascetate";TAB(T);250;"to";600"  (cellophane)"
550 PRINT " Formica";TAB(T);450
560 PRINT " Window glass";TAB(T);200;"to";250;"  (no ink)"
570 PRINT " Mica";TAB(T);3800;"to";5600
580 PRINT " Mylar";TAB(T);7500
590 PRINT " Paper";TAB(T);200
600 PRINT " Plexiglass";TAB(T);990
610 PRINT " Polyethylene";TAB(T);1200
620 PRINT " Polystyrene";TAB(T);500;"to";700;"  (Styrofoam)"
630 PRINT " Porcelain";TAB(T);40;"to";100
640 PRINT " Teflon";TAB(T);1000;"to";2000
650 RETURN
660 :REM'.....end
670 GOSUB 680:CLS:GOTO 180
680 :REM'.....PRT
690 KEY OFF:GOSUB 760:LOCATE 25,5:COLOR 0,2
700 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
710 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
720 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 720 :ELSE GOSUB 760
730 IF Z$="3"THEN RETURN
740 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
750 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 690
760 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
