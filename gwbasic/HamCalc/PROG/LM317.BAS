10 :REM'LM317 - LM317 specifications - 11 JUN 90 rev. 14 OCT 2007
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
280 IF V*VO THEN RO=3:CO=32:GOSUB 1990:GOTO 440
290 :REM'
300 :REM'.....start
310 RO=3:CO=32:GOSUB 1990                              :REM'print diagram
320 PRINT " Press number in < > to:"
330 PRINT "  < 1 >  RUN program";
340 IF V*VO THEN PRINT " with new input/output voltages" :ELSE PRINT ""
350 IF V*VO=0 THEN 370
360 PRINT "  < 2 >  RE-RUN program with existing input/output voltages"
370 PRINT "  < 0 >  EXIT"
380 Z$=INKEY$
390 IF Z$="0"THEN CLS:CHAIN GO$
400 IF Z$="1"THEN V=0:VO=0:GOTO 440
410 IF Z$="2"THEN 440
420 GOTO 380
430 :REM'
440 VIEW PRINT 9 TO 24:CLS:VIEW PRINT:LOCATE 9
450 R3=0:R4=0
460 IF V=0 THEN 490
470 LOCATE 4:PRINT " Input voltage =";V;"volts DC"
480 LOCATE 4,50:PRINT " Output voltage =";VO;"volts DC"
490 LOCATE 9
500 GOSUB 2160    :REM'text
510 GOSUB 2900
520 :REM'
530 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
540 FOR Z=32 TO 62:RO=3:CO=Z:GOSUB 1990:NEXT Z         :REM'move diagram
550 CEI=1
560 IF V THEN 760
570 LOCATE 3
580 COLOR 0,7:INPUT " ENTER: Input voltage (minimum 3.7)...";V:COLOR 7,0
590 IF V<3.700000047683716! THEN V=0:VIEW PRINT:GOTO 530
600 RO=3:CO=62
610 CEO=1:GOSUB 1990             :REM'print diagram
620 LOCATE 4
630 COLOR 0,7:INPUT " ENTER: Output voltage................";VO:COLOR 7,0
640 IF VO>V THEN LOCATE CSRLIN-1:PRINT STRING$(50,32):GOTO 620
650 IF VO>0 THEN 670
660 LOCATE CSRLIN-1:PRINT STRING$(50,32):LOCATE CSRLIN-1:GOTO 630
670 IF V-VO<=40 THEN 760
680 :REM'
690 :REM'.....differential exceeds minimum
700 COLOR 15,0
710 PRINT " Exceeds maximum allowable input/output differential of 40 volts "
720 COLOR 7,0:V=0:GOSUB 2900
730 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
740 GOTO 300
750 :REM'
760 IF R3 THEN 880
770 CR3=1:GOSUB 1990             :REM'print diagram
780 LOCATE 11
790 PRINT " Suggested combinations of resistors R3 and R4:"
800 PRINT STRING$(48,196)
810 FOR Z=1 TO 17 STEP 2
820 PRINT USING " R3:#### Ω";RS(Z)*10;
830 PRINT SPC(4);
840 PRINT USING " R4:##,### Ω";RS(Z)*(VO/1.25!-1)*10
850 NEXT Z
860 LOCATE 23:INPUT " ENTER: Value of R3 (suggested range 100-470)..";R3
870 R4=R3*(VO/1.25!-1)
880 FOR Z=11 TO 21:LOCATE Z,60:PRINT STRING$(21,32);:NEXT Z
890 :REM'
900 :REM'.....screen display
910 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
920 CEI=1:CR3=1:CR4=1:CEO=1
930 GOSUB 1990   :REM'diagram
940 LOCATE 4
950 I3=1.25!/R3*1000            :REM'current in mA. thru R3
960 I4=I3+0.10000000149011612!                   :REM'current in mA. thru R4
970 PRINT TAB(8);"Input voltage....................";USING U$;V;
980 PRINT " volts"
990 PRINT TAB(8);"Sought Output voltage............";USING U$;VO;
1000 PRINT " volts"
1010 DV=V-2.5!                          :REM'dropout voltage
1020 PRINT TAB(8);"Dropout voltage..................";USING U$;DV;
1030 PRINT " volts"
1040 PRINT TAB(8);"Value of R3......................";USING U$;R3;
1050 PRINT " ohms"
1060 IF R3>=100 AND R3<=470 THEN 1100
1070 COLOR 0,7
1080 LOCATE 7,19:PRINT " (100-470 recommended)"
1090 COLOR 7,0
1100 PRINT TAB(8);"Current thru R3..................";USING U$;I3;
1110 PRINT " mA."
1120 PRINT TAB(8);"Current thru R4..................";USING U$;I4;
1130 PRINT " mA."
1140 PRINT SPC(6);:COLOR 0,7:PRINT " Value of R4:"
1150 :REM'
1160 M=1      :REM'multiplier
1170 FOR X=1 TO 24
1180 Y=RS(X)*M
1190 IF Y<R4 THEN LO=Y:GOTO 1210
1200 HI=Y:GOTO 1380
1210 NEXT X
1220 M=M*10:GOTO 1170
1230 :REM'
1240 :REM'.....R4 display subroutine
1250 OLDVO=VO
1260 VO=1.25!*(1+R/R3):E=VO
1270 IF V-VO<2.5! THEN E=V-2.5!      :REM'2.5v. differential = dropout voltage
1280 PRINT " ";R$;TAB(19);USING U$;R;:PRINT " ohms = output of";USING U1$;E;
1290 PRINT " v."
1300 :REM'
1310 IF V-VO>=2.5! THEN 1340
1320 COLOR 0,7:LOCATE CSRLIN-1,57
1330 PRINT " UNREGULATED (Dropout)"
1340 COLOR 7,0
1350 VO=OLDVO
1360 RETURN
1370 :REM'
1380 :REM'.....display R4
1390 R$="Standard resistor":R=LO:COLOR 0,7:GOSUB 1240
1400 R$="Exact resistance":R=R4:COLOR 15,3:GOSUB 1240
1410 R$="Standard resistor":R=HI:COLOR 0,7:GOSUB 1240
1420 PRINT UL$;
1430 POTFLAG=0
1440 PRINT " Resistors of";LO;"or";HI;"ohms will provide outputs as shown, or"
1450 PRINT " you can assemble a precision resistor very close to";R4;"ohms,"
1460 PRINT " or you can use a potentiometer for R4."
1470 PRINT UL$;
1480 PRINT " Press number in < > to:"
1490 PRINT UL$;
1500 PRINT "   < 1 > Assemble a precision resistor for R4"
1510 PRINT "   < 2 > Use a potentiometer for R4"
1520 PRINT "   < 3 > Select a standard resistor for R4"
1530 PRINT "   < 4 > Return to Menu";
1540 Z$=INKEY$:IF Z$=""THEN 1540
1550 IF Z$="1" THEN VOUT=VO:GOSUB 2500:R=R4:CLS:CHAIN "precires"
1560 IF Z$="2" THEN 1650
1570 IF Z$="3" THEN 1600
1580 IF Z$="4" THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 300
1590 GOTO 1540
1600 VIEW PRINT 19 TO 24:CLS:VIEW PRINT:LOCATE 19
1610 INPUT " ENTER: Your choice of value for R4 (ohms)....";R4
1620 VOUT=1.25!*(1+R4/R3)
1630 GOSUB 2500:GOTO 300
1640 :REM'
1650 VIEW PRINT 19 TO 24:CLS:VIEW PRINT
1660 POTFLAG=1
1670 COLOR 0,7
1680 LOCATE RO+4,CO+7:PRINT "├"
1690 LOCATE RO+5,CO+7:PRINT "└──»"
1700 LOCATE 19:COLOR 15,3
1710 PRINT" ENTER: Value (ohms) of a LINEAR pot greater than";R4;"ohms";
1720 INPUT POT
1730 COLOR 7,0
1740 FOR Z=8 TO 9:LOCATE Z:PRINT STRING$(55,32):NEXT Z
1750 FOR Z=11 TO 19:LOCATE Z:PRINT STRING$(80,32);:NEXT Z
1760 LOCATE 11
1770 COLOR 0,7
1780 PRINT USING "####,###";POT;:PRINT " ohm LINEAR potentiometer:"
1790 :REM'
1800 COLOR 7,0                :REM'display potentiomenter values
1810 FOR Z=1 TO 10
1820 R=POT*Z/10:R$=""
1830 IF R4>=R OR R4<=POT*(Z-1)/10 THEN 1890
1840 :REM'
1850 COLOR 15,3
1860 PRINT " @";USING "####.#";R4/POT*100;:PRINT "% open =";
1870 Q=R:R=R4:GOSUB 1240:R=Q:GOTO 1900
1880 :REM'
1890 IF R=R4 THEN COLOR 0,7
1900 IF Z=10 THEN R=POT
1910 PRINT " @";USING "####.#";Z*10;:PRINT "% open =";
1920 GOSUB 1240
1930 NEXT Z
1940 PRINT UL$;
1950 GOSUB 2900
1960 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1970 VOUT=VO:GOSUB 2500:GOTO 300
1980 :REM'
1990 :REM'.....diagram
2000 COLOR 0,7
2010 LOCATE RO+0,CO:PRINT "     LM317       "
2020 LOCATE RO+1,CO:PRINT "   in┌───┐out    "
2030 LOCATE RO+2,CO:PRINT "  + ─┤   ├─┬── + "
2040 LOCATE RO+3,CO:PRINT "     └─┬─┘ R3    "
2050 LOCATE RO+4,CO:PRINT "    adj└───┤     "
2060 LOCATE RO+5,CO:PRINT "           R4    "
2070 LOCATE RO+6,CO:PRINT "  - ───────┴── - "
2080 IF CEI THEN COLOR 14,6:LOCATE RO+2,CO+2:PRINT"+"
2090 IF CR3 THEN COLOR 14,6:LOCATE RO+3,CO+11:PRINT"R3"
2100 IF CR4 THEN COLOR 14,6:LOCATE RO+5,CO+11:PRINT"R4"
2110 IF CEO THEN COLOR 14,6:LOCATE RO+2,CO+15:PRINT"+"
2120 CEI=0:CR3=0:CR4=0:CEO=0
2130 COLOR 7,0
2140 RETURN
2150 :REM'
2160 :REM'.....text block
2170 TB=8    :REM'tab for text
2180 PRINT TAB(TB);
2190 PRINT "  The LM317 is a floating regulator and sees only the input-to-"
2200 PRINT TAB(TB);
2210 PRINT "output differential voltages, therefore power supplies of several"
2220 PRINT TAB(TB);
2230 PRINT "hundred volts can be regulated as long as the maximum input-to-"
2240 PRINT TAB(TB);
2250 PRINT "output differential is not exceeded."
2260 PRINT TAB(TB);
2270 PRINT "  Most manufacturers recommend by-passing the input and output"
2280 PRINT TAB(TB);
2290 PRINT "leads with 1 µF tantalum capacitors soldered directly to the leads"
2300 PRINT TAB(TB);
2310 PRINT "as close as possible to the points where the leads project through"
2320 PRINT TAB(TB);
2330 PRINT "the heat sink."
2340 PRINT TAB(TB);
2350 PRINT "  The current carrying capacity of the LM317 is determined by the"
2360 PRINT TAB(TB);
2370 PRINT "type of its package. If the current carrying capacity of the type"
2380 PRINT TAB(TB);
2390 PRINT "selected is insufficient a power transistor may be added to"
2400 PRINT TAB(TB);
2410 PRINT "increase the capacity. In all cases the LM317 should be mounted"
2420 PRINT TAB(TB);
2430 PRINT "on a heat sink."
2440 PRINT TAB(TB+2);
2450 PRINT "Ref: Semiconductor Reference Guide, Radio Shack #276-4007, p.54.";
2460 PRINT TAB(TB+2);
2470 PRINT "Ref: ARRL 2007 Handbook, Fig 17.23"
2480 RETURN
2490 :REM'
2500 :REM'.....practical circuits
2510 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 2,22
2520 GOSUB 2560:GOSUB 2900
2530 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2540 RETURN
2550 :REM'
2560 :REM'.....diagram
2570 LOCATE 3:K=14
2580 LOCATE ,K:PRINT"              TYPICAL LM317 APPLICATIONS              "
2590 COLOR 0,7
2600 LOCATE ,K:PRINT"                      ││     ┌─NPN power transistor   "
2610 LOCATE ,K:PRINT"                      ││     └─»┌───┐                 "
2620 LOCATE ,K:PRINT"                      ││     ┌──┤c e├─────────┐       "
2630 LOCATE ,K:PRINT"                      ││     │  │ b │         │       "
2640 LOCATE ,K:PRINT" Vin ┌─────┐     Vout ││ Vin │  └─┬─┘┌─────┐  │  Vout "
2650 LOCATE ,K:PRINT" ───┬┤LM317├┬───┬──── ││ ────┴────┴─┬┤LM317├┬─┴─┬──── "
2660 LOCATE ,K:PRINT"    │└──┬──┘│   │     ││            │└──┬──┘│   │     "
2670 LOCATE ,K:PRINT"    C2  │   C3  R3    ││            C2  │   C3  R3    "
2680 LOCATE ,K:PRINT"    │   └───│───┤     ││            │   └───│───┤     "
2690 LOCATE ,K:PRINT"    │       │   R4    ││            │       │   R4    "
2700 LOCATE ,K:PRINT"    │       │   │     ││            │       │   │     "
2710 LOCATE ,K:PRINT"  \\┴\\   \\┴\\\┴\\   ││          \\┴\\   \\┴\\\┴\\   "
2720 IF POTFLAG=0 THEN 2770
2730 LOCATE CSRLIN-5,K
2740 PRINT          "    │   └───│─┬─┤     ││            │   └───│─┬─┤     "
2750 LOCATE ,K:PRINT"    │       │ └»R4    ││            │       │ └»R4    "
2760 LOCATE CSRLIN+3
2770 COLOR 7,0:T=30
2780 PRINT TAB(16);"C2, C3 = 1.0 µF/50v Tantalum RF by-pass capacitors"
2790 PRINT TAB(T);"Current thru R3: ";:PRINT USING "#.#### ma.";I3/1000
2800 PRINT TAB(T);"Current thru R3: ";:PRINT USING "#.#### ma.";I4/1000
2810 PRINT TAB(T);"Vin  =";USING U$;V;:PRINT " volts"
2820 PRINT TAB(T);"Vout =";USING U$;VOUT;:PRINT " volts"
2830 PRINT TAB(T);"R3   =";USING U$;R3;:PRINT " Ω"
2840 PRINT TAB(T);"R4   =";USING U$;R4;:PRINT " Ω";
2850 IF POTFLAG=0 THEN PRINT "":GOTO 2870
2860 PRINT "  (";POT;"Ω potentiometer) "
2870 PRINT TAB(16);"Mount the LM317 and the transistor on heat sinks."
2880 RETURN
2890 :REM'
2900 :REM'PRT
2910 KEY OFF:GOSUB 2980:LOCATE 25,5:COLOR 0,2
2920 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2930 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2940 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2940 :ELSE GOSUB 2980
2950 IF Z$="3"THEN RETURN
2960 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2970 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2910
2980 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
