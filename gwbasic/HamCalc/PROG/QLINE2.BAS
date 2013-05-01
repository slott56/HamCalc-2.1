10 :REM'QLINE2  - 16 SEP 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="QLINE2"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " TRANSMISSION LINE Q"TAB(60)"by R.J.Dehoney, IEEE ";
100 COLOR 7,0
110 :REM'.....start
120 PRINT
130 PRINT " This program verifies the ITT formula for the unloaded Q of a quarter wave"
140 PRINT  " stub at resonance by solving the transmission line formulas and finding the"
150 PRINT " frequencies where Z is 3 dB dowm from Z at F0. Inputs are line impedence,"
160 PRINT " velocity factor and loss in dB per 100 feet of cable."
170 PRINT:LN=CSRLIN
180 PRINT " Line Z, VF & dB loss can be found in HAMCALC's 'Coaxial Cable Characteristics'"
190 PRINT " menu items (e) and (f)."
200 PRINT:LN=CSRLIN
210 PRINT " .....Press (1) for link to 'Coaxial Cable Characteristics'"
220 PRINT " .....Press (2) to run this program"
230 PRINT " .....Press (0) to EXIT"
240 Z$=INKEY$:IF Z$=""THEN 240
250 IF Z$="1"THEN CHAIN "\hamcalc\prog\coaxchar"
260 IF Z$="2"THEN 290
270 IF Z$="0"THEN RUN EX$
280 GOTO 240
290 :REM'.....start
300 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
310 DEFDBL A-M, O-Z :V0=30000001024.0! :MHZ=10^6
320 TP=8*ATN(1) :INPUT " ENTER: Line Impedance (Ω);";Z0
330 LOCATE CSRLIN-1:PRINT USING "Line Impedence.. #### Ω                ";Z0
340 INPUT "ENTER: Resonant Frequency (MHz)";F0 :F0=F0*MHZ
350 LOCATE CSRLIN-1:PRINT USING "Frequency....... ####.### MHz          "   ;F0/10^6
360 INPUT " ENTER: Line velocity (decimal value)";K
370 LOCATE CSRLIN-1:PRINT USING "Line Velocity... ####.###                    "   ;K
380 WL=V0*K/F0/2.5399999618530273!/12 :L=WL/4
390 PRINT USING "Wavelength...... ####.### feet         "   ;WL
400 LN=CSRLIN
410 LOCATE LN:PRINT STRING$(79,32):LOCATE LN
420 INPUT " ENTER: Loss per 100 ft.(dB) or 0 to quit";L100 :ALPHA=L100/100*0.11509999632835388! :A=2*ALPHA*L
430 IF L100>0 THEN 440 :ELSE LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 640
440 LOCATE LN:PRINT USING "Line loss....... ####.### dB                     "   ;L100
450 ZMAX=(EXP(A)+1)/(EXP(A)-1)*Z0 :Z3=ZMAX/SQR(2)
460 DF=0.0010000000474974513!*F0 :F=0.5!*F0-DF
470 F=F+DF :ANG=90*F/F0 :RAD=TP/360*ANG :B=2*RAD
480 AX=EXP(A)*COS(B)+1 :BX=EXP(A)*SIN(B) :CX=EXP(A)*COS(B)-1
490 RE=(AX*CX+BX^2)/Z0/(CX^2+BX^2) :IM=-(BX*CX-AX*BX)/Z0/(CX^2+BX^2)
500 RP=1/RE :XP=1/IM :Z=1/SQR(RE^2+IM^2)
510 IF ABS(Z/Z3-Z3/Z)<0.0010000000474974513! THEN FL=F :GOTO 540
520 IF Z<Z3 THEN 470 :ELSE F=F-DF :DF=DF/2 :GOTO 470
530 ----------------ROUTINE TO FIND FH-----------------
540 DF=0.0010000000474974513!*F0 :F=F0-DF
550 F=F+DF :ANG=90*F/F0 :RAD=TP/360*ANG :B=2*RAD
560 AX=EXP(A)*COS(B)+1 :BX=EXP(A)*SIN(B) :CX=EXP(A)*COS(B)-1
570 RE=(AX*CX+BX^2)/Z0/(CX^2+BX^2) :IM=-(BX*CX-AX*BX)/Z0/(CX^2+BX^2)
580 RP=1/RE :XP=1/IM :Z=1/SQR(RE^2+IM^2)
590 IF ABS(Z/Z3-Z3/Z)<0.0010000000474974513! THEN FH=F :GOTO 610
600 IF Z>Z3 THEN 550 :ELSE F=F-DF :DF=DF/2 :GOTO 550
610 Q=F0/(FH-FL) :QITT=TP/WL/2/ALPHA
620 PRINT USING "Q=####.###   Q(ITT)=####.###  Diff.= #.###";Q,QITT,ABS(Q-QITT)
630 GOTO 410
640 :REM'.....end
650 GOSUB 660:CLS:GOTO 70
660 :REM'.....PRT
670 KEY OFF:GOSUB 740:LOCATE 25,5:COLOR 0,2
680 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
690 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
700 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 700 :ELSE GOSUB 740
710 IF Z$="3"THEN RETURN
720 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
730 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 670
740 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
