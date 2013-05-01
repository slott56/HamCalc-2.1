10 :REM'CASCAMP - 26 SEP 2005
20 PRINT " This program finds the bandwidth of cascaded op amp stages, given"
30 PRINT " the op amp open loop gain Gmax, 3 dB corner frequency F3 or the"
40 CLS:KEY OFF
50 IF EX$=""THEN EX$="EXIT"
60 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
70 COMMON EX$,PROG$
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " Cascaded OP AMPS"TAB(60)"by Robert J. Dehoney ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0,0
150 PRINT " This program finds the bandwidth of cascaded op amp stages, given"
160 PRINT " the op amp open loop gain Gmax, 3 dB corner frequency F3 or the"
170 PRINT " the gain-bandwidth Fmax and the overall closed loop gain."
180 COLOR 0,7,0:PRINT:LN=CSRLIN
190 LOCATE LN,27:PRINT " to RUN ...........press 1 "
200 LOCATE   ,27:PRINT " to EXIT...........press 0 "
210 COLOR  7,0
220 Z$=INKEY$
230 IF Z$="0"THEN RUN EX$
240 IF Z$="1"THEN VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 270
250 GOTO 220
260 1.4693679385278594e-39!1.4693679385278594e-39!1.4693679385278594e-39!1.4693679385278594e-39!1.4693679385278594e-39!1.4693679385278594e-39!SCHEMATIC
270 PRINT "     ┌──R1──┬──R2──┬───- - - R1- - - - -"
280 PRINT "     │      │┌──┐  │"
290 PRINT "     │      └┤- │  │V1"
300 PRINT "    Vin      │  ├──┘     to other stages"
310 PRINT "     │      ┌┤+ │"
320 PRINT "     │      │└──┘Op Amp"
330 PRINT "     ╧      ╧"
340 :REM'
350 LN=CSRLIN
360 INPUT " ENTER: Op Amp open loop DC gain ",GMAX
370 INPUT " ENTER: Amp open loop 3 dB corner frequency in Hz, or <CR> ",F3A
380 IF F3A=0 THEN INPUT " ENTER: Op Amp Gain-Bandwidth product in MHz ",FMAX
390 INPUT " ENTER: desired overall gain ",GT
400 IF F3A=0 THEN F3=FMAX*1000000.0!/SQR(GMAX^2-1) :ELSE F3=F3A
410 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
420 PRINT " Number of stages   BW MHz   Stage gain   R2/R1"
430 FOR N=1 TO 7
440 GS=GT^(1/N)
450 X=SQR(10^(0.30000001192092896!/N)-1)
460 IF GS=>GMAX THEN 510 :ELSE B=GMAX-1 :A=GS*(GMAX+1)/(GMAX-GS)
470 K=(A+1)/(A+B)
480 ALPHA=GS*(GMAX+1)/(GMAX-GS)
490 F=F3*X/K :F=INT(F*1000)/1000000000.0!
500 PRINT"     ";N;"          ";USING"###.##     ";F;GS;ALPHA
510 NEXT N :PRINT
520 IF F3A=0 THEN PRINT " Op Amp 3 dB corner frequency=";(F3);"Hz":GOTO 540
530 PRINT " Op Amp Gain Bandwidth=";(F3*SQR(GMAX^2-1)/1000000.0!);"MHz"
540 GOSUB 570:GOTO 90
550 :REM'
560 :REM'.....PRT
570 KEY OFF:GOSUB 640:LOCATE 25,5:COLOR 0,2
580 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
590 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
600 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 600 :ELSE GOSUB 640
610 IF Z$="3"THEN RETURN
620 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
630 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 570
640 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
