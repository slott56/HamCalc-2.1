10 :REM'SINK - Heat Sink Fins - 29 FEB 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 N$=" - fins 1.5 mm (.059 in.) thick"
60 K$=" - fins 3.0 mm (.118 in.) thick"
70 :REM'.....start page
80 CLS
90 COLOR 15,2,0
100 PRINT " HEAT SINK FINS"TAB(66)"by R.J.Dehoney ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 PRINT " This program assumes the heat generating element is in the centre";
140 PRINT " of the fin. "
150 PRINT " The temperature rise of the element above ambient temperature is c";
160 PRINT "alculated in"
170 PRINT " degrees per watt."
180 PRINT
190 K1=138 :K2=-0.5960000157356262! :K3=76.70966339111328! :K4=-0.584850013256073! :K5=0.3291836977005005!
200 PRINT "....Press 1 for dimensions in centimetres"
210 PRINT "....Press 2 for dimensions in inches"
220 PRINT "....Press 0 to exit program"
230 Z$=INKEY$:IF Z$=""THEN 230
240 VIEW PRINT 7 TO 24:CLS:VIEW PRINT:LOCATE 7
250 IF Z$="0"THEN RUN GO$
260 IF Z$="1"THEN 290
270 IF Z$="2"THEN 310
280 :REM'.....calculation
290 LN=CSRLIN:INPUT " ENTER: Area of fin in sq.cm ";ACM:LOCATE LN
300 PRINT USING " Fin area............. ##.## cm²           ";ACM:GOTO 330
310 LN=CSRLIN:INPUT " ENTER: Area of fin in sq.in ";AIN:LOCATE LN
320 PRINT USING " Fin area............. ##.## in²           ";AIN:GOTO 340
330 RCM1=K1*ACM^K2 :RCM2=K3*ACM^K4 :GOTO 350
340 RIN1=K1*K5*AIN^K2 :RIN2=K3*K5*AIN^K4 :GOTO 380
350 PRINT USING " Thermal resistance #####.## °C per watt";RCM1;:PRINT N$
360 PRINT USING "                    #####.## °C per watt";RCM2;:PRINT K$
370 GOTO 400
380 PRINT USING " Thermal resistance #####.## °C per watt";RIN1;:PRINT N$
390 PRINT USING "                    #####.## °C per watt";RIN2;:PRINT K$
400 :REM'.....end
410 GOSUB 420:GOTO 70
420 :REM'.....PRT
430 KEY OFF:GOSUB 500:LOCATE 25,5:COLOR 0,2
440 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
450 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
460 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 460 :ELSE GOSUB 500
470 IF Z$="3"THEN RETURN
480 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
490 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 430
500 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
