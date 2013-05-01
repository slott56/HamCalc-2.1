10 :REM'COAXLC3 - 05 SEP 09
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=PROG$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 DIM W(20), X(20)
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " COAXIAL CABLE L/C TANK"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 15,2:
120 LOCATE CSRLIN-1,24:PRINT " (algorithm by R.J.Dehoney IEEE "
130 COLOR 7,0
140 REM -------------LCFIND4.BAS,rjd,8/30/09-----------------------
150 PRINT
160 PRINT " This program finds the values of L and C corresponding to a length of coax"
170 PRINT " shorted at the far end."
180 PRINT
190 PRINT " Press (1) to continue or (0) to EXIT"
200 Z$=INKEY$:IF Z$=""THEN 200
210 IF Z$="0"THEN CLS:RUN GO$
220 IF Z$="1"THEN 250
230 GOTO 210
240 STOP
250 :REM'.....start
260 CLS
270 GOSUB 280:GOTO 370
280 :REM'.....diagram
290 PRINT "  ┌─┐                      "
300 PRINT "  │╒═ shield ═╕    ───┬──┐ "
310 PRINT "  └───────────── = L  C    "
320 PRINT "   ╘═ shield ═╛    ───┴──┘ "
330 PRINT "   │<───S────>│            "
340 PRINT "                           "
350 LN=CSRLIN
360 RETURN
370 PRINT
380 INPUT " ENTER: Impedence of cable (ohms)";Z0
390 INPUT " ENTER: Frequency in MHz, at which line is .25 wavelengths ";F0
400 INPUT " ENTER: V velocity factor of cable";K
410 PRINT " (Printout will show a 2.5% range of frequencies)"
420 PRINT " ENTER: Starting frequency (less than"F0"MHz)";:INPUT FS
430 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
440 TP=8*ATN(1) :V=300000000.0!*K :W0=TP*F0*10^6:S=TP*V/4/W0:WL=TP*V/W0:WL=300/F0
450 T=40
460 LOCATE 3,T:PRINT " COAXIAL CABLE L/C TANK "
470 LOCATE 4,T:PRINT "════════════════════════"
480 LOCATE 5,T:PRINT USING " Starting frequency: ####.### MHz";FS
490 LOCATE 6,T:PRINT USING " Wavelength: ###.### metres";WL
500 LOCATE 7,T:PRINT USING " Length S: ####.### m.= #####.### ft.";S,S*3.2799999713897705!
510 LOCATE 7,16:PRINT "COAX: Z=";Z0;"Ω  VF=";K
520 LOCATE 9
530 FOR N=10 TO 0  STEP -1 :F=FS*(1-0.0024999999441206455!*N) :W(N)=F*TP*10^6 :W=W(N)
540 X(N)=Z0*TAN(W*S/V) :NEXT N
550 W1=W(10) :W2=W(0) :X1=X(10) :X2=X(0)
560 L=(1/W2^2-1/W1^2)/(1/W2/X2-1/W1/X1) :C=(X1-W1*L)/W1^2/X1/L
570 :REM'PRINT "        Reactance of   Reactance of
580 PRINT "  MHz   Iine Reactance  Tank Reactance"
590 PRINT " ═════  ══════════════  ══════════════"
600 FOR N=10 TO 0  STEP -1 :F=FS*(1-0.0024999999441206455!*N) :W(N)=F*TP*10^6 :W=W(N)
610 XLC=W(N)*L/(1-W(N)^2*L*C)
620 PRINT USING " ###.##   ######.# Ω     ######.# Ω";F,X(N),XLC
630 NEXT N
640 LOCATE 8,T:PRINT USING " C= ###.### pF: L= ##.### µH";C*10^12,L*10^6
650 LOCATE 23:PRINT " Press (1) for new starting frequency or "0" to quit"
660 Z$=INKEY$:IF Z$=""THEN 660
670 IF Z$="0"THEN GOSUB 720:CLS:GOTO 70
680 IF Z$="1"THEN 700
690 GOTO  660
700 LOCATE 24:INPUT " New frequency";FS
710 IF FS<>0 THEN CLS:GOSUB 280:GOTO 440
720 :REM'.....PRT
730 KEY OFF:GOSUB 800:LOCATE 25,5:COLOR 0,2
740 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
750 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
760 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 760 :ELSE GOSUB 800
770 IF Z$="3"THEN RETURN
780 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
790 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 730
800 LOCATE 23,1:PRINT STRING$(80,32);:RETURN
