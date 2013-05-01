10 :REM'BEND - Bend Allowance - 19 FEB 2001 rev. 12 MAR 01,  04 JAN 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 COLOR 7,0,0
70 PI=4*ATN(1)  :REM'3.141593
80 UL$=STRING$(80,205)
90 :REM'
100 :REM'.....title page
110 CLS
120 COLOR 15,2
130 PRINT " BEND ALLOWANCE, Metal"TAB(57)"By George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 COLOR 0,7:L=18
170 LOCATE ,L:PRINT "     leg         leg                        "
180 LOCATE ,L:PRINT " │«── A ─»│«C»│«─ B ─»│     █▀▀▀▀▀▀▀ A      "
190 LOCATE ,L:PRINT " ┌────────┬─┬─┬───────┐     █ L             "
200 LOCATE ,L:PRINT " │    bend─»| |       │     █               "
210 LOCATE ,L:PRINT " └────────┴─┴─┴───────┘     B               "
220 LOCATE ,L:PRINT "  BLANK BEFORE BENDING    »│T│«             "
230 LOCATE ,L:PRINT " T = Thickness of material                  "
240 LOCATE ,L:PRINT " R = Bending radius to inside face of blank "
250 LOCATE ,L:PRINT " L = Included angle of bend                 "
260 LOCATE ,L:PRINT " C = Bend allowance                         "
270 COLOR 7,0
280 PRINT UL$;
290 LN=CSRLIN
300 :REM'
310 PRINT " In bending metal the problem is to find the length of straight s";
320 PRINT "tock required "
330 PRINT " for each bend; then these lengths are added to the lengths of th";
340 PRINT "e straight    "
350 PRINT " sections to obtain the total length of the material before bendi";
360 PRINT "ng.           "
370 PRINT "         (Machinery's Handbook, revised 21st edition, page 1928)."
380 PRINT " Bend allowance for pipe or tubing = radius to centreline of the ";
390 PRINT "material x    "
400 PRINT " included angle in degrees x 0.01745.                            ";
410 PRINT "         (Machinery's Handbook, revised 21st edition, page 2335)."
420 PRINT UL$;
430 PRINT " Press number in ( ) to:  (1) Run program with dimensions in ";
440 PRINT "millimetres"
450 PRINT "                          (2) Run program with dimensions in inches"
460 PRINT "                          (0) EXIT";
470 Z$=INKEY$:IF Z$=""THEN 470
480 IF Z$="0"THEN CLS:CHAIN EX$
490 IF Z$="1"THEN M=25.399999618530273!:M$="mm":GOTO 520
500 IF Z$="2"THEN M=1   :M$="in.":GOTO 520
510 GOTO 470
520 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
530 PRINT " ENTER: Material thickness (";M$;")....................T=";:INPUT Z
550 T=Z/M
560 PRINT " ENTER: Inside radius to face of material (";M$;").....R=";:INPUT Z
580 R=Z/M
590 INPUT " ENTER: Included angle of bend (degrees)............L=";L
600 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
610 M=25.399999618530273!
620 PRINT USING " Material thickness.......T= ###.# mm = ##.### in.";T*M,T
630 PRINT USING " Inside radius of bend....R= ###.# mm = ##.### in.";R*M,R
640 PRINT USING " Included angle...........L= ###.# degrees";L
650 K=PI/2*R
660 C1=0.550000011920929!*T+K
670 C2=0.6399999856948853!*T+K
680 C3=0.7099999785423279!*T+K
690 PRINT " Bending allowance C:"
700 M1$="  For brass & soft copper................................"
710 M2$="  For half-hard copper & brass, soft steel, & aluminum..."
720 M3$="  For bronze, hard copper, cold rolled & spring steel...."
730 PRINT M1$;:PRINT USING " ###.# mm = ##.### in.";C1*M,C1
740 PRINT M2$;:PRINT USING " ###.# mm = ##.### in.";C2*M,C2
750 PRINT M3$;:PRINT USING " ###.# mm = ##.### in.";C3*M,C3
760 GOSUB 790
770 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 310
780 :REM'
790 :REM'PRT
800 KEY OFF:GOSUB 870:LOCATE 25,5:COLOR 0,2
810 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
820 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
830 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 830 :ELSE GOSUB 870
840 IF Z$="3"THEN RETURN
850 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
860 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 800
870 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
