10 :REM'PWRCCT - Power Supply Schematic - 05 DEC 90  rev. 10 OCT 07
20 CLS:KEY OFF
30 SCREEN 0,0,0
40 COMMON EX$,PROG$
50 IF EX$=""THEN EX$="EXIT"
60 PROG$="pwrcct"
70 COLOR 7,0,1
80 PI=3.1415929794311523!
90 UL$=STRING$(79,205)
100 :REM'
110 :REM'.....start
120 CLS
130 COLOR 15,2
140 PRINT " POWER SUPPLIES";TAB(57);"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 TB=(7)        :REM'tab for text
180 GOSUB 1680    :REM'text block
190 PRINT
200 PRINT UL$;
210 PRINT " Press number in < > to:"
220 PRINT UL$
230 PRINT "  < 1 >  Display circuit diagram"
240 PRINT "  < 2 >  Design a basic power supply"
250 PRINT "  < 3 >  Run ripple calculator"
260 PRINT "  < 4 >  List standard electrolytic capacitor values"
270 PRINT "         (Your may want to print out this list now before starting ";
280 PRINT "the design)"
290 PRINT
300 PRINT "  < 0 >  EXIT"
310 Z$=INKEY$
320 IF Z$="0"THEN CLS:RUN EX$
330 IF Z$="1"THEN CLS:GOTO 390
340 IF Z$="2"THEN CLS:CHAIN "pwrsupp"
350 IF Z$="3"THEN CLS:CHAIN "ripple"
360 IF Z$="4"THEN CLS:CHAIN "capacval"
370 GOTO 310
380 :REM'
390 :REM'.....circuit diagram
400 SCREEN 9
410 COLOR 15,1
420 PRINT " UNREGULATED POWER SUPPLY CIRCUIT";TAB(55);"by George Murphy VE3ERP"
430 PRINT " --------------------------------"
440 :REM'
450 LINE(174,28)-(174,92):LINE(182,28)-(182,92)          :REM'xfmr core
460 FOR Z=36 TO 84 STEP 12                                 :REM'xfmr coils
470 CIRCLE (160,Z),8,,1.5!*PI,PI/2
480 CIRCLE (196,Z),8,,PI/2,1.5!*PI
490 NEXT Z
500 :REM'
510 CIRCLE (46,30),4:CIRCLE (46,90),4                     :REM'input terminals
520 LINE(50,30)-(99,30):LINE(100,26)-(124,34),,B        :REM'fuse
530 LINE(125,30)-(159,30):LINE(197,30)-(310,30)         :REM'top line
540 CIRCLE (100,90),3:CIRCLE (124,90),3                   :REM'switch terminals
550 LINE(50,90)-(96,90)                                  :REM'switch lever
560 LINE(102,89)-(120,84)                                :REM'switch
570 LINE(128,90)-(159,90):LINE(197,90)-(310,90)         :REM'bottom line
580 LINE(250,30)-(250,90):LINE(310,30)-(310,90)         :REM'bridge verticals
590 CIRCLE (250,30),2:CIRCLE (250,90),2                   :REM'dots
600 CIRCLE (550,60),4:CIRCLE (550,150),4                  :REM'output terminals
610 LINE(250,60)-(220,60):LINE(310,60)-(546,60)         :REM'output line
620 CIRCLE (250,60),2:CIRCLE (310,60),2                   :REM'dots
630 LINE(220,60)-(220,68):LINE(212,68)-(228,68)         :REM'chassis ground
640 LINE(216,70)-(224,70):LINE(219,72)-(221,72)         :REM'chassis ground
650 :REM'
660 LINE(276,26)-(276,34):LINE(284,26)-(284,34)         :REM'horizontal  diode
670 LINE(276,26)-(284,30):LINE(276,34)-(284,30)
680 PAINT (277,29):PAINT (277,31)
690 :REM'
700 LINE(276,86)-(276,94):LINE(284,86)-(284,94)         :REM'horizontal diode
710 LINE(276,86)-(284,90):LINE(276,94)-(284,90)
720 PAINT (277,89):PAINT (277,91)
730 :REM'
740 LINE(244,42)-(256,42):LINE(244,48)-(256,48)         :REM'vertical diode
750 LINE(244,48)-(250,42):LINE(256,48)-(250,42)
760 PAINT (249,47):PAINT(251,47)
770 :REM'
780 LINE(244,72)-(256,72):LINE(244,78)-(256,78)         :REM'vertical diode
790 LINE(244,72)-(250,78):LINE(256,72)-(250,78)
800 PAINT (249,73):PAINT(251,73)
810 :REM'
820 LINE(362,160)-(378,160):LINE(366,162)-(374,162)     :REM'chassis ground
830 LINE(369,164)-(371,164):LINE(370,150)-(546,150)     :REM'ground lead
840 :REM'
850 LINE(360,102)-(380,102):LINE(360,108)-(380,108)     :REM'capacitor
860 LINE(370,60)-(370,102):LINE(370,108)-(370,160)      :REM'capacitor leads
870 CIRCLE (370,60),2:CIRCLE (370,150),2                  :REM'dots
880 :REM'
890 LINE(430,97)-(435,99):LINE(435,99)-(425,103)        :REM'bleeder resistor
900 LINE(425,103)-(435,107):LINE(435,107)-(425,111)
910 LINE(425,111)-(430,113)
920 LINE(430,60)-(430,97):LINE(430,113)-(430,150)       :REM'bleeder leads
930 CIRCLE (430,60),2:CIRCLE (430,150),2                  :REM'dots
940 :REM'
950 LINE(490,82)-(495,84):LINE(495,84)-(485,88)         :REM'LED resistor
960 LINE(485,88)-(495,92):LINE(495,92)-(485,96)
970 LINE(485,96)-(490,98)
980 :REM'
990 LINE(484,117)-(496,117):LINE(484,123)-(496,123)     :REM'LED
1000 LINE(484,117)-(490,123):LINE(496,117)-(490,123)
1010 PAINT (490,118)
1020 LOCATE 9,64:PRINT CHR$(26)
1030 LINE(490,60)-(490,82):LINE(490,98)-(490,117)        :REM'LED leads
1040 LINE(490,123)-(490,150)
1050 CIRCLE (490,60),2:CIRCLE (490,150),2                  :REM'dots
1060 :REM'
1070 LOCATE 5,2:PRINT "A.C. input"
1080 LOCATE 4,14:PRINT "F1"
1090 LOCATE 5,18:PRINT "T1"
1100 LOCATE 5,34:PRINT "D1-D4"
1110 LOCATE 8,43:PRINT "C1"
1120 LOCATE 8,56:PRINT "R1"
1130 LOCATE 7,64:PRINT "R2"
1140 LOCATE 10,64:PRINT "D5"
1150 LOCATE 8,68:PRINT "D.C. output"
1160 LOCATE 5,72:PRINT "+"
1170 LOCATE 11,72:PRINT "-"
1180 LOCATE 8
1190 PRINT " F1     Mains Fuse"
1200 PRINT " T1     Transformer"
1210 PRINT " D1-D4  Rectifier Diodes"
1220 PRINT " D5     Power On LED indicator"
1230 PRINT " C1     Filter Capacitor"
1240 PRINT " R1     Bleeder Resistor"
1250 PRINT " R2     LED resistor"
1260 LOCATE 17
1270 CIRCLE (310,231),4:CIRCLE (310,315),4           :REM'input terminals
1280 LINE(370,216)-(450,246),,B                     :REM'LM317 box
1290 LINE(314,231)-(370,231)                        :REM'+ line
1300 LINE(450,231)-(546,231)                        :REM'+ line
1310 CIRCLE (550,231),4:CIRCLE (550,315),4           :REM'output terminals
1320 LINE(314,315)-(546,315)                        :REM'- line
1330 LINE(490,244)-(495,246):LINE(495,246)-(485,250)     :REM'R3
1340 LINE(485,250)-(495,254):LINE(495,254)-(485,258)
1350 LINE(485,258)-(490,260)
1360 :REM'
1370 LINE(490,286)-(495,288):LINE(495,288)-(485,292)     :REM'R4
1380 LINE(485,292)-(495,296):LINE(495,296)-(485,300)
1390 LINE(485,300)-(490,302)
1400 :REM'
1410 LINE(490,231)-(490,244):LINE(490,260)-(490,286)     :REM'resistor leads
1420 LINE(490,302)-(490,315)
1430 :REM'
1440 LINE(485,292)-(480,289):LINE(485,292)-(480,295)     :REM'arrow head
1450 LINE(480,289)-(480,295):PAINT (481,292)
1460 :REM'
1470 LINE(410,246)-(410,292):LINE(410,292)-(480,292)     :REM'pot leads
1480 LINE(410,273)-(490,273)
1490 :REM'
1500 CIRCLE (410,273),2:CIRCLE (490,231),2                 :REM'dots
1510 CIRCLE (490,273),2:CIRCLE (490,315),2
1520 :REM'
1530 LOCATE 16
1540 PRINT " LM317 VOLTAGE REGULATOR CCT."
1550 PRINT " ----------------------------"
1560 LOCATE 17,50:PRINT "LM317"
1570 LOCATE 17,37:PRINT "+"                          :REM'+ input terminal
1580 LOCATE 17,72:PRINT "+"                          :REM'+ output
1590 LOCATE 19,64:PRINT "R3"
1600 LOCATE 18:PRINT " R3     Fixed resistor"
1610 LOCATE 19:PRINT " R4     Adjustable resistor"
1620 LOCATE 22,64:PRINT "R4"
1630 LOCATE 23,37:PRINT "-"                          :REM'- output
1640 LOCATE 23,72:PRINT "-"
1650 LOCATE 23,2:PRINT "PRESS ANY KEY TO EXIT..."
1660 IF INKEY$=""THEN 1660 :ELSE 10
1670 :REM'
1680 :REM'.....text block
1690 PRINT TAB(TB);
1700 PRINT "The schematic diagram in program <1> is written for GWBASIC screen"
1710 PRINT TAB(TB);
1720 PRINT "mode 9 (graphics mode) and an EGA or VGA 640 x 350 pixel monitor."
1730 PRINT TAB(TB);
1740 PRINT "The diagram may be distorted or the program may hang up if your"
1750 PRINT TAB(TB);
1760 PRINT "hardware is not compatible with this configuration."
1770 PRINT
1780 PRINT TAB(TB);
1790 PRINT "But not to worry.........................."
1800 PRINT
1810 PRINT TAB(TB);
1820 PRINT "Block diagrams that will display on any monitor and print on any"
1830 PRINT TAB(TB);
1840 PRINT "printer loaded with standard ASCII character sets with graphics"
1850 PRINT TAB(TB);
1860 PRINT "characters are included in every program."
1870 RETURN
