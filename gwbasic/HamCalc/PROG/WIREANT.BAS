10 :REM'WIREANT - Wire Antenna Index - 07 JUN 01 rev. 03 FEB 2008
20 CLS:KEY OFF
30 EX$="wireant"
40 COMMON EX$
50 COLOR 7,0,1
60 UL$=STRING$(80,205)
70 DIM T$(36,2)
80 FOR Z=1 TO 36
90 READ T$(Z,1),T$(Z,2)
100 NEXT Z
110 :REM'
120 :REM'.....title page
130 CLS
140 COLOR 15,2
150 PRINT " Wire Antenna Index"TAB(57)"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,223);
170 COLOR 7,0
180 :REM'
190 PRINT " Press a character in < > below to select a wire antenna program:"
200 PRINT UL$;
210    FOR Z=1 TO 18
220 A=96+Z
230 IF Z<=8 THEN B=114+Z :ELSE B=39+Z
240 PRINT " <"CHR$(A);"> ";T$(Z,2);
250 PRINT TAB(41)"<"CHR$(B);"> ";T$(Z+18,2)
260    NEXT Z
270 :REM'GOSUB 720
280 :REM'
290 Z$=INKEY$:IF Z$=""THEN 290
300 Z=ASC(Z$)
310 IF Z>=97 AND Z<=122 THEN Z=Z-96:GOTO 340
320 IF Z>=48 AND Z<=57  THEN Z=Z-21:GOTO 340
330 GOTO 300
340 CLS:CHAIN T$(Z,1)
350 :REM'
360 DATA bevant  , Beverage receiving antenna
370 DATA ccdanten, CCD antennas
380 DATA buxtrap , Coaxial Cable SuperTrap
390 DATA duopole , Dual band short dipole
400 DATA fatdipol, Fat 2-conductor broadband dipole
410 DATA fishbone, Fishbone antenna
420 DATA foldipol, Folded dipole - 300- twinlead
430 DATA g5rv    , G5RV dipole
440 DATA halfloop, Half-Loop antenna
450 DATA invee   , Inverted VEE
460 DATA antenna , Length & pruning calculator
470 DATA loopsky , Loop Skywire
480 DATA miniloop, Miniature loop
490 DATA miniquad, Miniature quad
500 DATA moxon   , Moxon rectangle
510 DATA quad    , "Quads, multi-element"
520 DATA centload, Short centre-loaded dipole
530 DATA cylload , Short cylinder-loaded dipole
540 DATA dipol160, Short dipole for 160/80/40 m.
550 DATA es2b,     Short ES2B 2-band trap dipole
560 DATA shortant, Short off-centre loaded dipole
570 DATA shortdip, Short multi-band dipole array
580 DATA snglwire, Single wire antenna system
590 DATA sloper  , Sloper dimensions
600 DATA torotrap, Toroid antenna traps
610 DATA trapole , Trap dipole design
620 DATA trapdsgn, 3-band single trap dipole
630 DATA traprop , Trap properties estimator
640 DATA wavetrap, Wave trap filters
650 DATA windom  , Windom antenna
660 DATA zeppdbl , Zepp EDZ (extended double zepp)
670 DATA zepp    , Zepp multi-band antenna
680 DATA "",""
690 DATA "",""
700 DATA "",""
710 DATA "\hamcalc\menu\hcal", EXIT
720 :REM'
730 :REM'.....PRT
740 KEY OFF:GOSUB 810:LOCATE 25,5:COLOR 0,2
750 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
760 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
770 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 770 :ELSE GOSUB 810
780 IF Z$="3"THEN RETURN
790 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
800 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 740
810 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
