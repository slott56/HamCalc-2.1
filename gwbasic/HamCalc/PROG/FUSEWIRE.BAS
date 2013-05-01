10 :REM'FUSEWIRE - Fuses, Emergency - 01 OCT 1999, rev.
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COLOR 7,0,1
50 PI=4*ATN(1)  :REM'3.141593
60 UL$=STRING$(80,205)
70 U1$="#####.###"
80 DIM GA(50)
90 :REM'.....AWG calculator
100 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)    :REM'increment multiplier
110 FOR Z=1 TO 50
120 N=Z+3
130 GA(Z)=0.46000000834465027!/K^N
140 NEXT Z
150 :REM'
160 :REM'.....title page
170 CLS
180 COLOR 15,2
190 PRINT " FUSES - Emergency"TAB(57)"by George Murphy VE3ERP ";
200 COLOR 1,0:PRINT STRING$(80,223);
210 COLOR 7,0
220 :REM'
230 :REM'.....start
240 GOSUB 530
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="1"THEN 290
270 IF Z$="0"THEN RUN EX$
280 GOTO 250
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
300 INPUT " ENTER: Fuse rating in amperes............";I
310 D=(I/10244)^(2/3)
320 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
330 PRINT USING " Fuse rating.................... ##.### amps.";I
340 S=I*2/3
350 PRINT USING " Maximum safe current........... ##.### amps.";S
360 PRINT USING " Copper fuse wire diameter...... ##.#### in.(#.## mm)";D,D*25.399999618530273!
370 PRINT
380 FOR Z=1 TO 50
390 IF GA(Z)<D THEN 450
400 NEXT Z
410 BEEP:COLOR 12
420 PRINT USING " Smallest AWG copper wire is no. 50, dia. #.#### in.";GA(50)
430 COLOR 7,0:GOTO 510
440 :REM'
450 COLOR 0,7
460 PRINT USING " Nearest AWG size is no. ## , diameter #.#### in.";Z,GA(Z);
470 II=10244*EXP(LOG(GA(Z))/0.6669999957084656!)
480 PRINT USING ", rated at ##.### amps.";II
490 PRINT :PRINT USING " Maximum safe current ##.### amps.";II*0.6669999957084656!
500 COLOR 7,0
510 PRINT :PRINT " Press any key . . . "
520 IF INKEY$=""THEN 520 :ELSE 160
530 :REM'.....preface
540 T=7
550 PRINT TAB(T);
560 PRINT "For fuses up to about 25 amps, a short length of solid copper wire"
570 PRINT TAB(T);
580 PRINT "can be used as a temporary emergency replacement. Copper wire"
590 PRINT TAB(T);
600 PRINT "operated near the fusing current is particularly subject to"
610 PRINT TAB(T);
620 PRINT "corrosion and should therefore be tinned so that it will not oxidize"
630 PRINT TAB(T);
640 PRINT "excessively."
650 PRINT
660 PRINT TAB(T);
670 PRINT "ref. Radiotron Designer's Handbook, page 1395"
680 PRINT :COLOR 0,7:LOCATE ,23
690 PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
700 RETURN
