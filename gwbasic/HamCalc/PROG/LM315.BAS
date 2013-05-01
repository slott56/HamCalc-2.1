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
280 IF V*VO THEN RO=3:CO=32:GOSUB 2000:GOTO 450
290 :REM'
300 :REM'.....start
310 RO=3:CO=32:GOSUB 2000                              :REM'print diagram
320 PRINT " Press number in < > to:"
330 PRINT "  < 1 >  RUN program";
340 IF V*VO THEN PRINT " with new input/output voltages" :ELSE PRINT ""
350 IF V*VO=0 THEN 370
360 PRINT "  < 2 >  RE-RUN program with existing input/output voltages"
370 PRINT "  < 0 >  EXIT"
380 :REM'IF V*VO=0 THEN PRINT UL$;
390 Z$=INKEY$
400 IF Z$="0"THEN CLS:CHAIN GO$
410 IF Z$="1"THEN V=0:VO=0:GOTO 450
420 IF Z$="2"THEN 450
430 GOTO 390
440 :REM'
450 VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9
460 R3=0:R4=0
470 IF V=0 THEN 500
480 LOCATE 4:PRINT " Input voltage =";V;"volts DC"
490 LOCATE 4,50:PRINT " Output voltage =";VO;"volts DC"
500 LOCATE 9
510 GOSUB 2170    :REM'text
520 GOSUB 2910
530 :REM'
540 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
550 FOR Z=32 TO 62:RO=3:CO=Z:GOSUB 2000:NEXT Z         :REM'move diagram
560 CEI=1
570 IF V THEN 770
580 LOCATE 3
590 COLOR 0,7:INPUT " ENTER: Input voltage (minimum 3.7)...";V:COLOR 7,0
600 IF V<3.700000047683716! THEN V=0:VIEW PRINT:GOTO 540
610 RO=3:CO=62
620 CEO=1:GOSUB 2000             :REM'print diagram
630 LOCATE 4
640 COLOR 0,7:INPUT " ENTER: Output voltage................";VO:COLOR 7,0
650 IF VO>V THEN LOCATE CSRLIN-1:PRINT STRING$(50,32):GOTO 630
660 IF VO>0 THEN 680
670 LOCATE CSRLIN-1:PRINT STRING$(50,32):LOCATE CSRLIN-1:GOTO 640
680 IF V-VO<=40 THEN 770
690 :REM'
700 :REM'.....differential exceeds minimum
710 COLOR 15,0
720 PRINT " Exceeds maximum allowable input/output differential of 40 volts "
730 COLOR 7,0:V=0:GOSUB 2910
740 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
750 GOTO 300
760 :REM'
770 IF R3 THEN 890
780 CR3=1:GOSUB 2000             :REM'print diagram
790 LOCATE 11
800 PRINT " Suggested combinations of resistors R3 and R4:"
810 PRINT STRING$(48,196)
820 FOR Z=1 TO 17 STEP 2
830 PRINT USING " R3:#### Ω";RS(Z)*10;
840 PRINT SPC(4);
850 PRINT USING " R4:##,### Ω";RS(Z)*(VO/1.25!-1)*10
860 NEXT Z
870 LOCATE 23:INPUT " ENTER: Value of R3 (suggested range 100-470)..";R3
880 R4=R3*(VO/1.25!-1)
890 FOR Z=11 TO 21:LOCATE Z,60:PRINT STRING$(21,32);:NEXT Z
900 :REM'
910 :REM'.....screen display
920 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
930 CEI=1:CR3=1:CR4=1:CEO=1
940 GOSUB 2000   :REM'diagram
950 LOCATE 4
960 I3=1.25!/R3*1000            :REM'current in mA. thru R3
970 I4=I3+0.10000000149011612!                   :REM'current in mA. thru R4
980 PRINT TAB(8);"Input voltage....................";USING U$;V;
990 PRINT " volts"
1000 PRINT TAB(8);"Sought Output voltage............";USING U$;VO;
1010 PRINT " volts"
1020 DV=V-2.5!                          :REM'dropout voltage
1030 PRINT TAB(8);"Dropout voltage..................";USING U$;DV;
1040 PRINT " volts"
1050 PRINT TAB(8);"Value of R3......................";USING U$;R3;
1060 PRINT " ohms"
1070 IF R3>=100 AND R3<=470 THEN 1110
1080 COLOR 0,7
1090 LOCATE 7,19:PRINT " (100-470 recommended)"
1100 COLOR 7,0
1110 PRINT TAB(8);"Current thru R3..................";USING U$;I3;
1120 PRINT " mA."
1130 PRINT TAB(8);"Current thru R4..................";USING U$;I4;
1140 PRINT " mA."
1150 PRINT SPC(6);:COLOR 0,7:PRINT " Value of R4:"
1160 :REM'
1170 M=1      :REM'multiplier
1180 FOR X=1 TO 24
1190 Y=RS(X)*M
1200 IF Y<R4 THEN LO=Y:GOTO 1220
1210 HI=Y:GOTO 1390
1220 NEXT X
1230 M=M*10:GOTO 1180
1240 :REM'
1250 :REM'.....R4 display subroutine
1260 OLDVO=VO
1270 VO=1.25!*(1+R/R3):E=VO
1280 IF V-VO<2.5! THEN E=V-2.5!      :REM'2.5v. differential = dropout voltage
1290 PRINT " ";R$;TAB(19);USING U$;R;:PRINT " ohms = output of";USING U1$;E;
1300 PRINT " volts "
1310 :REM'
1320 IF V-VO>=2.5! THEN 1350
1330 COLOR 0,7:LOCATE CSRLIN-1,57
1340 PRINT " UNREGULATED (Dropout)"
1350 COLOR 7,0
1360 VO=OLDVO
1370 RETURN
1380 :REM'
1390 :REM'.....display R4
1400 R$="Standard resistor":R=LO:COLOR 0,7:GOSUB 1250
1410 R$="Exact resistance":R=R4:COLOR 15,3:GOSUB 1250
1420 R$="Standard resistor":R=HI:COLOR 0,7:GOSUB 1250
1430 PRINT UL$;
1440 POTFLAG=0
1450 PRINT " Resistors of";LO;"or";HI;"ohms will provide outputs as shown, or"
1460 PRINT " you can assemble a precision resistor very close to";R4;"ohms,"
1470 PRINT " or you can use a potentiometer for R4."
1480 PRINT UL$;
1490 PRINT " Press number in < > to:"
1500 PRINT UL$;
1510 PRINT "   < 1 > Assemble a precision resistor for R4"
1520 PRINT "   < 2 > Use a potentiometer for R4"
1530 PRINT "   < 3 > Select a standard resistor for R4"
1540 PRINT "   < 4 > Return to Menu";
1550 Z$=INKEY$:IF Z$=""THEN 1550
1560 IF Z$="1" THEN VOUT=VO:GOSUB 2510:R=R4:CLS:CHAIN "precires"
1570 IF Z$="2" THEN 1660
1580 IF Z$="3" THEN 1610
1590 IF Z$="4" THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 300
1600 GOTO 1550
1610 VIEW PRINT 19 TO 24:CLS:VIEW PRINT:LOCATE 19
1620 INPUT " ENTER: Your choice of value for R4 (ohms)....";R4
1630 VOUT=1.25!*(1+R4/R3)
1640 GOSUB 2510:GOTO 300
1650 :REM'
1660 VIEW PRINT 19 TO 24:CLS:VIEW PRINT
1670 POTFLAG=1
1680 COLOR 0,7
1690 LOCATE RO+4,CO+7:PRINT "├"
1700 LOCATE RO+5,CO+7:PRINT "└──»"
1710 LOCATE 19:COLOR 15,3
1720 PRINT" ENTER: Value (ohms) of a LINEAR pot greater than";R4;"ohms";
1730 INPUT POT
1740 COLOR 7,0
1750 FOR Z=8 TO 9:LOCATE Z:PRINT STRING$(55,32):NEXT Z
1760 FOR Z=11 TO 19:LOCATE Z:PRINT STRING$(80,32);:NEXT Z
1770 LOCATE 11
1780 COLOR 0,7
1790 PRINT USING "####,###";POT;:PRINT " ohm LINEAR potentiometer:"
1800 :REM'
1810 COLOR 7,0                :REM'display potentiomenter values
1820 FOR Z=1 TO 10
1830 R=POT*Z/10:R$=""
1840 IF R4>=R OR R4<=POT*(Z-1)/10 THEN 1900
1850 :REM'
1860 COLOR 15,3
1870 PRINT " @";USING "####.#";R4/POT*100;:PRINT "% open =";
1880 Q=R:R=R4:GOSUB 1250:R=Q:GOTO 1910
1890 :REM'
1900 IF R=R4 THEN COLOR 0,7
1910 IF Z=10 THEN R=POT
1920 PRINT " @";USING "####.#";Z*10;:PRINT "% open =";
1930 GOSUB 1250
1940 NEXT Z
1950 PRINT UL$;
1960 GOSUB 2910
1970 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1980 VOUT=VO:GOSUB 2510:GOTO 300
1990 :REM'
2000 :REM'.....diagram
2010 COLOR 0,7
2020 LOCATE RO+0,CO:PRINT "     LM317       "
2030 LOCATE RO+1,CO:PRINT "   in┌───┐out    "
2040 LOCATE RO+2,CO:PRINT "  + ─┤   ├─┬── + "
2050 LOCATE RO+3,CO:PRINT "     └─┬─┘ R3    "
2060 LOCATE RO+4,CO:PRINT "    adj└───┤     "
2070 LOCATE RO+5,CO:PRINT "           R4    "
2080 LOCATE RO+6,CO:PRINT "  - ───────┴── - "
2090 IF CEI THEN COLOR 14,6:LOCATE RO+2,CO+2:PRINT"+"
2100 IF CR3 THEN COLOR 14,6:LOCATE RO+3,CO+11:PRINT"R3"
2110 IF CR4 THEN COLOR 14,6:LOCATE RO+5,CO+11:PRINT"R4"
2120 IF CEO THEN COLOR 14,6:LOCATE RO+2,CO+15:PRINT"+"
2130 CEI=0:CR3=0:CR4=0:CEO=0
2140 COLOR 7,0
2150 RETURN
2160 :REM'
2170 :REM'.....text block
2180 TB=8    :REM'tab for text
2190 PRINT TAB(TB);
2200 PRINT "  The LM317 is a floating regulator and sees only the input-to-"
2210 PRINT TAB(TB);
2220 PRINT "output differential voltages, therefore power supplies of several"
2230 PRINT TAB(TB);
2240 PRINT "hundred volts can be regulated as long as the maximum input-to-"
2250 PRINT TAB(TB);
2260 PRINT "output differential is not exceeded."
2270 PRINT TAB(TB);
2280 PRINT "  Most manufacturers recommend by-passing the input and output"
2290 PRINT TAB(TB);
2300 PRINT "leads with 1 µF tantalum capacitors soldered directly to the leads"
2310 PRINT TAB(TB);
2320 PRINT "as close as possible to the points where the leads project through"
2330 PRINT TAB(TB);
2340 PRINT "the heat sink."
2350 PRINT TAB(TB);
2360 PRINT "  The current carrying capacity of the LM317 is determined by the"
2370 PRINT TAB(TB);
2380 PRINT "type of its package. If the current carrying capacity of the type"
2390 PRINT TAB(TB);
2400 PRINT "selected is insufficient a power transistor may be added to"
2410 PRINT TAB(TB);
2420 PRINT "increase the capacity. In all cases the LM317 should be mounted"
2430 PRINT TAB(TB);
2440 PRINT "on a heat sink."
2450 PRINT TAB(TB+2);
2460 PRINT "Ref: Semiconductor Reference Guide, Radio Shack #276-4007, p.54.";
2470 PRINT TAB(TB+2);
2480 PRINT "Ref: ARRL 2007 Handbook, page 17.23"
2490 RETURN
2500 :REM'
2510 :REM'.....practical circuits
2520 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 2,22
2530 GOSUB 2570:GOSUB 2910
2540 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2550 RETURN
2560 :REM'
2570 :REM'.....diagram
2580 LOCATE 3:K=14
2590 LOCATE ,K:PRINT"              TYPICAL LM317 APPLICATIONS              "
2600 COLOR 0,7
2610 LOCATE ,K:PRINT"                      ││     ┌─PNP power transistor   "
2620 LOCATE ,K:PRINT"                      ││     └─»┌───┐                 "
2630 LOCATE ,K:PRINT"                      ││     ┌──┤e c├─────────┐       "
2640 LOCATE ,K:PRINT"                      ││     │  │ b │         │       "
2650 LOCATE ,K:PRINT" Vin ┌─────┐     Vout ││ Vin │  └─┬─┘┌─────┐  │  Vout "
2660 LOCATE ,K:PRINT" ───┬┤LM317├┬───┬──── ││ ────┴────┴─┬┤LM317├┬─┴─┬──── "
2670 LOCATE ,K:PRINT"    │└──┬──┘│   │ I-» ││            │└──┬──┘│   │ I─» "
2680 LOCATE ,K:PRINT"    C2  │   C3  R3    ││            C2  │   C3  R3    "
2690 LOCATE ,K:PRINT"    │   └───│───┤     ││            │   └───│───┤     "
2700 LOCATE ,K:PRINT"    │       │   R4    ││            │       │   R4    "
2710 LOCATE ,K:PRINT"    │       │   │     ││            │       │   │     "
2720 LOCATE ,K:PRINT"  \\┴\\   \\┴\\\┴\\   ││          \\┴\\   \\┴\\\┴\\   "
2730 LOCATE ,K:PRINT"                      ││                              "
2740 LOCATE ,K:PRINT"  CURRENT I <= 1.5 A. ││      CURRENT I > 1.5 A.      "
2750 IF POTFLAG=0 THEN 2800
2760 LOCATE CSRLIN-6,K
2770 PRINT          "    │   └───│─┬─┤     ││            │   └───│─┬─┤     "
2780 LOCATE ,K:PRINT"    │       │ └»R4    ││            │       │ └»R4    "
2790 LOCATE CSRLIN+4
2800 COLOR 7,0:T=30
2810 PRINT TAB(16);"C2, C3 = 1.0 µF/50v Tantalum RF by-pass capacitors"
2820 PRINT TAB(T);"Vin  =";USING U$;V;:PRINT " volts"
2830 PRINT TAB(T);"Vout =";USING U$;VOUT;:PRINT " volts"
2840 PRINT TAB(T);"R3   =";USING U$;R3;:PRINT " Ω"
2850 PRINT TAB(T);"R4   =";USING U$;R4;:PRINT " Ω";
2860 IF POTFLAG=0 THEN PRINT "":GOTO 2880
2870 PRINT "  (";POT;"Ω potentiometer) "
2880 PRINT TAB(16);"Mount the LM317 and the transistor on heat sinks."
2890 RETURN
2900 :REM'
2910 :REM'PRT
2920 KEY OFF:GOSUB 2990:LOCATE 25,5:COLOR 0,2
2930 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2940 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2950 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2950 :ELSE GOSUB 2990
2960 IF Z$="3"THEN RETURN
2970 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2980 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2920
2990 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
