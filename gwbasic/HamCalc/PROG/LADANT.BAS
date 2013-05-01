10 :REM'LADANT - Ladder Line ANTENNA -  14 MAR 2010
20 KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2
90 PRINT " LADDER LINE ANTENNA"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0
110 GOTO 130
120 VIEW PRINT 12 TO 24:CLS:VIEW PRINT:LOCATE 13:RETURN
130 :REM'.....diagram
140 COLOR 0,7
150 PRINT "                                 "
160 PRINT " │«─────────────A─────────────»│ "
170 PRINT " │«─────C──────»│«─────B──────»│ "
180 PRINT " │«─E─»│«──D───»│              │ "
190 PRINT " ┌─────┬────────G──────────────┐ "
200 PRINT " ││   ││  │   │   │   │   │   ││«─leg ends connected together "
210 PRINT " └─────┼┬──────────────────────┘ "
220 PRINT " braid»││«─ 50 Ω coax            "
230 PRINT "       └┴─»choke»transmatch»XCVR "
240 PRINT " 450 Ω Ladder Line Antenna       "
250 PRINT:LN=CSRLIN
260 PRINT :COLOR 7,O:LOCATE 10,34:PRINT "«─choke = few turns of coax "
270 GOSUB 120
280 PRINT " Note the gap G in the side to which the coax braid is connected."
290 PRINT " This antenna may be mounted horizonatally or vertically."
300 PRINT " For maximum performance a transmatch (antenna tuner) is required."
310 PRINT " Primarily a VHF/UHF antenna, it is very long at HF frequencies."
320 PRINT " For plastic pipe construction details e-mail <ve3erp@rac.ca>."
330 PRINT
340 PRINT " Press 1 to continue or 0 to EXIT"
350 Z$=INKEY$:IF Z$=" "THEN 350
360 IF Z$="0"THEN CLS:RUN GO$
370 IF Z$="1"THEN 390
380 GOTO 350
390 :REM'.....data input
400 GOSUB 120
410 INPUT " ENTER: Frequency in MHz";F
420 FW=299.7919921875!/F   :REM'full wavelenght in metres
430 B=FW/2         :REM'half wavelength in metres
440 C=FW/4         :REM'quarter wavelength in metres
450 A=B+C
460 D=1500/F
470 G=300/F
480 GOSUB 120
490 PRINT USING " Frequency...... ####.### MHz";F
500 PRINT USING " Wavelength..... ####.### metres";FW
510 PRINT USING " A = ####.## cm.= ###.### in.";A*100,A*100/2.5399999618530273!
520 PRINT USING " B = ####.## cm.= ###.### in.";B*100,B*100/2.5399999618530273!
530 PRINT USING " C = ####.## cm.= ###.### in.";C*100,C*100/2.5399999618530273!
540 PRINT USING " D = ####.## cm.= ###.### in.";D,D/2.5399999618530273!
550 PRINT USING " G = ####.## cm.= ###.### in.";G,G/2.5399999618530273!
560 PRINT
570 PRINT " Adjust D & E for minumum SWR."
580 :REM'......end
590 GOSUB 600:GOTO 60
600 :REM'.....PRT
610 KEY OFF:GOSUB 680:LOCATE 25,5:COLOR 0,2
620 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
630 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
640 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 640 :ELSE GOSUB 680
650 IF Z$="3"THEN RETURN
660 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
670 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 610
680 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
