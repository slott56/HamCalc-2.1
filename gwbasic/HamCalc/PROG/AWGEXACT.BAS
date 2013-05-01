10 :REM'AWGEXACT - AWG wire size calculator - 15 AUG 2001
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 7,0,0
70 UL$=STRING$(80,205)
80 DIM GA(54)
90 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
100 :REM'
110 :REM'.....title page
120 CLS
130 COLOR 15,2
140 PRINT " A.W.G. WIRE SIZE CALCULATOR"TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 GOSUB 840  :REM'prologue
180 PRINT UL$;
190 PRINT " Press number in < > to:"
200 PRINT UL$;
210 PRINT "   < 1 > Display table of AWG sizes"
220 PRINT "   < 2 > Run Copper Wire Data program"
230 PRINT "   < 3 > Find AWG size of ANY wire diameter"
240 PRINT "   < 4 > Find AWG size of METRIC wire"
250 PRINT "   < 5 > Find diameter of any AWG value"
260 PRINT
270 PRINT "   < 0 > EXIT"
280 Z$=INKEY$:IF Z$=""THEN 280
290 IF Z$="0"THEN CHAIN GO$
300 IF Z$="1"THEN 370
310 IF Z$="2"THEN CHAIN"copwire"
320 IF Z$="3"THEN M=0:GOTO 610
330 IF Z$="4"THEN M=1:GOTO 610
340 IF Z$="5"THEN M=0:GOTO 750
350 GOTO 280
360 :REM'
370 :REM'.....AWG calculator
380 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
390 FOR N=0 TO 54
400 GA(N)=0.46000000834465027!/K#^N
410 NEXT N
420 :REM'
430 O$(0)="0000":O$(1)=" 000":O$(2)="  00":O$(3)="   0"
440 FOR Z=0 TO 3
450 IF O$(Z)="0000"THEN COLOR 0,7 :ELSE COLOR 7,0
460 PRINT " ";CHR$(35);O$(Z);USING "= #.#######"+CHR$(34);GA(Z)
470 COLOR 7,0:NEXT Z
480 FOR Z=4 TO 17
490 PRINT " ";CHR$(35);USING " ## = #.#######"+CHR$(34);Z-3,GA(Z);
500 PRINT TAB(30);
510 PRINT " ";CHR$(35);USING " ## = #.#######"+CHR$(34);Z+11,GA(Z+14);
520 PRINT TAB(60);
530 IF Z=11 THEN COLOR 0,7
540 IF Z>=16 THEN PRINT "":GOTO 570
550 PRINT " ";CHR$(35);USING " ## = #.#######"+CHR$(34);Z+25,GA(Z+28)
560 COLOR 7,0
570 NEXT Z
580 PRINT UL$;
590 GOSUB 920:GOTO 1040
600 :REM'
610 :REM'.....find AWG size
620 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
630 IF M=0 THEN INPUT " ENTER: Wire diameter (inches) or 0 to quit....";D
640 IF M=1 THEN INPUT " ENTER: Wire diameter (mm) or 0 to quit....";D:D=D/25.399999618530273!
650 IF D=0 THEN 110
660 GA=LOG(0.46000000834465027!/D)/(LOG(K#))-3
670 LOCATE CSRLIN-1
680 PRINT USING " ###.####### in.(##.##mm) diameter = AWG ";D;D*25.399999618530273!;
690 PRINT "#";USING "#####.##";GA;:PRINT STRING$(20," ")
700 IF FIX(GA)<=0 THEN O$=STR$(ABS(FIX(GA))+1)+"/0":GOTO 710 :ELSE 730
710 IF LEN(O$)<5 THEN O$=" "+O$
720 LOCATE CSRLIN-1,43:PRINT O$
730 GOTO 630
740 :REM'
750 :REM'.....find diameter
760 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
770 INPUT " ENTER: Any AWG value greater than 0 (or 0 to quit)...";WG
780 IF WG=0 THEN 110
790 D=0.46000000834465027!/K#^(WG+3)
800 LOCATE CSRLIN-1
810 PRINT USING " AWG ##.### = ##.#### in. = ###.## mm"+SPACE$(40);WG,D,D*25.399999618530273!
820 GOTO 770
830 :REM'
840 :REM'.....prologue
850 PRINT " This program computes precise theoretical diameters of A.W.G. wi";
860 PRINT "re to seven   "
870 PRINT " decimal places. Due to manufacturing tolerances, actual wire dia";
880 PRINT "meters are    "
890 PRINT " held to only the first 3 or 4 decimal places.                   "
900 RETURN
910 :REM'
920 :REM'.....note
930 COLOR 0,7
940 LOCATE 3,20: PRINT " In the A.W.G. system, each size is";K#;"times "
950 LOCATE 4,20: PRINT " the diameter of the next smaller size, based on an o";
960 PRINT "riginal"
970 LOCATE 5,20: PRINT " concept of 40 sizes in arithmetic progression rangin";
980 PRINT "g from "
990 LOCATE 6,20: PRINT " .460 in.(#0000) to .005 in.(#36).                   ";
1000 PRINT "       "
1010 COLOR 7,0
1020 RETURN
1030 :REM'
1040 :REM'.....end
1050 GOSUB 1070:GOTO 110
1060 :REM'
1070 :REM'.....PRT
1080 KEY OFF:GOSUB 1150:LOCATE 25,5:COLOR 0,2
1090 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1100 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1110 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1110 :ELSE GOSUB 1150
1120 IF Z$="3"THEN RETURN
1130 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1140 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1080
1150 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
