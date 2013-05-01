10 :REM'LM317 - LM317 specifications - 11 JUN 90 rev. 11 OCT 2007
20 COMMON EX$,PROG$,R
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 IF EO THEN 60 :ELSE 80      :REM'EO & OV chained from another program
60 V=INT(EO*10)/10:FLAG=1     :REM'input voltage
70 VO=INT(OV*10)/10           :REM'output voltage
80 COLOR 7,0,1
90 CLS:KEY OFF
100 UL$=STRING$(80,205)
110 U$="###,###.##"
120 U1$="####.##"
130 V$="##.##"
140 DIM R(18),RS(24)          :REM'standard resistors
150 :REM'.....standard resistor values
160 DATA 10,11,12,13,15,16,18,20,22,24,27,30,33,36,39,43,47
170 DATA 51,56,62,68,75,82,91
180 FOR Z=1 TO 17:READ E:R(Z)=E*10:NEXT Z   :REM'data for R3
190 Q=0
200 FOR Y=1 TO 17 STEP 2:Q=Q+1:R(Q)=R(Y):NEXT Y
210 RESTORE
220 FOR Z=1 TO 24:READ RS(Z):NEXT Z        :REM'standard resistors
230 :REM'
240 T$=" LM317 VOLTAGE REGULATOR"+STRING$(32,32)+"by George Murphy VE3ERP "
250 COLOR 15,2:PRINT T$;
260 COLOR 1,0:PRINT STRING$(80,"▀");
270 COLOR 7,0
280 IF V*VO THEN RO=3:CO=32:GOSUB 2030:GOTO 480
290 :REM'
300 :REM'.....start
310 RO=3:CO=32:GOSUB 2030                              :REM'print diagram
320 PRINT UL$;
330 PRINT " Press number in < > to:"
340 PRINT UL$;
350 PRINT "  < 1 >  RUN program";
360 IF V*VO THEN PRINT " with new input/output voltages" :ELSE PRINT ""
370 IF V*VO=0 THEN 400
380 PRINT "  < 2 >  RE-RUN program with existing input/output voltages"
390 PRINT UL$;
400 PRINT "  < 0 >  EXIT"
410 IF V*VO=0 THEN PRINT UL$;
420 Z$=INKEY$
430 IF Z$="0"THEN CLS:CHAIN GO$
440 IF Z$="1"THEN V=0:VO=0:GOTO 480
450 IF Z$="2"THEN 480
460 GOTO 420
470 :REM'
480 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 11
490 R3=0:R4=0
500 IF V=0 THEN 530
510 LOCATE 4:PRINT " Input voltage =";V;"volts DC"
520 LOCATE 4,50:PRINT " Output voltage =";VO;"volts DC"
530 LOCATE 11
540 GOSUB 2200    :REM'text
550 GOSUB 2920
560 :REM'
570 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
580 FOR Z=32 TO 62:RO=3:CO=Z:GOSUB 2030:NEXT Z         :REM'move diagram
590 CEI=1
600 IF V THEN 800
610 LOCATE 3
620 INPUT " ENTER: Input voltage (minimum 3.7)............";V
630 IF V<3.700000047683716! THEN V=0:VIEW PRINT:GOTO 570
640 RO=3:CO=62
650 CEO=1:GOSUB 2030             :REM'print diagram
660 LOCATE 4
670 INPUT " ENTER: Output voltage ........................";VO
680 IF VO>V THEN LOCATE CSRLIN-1:PRINT STRING$(50,32):GOTO 660
690 IF VO>0 THEN 710
700 LOCATE CSRLIN-1:PRINT STRING$(50,32):LOCATE CSRLIN-1:GOTO 670
710 IF V-VO<=40 THEN 800
720 :REM'
730 :REM'.....differential exceeds minimum
740 COLOR 15,0
750 PRINT " Exceeds maximum allowable input/output differential of 40 volts "
760 COLOR 7,0:V=0:GOSUB 2920
770 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
780 GOTO 300
790 :REM'
800 IF R3 THEN 920
810 CR3=1:GOSUB 2030             :REM'print diagram
820 LOCATE 11
830 PRINT " Suggested combinations of resistors R3 and R4:"
840 PRINT STRING$(48,196)
850 FOR Z=1 TO 17 STEP 2
860 PRINT USING " R3:#### Ω";RS(Z)*10;
870 PRINT SPC(4);
880 PRINT USING " R4:##,### Ω";RS(Z)*(VO/1.25!-1)*10
890 NEXT Z
900 LOCATE 23:INPUT " ENTER: Value of R3 (suggested range 100-470)..";R3
910 R4=R3*(VO/1.25!-1)
920 FOR Z=11 TO 21:LOCATE Z,60:PRINT STRING$(21,32);:NEXT Z
930 :REM'
940 :REM'.....screen display
950 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
960 CEI=1:CR3=1:CR4=1:CEO=1
970 GOSUB 2030   :REM'diagram
980 LOCATE 4
990 I3=1.25!/R3*1000            :REM'current in mA. thru R3
1000 I4=I3+0.10000000149011612!                   :REM'current in mA. thru R4
1010 PRINT TAB(8);"Input voltage....................";USING U$;V;
1020 PRINT " volts"
1030 PRINT TAB(8);"Sought Output voltage............";USING U$;VO;
1040 PRINT " volts"
1050 DV=V-2.5!                          :REM'dropout voltage
1060 PRINT TAB(8);"Dropout voltage..................";USING U$;DV;
1070 PRINT " volts"
1080 PRINT TAB(8);"Value of R3......................";USING U$;R3;
1090 PRINT " ohms"
1100 IF R3>=100 AND R3<=470 THEN 1140
1110 COLOR 0,7
1120 LOCATE 7,19:PRINT " (100-470 recommended)"
1130 COLOR 7,0
1140 PRINT TAB(8);"Current thru R3..................";USING U$;I3;
1150 PRINT " mA."
1160 PRINT TAB(8);"Current thru R4..................";USING U$;I4;
1170 PRINT " mA."
1180 PRINT SPC(6);:COLOR 0,7:PRINT " Value of R4:"
1190 :REM'
1200 M=1      :REM'multiplier
1210 FOR X=1 TO 24
1220 Y=RS(X)*M
1230 IF Y<R4 THEN LO=Y:GOTO 1250
1240 HI=Y:GOTO 1420
1250 NEXT X
1260 M=M*10:GOTO 1210
1270 :REM'
1280 :REM'.....R4 display subroutine
1290 OLDVO=VO
1300 VO=1.25!*(1+R/R3):E=VO
1310 IF V-VO<2.5! THEN E=V-2.5!      :REM'2.5v. differential = dropout voltage
1320 PRINT " ";R$;TAB(19);USING U$;R;:PRINT " ohms = output of";USING U1$;E;
1330 PRINT " volts "
1340 :REM'
1350 IF V-VO>=2.5! THEN 1380
1360 COLOR 0,7:LOCATE CSRLIN-1,57
1370 PRINT " UNREGULATED (Dropout)"
1380 COLOR 7,0
1390 VO=OLDVO
1400 RETURN
1410 :REM'
1420 :REM'.....display R4
1430 R$="Standard resistor":R=LO:COLOR 0,7:GOSUB 1280
1440 R$="Exact resistance":R=R4:COLOR 15,3:GOSUB 1280
1450 R$="Standard resistor":R=HI:COLOR 0,7:GOSUB 1280
1460 PRINT UL$;
1470 POTFLAG=0
1480 PRINT " Resistors of";LO;"or";HI;"ohms will provide outputs as shown, or"
1490 PRINT " you can assemble a precision resistor very close to";R4;"ohms,"
1500 PRINT " or you can use a potentiometer for R4."
1510 PRINT UL$;
1520 PRINT " Press number in < > to:"
1530 PRINT UL$;
1540 PRINT "   < 1 > Assemble a precision resistor for R4"
1550 PRINT "   < 2 > Use a potentiometer for R4"
1560 PRINT "   < 3 > Select a standard resistor for R4"
1570 PRINT "   < 4 > Return to Menu";
1580 Z$=INKEY$:IF Z$=""THEN 1580
1590 IF Z$="1" THEN VOUT=VO:GOSUB 2520:R=R4:CLS:CHAIN "precires"
1600 IF Z$="2" THEN 1690
1610 IF Z$="3" THEN 1640
1620 IF Z$="4" THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 300
1630 GOTO 1580
1640 VIEW PRINT 19 TO 24:CLS:VIEW PRINT:LOCATE 19
1650 INPUT " ENTER: Your choice of value for R4 (ohms)....";R4
1660 VOUT=1.25!*(1+R4/R3)
1670 GOSUB 2520:GOTO 300
1680 :REM'
1690 VIEW PRINT 19 TO 24:CLS:VIEW PRINT
1700 POTFLAG=1
1710 COLOR 0,7
1720 LOCATE RO+4,CO+7:PRINT "├"
1730 LOCATE RO+5,CO+7:PRINT "└──»"
1740 LOCATE 19:COLOR 15,3
1750 PRINT" ENTER: Value (ohms) of a LINEAR pot greater than";R4;"ohms";
1760 INPUT POT
1770 COLOR 7,0
1780 FOR Z=8 TO 9:LOCATE Z:PRINT STRING$(55,32):NEXT Z
1790 FOR Z=11 TO 19:LOCATE Z:PRINT STRING$(80,32);:NEXT Z
1800 LOCATE 11
1810 COLOR 0,7
1820 PRINT USING "####,###";POT;:PRINT " ohm LINEAR potentiometer:"
1830 :REM'
1840 COLOR 7,0                :REM'display potentiomenter values
1850 FOR Z=1 TO 10
1860 R=POT*Z/10:R$=""
1870 IF R4>=R OR R4<=POT*(Z-1)/10 THEN 1930
1880 :REM'
1890 COLOR 15,3
1900 PRINT " @";USING "####.#";R4/POT*100;:PRINT "% open =";
1910 Q=R:R=R4:GOSUB 1280:R=Q:GOTO 1940
1920 :REM'
1930 IF R=R4 THEN COLOR 0,7
1940 IF Z=10 THEN R=POT
1950 PRINT " @";USING "####.#";Z*10;:PRINT "% open =";
1960 GOSUB 1280
1970 NEXT Z
1980 PRINT UL$;
1990 GOSUB 2920
2000 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2010 VOUT=VO:GOSUB 2520:GOTO 300
2020 :REM'
2030 :REM'.....diagram
2040 COLOR 0,7
2050 LOCATE RO+0,CO:PRINT "║    LM317       "
2060 LOCATE RO+1,CO:PRINT "█  in┌───┐out    "
2070 LOCATE RO+2,CO:PRINT "█ + ─┤   ├─┬── + "
2080 LOCATE RO+3,CO:PRINT "█    └─┬─┘ R3    "
2090 LOCATE RO+4,CO:PRINT "█   adj└───┤     "
2100 LOCATE RO+5,CO:PRINT "█          R4    "
2110 LOCATE RO+6,CO:PRINT "█ - ───────┴── - "
2120 IF CEI THEN COLOR 14,6:LOCATE RO+2,CO+2:PRINT"+"
2130 IF CR3 THEN COLOR 14,6:LOCATE RO+3,CO+11:PRINT"R3"
2140 IF CR4 THEN COLOR 14,6:LOCATE RO+5,CO+11:PRINT"R4"
2150 IF CEO THEN COLOR 14,6:LOCATE RO+2,CO+15:PRINT"+"
2160 CEI=0:CR3=0:CR4=0:CEO=0
2170 COLOR 7,0
2180 RETURN
2190 :REM'
2200 :REM'.....text block
2210 TB=8    :REM'tab for text
2220 PRINT TAB(TB);
2230 PRINT "  The LM317 is a floating regulator and sees only the input-to-"
2240 PRINT TAB(TB);
2250 PRINT "output differential voltages, therefore power supplies of several"
2260 PRINT TAB(TB);
2270 PRINT "hundred volts can be regulated as long as the maximum input-to-"
2280 PRINT TAB(TB);
2290 PRINT "output differential is not exceeded."
2300 PRINT TAB(TB);
2310 PRINT "  Most manufacturers recommend by-passing the input and output"
2320 PRINT TAB(TB);
2330 PRINT "leads with 1 µF tantalum capacitors soldered directly to the leads"
2340 PRINT TAB(TB);
2350 PRINT "as close as possible to the points where the leads project through"
2360 PRINT TAB(TB);
2370 PRINT "the heat sink."
2380 PRINT TAB(TB);
2390 PRINT "  The current carrying capacity of the LM317 is determined by the"
2400 PRINT TAB(TB);
2410 PRINT "type of its package. If the current carrying capacity of the type"
2420 PRINT TAB(TB);
2430 PRINT "selected is insufficient a power transistor may be added to"
2440 PRINT TAB(TB);
2450 PRINT "increase the capacity. In all cases the LM317 should be mounted"
2460 PRINT TAB(TB);
2470 PRINT "on a heat sink."
2480 PRINT TAB(TB+2);
2490 PRINT "Ref: Semiconductor Reference Guide, Radio Shack #276-4007, p.54.";
2500 RETURN
2510 :REM'
2520 :REM'.....practical circuits
2530 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 2,22
2540 GOSUB 2580:GOSUB 2920
2550 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2560 RETURN
2570 :REM'
2580 :REM'.....diagram
2590 LOCATE 3:K=14
2600 LOCATE ,K:PRINT"              TYPICAL LM317 APPLICATIONS              "
2610 COLOR 0,7
2620 LOCATE ,K:PRINT"                      ██     ┌─PNP power transistor   "
2630 LOCATE ,K:PRINT"                      ██     └─»┌───┐                 "
2640 LOCATE ,K:PRINT"                      ██     ┌──┤e c├─────────┐       "
2650 LOCATE ,K:PRINT"                      ██     │  │ b │         │       "
2660 LOCATE ,K:PRINT" Vin ┌─────┐     Vout ██ Vin │  └─┬─┘┌─────┐  │  Vout "
2670 LOCATE ,K:PRINT" ───┬┤LM317├┬───┬──── ██ ────┴─R5─┴─┬┤LM317├┬─┴─┬──── "
2680 LOCATE ,K:PRINT"    │└──┬──┘│   │ I-» ██      330Ω  │└──┬──┘│   │ I─» "
2690 LOCATE ,K:PRINT"    C2  │   C3  R3    ██            C2  │   C3  R3    "
2700 LOCATE ,K:PRINT"    │   └───│───┤     ██            │   └───│───┤     "
2710 LOCATE ,K:PRINT"    │       │   R4    ██            │       │   R4    "
2720 LOCATE ,K:PRINT"    │       │   │     ██            │       │   │     "
2730 LOCATE ,K:PRINT"  \\┴\\   \\┴\\\┴\\   ██          \\┴\\   \\┴\\\┴\\   "
2740 LOCATE ,K:PRINT"                      ██                              "
2750 LOCATE ,K:PRINT"  CURRENT I <= 1.5 A. ██      CURRENT I > 1.5 A.      "
2760 IF POTFLAG=0 THEN 2810
2770 LOCATE CSRLIN-6,K
2780 PRINT          "    │   └───│─┬─┤     ██            │   └───│─┬─┤     "
2790 LOCATE ,K:PRINT"    │       │ └»R4    ██            │       │ └»R4    "
2800 LOCATE CSRLIN+4
2810 COLOR 7,0:T=30
2820 PRINT TAB(16);"C2, C3 = 1.0 µF/50v Tantalum RF by-pass capacitors"
2830 PRINT TAB(T);"Vin  =";USING U$;V;:PRINT " volts"
2840 PRINT TAB(T);"Vout =";USING U$;VOUT;:PRINT " volts"
2850 PRINT TAB(T);"R3   =";USING U$;R3;:PRINT " Ω"
2860 PRINT TAB(T);"R4   =";USING U$;R4;:PRINT " Ω";
2870 IF POTFLAG=0 THEN PRINT "":GOTO 2890
2880 PRINT "  (";POT;"Ω potentiometer) "
2890 PRINT TAB(16);"Mount the LM317 and the transistor on heat sinks."
2900 RETURN
2910 :REM'
2920 :REM'PRT
2930 KEY OFF:GOSUB 3000:LOCATE 25,5:COLOR 0,2
2940 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2950 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2960 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2960 :ELSE GOSUB 3000
2970 IF Z$="3"THEN RETURN
2980 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2990 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2930
3000 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
