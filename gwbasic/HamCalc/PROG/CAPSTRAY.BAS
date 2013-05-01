10 :REM'CAPSTRAY -Stray capacitance - 21 MAR 2006 rev. 01 AUG 2009
20 IF EX$=""THEN EX$="exit"
30 COMMON EX$
40 UL$=STRING$(80,205)
50 PI=4*ATN(1):P2=2*PI
60 :REM'.....start
70 CLS:KEY OFF:COLOR 7,0,0
80 PRINT " STRAY CAPACITANCE"TAB(57)"by George Murphy VE3ERP ";
90 PRINT UL$;
100 LOCATE CSRLIN-1,26:PRINT " (algorithm author unknown) "
110 LN=CSRLIN
120 PRINT " The stray or distributed capacitance of an inductor may be deter";
130 PRINT "mined by"
140 PRINT " entering frequency and capacitance at resonance at two separate";
150 PRINT " frequencies."
160 PRINT UL$;
170 PRINT " Press <1> to run program or <0> to EXIT."
180 Z$=INKEY$:IF Z$=""THEN 180
190 IF Z$="0"THEN CLS:CHAIN EX$
200 IF Z$="1"THEN 220
210 GOTO 180
220 :REM'.....start
230 GOSUB 450:INPUT " ENTER: Higher frequency (MHz)";Z:F=Z*10^3
240 GOSUB 450: PRINT USING " Higher frequency.............. ####.### MHz";F/10^3
250 WH=P2*F
260 LN=CSRLIN:INPUT " ENTER: Higher frequency capacitance (pF)";C
270 GOSUB 450: PRINT USING " Higher frequency capacitance.. ####.### µF";C
280 CH=C
290 LN=CSRLIN
300 GOSUB 450:INPUT " ENTER: Lower frequency (MHz)";Z:F=Z*10^3
310 WL=P2*F:IF WL=0 OR WL>WH THEN BEEP:GOSUB 450:GOTO 300
320 GOSUB 450: PRINT USING " Lower frequency............... ####.### MHz";F/10^3
330 LN=CSRLIN:COLOR 0,7:PRINT " Lower frequency capacitance must be <=";CH:COLOR 7,0
340 INPUT " ENTER: Lower frequency capacitance (pF)";C
350 IF C=0 OR C>CH THEN BEEP:GOSUB 440:GOSUB 450:GOTO 330
360 GOSUB 450: PRINT USING " Lower frequency capacitance... ####.### µF";C
370 LN=CSRLIN
380 CL = C
390 CLC1=(CH/((WL^2/WH^2)-1)):A$=STR$(CLC1):B$=MID$(A$,2):A=VAL(B$)
400 CS=A-(CL/((WH^2/WL^2)-1))
410 GOSUB 450: PRINT USING " Distributed capacitance....... ####.### pF";CS
420 :REM'.....end
430 GOSUB 460:GOTO 60
440 :REM'.....clear to bottom of screen
450 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
460 :REM'.....PRT
470 KEY OFF:GOSUB 540:LOCATE 25,5:COLOR 0,2
480 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
490 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
500 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 500 :ELSE GOSUB 540
510 IF Z$="3"THEN RETURN
520 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
530 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 470
540 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
