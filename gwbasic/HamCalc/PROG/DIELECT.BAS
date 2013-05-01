10 :REM'DIELECT  - Dielectric Materials - 17 AUG 2001
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 DIM T$(33)
60 FOR Z=1 TO 33:READ T$(Z):NEXT Z:RESTORE
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,0
110 PRINT " DIELECTRIC MATERIALS"TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0:PRINT TAB(8);
140 PRINT "This program lists the dielectric constant Σ of various materials."
150 PRINT
160 LOCATE ,23:COLOR 0,7:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
170 Z$=INKEY$:IF Z$=""THEN 170
180 IF Z$="0"THEN CLS:RUN EX$
190 IF Z$="1"THEN 220
200 GOTO 170
210 :REM'
220 :REM'.....start
230 COLOR 7,0,0:CLS
240 H$=" Dielectric Constant Σ of Various Materials "
250 COLOR 0,7:LOCATE ,18:PRINT H$:COLOR 7,0
260 PRINT STRING$(80,205);
270 LOCATE CSRLIN-1,36:PRINT " Σ "
280 LOCATE CSRLIN-1,40:PRINT "╤"
290 LOCATE CSRLIN-1,77:PRINT " Σ "
300 FOR Z=1 TO 17
310 PRINT T$(Z);"│ ";
320 IF Z=17 THEN 340
330 PRINT T$(Z+17);
340 NEXT Z
350 GOTO 710
360 END
370 DATA "Air............................... 1.00"
380 DATA "Alsimag 196....................... 5.70"
390 DATA "Bakelite..................... 4.40-5.40"
400 DATA "Bakelite - mica filled............ 4.70"
410 DATA "Butyl Rubber...................... 2.37"
420 DATA "Cellular Polyethylene............. 1.75"
430 DATA "Cellulose acetate.............3.30-3.90"
440 DATA "Epoxy\glass FR-4 Generic.......... 4.30"
450 DATA "Epoxy\glass G-10 Generic... 4.30 ± 0.05"
460 DATA "Fibre........................ 5.00-7.50"
470 DATA "Flourin. Ethylene Propylene (FEP). 2.15"
480 DATA "Foamed FEP........................ 1.60"
490 DATA "Foamed Polyethylene............... 1.55"
500 DATA "Glass (Pyrex)..................... 4.80"
510 DATA "Glass (window)............... 7.60-8.00"
520 DATA "Magnesium Oxide................... 3.60"
530 DATA "Mica (ruby)....................... 5.40"
540 DATA "Mycalex........................... 7.40"
550 DATA "Nylon............................. 3.00"
560 DATA "Paper (Royal grey)................ 3.00"
570 DATA "Plexiglas......................... 2.80"
580 DATA "Polyethylene - High Pressure...... 2.26"
590 DATA "Polyethylene - Low Pressure....... 2.34"
600 DATA "Polystyrene...................2.50-2.60"
610 DATA "Polyimide G-30.................... 4.20"
620 DATA "Polystyrene....................... 2.50"
630 DATA "Porcelain.................... 5.10-5.90"
640 DATA "Polysulfone.................. 3.50-3.90"
650 DATA "Polytetrafluoethylene (PTFE)..nom. 2.40"
660 DATA "Quartz (fused).................... 3.80"
670 DATA "Silicon Rubber.................... 3.10"
680 DATA "Steatite (low loss)............... 5.80"
690 DATA "Teflon............................ 2.10"
700 :REM'
710 :REM'.....end
720 GOSUB 740:GOTO 80
730 :REM'
740 :REM'.....PRT
750 KEY OFF:GOSUB 820:LOCATE 25,5:COLOR 0,2
760 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
770 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
780 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 780 :ELSE GOSUB 820
790 IF Z$="3"THEN RETURN
800 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
810 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 750
820 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
