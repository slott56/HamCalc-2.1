10 :REM'GAMMATCH - 25 MAY 06
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " Gamma Match Design"TAB(49)"ARRL ANTENNA BOOK, 20th Edition ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 15,2:LOCATE CSRLIN-1,19
150 PRINT " Edited for Hamcalc by George Murphy, VE3ERP "
160 COLOR 7,0
170 :REM'
180 REM Removed corrections RA/2 and XA/2 per W6NL, Apr 1, 2000
190 REM Corrected error in wavelength conversion, Mar 1997
200 PRINT TAB(24)"Using W7ITB, WB0IKN, W6NL Equations"
210 PRINT UL$;
220 PRINT " Press 1 to continue or 0 to EXIT"
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN RUN EX$
250 IF Z$="1"THEN 280
260 GOTO 240
270 :REM'
280 :REM'.....start
290 CLS:COLOR 7,0,0
300 DEF FNCSH (X) = LOG(X + SQR(X * X - 1))
310 INPUT " ENTER: Frequency (MHz)...................";F
320 INPUT " ENTER: Feed point resistance (ohms)......"; RA
330 INPUT " ENTER: Feed point reactance (ohms)......."; XA
340 INPUT " ENTER: Feed line impedance (ohms)........"; RO
350 PRINT
360 INPUT " ENTER: Driven element diameter (inches).."; DE
370 INPUT " ENTER: Gamma rod diameter (inches)......."; DR
380 INPUT " ENTER: Gamma rod spacing (inches)........"; S
390 :REM'
400 :REM'.....calculate
410 HZ = (1 + ((FNCSH((4 * S * S - DE * DE + DR * DR) / (4 * S * DR))) / (FNCSH((4 * S * S + DE * DE - DR * DR) / (4 * S * DE))))) ^ 2
420 ZO = 60 * FNCSH((4 * S * S - DE * DE - DR * DR) / (2 * DE * DR))
430 T = HZ / ZO
440 A = ((RO * XA) / (HZ * RA - RO))
450 B = (RO * (RA ^ 2 + XA ^ 2)) / (HZ * RA - RO)
460 Q = A + SQR(A * A + B)
470 XS = HZ * ((RO * XA + SQR((RO * XA) ^ 2 + RO * (HZ * RA - RO) * (RA ^ 2 + XA ^ 2))) / (HZ * RA - RO))
480 LDRA = ATN(Q * T)
490 LDR = LDRA * 180 / PI
500 E = (RO / RA) * ((RA ^ 2 + XA ^ 2) / Q)
510 G = (RO / RA) * XA
520 CR = 1000000.0! / (2 * PI * (E + G) * F)
530 CLS
540 :REM'
550 :REM'.....display results
560 PRINT USING "Frequency................ ####.### MHz"; F
570 PRINT USING "Driven element diameter.. ####.### inches"; DE
580 PRINT USING "Gamma rod diameter....... ####.### inches"; DR
590 PRINT USING "Gamma rod spacing........ ####.### inches"; S
600 PRINT USING "Feed point resistance.... ####.### ohms"; RA
610 PRINT USING "Feed point reactance..... ####.### ohms"; XA
620 PRINT USING "Feed line impedance...... ####.### ohms "; RO
630 PRINT
640 PRINT USING "Gamma length (degrees)... ####.###°"; LDR
650 FT = (984 / F) * (LDR / 360)
660 PRINT USING "Gamma length (feet)...... ####.### ft."; FT
670 IN = FT * 12
680 PRINT USING "Gamma length (inches).... ####.### in."; IN
690 :REM'
700 :REM'.....end
710 GOSUB 730:GOTO 90
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
