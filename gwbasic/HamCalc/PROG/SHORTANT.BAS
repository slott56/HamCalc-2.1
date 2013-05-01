10 :REM'SHORTANT - Short Off-Centre Loaded Dipole -  25 JAN 94 rev. 09 FRB 2006
20 IF EX$=""THEN EX$="EXIT"
30 PROG$="shortant"
40 COMMON EX$,PROG$,U,UH,LX,FQ,DIA
50 COLOR 7,0,0:CLS:KEY OFF
60 DIM GA(40)    :REM'AWG sizes
70 DIM L(9)
80 PI=4*ATN(1)
90 UL$=STRING$(80,205)
100 :REM'
110 :REM'.....AWG sizes
120 K=(0.46000000834465027!/0.004999999888241291!)^(1/39)  :REM'increment multiplier
130  FOR Z=1 TO 40
140   N=Z+3
150   GA(Z)=0.46000000834465027!/K^N
160  NEXT Z
170 :REM'
180 :REM'.....start
190 CLS
200 COLOR 7,0,1
210 COLOR 15,2
220 PRINT " SHORT OFF-CENTRE-LOADED DIPOLE";
230 PRINT TAB(57)"by George Murphy VE3ERP ";
240 COLOR 1,0:PRINT STRING$(80,223);
250 COLOR 7,0
260 IF LX THEN 270 :ELSE 300
270 PRINT " The current predetermined data are for an antenna length of"
280 PRINT USING "####.### ft. (###.## m.)";LX,LX*0.30480000376701355!
290 GOTO 330
300 IF UH=0 AND U<>0 THEN UH=U
310 IF UH THEN 370 :REM'skip preface
320 GOSUB 3250     :REM'preface
330 PRINT
340 GOSUB 3120
350 PRINT UL$;
360 :REM'
370 PRINT  " Press number in < > to:"
380 PRINT UL$;
390 PRINT "      < 1 > RUN program"
400 IF UH=0 THEN 440
410 PRINT "      < 2 > Design an AIR-CORE INDUCTOR for antenna just designed"
420 PRINT "      < 3 > SELECT a commercial inductor for antenna just designed"
430 PRINT UL$;
440 PRINT "      < 0 > EXIT"
450 PRUN=0
460 Z$=INKEY$
470 IF Z$=""THEN 460
480 IF Z$="0"THEN CLS:RUN EX$
490 IF Z$="1"THEN M=0:UH=0:F=0:D=0:LG=0:BB=0:W=0:DIA=0:V$="":GOTO 530
500 IF Z$="2"THEN CLS:CHAIN"coildsgn"
510 IF Z$="3"THEN U=UH:CLS:CHAIN "aircore"
520 :REM'
530 :REM'.....preamble
540 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
550 IF BB THEN 640
560 PRINT " Press number in < > to choose standard units of measure:"
570 PRINT UL$;
580 PRINT "  < 1 >  Metric"
590 PRINT "  < 2 >  U.S.A./Imperial"
600 Z$=INKEY$
610 IF Z$="1"THEN UM=0.30480000376701355!:UM$=" m.":GOTO 640
620 IF Z$="2"THEN UM=1:UM$=" ft.":GOTO 640
630 GOTO 600
640 IF M THEN 710
650 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
660 GOSUB 2600      :REM'text
670 GOSUB 3370      :REM'screen dump
680 PRINT UL$;
690 COLOR 7,0,0
700 :REM'
710 :REM'.....diagram
720 CLS
730 T=11    :REM'tab
740 COLOR 0,7
750 LOCATE,T:PRINT"                    SHORT OFF-CENTRE LOADED DIPOLE         "
760 LOCATE,T:PRINT" │«───────────────────────── A ─────────────────────────»│ "
770 LOCATE,T:PRINT" │«────────── A/2 ──────────»│«────────── A/2 ──────────»│ "
780 LOCATE,T:PRINT" │«─── C ───»│«───── B ─────»│«───── B ─────»│«─── C ───»│ "
790 LOCATE,T:PRINT" ∞─────────∩∩∩──────────────┬∞┬──────────────∩∩∩─────────∞ "
800 LOCATE,T:PRINT"      loading coil          ╟─┘           loading coil     "
810 LOCATE,T:PRINT"                        50 Ω║COAX                          "
820 LOCATE,T:PRINT"                                                           "
830 COLOR 7,0
840 PRINT UL$;
850 LN=CSRLIN
860 :REM'
870 :REM'.....input parameters
880    IF F THEN 920
890 INPUT" ENTER: Centre frequency (in MHz) of the band you want to operate ";F
900 IF F=0 THEN LOCATE CSRLIN-1:GOTO 890
910 FQ=F   :REM'for chaining to coil designer program
920 SP=300/F*0.656000018119812!  :REM'min. lgth in feet
930 COLOR 0,7:LOCATE 1,T+8:PRINT USING "###.### MHz ";F:COLOR 7,0
940 IF BB THEN 1310
950 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
960 PRINT " For maximum efficiency dimension A should be at least";
970 PRINT USING "####.## feet (###.## m.).";SP,SP*0.30480000376701355!
980 PRINT " Shorter antennas will also work, but at reduced efficiency."
990   IF LG=0 AND LX<>0 THEN LG=LX     :REM'if lgth chained from SHORTDIP
1000   IF LG THEN 1140
1010 PRINT USING " Maximum length =###.###";468/F*UM;:PRINT UM$
1020 PRINT UL$;
1030 PRINT " ENTER: Length A (";UM$;")........................A= ";:INPUT LG
1040 IF LG/UM>SP THEN 1110
1050 COLOR 15:PRINT :PRINT " WARNING!"
1060 PRINT " An antenna this short may operate at somewhat less ";
1070 PRINT "than optimum efficiency!"
1080 COLOR 7:PRINT
1090 PRINT " Press any key . . . . ."
1100 IF INKEY$=""THEN 1100 :ELSE 1110
1110 LG=LG/UM
1120 IF LG>468/F THEN 1620
1130 IF LG=0 THEN LOCATE CSRLIN-1:GOTO 1030
1140   IF DIA THEN 1310
1150 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1160 PRINT " Press letter in < > to select conductor size:"
1170 PRINT UL$;
1180 PRINT "   < a >  Diameter in millimetres"
1190 PRINT "   < b >  Diameter in inches"
1200 PRINT "   < c >  AWG#"
1210 Z$=INKEY$
1220 IF Z$="a"OR Z$="A"THEN WS$="mm":GOTO 1260
1230 IF Z$="b"OR Z$="B"THEN WS$="inches":GOTO 1260
1240 IF Z$="c"OR Z$="C"THEN WS$="AWG#":GOTO 1260
1250 GOTO 1210
1260 PRINT " ENTER: Wire size (";WS$;")";:INPUT ZD
1270 IF WS$="mm"THEN DIA=ZD/25.399999618530273!
1280 IF WS$="inches"THEN DIA=ZD
1290 IF WS$="AWG#"THEN DIA=GA(ZD)
1300 :REM'
1310 :REM'.....display data
1320 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN-2,13
1330 P$="A=###.## ft.(###.## m.) using #.### in. (##.# mm ) wire "
1340 COLOR 0,7
1350 PRINT USING P$;LG,LG*0.30480000376701355!,DIA,DIA*25.399999618530273!
1360 COLOR 7,0:PRINT UL$;
1370 LOCATE CSRLIN-1,46:PRINT "╒"
1380 LOCATE CSRLIN-1,60:PRINT " COIL "
1390 LOCATE CSRLIN-1,80:PRINT "╕";
1400 W=ZD   :REM'AWG # for chaining to coil designer program
1410 :REM'
1420 :REM'.....calculate and print
1430 PRINT SPC(PRUN)
1440 PRINT SPC(13)"B";SPC(20)"C";SPC(15);"L   ";
1450 IF BB THEN PRINT "" :ELSE PRINT " diameter  self-res.   Q"
1460 F1=10^6/(68*PI^2*F^2)
1470 IF BB=0 THEN 1510
1480 Z=0
1490 B=BB:GOTO 1530
1500 :REM'
1510 FOR Z=1 TO 9 :REM'.....start loop
1520  B=Z*0.10000000149011612!*LG/2
1530   F2=LOG(24*(234/F-B)/DIA)-1
1540   F3=(1-F*B/234)^2-1
1550   F4=234/F-B
1560   F5=LOG(24*(LG/2-B)/DIA)-1
1570   F6=((F*LG/2-F*B)/234)^2-1
1580   F7=LG/2-B
1590   L(Z)=F1*(F2*F3/F4-F5*F6/F7)
1600  IF L(Z)>0 THEN 1720
1610 :REM'
1620 BEEP:VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1630 PRINT TAB(7)USING "####.## ft. (###.## m.)";LG,LG*0.30480000376701355!;
1640 PRINT " is enough space for a full size half-wave"
1650 PRINT TAB(7)USING "####.### MHz dipole, which is";F;
1660 PRINT USING "####.## ft.(###.## m.) long.";468/F,468/F*0.30480000376701355!
1670 PRINT UL$;
1680 GOSUB 3370
1690 GOTO 180
1700 END
1710 :REM'
1720 :REM'.....calculate
1730 FF=F:JJ=1/(4*PI^2)*10^6:U=L(Z):D=DIA:T=1/(2*D)
1740 :REM'.....find diameter
1750 D=10:X=1               :REM'D=coil diameter in inches
1760 R=0.5!                   :REM'coil length/diameter ratio for max. Q
1770 L=R*D                  :REM'coil length in inches
1780 N=L*T                  :REM'number of turns
1790 Y=SQR(U*(18*D+40*L))/D :REM'number of turns
1800 IF ABS(Y-N)<9.999999747378752e-05! THEN 1830
1810 IF SGN(Y-N)<>SGN(X)THEN X=-X/10
1820 D=D+X:GOTO 1770
1830 :REM'.....self resonant frequency
1840 SW=2                    :REM'turn spacing/wire diameter ratio
1850 IHC=LOG(SW+SQR(SW^2-1)) :REM'inverse hyperbolic cosine
1860 CO=PI*D*2.5399999618530273!/(3.5999999046325684!*IHC)  :REM'distributed capacitance
1870 FS=SQR(JJ/CO/U)         :REM'self resonant frequency
1880 :REM'.....Q
1890 CR=JJ/(F^2*U)           :REM'capacitance required to resonate
1900 C=CR-CO                 :REM'added capacity required to resonate
1910 RAD=D*2.5399999618530273!/2            :REM'coil radius in cm.
1920 LGTH=L*2.5399999618530273!             :REM'coil length in cm.
1930 QT=SQR(F*10^6)/(6.900000095367432!/RAD+5.400000095367432!/LGTH) :REM'true Q
1940 :REM'.....display
1950 PRINT USING "<#>";Z;
1960 IF UM=1 THEN M=1:M$="in.│":ELSE M=2.5399999618530273!:M$="cm.│"
1970 P$="│###.## ft.(##.## m.)│###.## ft.(##.## m.)│###.# µH│##.## "+M$
1980 AQ=QT/(1+CO/C)
1990 IF AQ<0 THEN AQ=0
2000 PRINT USING P$;B,B*0.30480000376701355!,LG/2-B,(LG/2-B)*0.30480000376701355!,L(Z),D*M;
2010 IF FS<F THEN COLOR 0,7
2020 PRINT USING "###.# MHz│####";FS;AQ;
2030 COLOR 7,0
2040 IF BB THEN UH=L(Z):Z=0:GOTO 2160
2050 IF Z<10 THEN PRINT ""
2060 NEXT Z       :REM'.....end loop
2070 COLOR 15,2:LOCATE 22,9
2080 PRINT " For optimum efficiency self-resonance should be near";
2090 PRINT USING "###.# MHz ";2*F
2100 COLOR 0,7
2110 :REM'
2120 IF FS>F THEN 2160
2130 LOCATE 20,6
2140 PRINT " The self-resonant frequency of the coil must be higher than";
2150 PRINT USING "###.# MHz│";F
2160 LOCATE 23,11
2170 PRINT " Do you want to calculate other B & C dimensions?    (y/n) "
2180 COLOR 7,0
2190 Z$=INKEY$:IF Z$=""THEN 2190
2200 IF Z$="n"THEN LOCATE 23:PRINT STRING$(80,32);:LOCATE 23:GOTO 2390
2210 IF Z$="y"THEN LOCATE 23:PRINT STRING$(80,32);:LOCATE 23:GOTO 2250
2220 GOTO 2190
2230 COLOR 7,0
2240 :REM'
2250 :REM'.....alternate B & C dimensions
2260 LOCATE 23
2270 PRINT " ENTER: Desired dimension B (";UM$;")....B= ";:INPUT B
2280 IF B<=0 THEN B=9.999999747378752e-06!
2290 B=B/UM
2300 LOCATE CSRLIN-1:PRINT STRING$(80,32);
2310 J=LG/UM/2
2320 IF B=<J THEN LOCATE 21:GOTO 2370
2330 BEEP:LOCATE 23:PRINT STRING$(80,32);:LOCATE 22:COLOR 0,7
2340 PRINT " Dimension B must be less than";J;UM$;"....PRESS ANY KEY...."
2350 IF INKEY$=""THEN 2350
2360 COLOR 7,0:LOCATE CSRLIN-1:PRINT STRING$(80,32);:GOTO 2260
2370 Z=0:BB=B:GOTO 1530
2380 :REM'
2390 :REM'.....end
2400 IF NF THEN LOCATE 11:PRINT "    ":NF=0:GOSUB 3370:GOTO 2550
2410 GOSUB 3370    :REM'screen dump
2420 LOCATE 25,1:PRINT STRING$(80,32);
2430 VIEW PRINT 22 TO 24:CLS:VIEW PRINT:LOCATE 22,4
2440 COLOR 7,0
2450 PRINT " For optimum efficiency select a combination self-resonant near";
2460 PRINT USING "###.# MHz";F*2
2470 LOCATE 22,5:COLOR 0,7
2480 PRINT " Press a number in < > above to select your choice of antenna ";
2490 PRINT "and EXIT "
2500 COLOR 7,0
2510 Z$=INKEY$:IF Z$=""THEN 2510
2520 IF VAL(Z$)<0 OR VAL(Z$)>9 THEN 2510
2530 UH=L(VAL(Z$))       :REM':V$=STRING$(VAL(Z$),"*")
2540 :REM'
2550 IF Z$="0"THEN 2570
2560 BB=VAL(Z$)*0.10000000149011612!*LG/2
2570 CLS:GOTO 180
2580 END
2590 :REM'
2600 :REM'.....text block
2610 CLS:COLOR 7,0,0
2620 TB=7      :REM'tab for text
2630 PRINT TAB(TB);
2640 PRINT "  This antenna is a dipole with lumped-constant loading. At modest"
2650 PRINT TAB(TB);
2660 PRINT "heights (10-30 metres) it will work well if its physical length is"
2670 PRINT TAB(TB);
2680 PRINT "longer than 0.2 wavelength. This threshold length is displayed"
2690 PRINT TAB(TB);
2700 PRINT "early in the program. Shorter lengths will be less efficient."
2710 PRINT TAB(TB);
2720 PRINT "  The antenna can be fed directly with 50Ω coaxial line. The design"
2730 PRINT TAB(TB);
2740 PRINT "is based on the concept of inductive loading, widely used in centre"
2750 PRINT TAB(TB);
2760 PRINT "loaded mobile whip antennas."
2770 PRINT TAB(TB);
2780 PRINT "  For maximum efficiency the antenna should be as long as possible,"
2790 PRINT TAB(TB);
2800 PRINT "consistent with available space. The loading coils should be as far"
2810 PRINT TAB(TB);
2820 PRINT "from the centre feed point as possible, bearing in mind that as the"
2830 PRINT TAB(TB);
2840 PRINT "distance from the feed point increases, coil size increases and the"
2850 PRINT TAB(TB);
2860 PRINT "self-resonant frequency decreases until it reaches the operating"
2870 PRINT TAB(TB);
2880 PRINT "frequency, at which point coil Q decays to zero, and the antenna"
2890 LOCATE ,TB
2900 PRINT "efficiency approaches zero."
2910 PRINT
2920 COLOR 0,7
2930 LOCATE ,TB+1
2940 PRINT " OPTIMUM Q OCCURS WHEN SELF-RESONANT FREQUENCY IS ABOUT TWICE THE "
2950 LOCATE ,TB+1
2960 PRINT " OPERATING FREQUENCY.                                             "
2970 COLOR 7,0
2980 PRINT
2990 PRINT TAB(TB);
3000 PRINT "  The program calculates 9 different combinations of inductor size"
3010 PRINT TAB(TB);
3020 PRINT "and location. You can specify additional combinations if you wish."
3030 PRINT TAB(TB);
3040 PRINT "  For maximum efficiency select the combination with the highest"
3050 PRINT TAB(TB);
3060 PRINT "coil Q that is practicable for your application. When you select"
3070 PRINT TAB(TB);
3080 PRINT "one of the combinations you will be given the option of selecting a"
3090 PRINT TAB(TB);
3100 PRINT "commercial coil of the inductance required or designing your own.";
3110 RETURN
3120 :REM'
3130 :REM'.....credits
3140 TB=7
3150 PRINT TAB(TB);
3160 PRINT "The equations in this program were developed by Jerry Hall K1TD."
3170 PRINT TAB(TB);
3180 PRINT "For a comprehensive discussion of this antenna design see The ARRL"
3190 PRINT TAB(TB);
3200 PRINT "ANTENNA ANTHOLOGY, 1978, publication #36, p.107, The ARRL ANTENNA "
3210 PRINT TAB(TB);
3220 PRINT "BOOK, 18th edition, page 6-26, and the Sept.1974 edition of QST."
3230 RETURN
3240 :REM'
3250 :REM'.....preface
3260 T=7
3270 PRINT TAB(T);
3280 PRINT "This electrically shortened dipole is similar in appearance to a"
3290 PRINT TAB(T);
3300 PRINT "trap dipole except the `traps' consist of coils only, causing the"
3310 PRINT TAB(T);
3320 PRINT "antenna to operate not unlike two mobile inductively loaded whips"
3330 PRINT TAB(T);
3340 PRINT "mounted horizontally, base-to-base, but much more efficiently."
3350 RETURN
3360 :REM'
3370 :REM'PRT
3380 KEY OFF:GOSUB 3450:LOCATE 25,5:COLOR 0,2
3390 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3400 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3410 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3410 :ELSE GOSUB 3450
3420 IF Z$="3"THEN RETURN
3430 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3440 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3380
3450 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
