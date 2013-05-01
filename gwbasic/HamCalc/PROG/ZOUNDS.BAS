10 :REM'ZOUNDS - Audio PROGRAMS - 15 OCT 86 rev. 01 DEC 2009
20 IF EX$=""THEN EX$="EXIT"
25 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
30 PROG$="zounds"
40 COMMON EX$,PROG$
50 CLS:KEY OFF
60 COLOR 7,0,0
70 DIM W$(12,2)     :REM'frequency chart variables
80 DIM N$(12)       :REM'names of notes e.g. A,A# etc.
90 DIM C$(9)        :REM'names of chords
100 DIM AB$(255,2)   :REM'keyboard variables
110 DIM X(9)         :REM'fret locations for guitar tuner graphics
120 DIM Q$(8)        :REM'menu lines for guitar tuner
130 DIM A$(21)       :REM'keyboard variables
140 DIM B$(21)       :REM'keyboard variables
150 D$=" Hz."
160 Q$="º"      :REM'symbol for flat - chr$(167)
170 U$="###,###.###"
180 UL$=STRING$(80,205)
190 LU$=STRING$(80,"▀")
200 E$=STRING$(80,32)
210 GOSUB 4660               :REM'load variables from data
220 LOCATE ,,0  :REM'cursor off
230 :REM'
240 :REM'.....mathematical formulae
250 I=0.5!        :REM'Increment for halftone
260 LF=0.4342944920063019! :REM'Log conversion factor to base 10 = 1/log(10)
270 Z=LOG(I)*LF :REM'Octave factor (Z= -.3010301)
280 N=12        :REM'12 notes (halftones) per octave
290 U=10^(Z/N)  :REM'Halftone increment multiplier (U=.9438742)
300 A=440       :REM'Standard Pitch in Hz. for middle A
310 X=A*U^9     :REM'Middle C (Start of Octave 4) 9th note below middle A (261.6254)
320 Y=A/U^3     :REM'High C   (Start of Octave 5) 3rd note above middle A (523.2512)
330 SS=335280.0!  :REM'Speed of sound in mm/sec. (1100 ft./sec.,750 m.p.h.)
340 :REM'
350 COLOR 15,2
360 PRINT " ZOUNDS OF MUSIC";TAB(57)"by George Murphy VE3ERP ";
370 COLOR 1,0:PRINT STRING$(80,223);
380 COLOR 7,0
390 PRINT " A PROGRAM FOR MUSICIANS, AUDIO ENGINEERS AND CONFIRMED TINKERERS"
400 PRINT UL$;
410 PRINT " NOTE: In the following programs the symbol º denotes flat, e.g. ";
420 PRINT "Dº,Eº,Gº,Aº,Bº"
430 PRINT " for the musical notes D-flat, E-flat, G-flat, A-flat and B-flat."
440 PRINT
450 PRINT " Sharps are denoted by the standard # symbol, e.g. C#,D#,F#,G#,A#"
460 PRINT UL$;
470 PRINT " Press letter in < > to:"
480 PRINT UL$;
490 PRINT "   < a >  Generate audio tones"
500 PRINT "   < b >  Test your ear/hand coordination"
510 PRINT "   < c >  List frequencies of musical tones"
520 PRINT "   < d >  Calculate fret locations for stringed instruments"
530 PRINT "   < e >  Analyze a musical tone"
540 PRINT "   < f >  Analyze an audio frequency or wavelength"
550 PRINT "   < g >  Analyze chords"
560 PRINT "   < h >  Tune your guitar"
570 PRINT "   < i >  Fool around on a Keyboard"
580 PRINT "   < j >  Linkwitz Speaker Equalizer"
590 PRINT "   < k >  EXIT"
600 I$=INKEY$:IF I$=""THEN 600
610 IF ASC(I$)>=97 AND ASC(I$)<=106 THEN CLS
620 IF I$="a"THEN 4170
630 IF I$="b"THEN 3700
640 IF I$="c"THEN 1930
650 IF I$="d"THEN 750
660 IF I$="e"THEN 1090
670 IF I$="f"THEN 1270
680 IF I$="g"THEN 2810
690 IF I$="h"THEN 2370
700 IF I$="i"THEN 3360
710 IF I$="j"THEN CHAIN"\hamcalc\prog\speakr"
720 IF I$="k"THEN CLS:RUN GO$
730 GOTO 600
740 :REM'
750 :REM'......location of frets
760 CLS
770 COLOR 15,2:PRINT " LOCATIONS OF FRETS "
780 COLOR 1,0:PRINT LU$;
790 COLOR 7,0
800 PRINT " For dimensions in centimetres ..... press 1"
810 PRINT " For dimensions in inches .......... press 2"
820 Z$=INKEY$:IF Z$=""THEN 820
830 IF Z$="1"THEN D$="(cm.)"
840 IF Z$="2"THEN D$="(in.)"
850 PRINT " ENTER: Length of string, nut to bridge. ..........";D$;
860 INPUT L:IF Z$="1"THEN L=L/2.5399999618530273!
870 CLS
880 W=22
890 PRINT " Location"TAB(12)"│NF in.│NF cm.║FB in.│FB cm.│"
900 FOR Z=0 TO W
910 S=L-L*U^Z
920 IF Z<10 THEN Z$=" ":ELSE Z$=""
930 PRINT " Fret #";Z$;Z;
940 PRINT USING "│###.##│####.#║###.##│####.#│";S,S*2.5399999618530273!,L-S,(L-S)*2.5399999618530273!;
950 PRINT SPC(10)"│";
960 IF Z=0 THEN LOCATE CSRLIN,2:PRINT "Nut       ":LOCATE CSRLIN-1
970 IF Z<22 THEN PRINT ""
980 NEXT Z
990 LOCATE 1,42:PRINT "NF=nut to fret, FB=fret to bridge"
1000 LOCATE 2,49:PRINT "«─┐"
1010 LOCATE 14,41:PRINT "«─octave"
1020 LOCATE 12,53:PRINT "LOCATIONS of FRET or"
1030 LOCATE 13,53:PRINT "FINGER POSITIONS for"
1040 LOCATE 14,53:PRINT "NUT to BRIDGE DISTANCE"
1050 LOCATE 15,53:PRINT USING "of ###.## in (####.# cm)";L,L*2.5399999618530273!;
1060 LOCATE 24,49:PRINT "«─┘";
1070 GOTO 4620
1080 :REM'
1090 :REM'.....analyze note
1100 CLS
1110 COLOR 15,2:PRINT " ANALYSIS OF A MUSICAL TONE "
1120 COLOR  1,0:PRINT LU$;
1130 COLOR 7,0
1140 K=0:Z=0
1150 INPUT " ENTER: Note (add - if flat, + if sharp, e.g A-, A+ ) .......";N$
1160 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1170 Z=ASC(N$):IF Z>96 AND Z<104 THEN MID$(N$,1)=CHR$(Z-32)
1180 IF RIGHT$(N$,1)="+"THEN N$=LEFT$(N$,1)+"#"
1190 IF RIGHT$(N$,1)="-"THEN N$=CHR$(ASC(LEFT$(N$,1))-1)+"#"
1200 IF LEN(N$)=1 THEN N$=N$+" "
1210 IF N$="@#"THEN N$="G#"
1220 FOR P=1 TO 12:IF N$=LEFT$(N$(P),2) THEN W=Y*U^(13-P):GOTO 1610 :REM'print table
1230 NEXT P:BEEP:PRINT " There is no such note as ";N$:GOTO 4620
1240 NEXT Z
1250 GOTO 4620     :REM'end
1260 :REM'
1270 :REM'.....analyze frequency
1280 CLS
1290 COLOR 15,2:PRINT " FREQUENCY ANALYSIS "
1300 COLOR 1,0:PRINT LU$;
1310 COLOR 7,0
1320 PRINT" (Press <ENTER> if you wish to enter wavelength)"
1330 PRINT
1340 INPUT " Frequency (Hz.) if known ...";F
1350 IF F THEN 1410
1360 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1370 INPUT " Wavelength (cm) in air, if known ...";F:F=F*10
1380 IF F<>0 THEN F=SS/F
1390 IF F THEN 1410
1400 GOTO 1340
1410 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1420 A=F
1430 YY=LOG(F/X):ZZ=LOG(2)
1440 V=INT(YY/ZZ):W=F/2^V:T=X*SQR(U)    :REM'W=HALFTONE, T=QUARTERTONE
1450 FOR P=12 TO 1 STEP-1
1460  T=T/U:N$=N$(P)
1470  IF W>=T THEN 1540
1480  Z=F:GOSUB 1830
1490  PRINT TAB(4)" Frequency =";TAB(19)USING U$;Z;:PRINT D$;
1500  GOSUB 1850:COLOR 0,7:LOCATE CSRLIN,4
1510  PRINT " Nearest musical tone is highlighted in the table below "
1520  COLOR 7,0
1530  GOTO 1570
1540 NEXT P
1550 GOTO 1480
1560 :REM'
1570 FOR J=1 TO 12:IF N$(J)=N$ THEN W=Y*U^J:GOTO 1610
1580 NEXT J
1590 END
1600 :REM'
1610 :REM'.......print table
1620 V=V+1
1630 Z=W:GOSUB 1830
1640 PRINT "    Middle ";N$;" =";TAB(19)USING U$;Z;:PRINT D$;:A=W:GOSUB 1850
1650 LOCATE CSRLIN-1,65:PRINT "( Octave 4 )    ";
1660 PRINT UL$;
1670 W=W/2^4:COL=0
1680 FOR V=-4 TO 12
1690 IF V<10 THEN  C$=" ":ELSE C$=""
1700 Z1=W*2^V:Z2=W*2^(V+1):Z3=(Z1+Z2)/2
1710 IF I$="e" AND V=4 THEN COLOR 0,15:GOTO 1750
1720 IF COL=1 THEN COLOR 0,15:COL=0:GOTO 1750
1730 IF I$="f"AND F>=Z1 AND F<Z3 THEN COLOR 0,15
1740 IF I$="f"AND F>Z3 AND F<=Z2 THEN COL=1
1750 PRINT " Octave";C$;V;N$;" =";TAB(19)USING U$;Z1;:PRINT D$;
1760 A=Z1:GOSUB 1850
1770 COLOR 7,0:NEXT V
1780 PRINT UL$;
1790 LOCATE 1,41:PRINT "The symbol º denotes flat"
1800 LOCATE 24,1
1810 GOTO 4620      :REM'end
1820 :REM'
1830 IF Z<0.0010000000474974513! THEN Z=0:RETURN
1840 Z=INT(1000*Z+0.5!)/1000:RETURN
1850 R$="m":Z=SS/A:IF Z<0.0010000000474974513! THEN 1890
1860 IF Z>=10 THEN Z=Z/10:R$="c"
1870 IF Z>=100 THEN Z=Z/100:R$=""
1880 GOSUB 1830
1890 PRINT TAB(38)"Wavelength =";USING U$;Z;:PRINT" ";R$;"m ";
1900 IF V=4 THEN PRINT"(middle octave)":ELSE PRINT ""
1910 RETURN
1920 :REM'
1930 :REM'.....musical scale
1940 CLS
1950 COLOR 15,2:PRINT " FREQUENCIES (Hz.) of MUSICAL TONES "
1960 COLOR 1,0:PRINT LU$;
1970 COLOR 7,0
1980 PRINT " The symbol ";:COLOR 15:PRINT "º";:COLOR 7:PRINT " signifies flat.";
1990 PRINT "   Octave 4 is the range from middle C to middle B";
2000 PRINT TAB(6)"Frequencies are rounded off. ";
2010 PRINT "Use other programs for more exact figures.";
2020 PRINT UL$;
2030 LOCATE CSRLIN-1,7:PRINT "╤"
2040 FOR P=1 TO 12
2050 W$(P,1)=N$(P)
2060 W$(P,2)=STR$(Y*U^(13-P)/16)
2070 NEXT P
2080 PRINT TAB(7);"│";TAB(40);"OCTAVE"
2090 PRINT " Note │";TAB(40);"──────"
2100 PRINT "      │";
2110 FOR Z=-1 TO 10                     :REM'print column headings (octaves)
2120  COLOR 7,0:IF Z=4 THEN COLOR 15,0
2130  PRINT USING "######";Z;
2140 NEXT Z
2150 PRINT UL$;
2160 LOCATE CSRLIN-1,7:PRINT "╪"
2170 FOR Z=1 TO 12                               :REM'print rows
2180  PRINT " ";W$(Z,1);TAB(7);"│";              :REM'key
2190   FOR P=-1 TO 10                            :REM'columns
2200   Q=VAL(W$(Z,2))*2^P
2210   IF Q>27.489999771118164! AND Q<4186.10009765625! THEN COLOR 15,1 :ELSE COLOR 7,0
2220   IF Q<100 THEN V$="####.#":ELSE V$="######"
2230   PRINT USING V$;Q;
2240 :REM'  PLAY"mbo3t255l64ml"
2250 :REM'  PLAY LEFT$(W$(Z,1),2)
2260  NEXT P
2270  PRINT ""
2280 NEXT Z
2290 PRINT "      │";
2300 PRINT TAB(14);:COLOR 15,1
2310 PRINT " Highlighted notes are the notes on a standard 88 key piano."
2320 COLOR 7,0
2330 PRINT UL$;
2340 LOCATE CSRLIN-1,7:PRINT "╧"
2350 GOTO 4620
2360 :REM'
2370 :REM'.....tune guitar
2380 CLS
2390 COLOR 15,2:PRINT " GUITAR TUNER "
2400 COLOR 1,0:PRINT LU$;
2410 COLOR 7,0
2420 PLAY"ml"
2430 FOR Z=7 TO 17 STEP 2
2440 LOCATE Z:PRINT TAB(11)STRING$(68,45)
2450 NEXT Z
2460 FOR Z=1 TO 9
2470  FOR Y=7 TO 17
2480   LOCATE Y,X(Z):PRINT "█"                :REM'print frets
2490  NEXT Y
2500 NEXT Z
2510 GOSUB 2530:GOTO 2590
2520 :REM'
2530 FOR Z=1 TO 8
2540 LOCATE(2*Z+5),1
2550 PRINT " ";Q$(Z);
2560 NEXT Z
2570 RETURN
2580 :REM'
2590 COLOR 15,3
2600 LOCATE 4,6:PRINT " Press number in ( ) to tune a string or stop program: "
2610 COLOR 7,0
2620 Z$=INKEY$
2630 Z=VAL (Z$):IF Z<1 OR Z>8 THEN 2620
2640 LOCATE 4:PRINT E$;
2650 IF Z=1 THEN M$="o3e"
2660 IF Z=2 THEN M$="o2b"
2670 IF Z=3 THEN M$="o2g"
2680 IF Z=4 THEN M$="o2d"
2690 IF Z=5 THEN M$="o1a"
2700 IF Z=6 THEN M$="o1e"
2710 IF Z=7 THEN 2460
2720 IF Z=8 THEN 4640
2730 LOCATE Z*2+5:COLOR 15,0:PRINT " ███"
2740 COLOR 15,3
2750 LOCATE 4,6:PRINT " Press another number to continue...."
2760 COLOR 7,0
2770 PLAY M$
2780 Z$=INKEY$
2790 IF Z$=""THEN 2770 :ELSE COLOR 7,0:GOSUB 2530:GOTO 2630
2800 :REM'
2810 :REM'.....chords
2820 CLS
2830 COLOR 15,2:PRINT " CHORD STRUCTURE "
2840 COLOR 1,0:PRINT LU$;
2850 COLOR 7,0
2860 A=0
2870 PLAY"o2"
2880 PRINT " Press letter in < > for desired key.....( º denotes flat ):"
2890 PRINT UL$;
2900 FOR Z=1 TO 12:PRINT TAB(18);"<";CHR$(Z+103);">  ";N$(Z):NEXT Z
2910 Z$=INKEY$:IF Z$=""THEN 2910
2920 Z=ASC(Z$):IF Z<104 OR Z>115 THEN 2910
2930 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2940 :REM'
2950 N=Z-103
2960 PRINT " CHORDS IN THE KEY OF ";N$(N)
2970 PRINT UL$;
2980 PRINT " Press number in ( ) for desired chord:"
2990 PRINT UL$;
3000 FOR Z=1 TO 9
3010 CH$(Z)=N$(N)+" "+C$(Z)
3020 PRINT TAB(17);"(";Z;")  ";CH$(Z)
3030 NEXT Z
3040 Z$=INKEY$:X=VAL (Z$):IF X=0 THEN 3040
3050 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
3060 CH$=CH$(X)
3070 PRINT " The notes in ";CH$;" are.....( º signifies flat ):"
3080 PRINT UL$;
3090 IF X=1 THEN A=1:B=5:C=8:D=1 :E=0:P$="ceg>c"     :REM'maj
3100 IF X=2 THEN A=1:B=5:C=8:D=10:E=1:P$="cega>c"    :REM'6
3110 IF X=3 THEN A=1:B=5:C=8:D=11:E=1:P$="cegb->c"   :REM'7
3120 IF Y=13 THEN Z$=STRING$(3,"_"):ELSE Z$=STRING$(3," ")
3130 IF X=4 THEN A=1:B=5:C=8:D=12:E=1:P$="cegb>c"    :REM'maj 7
3140 IF X=5 THEN A=1:B=4:C=7:D=10:E=1:P$="ce-g-a>c"  :REM'dim
3150 IF X=6 THEN A=1:B=5:C=9:D=1 :E=0:P$="ceg+>c"    :REM'aug
3160 IF X=7 THEN A=1:B=4:C=8:D=1 :E=0:P$="ce-g>c"    :REM'min
3170 IF X=8 THEN A=1:B=4:C=8:D=10:E=1:P$="ce-ga>c"   :REM'min 6
3180 IF X=9 THEN A=1:B=4:C=8:D=11:E=1:P$="ce-gb->c"  :REM'min 7
3190 Q(1)=N-1+A:IF Q(1)>12 THEN Q(1)=Q(1)-12
3200 Q(2)=N-1+B:IF Q(2)>12 THEN Q(2)=Q(2)-12
3210 Q(3)=N-1+C:IF Q(3)>12 THEN Q(3)=Q(3)-12
3220 Q(4)=N-1+D:IF Q(4)>12 THEN Q(4)=Q(4)-12
3230 Q(5)=N-1+E:IF Q(5)>12 THEN Q(5)=Q(5)-12
3240 IF E=0 THEN Q(5)=0       :REM'triad
3250 FOR Z=1 TO 5
3260 COLOR 15,4
3270 PRINT " ";N$(Q(Z)),
3280 NEXT Z
3290 COLOR 7,0:PRINT UL$;
3300 PRINT " To stop music press any key."
3310 PRINT " The music will stop when the chord being played is finished."
3320 PLAY"L4o2":PLAY P$
3330 IF INKEY$=""THEN 3320
3340 GOTO 4640
3350 :REM'
3360 :REM'.....keyboard
3370 CLS
3380 COLOR 15,2:PRINT " ELECTRONIC KEYBOARD "
3390 COLOR 1,0:PRINT LU$;
3400 COLOR 7,0
3410 COLOR 0,7
3420 RO=5    :REM'row
3430 CO=16   :REM'column
3440 LOCATE RO+0,CO:PRINT"│  ▐█▌ ▐█▌  │  ▐█▌ ▐█▌ ▐█▌  │  ▐█▌ ▐█▌  │  ▐█▌ ▐█"
3450 LOCATE RO+1,CO:PRINT"│  ▐█▌ ▐█▌  │  ▐█▌ ▐█▌ ▐█▌  │  ▐█▌ ▐█▌  │  ▐█▌ ▐█"
3460 LOCATE RO+2,CO:PRINT"│  ▐2▌ ▐3▌  │  ▐5▌ ▐6▌ ▐7▌  │  ▐9▌ ▐0▌  │  ▐=▌ ▐█"
3470 LOCATE RO+3,CO:PRINT"│  ▐█▌ ▐█▌  │  ▐█▌ ▐█▌ ▐█▌  │  ▐█▌ ▐█▌  │  ▐█▌ ▐█"
3480 LOCATE RO+4,CO:PRINT"│   │   │   │   │   │   │   │   │   │   │   │   │"
3490 LOCATE RO+5,CO:PRINT"│ q │ w │ e │ r │ t │ y │ u │ i │ o │ p │ [ │ ] │"
3500 LOCATE RO+6,CO:PRINT"┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴"
3510 LOCATE RO+7,CO:PRINT"  C   D   E   F   G   A   B   C   D   E   F   G  "
3520 LOCATE RO+2,CO-10:PRINT " Rest: [1]"
3530 LOCATE RO+10
3540 COLOR 7,0
3550 PRINT " To play a note, press the number/letter ";
3560 PRINT "on any piano key in the diagram."
3570 PRINT
3580 PRINT " To play a rest press [1]."
3590 PRINT
3600 PRINT " To return to menu press SPACE BAR "
3610 PLAY"t255L64ml"
3620 FOR Z=1 TO 21:A=ASC(A$(Z)):AB$(A,2)=B$(Z):NEXT Z
3630 Z$=INKEY$:IF Z$=""THEN 3630
3640 IF Z$=" "THEN 4640
3650 A=ASC(Z$)
3660 Q$=INKEY$:IF Q$=""THEN PLAY AB$(A,2):GOTO 3660
3670 Z$=Q$:GOTO 3640
3680 PLAY AB$(A,2):GOTO 3630
3690 :REM'
3700 :REM'.....continuous range of tones
3710 CLS
3720 COLOR 15,2:PRINT " CONTINUOUS RANGE OF TONES "
3730 COLOR 1,0:PRINT LU$;
3740 COLOR 7,0
3750 GOSUB 4490
3760 PRINT UL$;
3770 PRINT " Where the tone stops is where your hand caught up with your ear!"
3780 PRINT " .....press any key to start....."
3785 PRINT " .....PRESS ANY KEY as soon as you hear a tone!"
3790 Z$=INKEY$:IF Z$=""THEN 3790
3800 X=30000
3810 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
3820 :REM'
3830 :REM'.....start tone
3840 LOCATE 5:PRINT " Press any key to halt"
3850 LOCATE 3:PRINT " Audio frequency (Hz.)="
3860 N=X/10:A=EXP(LOG(37/X)/N)
3870  FOR Z=1 TO N STEP 15
3880   IF INKEY$<>""THEN 3980
3890   Y=X*A^Z
3900   LOCATE 3,24:PRINT CINT(Y)
3910   SOUND Y,1
3920  NEXT Z
3930   LOCATE 3,24:PRINT " 37"
3940   SOUND 37,25
3950 PRINT
3960 PRINT " THAT's as low as the computer goes!":PRINT:GOTO 4080
3970 :REM'
3980 SOUND Y,25    :REM'sustain tone for short time
3990 LOCATE 5,1
4000 PRINT " Press <1> to continue"
4010 PRINT
4020 PRINT " Press <0> to quit    "
4030 Y$=INKEY$
4040 IF Y$="1"OR Y$="0"THEN VIEW PRINT 4 TO 24:CLS:VIEW PRINT
4050 IF Y$="1"THEN X=Y:GOTO 3840
4060 IF Y$="0"THEN LOCATE 5:GOTO 4080
4070 GOTO 4030
4080 PRINT " Press <1> to run again"
4090 PRINT
4100 PRINT " Press <0> to return to menu"
4110 Z$=INKEY$
4120 IF Z$="1"THEN 3710
4130 IF Z$="0"THEN 4640
4140 IF Y=37 THEN SOUND Y,3
4150 GOTO 4110
4160 :REM'
4170 :REM'.....tone generator
4180 CLS
4190 COLOR 15,2:PRINT " TONE GENERATOR "
4200 COLOR 1,0:PRINT LU$;
4210 COLOR 7,0
4220 GOSUB 4490     :REM'warning
4230 PRINT UL$;
4240 GOTO 4300
4250 :REM'
4260 INPUT "     ENTER: Frequency in Hz (between 37 Hz and 32,767 Hz)=";F
4270 IF F>=37 AND F<=32767 THEN RETURN
4280 BEEP:LOCATE CSRLIN-1:PRINT E$;:LOCATE CSRLIN-1:GOTO 4260
4290 :REM'
4300 GOSUB 4260:F1=F:F2=F
4310 PRINT:PRINT "     Do you want to generate a second tone?  (y/n)"
4320 Z$=INKEY$:IF Z$="n"THEN 4350
4330 IF Z$="y"THEN PRINT:GOSUB 4260:F2=F:GOTO 4350
4340 GOTO 4320
4350 FOR Z=3 TO CSRLIN-1:LOCATE Z:PRINT E$;:NEXT Z:LOCATE 3
4360 IF F1=F2 THEN Z$="":ELSE Z$="1"
4370 PRINT "     Tone ";Z$;" =";F1;"Hz."
4380 IF F2=F1 THEN 4410
4390 PRINT "     Tone ";"2 =";F2;"Hz."
4400 LOCATE CSRLIN-1,25:PRINT "Tones are at 1/2 Second intervals"
4410 PRINT UL$;
4420 PRINT "     Press any key to stop....."
4430 Z$=INKEY$
4440 IF Z$<>""THEN 4640
4450 SOUND F1,9.100001335144043!
4460 SOUND F2,9.100001335144043!
4470 GOTO 4430
4480 :REM'
4490 :REM'.....warning
4500 COLOR 12,0:T=6
4510 PRINT TAB(T);
4520 PRINT "WARNING! If you can't hear some of the high frequency tones you"
4530 PRINT TAB(T);
4540 PRINT "generate don't blame your computer - it's probably because you are"
4550 PRINT TAB(T);
4560 PRINT "either getting long in the tooth or have spent too much of your"
4570 PRINT TAB(T);
4580 PRINT "mis-spent youth listening to cranked-up Rock'n'Roll."
4590 COLOR 7,0
4600 RETURN
4610 :REM'
4620 :REM'.....end
4630 GOSUB 4860
4640 CLS:ERASE W$,N$,C$,AB$,X,Q$,A$,B$:RESTORE:GOTO 350
4650 :REM'
4660 :REM'.....data
4670 DATA "C ","C#/Dº","D ","D#/Eº","E ","F "
4680 DATA "F#/Gº","G ","G#/Aº","A ","A#/Bº","B "
4690  FOR Z=1 TO 12:READ N$(Z):NEXT Z               :REM'names of keys
4700 :REM'
4710 DATA maj,6,7,maj 7,dim,aug,min,min 6,min 7
4720  FOR Z=1 TO 9:READ C$(Z):NEXT Z                :REM'names of chords
4730 :REM'
4740 DATA 10,11,23,34,44,53,61,68,74
4750  FOR Z=1 TO 9:READ X(Z):NEXT Z                 :REM'location of frets
4760 :REM'
4770 DATA (1)  E,(2)  B,(3)  G,(4)  D,(5)  A,(6)  E,(7)  Stop sound,(8)  EXIT
4780  FOR Z=1 TO 8:READ Q$(Z):NEXT Z                :REM'guitar strings menu
4790 :REM'
4800 DATA q,o2c,2,o2c+,w,o2d,3,o2d+,e,o2e,r,o2f,5,o2f+,t,o2g,6,o2g+,y,o2a
4810 DATA 7,o2a+,u,o2b,i,o3c,9,o3c+,o,o3d,0,o3d+,p,o3e,[,o3f,=,o3f+,],o3g
4820 DATA " ",p64
4830  FOR Z=1 TO 21:READ A$(Z),B$(Z):NEXT Z         :REM'keyboard notes
4840 RETURN
4850 :REM'
4860 :REM'PRT
4870 KEY OFF:GOSUB 4940:LOCATE 25,5:COLOR 0,2
4880 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
4890 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
4900 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 4900 :ELSE GOSUB 4940
4910 IF Z$="3"THEN RETURN
4920 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
4930 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 4870
4940 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
