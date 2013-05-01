10 :REM'\hamcalc\prog\HCINSTAL - 24 MAR 2000 rev. 20 FEB 2002
20 :REM' PRINT " 2. The HAMCALC CD-ROM contains two files (ve3erp.bat & gwbasic";
30 COLOR 14,4,0
40 COMMON EX$
50 CLS:KEY OFF
60 T=7
70 PRINT TAB(20)"HOW TO INSTALL HAMCALC ON YOUR HARD DRIVE"
80 PRINT TAB(10);
90 PRINT "If no version of HAMCALC is already installed, do Step 2 only."
100 PRINT STRING$(80,205);
110 PRINT " 1. If version 43 or later is already installed and any of the fol";
120 PRINT "lowing files "
130 PRINT " exist, move:"
140 PRINT TAB(7)"battery.fil from \hamcalc\batt";
150 PRINT TAB(39)"│ latlong.dat from \hamcalc\latlong"
160 PRINT TAB(7)"rptrdex.fil from \hamcalc\index";
170 PRINT TAB(39)"│ data (folder) from \hamcalc"
180 PRINT " to a temporary location on your hard drive, or to floppy disc."
190 PRINT
200 PRINT " 2. HAMCALC.zip or CD contains two files (ve3erp.bat & gwbasic";
210  PRINT ".exe) and one"
220 PRINT " directory (folder) labelled HAMCALC. Copy them to drive C. HAMCALC";
230 PRINT " will not"
240 PRINT " work if you install them anywhere else."
250 PRINT
260 PRINT " 3. If files were temporarily moved in Step 1, return:"
270 PRINT TAB(7)"battery.fil to \hamcalc\batt";
280 PRINT TAB(39)"│ latlong.dat to \hamcalc\latlong"
290 PRINT TAB(7)"rptrdex.fil to \hamcalc\index";
300 PRINT TAB(39)"│ data (folder) to \hamcalc"
310 PRINT
320 PRINT " 4. If you already have version 42 or earlier installed, move:"
330 PRINT TAB(7);
340 PRINT "rptrdex.fil from \data\index   to \hamcalc\index"
350 PRINT TAB(7);
360 PRINT "latlong.dat from \data\latlong to \hamcalc\latlong"
370 PRINT TAB(7);
380 PRINT "battery.fil from \data\batt    to \hamcalc\batt"
390 GOSUB 410:CLS:CHAIN EX$
400 :REM'
410 :REM'PRT
420 KEY OFF:GOSUB 490:LOCATE 25,5:COLOR 0,2
430 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
440 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
450 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 450 :ELSE GOSUB 490
460 IF Z$="3"THEN RETURN
470 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
480 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 420
490 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
