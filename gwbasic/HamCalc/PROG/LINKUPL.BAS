10 :REM'LINKUPL - 12 DEC 2007
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 JJ=1/(4*PI^2)*10^6
80 :REM'.....title page
90 CLS
100 COLOR 15,2,1
110 PRINT " LINK COUPLED ANTENNA TUNERS"TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0,0
140 :REM'.....start
150 F=0:W=0:XIN=0:XOUT=0:UIN=0:UOUT=0:CIN=0:COUT=0
160 PRINT
170 PRINT "Capacitance and Inductance Calculator for Link Coupled Antenna Tun";
180 PRINT "ers."
190 PRINT
200 PRINT "Ref. <www.cebik.com/link/link5.html>"
210 PRINT
220 PRINT TAB(20)"....Press 1 to continue or 0 to exit...."
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN CLS:RUN EX$
250 IF Z$="1"THEN CLS:GOTO 270
260 GOTO 230
270 :REM'.....data input
280 CLS:PRINT
290 INPUT "ENTER: Low frequency limit in MHz";FL
300 INPUT "ENTER: High frequency limit in MHz";FH
310 XL=50:XH=500
320 UL=XL/(2*PI*FL)
330 UH=XH/(2*PI*FH)
340 CL=JJ/FL^2/UL
350 CH=JJ/FH^2/UH
360 WL=300/FL
370 WH=300/FH
380 :REM'.....display
390 CLS
400 PRINT "VALUE LIMITS for LINK-COUPLED TUNERS"
410 PRINT
420 PRINT "              PRIMARY       SECONDARY"
430 PRINT
440 PRINT USING "Frequencies  ####.### MHz     ###.### MHz";FL,FH
450 PRINT USING "Wavelengths  ####.### metres  ###.### metres";WL,WH
460 PRINT USING "Reactances   ####.### Ω       ###.### Ω";XL,XH
470 PRINT USING "Inductances  ####.### µH      ###.### µH";UL,UH
480 PRINT USING "Capacitances ####.### pF      ###.### pF";CL,CH
490 PRINT
500 PRINT "If you want to design capacitor plates make a note of these values";
510 PRINT " and run the"
520 PRINT "`Capacitors - Variable Plate' program."
530 :REM'.....end
540 GOSUB 550:CLS:GOTO 140
550 :REM'.....PRT
560 KEY OFF:GOSUB 630:LOCATE 25,5:COLOR 0,2
570 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
580 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
590 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 590 :ELSE GOSUB 630
600 IF Z$="3"THEN RETURN
610 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
620 JJ=1/(4*PI^2)*10^6
630 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
