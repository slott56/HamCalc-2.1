10 :REM'NOISFIG
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 UL$=STRING$(80,205)
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,1
110 PRINT " NOISE FIGURE, Op Amps"TAB(61)"by R.J.Dehoney IEEE ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0
140 :REM'
150 PRINT " This program calculates the noise figure of op amps, given En,In, ";
160 PRINT "and R source.";
170 PRINT " It is based on an article by John Christiensen, National Semicond";
180 PRINT "uctor."
190 PRINT UL$;
200 PRINT " Press <1> to run program or <0> to EXIT"
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="0"THEN CLS:RUN EX$
230 IF Z$="1"THEN 250
240 GOTO 220
250 COLOR 7,0,0:CLS
260 PRINT "OP AMP NOISE FIGURE"
270 PRINT UL$;
280 PRINT "               + ┌- -- -- -- -┐Op Amp"
290 PRINT "       ┌───Rsa───|─┬-En---    |"
300 PRINT "      Vin        | In         |"
310 PRINT "       ├─────┬───|─┤          |───┬──Out"
320 PRINT "       │     ╧ - | In         |   │"
330 PRINT "       └───Rsb─┬─|─┴-En---    |   │"
340 PRINT "               │ └- -- -- -- -┘   │"
350 PRINT "               └───────Rfb────────┘"
360 PRINT UL$;
370 LN =CSRLIN
380 INPUT "From the op amp data sheet, ENTER: En in nV/√Hz ";EN
390 IF EN=0 THEN 380
400 INPUT "ENTER: In in fA/√Hz ";IN :IN=IN/1000
410 IF IN=0 THEN 400
420 PRINT "For minimum DC offset, the parallel combination of Rsb & Rfb shoul";
430 PRINT "d equal Rsa."
440 INPUT "If it does, ENTER <0> ELSE ENTER Rsb in kilohms";RSB
450 IF RSB=0 THEN RSX=RSA:GOTO 470
460 INPUT "ENTER Rfb in kilohms";RFB:RSX=RFB*RSB/(RFB+RSB)
470 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
480 PRINT "  Rs      Noise Figure    Effective Input Noise nV/√Hz"
490 PRINT UL$;
500 READ RS :E0=SQR(16.600000381469727!*RS) :IF RS=0 THEN 570 :REM'end
510 IF RSX=0 THEN RS2=RS :ELSE RS2=RSX
520 EN1=1.4140000343322754!*EN :EN2A=IN*RS :EN2B=IN*RS2 :ENT=SQR(E0^2+EN1^2+EN2A^2+EN2B^2)
530 NF=20*LOG(ENT/E0)/LOG(10)
540 A$="K" :IF RS>999 THEN RS=RS/1000 :A$="Meg"
550 PRINT RS;A$;TAB(10);USING "####.###               ";NF;ENT
560 GOTO 500
570 :REM'.....end
580 GOSUB 600:CLS:GOTO 200
590 DATA 1,3,10,30,100,300,1000,3000,10000,0
600 :REM'.....PRT
610 KEY OFF:GOSUB 680:LOCATE 25,5:COLOR 0,2
620 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
630 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
640 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 640 :ELSE GOSUB 680
650 IF Z$="3"THEN RETURN
660 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
670 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 610
680 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
