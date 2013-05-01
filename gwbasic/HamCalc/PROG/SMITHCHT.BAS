10 :REM'SMITHCHT - Smith Chart reference - 01 MAY 96 rev.01 NOV 1999
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 PROG$="smithcht"
50 COMMON EX$,PROG$
60 CLS:KEY OFF
70 COLOR 7,0,1
80 UL$=STRING$(80,205)
90 DIM A$(26,2)
100 FOR Z=1 TO 26:READ A$(Z,2),A$(Z,1):NEXT Z
110 :REM'
120 :REM'.....start
130 CLS
140 COLOR 15,2
150 PRINT " SMITH CHART CALCULATIONS";TAB(57)"by George Murphy VE3ERP ";
160 COLOR 1,0:PRINT STRING$(80,223);
170 COLOR 7,0
180 T=7
190 PRINT TAB(T);
200 PRINT "The following HAMCALC programs may be useful for calculating data"
210 PRINT TAB(T);
220 PRINT "that you might otherwise seek using a Smith Chart."
230 PRINT
240 PRINT TAB(T);
250 PRINT CHR$(34);"MicroSmith";CHR$(34);", a comprehensive Smith Chart ";
260 PRINT "graphics and tabular"
270 PRINT TAB(T);
280 PRINT "software program by Wes Haywood, W7ZOI, is available from the ARRL."
290 PRINT UL$;
300 PRINT " Press a letter in ( ) to select a program"
310 PRINT UL$;
320 LN=CSRLIN-1
330 FOR Z=1 TO 26
340 IF Z=14 THEN LN=LN-13
350 LN=LN+1
360 IF Z>13 THEN LOCATE LN,42 :ELSE LOCATE LN,2
370 PRINT "(";CHR$(Z+ 96);")  ";A$(Z,1);
380 NEXT Z
390 PRINT ""
400 Z$=INKEY$:IF Z$=""THEN 400
410 Z=ASC(Z$)-96
420 IF Z<1 OR Z>26 THEN 400
430 IF A$(Z,1)="-"THEN 400
440 IF A$(Z,2)="zzz"THEN A$(Z,2)=EX$
450 CLS:CHAIN A$(Z,2)
460 END
470 :REM'
480 :REM'.....database
490 DATA antfield, Antenna Field Strength
500 DATA coaxchar, Coaxial Cable Characteristics
510 DATA coilq,    Coil Q Calculator
520 DATA conjumat, Conjugate Match Calculator
530 DATA hairpin,  Hairpin Match for Yagis
540 DATA serisect, Series-Section Transformer
550 DATA stubant,  Stub Match for Antennas
560 DATA swr,      SWR Calculator
570 DATA transmat, Transmatch Design
580 DATA elecleng, Transmission Line Length
590 DATA lineloss, Transmission Line Losses
600 DATA tranline, Transmission Line Performance
610 DATA transtub, Transmission Line Stubs
620 DATA xmtrzmat, Xmtr Transistor Stage Coupling
630 DATA "","-"
640 DATA "","-"
650 DATA "","-"
660 DATA "","-"
670 DATA "","-"
680 DATA "","-"
690 DATA "","-"
700 DATA "","-"
710 DATA "","-"
720 DATA "","-"
730 DATA "","-"
740 DATA zzz,      EXIT
