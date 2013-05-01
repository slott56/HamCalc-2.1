10 :REM'CW - 5 SEP 87 rev. 27 DEC 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
32 PROG$="CW"
35 COMMON EX$,PROG$
40 COLOR 7,0,0
50 UL$=STRING$(80,205)
60 X$=STRING$(79,32)
70 H=25  :REM'default speed
80 VV=0  :REM'set pause factor (weighting) to nil
90 PLAY "mfmll2o3" :REM'music foreground, legato, L=2 whole notes, octave 3
100 DIM C$(90,3)
110 ON ERROR  GOTO 140
120 GOTO 300
130 :REM'
140 :REM'error trap
150 BEEP:CLS:PRINT " Error";ERR;"in line";ERL
160 END
170 :REM'
180 :REM'.....speed in WPM
190 COLOR 0,7:PRINT " Sample tone         ":COLOR 7,0,0
200 PRINT " and"
210 TEMPO=H*6 :REM'tempo limits 32/255
220 T$="t"+STR$(TEMPO):PLAY T$ :REM'set tempo
230 COLOR 0,7:PRINT " Sample Keying Speed ";:COLOR 7,0,0
240 PRINT " (";H;"WPM )"
250 PLAY C$(77,3):PLAY C$(80,3):PLAY C$(65,3):PLAY C$(73,3):PLAY C$(83,3)
260 TW=60/H   :REM'word time
270 SP=60/TW  :REM'WPM
280 RETURN
290 :REM'
300 :REM'.....title page
310 CLS
320 COLOR 15,2,1
330 PRINT " MORSE CODE TRAINER";TAB(57)"by George Murphy VE3ERP ";
340 COLOR 1,0:PRINT STRING$(80,223);
350 COLOR 7,0
360 GOSUB 2780  :REM'preamble
370 PRINT UL$;
380 COLOR 0,7:PRINT " Press number in < > for:":COLOR 7,0
390 PRINT "  < 1 > 523 Hz sidetone (musical note C)"
400 PRINT "  < 2 > 587 Hz sidetone (musical note D)"
410 PRINT "  < 3 > 659 Hz sidetone (musical note E)"
420 PRINT "  < 4 > 698 Hz sidetone (musical note F)"
430 PRINT "  < 5 > 784 Hz sidetone (musical note G)"
440 PRINT "  < 6 > 880 Hz sidetone (musical note A)"
450 PRINT "  < 7 > 988 Hz sidetone (musical note B)"
460 PRINT "  < 8 > Sidetone Generator schematic"
470 LOCATE ,2:COLOR 0,7:PRINT " < 0 > EXIT ";:COLOR 7,0
480 Q=42:LOCATE 13,Q:PRINT "╦"
490 LOCATE ,Q:PRINT "║ The program generates dits, dahs and"
500 LOCATE ,Q:PRINT "║ spaces as musical notes and rests.  "
510 LOCATE ,Q:PRINT "║ The notes and rests are played at   "
520 LOCATE ,Q:PRINT "║ the musical tempo relevant to the   "
530 LOCATE ,Q:PRINT "║ selected code speed.                "
540 LOCATE ,Q:PRINT "║                                     "
550 LOCATE ,Q:PRINT "║ Characters and spaces are thus      "
560 LOCATE ,Q:PRINT "║ formed precisely at all speeds.     "
570 LOCATE ,Q:PRINT "║                                     "
580 LOCATE ,Q:PRINT "║ Speeds selectable from 5.5/42.5 WPM."
590 PRINT UL$;
600 LOCATE ,Q:PRINT "╩";
610 K$=INKEY$:IF K$=""THEN 610
620 IF K$="0"THEN CLS:RUN EX$
630 :REM'IF K$="8"THEN CLS:GOTO 3290
635 IF K$="8"THEN CHAIN"CODOSC5"
640 Z=VAL(K$):K=Z
650 J=Z+98:IF J>103 THEN J=J-7
660 J$=CHR$(J)
670 IF Z>=1 AND Z<=9 THEN 700
680 GOTO 610
690 :REM'
700 :REM'.....start
710 CLS
720 GOSUB 3110  :REM'compile data array
730 GOSUB 180   :REM'set speed
740 PRINT
750 PRINT USING "The tone you just heard was selection no. # (### Hz)";K,TONE(K)
760 PRINT "Want to change tone?  ";:COLOR 0,7:PRINT " y/n ":COLOR 7,0
770 Z$=INKEY$:IF Z$=""THEN 770
780 IF Z$="y"THEN 300
790 IF Z$="n"THEN 880
800 GOTO 770
810 :REM'
820 :REM'.....new speed
830 CLS
840 INPUT" ENTER: New speed (max. 42.5 WPM, min. 5.5 WPM)....";H
850 IF H<5.5! OR H>42.5! THEN BEEP:GOTO 830
860 CLS:GOSUB 210:GOTO 880
870 :REM'
880 :REM'.....sub-menu
890 CLS
900 PRINT
910 PRINT " Time in Morse code is measured in bits. The duration of a dit (d";
920 PRINT "ot) element is"
930 PRINT " 1 bit, a dah (dash) element 3 bits, and separation between dit/d";
940 PRINT "ah elements 1 "
950 PRINT " bit. Space between characters is 3 bits, between words 7 bits. P";
960 PRINT "auses can be  "
970 PRINT " added to character and word spacing without changing the keying ";
980 PRINT "speed as a   "
990 PRINT " learning aid. Set the keying speed to the level you wish to atta";
1000 PRINT "in, set a     "
1010 PRINT " moderate pause factor and copy random code groups, gradually red";
1020 PRINT "ucing the pause";
1030 PRINT " factor until you can read the groups with a pause factor of zero."
1040 PRINT UL$;
1050 PRINT " Current: Keying ";
1060 COLOR 0,7:PRINT USING "###.# ";SP;
1070 COLOR 7,0:PRINT " WPM, pause factor ";
1080 COLOR 0,7:PRINT USING " ##.# ";VV;:COLOR 7,0
1090 PRINT ", sidetone frequency ";:COLOR 0,7:PRINT TONE(K);"Hz":COLOR 7,0
1100 GOTO 1280
1110 :REM'
1120 :REM'.....pause factor
1130 CLS
1140 PRINT " PAUSE FACTOR (also known as Farnsworth spacing, after Russ Farns";
1150 PRINT "worthth W6TTB)"
1160 PRINT UL$;
1170 PRINT " A factor of 0 introduces no additional pauses between characters ";
1180 PRINT "and words."
1190 PRINT " A factor of 0.25 inserts a very short additional pause."
1200 PRINT " A factor of 50 or more inserts a fairly long pause."
1210 PRINT
1220 PRINT " Current pause factor is";VV
1230 PRINT
1240 PRINT " You may select a factor of any value to suit your preference."
1250 PRINT
1260 INPUT " ENTER: New pause factor";VV:VV=ABS(VV):GOTO 880
1270 :REM'
1280 PRINT UL$;
1290 PRINT " Press number in < > to:"
1300 PRINT "  <1> Copy a message or series of characters"
1310 PRINT "  <2> Copy random 5-character groups"
1320 PRINT "  <3> Learn Morse characters"
1330 PRINT "  <4> Change Pause Factor"
1340 PRINT "  <5> Change keying speed (WPM)"
1350 PRINT "  <6> Change tone"
1360 PRINT "  <7> Read definition of code speed"
1370 PRINT "  <8> See table of Morse characters"
1380 PRINT "  <9> Return to main menu/Exit"
1390 PRINT UL$;
1400 Z$=INKEY$
1410 IF Z$="1"THEN 1520
1420 IF Z$="2"THEN 1940
1430 IF Z$="3"THEN 2630
1440 IF Z$="4"THEN 1120
1450 IF Z$="5"THEN 820
1460 IF Z$="6"THEN 300
1470 IF Z$="7"THEN 3770
1480 IF Z$="8"THEN 2430
1490 IF Z$="9"THEN 300
1500 GOTO 1400
1510 :REM'
1520 :REM'.....send characters
1530 CLS:FLAG=0  :REM'flag indicates no morse character in data base
1540 PRINT
1550 PRINT " ENTER MESSAGE or ENTER <0> to return to Menu"
1560 PRINT:PRINT "? ";
1570 COLOR 0,7:LINE INPUT Z$
1580 COLOR 7,0
1590 IF Z$="0"THEN 300
1600 PRINT
1610 PRINT " Press any key when ready to copy....."
1620 IF INKEY$=""THEN 1620 :ELSE CLS
1630 N=0
1640 T1=TIMER
1650 PRINT " ";
1660 FOR Z=1 TO LEN(Z$)
1670 Y=ASC(MID$(Z$,Z)):IF Y>96 AND Y<123 THEN Y=Y-32
1680 IF Y=32 THEN PLAY"p5":N=N+1:GOTO 1710
1690 PLAY C$(Y,3):N=N+1
1700 IF C$(Y,3)=""THEN PLAY C$(63,3):PRINT "≈";:FLAG=1:GOTO 1720
1710 PRINT CHR$(Y);
1720 FOR UU=1 TO SP*VV/10:PLAY"p60":NEXT UU :REM'timed pause
1730 NEXT Z:PRINT ""
1740 T2=TIMER:T=T2-T1:TT=T/60
1750 PRINT UL$;
1760 PRINT USING " Length of transmission..................... ####.# sec.";T;
1770 PRINT USING " = ##.### min.";TT
1780 PRINT USING " Keying speed............................... ####.# WPM ";H
1790 PRINT USING " Pause factor............................... ####.#";VV
1800 PRINT USING " No. of characters, including word spaces... ####.#";N
1810 CM=N/TT:SS=CM/5
1820 COLOR 0,7
1830 PRINT USING " Characters per minute...................... ####.#     ";CM
1840 PRINT USING "  Equivalent speed @ 5 characters per word.. ####.# WPM ";SS
1850 COLOR 7,0
1860 PRINT UL$;
1862 PRINT " Want to repeat the message?   (y/n)"
1863 Y$=INKEY$:IF Y$=""THEN 1863
1864 IF Y$="y"THEN CLS:GOTO 1600
1865 IF Y$="n"THEN 1870
1866 GOTO 1863
1870 IF FLAG=0 THEN 1920
1880 PRINT :PRINT " ≈ indicates no Morse equivalent in the data base for the ";
1890 PRINT "character entered."
1900 PRINT " (The data base includes only characters most commonly used in ";
1910 PRINT "Amateur radio)"
1920 GOTO 4140
1930 :REM'
1940 :REM'.....generate random groups
1950 INPUT " How many 5-character groups ......";N:N=CINT(N)
1960 IF Y=32 THEN PLAY"p5":GOTO 1710
1970 DIM A$(N*5+1)
1980 CLS:COLOR 7,0,0
1990 PRINT " Press any key when ready to copy....."
2000 IF INKEY$=""THEN 2000 :ELSE CLS
2010 RANDOMIZE TIMER
2020 LOCATE 12,27:COLOR 0,7:PRINT " Sending group #  1 of";N
2030 COLOR 7,0
2040 T1=TIMER  :REM'start time
2050 :REM'
2060 C=33
2070 FOR Z=1 TO N*5
2080 Y=INT(RND*100)
2090 IF Y=63 THEN 2120
2100 IF Y<44 OR Y>90 THEN Z=Z-1:GOTO 2190
2110 IF Y>57 AND Y<65 THEN Z=Z-1:GOTO 2190
2120 PLAY C$(Y,3):A$(Z)=C$(Y,1)
2130 IF C=43 THEN C=33
2140 C=C+2:LOCATE 10,C:PRINT A$(Z)+STRING$(8,32)
2150 IF Z/5=INT(Z/5)THEN PLAY"p5"
2160 ZZ=INT(1+(Z/5)):IF ZZ>N THEN ZZ=N
2170 LOCATE 12,43:COLOR 0,7:PRINT USING "### ";ZZ:COLOR 7,0
2180 FOR UU=1 TO SP*VV/10:PLAY"p60":NEXT UU :REM'timed pause
2190 NEXT Z
2200 CLS
2210 :REM'
2220 T2=TIMER  :REM'end time
2230 PRINT "This is what you just heard ( _ is a pause -∙∙∙- ):"
2240 PRINT UL$;
2250 FOR I=1 TO Z:PRINT A$(I);
2260 IF I/5=INT(I/5)THEN PRINT "   ";
2270 NEXT I:PRINT UL$;
2280 T=T2-T1:TT=T/60
2290 PRINT USING " Length of transmission................... ####.# sec.";T;
2300 PRINT USING " = ##.### min.";TT
2310 PRINT USING " Keying speed............................. ####.# WPM ";H
2320 PRINT USING " Pause factor............................. ####.#";VV
2330 W=N/TT
2340 PRINT USING " Actual speed: ### groups in ##.### min.   ####.# GPM";N,TT,W;
2350 PRINT " (Groups Per Minute)"
2360 COLOR 0,7:LOCATE ,2
2370 X=W*1.7999999523162842!
2380 PRINT USING " Equivalent speed ( ##.# x 80/50 )....... ####.# WPM ";W,X
2390 COLOR 7,0
2400 PRINT UL$;
2410 ERASE A$:GOTO 4140
2420 :REM'
2430 :REM'.....morse characters
2440 CLS:COLOR 7,0,0
2450 PRINT TAB(30)"MORSE CODE CHARACTERS"
2460 PRINT TAB(30)STRING$(21,205)
2470 PRINT TAB(26)CHR$(34);" _ ";CHR$(34);" (-∙∙∙-) denotes a pause"
2480 PRINT
2490 COLOR 0,7:PRINT " "+C$(63,1)+" =";:COLOR 15,0:PRINT C$(63,2),
2500 FOR Z=44 TO 90
2510 IF Z=48 OR Z=58 THEN PRINT
2520 IF Z>57 AND Z<65 THEN 2550
2530 IF C$(Z,1)=" *"THEN 2550
2540 COLOR 0,7:PRINT " "+C$(Z,1)+" =";:COLOR 15,0:PRINT C$(Z,2),
2550 NEXT Z
2560 COLOR 0,7:PRINT " "+C$(42,1);:COLOR 15,0:PRINT C$(42,2)
2570 COLOR 7:PRINT
2580 PRINT " There are several other Morse characters, but these are the ones";
2590 PRINT " most commonly"
2600 PRINT " used in amateur radio communication."
2610 GOSUB 4170:GOTO 880
2620 :REM'
2630 :REM'.....learn characters
2640 CLS:COLOR 7,0,0:PRINT :RANDOMIZE TIMER
2650 PRINT " Press 1 to copy a character or 0 to QUIT"
2660 Z$=INKEY$:IF Z$=""THEN 2660
2670 IF Z$="0"THEN 880
2680 IF Z$="1"THEN 2690 :ELSE 2660
2690 LOCATE CSRLIN-1:PRINT X$:LOCATE CSRLIN-1
2700 Y=INT(RND*100):IF Y<44 OR Y>90 THEN 2700
2710 IF Y>57 AND Y<65 THEN 2700
2720 PLAY C$(Y,3):PRINT" Press 2 to see what you heard"
2730 IF INKEY$="2"THEN 2740 :ELSE 2730
2740 LOCATE CSRLIN-1:PRINT X$:LOCATE CSRLIN-1
2750 PRINT " "+C$(Y,1)+" "+C$(Y,2)
2760 GOTO 2650
2770 :REM'
2780 :REM'.....preface
2790 T=7
2800 PRINT TAB(T);
2810 PRINT " This program can help you learn Morse code by the British military"
2820 PRINT TAB(T);
2830 PRINT "secret cipher system. Encoded messages were sent in cipher groups"
2840 PRINT TAB(T);
2850 PRINT "of 5 Morse characters. Operators had no way of knowing the meaning"
2860 PRINT TAB(T);
2870 PRINT "of the message, and were required only to copy each character"
2880 PRINT TAB(T);
2890 PRINT "exactly. There was no point in anticipating the next one or"
2900 PRINT TAB(T);
2910 PRINT "guessing one that had been missed, because they could be anything."
2920 PRINT TAB(T);
2930 PRINT " There may be easier methods of learning Morse, and some may even"
2940 PRINT TAB(T);
2950 PRINT "teach how to remember it after passing some required test. But as"
2960 PRINT TAB(T);
2970 PRINT "anyone who learned by the military 5-character group method knows,"
2980 PRINT TAB(T);
2990 PRINT "once learned by this method it will never be forgotten."
3000 RETURN
3010 :REM'
3020 :REM'.....data
3030 DATA 523,587,659,698,784,880,988
3040 DATA (Undefined)-(Undefined)-(Undefined),*,--(Undefined)(Undefined)--,-(Undefined)(Undefined)(Undefined)-,(Undefined)-(Undefined)-(Undefined)-,-(Undefined)(Undefined)-(Undefined),-----
3050 DATA (Undefined)----,(Undefined)(Undefined)---,(Undefined)(Undefined)(Undefined)--,(Undefined)(Undefined)(Undefined)(Undefined)-,(Undefined)(Undefined)(Undefined)(Undefined)(Undefined),-(Undefined)(Undefined)(Undefined)(Undefined),--(Undefined)(Undefined)(Undefined)
3060 DATA ---(Undefined)(Undefined),----(Undefined),*,*,*,*,*,(Undefined)(Undefined)--(Undefined)(Undefined),*,(Undefined)-,-(Undefined)(Undefined)(Undefined)
3070 DATA -(Undefined)-(Undefined),-(Undefined)(Undefined),(Undefined),(Undefined)(Undefined)-(Undefined),--(Undefined),(Undefined)(Undefined)(Undefined)(Undefined),(Undefined)(Undefined),(Undefined)---,-(Undefined)-,(Undefined)-(Undefined)(Undefined)
3080 DATA --,-(Undefined),---,(Undefined)--(Undefined),--(Undefined)-,(Undefined)-(Undefined),(Undefined)(Undefined)(Undefined),-,(Undefined)(Undefined)-,(Undefined)(Undefined)(Undefined)-
3090 DATA (Undefined)--,-(Undefined)(Undefined)-,-(Undefined)--,--(Undefined)(Undefined)
3100 :REM'
3110 :REM'.....compile data array
3120 RESTORE
3130 FOR Z=1 TO 7:READ TONE(Z):NEXT Z
3140 FOR Z=42 TO 90:C$(Z,1)=CHR$(Z):READ Z$:C$(Z,2)=" "+Z$
3150 IF Z$="*"THEN D$="":GOTO 3240
3160 L=LEN(Z$):D$=""
3170 FOR X=1 TO L
3180 M$=MID$(Z$,X,1)
3190 IF M$="∙"THEN N$=J$+"30p30"
3200 IF M$="-"THEN N$=J$+"10p30"
3210 D$=D$+N$
3220 NEXT X
3230 L=LEN(D$)-1:MID$(D$,L,1)="1"
3240 C$(Z,3)=D$
3250 NEXT Z
3260 C$(42,1)="END":C$(45,1)="_"
3270 RETURN
3280 :REM'
3290 :REM'.....schematic
3300 CLS:PRINT
3310 COLOR 7,0,0
3320 COLOR 0,7:T=20
3330 LOCATE ,T:PRINT "   S I D E T O N E    G E N E R A T O R   "
3340 LOCATE ,T:PRINT "                   R1        R2           "
3350 LOCATE ,T:PRINT "  + «───X────┬──┬─\/\/\──┬──\/\/\─┐       "
3360 LOCATE ,T:PRINT " DC 5-15v    │  │ ┌────┐ │        │       "
3370 LOCATE ,T:PRINT "  - «─┐      │  ├─┤4  7├─┘        │       "
3380 LOCATE ,T:PRINT "      │ 0.01═╪═ └─┤8  2├─┬────────┤       "
3390 LOCATE ,T:PRINT "      │      ├────┤1  6├─┘ R3    ═╪═ 0.01 "
3400 LOCATE ,T:PRINT "      X      ├──╫─┤5  3├──\/\/\───┤       "
3410 LOCATE ,T:PRINT "      │      │0.01└────┘   │    \\┴\\     "
3420 LOCATE ,T:PRINT "      │      │    NE 555  ═╪═ 0.1         "
3430 LOCATE ,T:PRINT "      │      │             └───X───» tone "
3440 LOCATE ,T:PRINT "      ├──────┴─────────────────X───» out  "
3450 LOCATE ,T:PRINT "      │   Key may be inserted at any      "
3460 LOCATE ,T:PRINT "    \\┴\\   of the points marked X        "
3470 COLOR 7,0
3480 PRINT
3490 T1=20:T2=29:T3=38:T4=47
3500 PRINT TAB(T1-1)"Tone(Hz)"TAB(T2+1)"R1"TAB(T3+1)"R2";
3510 PRINT TAB(T4)"R3 potentiometer"
3520 PRINT TAB(T1)" 587"TAB(T2)"8.2k"TAB(T3)"8.2k"TAB(T4)"10k audio taper"
3530 PRINT TAB(T1)" 707"TAB(T2)"6.8k"TAB(T3)"6.8k"TAB(T4)"10k audio taper"
3540 PRINT TAB(T1)" 893"TAB(T2)"5.6k"TAB(T3)"5.6k"TAB(T4)"10k audio taper"
3550 PRINT TAB(T1)"1023"TAB(T2)"4.7k"TAB(T3)"4.7k"TAB(T4)"10k audio taper"
3560 COLOR 15,1:LOCATE ,T1-1
3570 PRINT " Do you want to hear a tone sample?   (y/n) ":COLOR 7,0
3580 Z$=INKEY$:IF Z$=""THEN 3580
3590 IF Z$="n"OR Z$="y"THEN LOCATE CSRLIN-1:PRINT STRING$(80,32);
3600 IF Z$="n"THEN 3710
3610 IF Z$="y"THEN 3640
3620 GOTO 3580
3630 :REM'
3640 LOCATE CSRLIN-1,T1+7:COLOR 15,1
3650 INPUT " ENTER: Frequency in Hz...";I:COLOR 7,0
3660 IF I<37 THEN 3710
3670 LOCATE CSRLIN-1:PRINT STRING$(80,32);
3680 SOUND I,20
3690 LOCATE CSRLIN-1:GOTO 3560
3700 :REM'
3710 LOCATE CSRLIN-1,2
3720 PRINT "Use HAMCALC's '555 TIMER' program to determine values of R1/R2 for";
3730 PRINT " other tones.";
3740 GOSUB 4170:GOTO 300
3750 END
3760 :REM'
3770 :REM'.....definition
3780 CLS:PRINT " DEFINITION of CODE SPEED"
3790 PRINT UL$;
3800 PRINT " The basic unit of time in Morse code is the ";CHR$(34);"bit";
3810 PRINT CHR$(34);" whereby the duration of a:"
3820 PRINT "   1) dit (dot) element is 1 bit."
3830 PRINT "   2) dah (dash) element is 3 bits."
3840 PRINT "   3) space between elements in the same character is 1 bit."
3850 PRINT "   4) space between characters is 3 bits."
3860 PRINT "   5) space between words or groups of characters is 7 bits."
3870 PRINT
3880 PRINT " By tradition, code speed is measured in WPM (words per minute). ";
3890 PRINT "Statistically:"
3900 PRINT
3910 PRINT " The average plain-language English word is 50 bits long, includi";
3920 PRINT "ng the space  "
3930 PRINT " between words. The words PARIS and MORSE are of this length. By ";
3940 PRINT "definition,   "
3950 PRINT " the speed in WPM is the number of 50-bit groups signalled in one";
3960 PRINT " minute.      "
3970 PRINT
3980 PRINT " The average 5-character random-letter group is 60 bits long, inc";
3990 PRINT "luding the    "
4000 PRINT " space between groups. The letter group CODEX is of this length. ";
4010 PRINT "The eqivalent "
4020 PRINT " speed in WPM is 1.2 x the number of 60-bit groups signalled in o";
4030 PRINT "ne minute.    "
4040 PRINT
4050 PRINT " The average 5-character random-letter, number and punctuation gr";
4060 PRINT "oup, including"
4070 PRINT " the space between groups, is 80 bits long. The equivalent speed ";
4080 PRINT "in WPM is     "
4090 PRINT " 1.6 x the number of 80-bit groups signalled in one minute.      "
4100 PRINT
4110 PRINT " ref: The 1989 ARRL Handbook for the Radio Amateur, p.19-4";
4120 GOTO 4140
4130 :REM'
4140 :REM'.....end
4150 GOSUB 4170:CLS:GOTO 880
4160 :REM'
4170 :REM'PRT
4180 KEY OFF:GOSUB 4250:LOCATE 25,5:COLOR 0,2
4190 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4200 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4210 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4210 :ELSE GOSUB 4250
4220 IF Z$="3"THEN RETURN
4230 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4240 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4180
4250 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
