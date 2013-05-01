10 :REM'SQCOAX - Square Coax - 10 DEC 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$
60 COLOR 7,0,1
70 PI=4*ATN(1)  :REM' = 3.141593
80 UL$=STRING$(80,205)
90 :REM'
100 NZERO = 120*PI  :REM'characteristic impedance in free space = 376.9912 ohms
110 EPSLNR= 1       :REM'Relative dielectric constant = 1.0 for air dielectric
120 ZDIEL = NZERO/SQR(EPSLNR)                   :REM' = 376.9912 ohms
130 :REM'
140 T1$=" Ref: Transmission Line Design Handbook "
150 T2$=" by Brian C. Wadell, Artech House, 1991 "
160 T3$=" Section 3.2.4., pages 57-59 "
170 GOTO 280
180 :REM'
190 :REM'.....dimensions
200 LOCATE 3:PRINT " Want dimensions in (c)entimetres or (i)nches?  (c/i)"
210 Z$=INKEY$:IF Z$=""THEN 210
220 IF Z$="c"THEN U=2.5399999618530273!:U$="cm.":GOTO 250
230 IF Z$="i"THEN U=1   :U$="in.":GOTO 250
240 GOTO 210
250 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
260 RETURN
270 :REM'
280 :REM'.....start
290 CLS
300 COLOR 15,2
310 PRINT " SQUARE COAXIAL TRANSMISSION LINE"TAB(57)"by George Murphy VE3ERP ";
320 COLOR 1,0:PRINT STRING$(80,223);
330 COLOR 15,2:LOCATE CSRLIN-1,18
340 PRINT " in collaboration with Ron McConnell, W2IOL "
350 COLOR 7,0
360 PRINT
370 GOSUB 2120   :REM'prologue
380 PRINT UL$;
390 LOCATE ,20:PRINT T1$
400 LOCATE ,20:PRINT T2$
410 LOCATE ,25:PRINT T3$
420 PRINT UL$;
430 PRINT " Press number in < > for:"
440 PRINT "   <1> Square outer shield, square centre conductor"
450 PRINT "   <2> Square outer shield, round centre conductor"
460 PRINT
470 PRINT "   <0> EXIT";
480 Z$=INKEY$:IF Z$=""THEN 480
490 IF Z$="0"THEN CLS:CHAIN GO$
500 IF Z$="1"THEN 540
510 IF Z$="2"THEN 1310
520 GOTO 480
530 :REM'
540 :REM'.....square/square
550 CLS
560 PRINT " SQUARE TRANSMISSION LINE with SQUARE Inner Conductor"
570 PRINT UL$;
580 GOSUB 190
590 PRINT " Press number in < > to:"
600 PRINT UL$;
610 PRINT "  <1> Calculate impedance - ";
620 PRINT "centre conductor and shield sizes known"
630 PRINT "  <2> Calculate shield size - ";
640 PRINT "centre conductor size and impedance known"
650 PRINT "  <3> Calculate centre conductor size - ";
660 PRINT "shield size and impedance known"
670 Z$=INKEY$:IF Z$=""THEN 670
680 IF Z$="1"THEN 730
690 IF Z$="2"THEN 890
700 IF Z$="3"THEN 1040
710 GOTO 670
720 :REM'
730 :REM'.....calculate impedance
740 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
750 PRINT " ENTER: Side of centre conductor outer face (";U$;")...";
760 INPUT Z:DCNTR=Z/U
770 MAX1=29.399999618530273!*DCNTR:MAX2=4*DCNTR
780 PRINT
790 COLOR 0,7:PRINT " Maximum shield inner face =";MAX1*U;U$
800 COLOR 7,0:PRINT
810 PRINT " ENTER: Side of shield inner face (";U$;").............";:INPUT Z
820 IF Z>MAX1*U+9.999999974752427e-07! THEN BEEP:GOTO 770
830 DSHLD=Z/U
840 GAP=(DSHLD-DCNTR)/2
850 BKV=GAP*21000.0!
860 ZOSQSQ=ZDIEL*(1/(4*(2*DCNTR/(DSHLD-DCNTR)+0.5580000281333923!)))
870 GOSUB 1190:GOTO 2410
880 :REM'
890 :REM'.....calculate shield
900 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
910 PRINT " ENTER: Side of centre conductor outer face (";U$;")...";
920 INPUT Z:DCNTR=Z/U
930 INPUT " ENTER: Desired impedance (maximum 150 ohms)........";ZOSQSQ
940 IF ZOSQSQ>150 THEN BEEP:GOTO 930
950 SH=0:X=1
960 SH=SH+X
970 ZO=ZDIEL*(1/(4*(2*DCNTR/(SH-DCNTR)+0.5580000281333923!)))
980 IF ABS(ZO-ZOSQSQ)<9.999999747378752e-05! THEN 1010
990 IF ZO>ZOSQSQ THEN SH=SH-X:X=X/10:GOTO 960
1000 GOTO 960
1010 DSHLD=SH:GAP=(DSHLD-DCNTR)/2:BKV=GAP*21000.0!
1020 GOSUB 1190:GOTO 2410
1030 :REM'
1040 :REM'.....calculate inner conductor
1050 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1060 PRINT " ENTER: Side of shield inner face (";U$;").............";:INPUT Z
1070 DSHLD=Z/U
1080 INPUT " ENTER: Desired impedance (maximum 150 ohms)........";ZOSQSQ
1090 IF ZOSQSQ>150 THEN BEEP:GOTO 930
1100 CN=0:X=1
1110 CN=CN+X
1120 ZO=ZDIEL*(1/(4*(2*CN/(DSHLD-CN)+0.5580000281333923!)))
1130 IF ABS(ZO-ZOSQSQ)<9.999999747378752e-05! THEN 1160
1140 IF ZO<ZOSQSQ THEN CN=CN-X:X=X/10:GOTO 1110
1150 GOTO 1110
1160 DCNTR=CN:GAP=(DSHLD-DCNTR)/2:BKV=GAP*21000.0!
1170 GOSUB 1190:GOTO 2410
1180 :REM'
1190 :REM'.....display
1200 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1210 PRINT USING" Side of centre conductor (outer face)..= ###.### "+U$;DCNTR*U
1220 PRINT USING" Side of outer shield (inner face)......= ###.### "+U$;DSHLD*U
1230 PRINT USING" Air gap between shield and conductor...= ###.### "+U$;GAP*U
1240 PRINT USING" Transmission Line Impedance............= ###.### ohms";ZOSQSQ
1250 PRINT USING" Air gap breakdown voltage (approx.)....= ###,### volts";BKV
1260 PRINT UL$;
1270 IF DSHLD/DCNTR<=5 THEN 1290
1280 GOSUB 2300
1290 GOTO 2410
1300 :REM'
1310 :REM'.....square/round
1320 CLS
1330 PRINT " SQUARE TRANSMISSION LINE with ROUND Inner Conductor"
1340 PRINT UL$;
1350 GOSUB 190
1360 PRINT " Press number in < > to:"
1370 PRINT UL$;
1380 PRINT "  <1> Calculate impedance - ";
1390 PRINT "centre conductor and shield sizes known"
1400 PRINT "  <2> Calculate shield size - ";
1410 PRINT "centre conductor size and impedance known"
1420 PRINT "  <3> Calculate centre conductor size - ";
1430 PRINT "shield size and impedance known"
1440 Z$=INKEY$:IF Z$=""THEN 1440
1450 IF Z$="1"THEN 1500
1460 IF Z$="2"THEN 1660
1470 IF Z$="3"THEN 1820
1480 GOTO 1440
1490 :REM'
1500 :REM'.....calculate impedance
1510 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1520 PRINT " ENTER: Diameter of centre conductor (";U$;")..........";
1530 INPUT Z:DCNTR=Z/U
1540 MAX1=11.300000190734863!*DCNTR:MAX2=4*DCNTR
1550 PRINT
1560 COLOR 0,7:PRINT " Maximum shield inner face =";MAX1*U;U$;" "
1570 COLOR 7,0:PRINT
1580 PRINT " ENTER: Side of shield inner face (";U$;").............";
1590 INPUT Z
1600 IF Z>MAX1*U+9.999999974752427e-07! THEN BEEP:GOTO 1550
1610 DSHLD=Z/U
1620 GAP=(DSHLD-DCNTR)/2:BKV=GAP*21000.0!
1630 ZOSQRD=(NZERO/(2*PI*SQR(EPSLNR)))*LOG((1.0786999464035034!*DSHLD)/DCNTR)
1640 GOSUB 1980:GOTO 2410
1650 :REM'
1660 :REM'.....calculate shield
1670 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1680 PRINT " ENTER: Diameter of centre conductor (";U$;")..........";
1690 INPUT Z:DCNTR=Z/U
1700 INPUT " ENTER: Desired impedance (maximum 150 ohms)........";ZOSQRD
1710 IF ZOSQRD>150 THEN  BEEP:GOTO 1700
1720 SH=0:X=1
1730 SH=SH+X
1740 ZO=(NZERO/(2*PI*SQR(EPSLNR)))*LOG((1.0786999464035034!*SH)/DCNTR)
1750 IF ABS(ZO-ZOSQRD)<9.999999747378752e-05! THEN 1780
1760 IF ZO>ZOSQRD THEN SH=SH-X:X=X/10:GOTO 1730
1770 GOTO 1730
1780 DSHLD=SH:GAP=(DSHLD-DCNTR)/2:BKV=GAP*21000.0!
1790 PRINT UL$;
1800 GOSUB 1980:GOTO 2410
1810 :REM'
1820 :REM'.....calculate inner conductor
1830 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1840 PRINT " ENTER: Side of shield inner face (";U$;").............";:INPUT Z
1850 DSHLD=Z/U
1860 INPUT " ENTER: Desired impedance (maximum 150 ohms)........";ZOSQRD
1870 IF ZOSQRD>150 THEN BEEP:GOTO 1860
1880 CN=0:X=1
1890 CN=CN+X
1900 ZO=(NZERO/(2*PI*SQR(EPSLNR)))*LOG((1.0786999464035034!*DSHLD)/CN)
1910 IF ABS(ZO-ZOSQRD)<9.999999747378752e-05! THEN 1940
1920 IF ZO<ZOSQRD THEN CN=CN-X:X=X/10:GOTO 1890
1930 GOTO 1890
1940 DCNTR=CN:GAP=(DSHLD-DCNTR)/2:BKV=GAP*21000.0!
1950 PRINT UL$;
1960 GOSUB 1980:GOTO 2410
1970 :REM'
1980 :REM'.....display
1990 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
2000 PRINT USING" Diameter of centre conductor...........= ###.### "+U$;DCNTR*U
2010 PRINT USING" Side of outer shield (inner face)......= ###.### "+U$;DSHLD*U
2020 PRINT USING" Min. gap between shield and conductor..= ###.### "+U$;GAP*U
2030 PRINT USING" Transmission Line Impedance............= ###.### ohms";ZOSQRD
2040 :REM'PRINT
2050 PRINT USING" Air gap breakdown voltage (approx.)....= ###,### volts";BKV
2060 PRINT UL$;
2070 IF DSHLD/DCNTR<=5 THEN 1290
2080 GOSUB 2300
2090 GOTO 2410
2100 RETURN
2110 :REM'
2120 :REM'.....prologue
2130 PRINT " Properties of square coaxial transmission line include:"
2140 PRINT " - Can handle high-voltage high-power loads."
2150 PRINT " - Can be designed for a wide range of impedances."
2160 PRINT " - High velocity factor - approximately 99%"
2170 PRINT " - Low-loss air dielectric."
2180 PRINT " - Superior mechanical strength and rigidity."
2190 PRINT " - Centre conductor can be square or round - buss bar, rod or tub";
2200 PRINT "ng.          "
2210 PRINT " - Shield can be homebrewed from metal flashing or ventilating du";
2220 PRINT "ct material. "
2230 PRINT " - Easier and cheaper to build than round line, especially for he";
2240 PRINT "avy duty use."
2250 PRINT " - Useful for applications requiring waveguide-type construction."
2260 PRINT " - Good for complex filter, duplexer, multiple input/output etc. ";
2270 PRINT "networks.    "
2280 RETURN
2290 :REM'
2300 :REM'.....accuracy note
2310 PRINT " When the shield size is near or greater than five times the inne";
2320 PRINT "r conductor   "
2330 PRINT " size (as in the above case) calculation accuracy begins to degra";
2340 PRINT "de. Therefore "
2350 PRINT " it is recommended that a sample section be made and the impedanc";
2360 PRINT "e measured to "
2370 PRINT " verify the calculated value, before starting final construction."
2380 PRINT UL$;
2390 RETURN
2400 :REM'
2410 :REM'.....end
2420 C=18:COLOR 0,7
2430 LOCATE ,C:PRINT "   ┌──┐                                       "
2440 LOCATE ,C:PRINT "   └┬┬┘«──── Nylon screw, all four sides      "
2450 LOCATE ,C:PRINT "   ┌┼┼┐«──── Nylon nuts epoxy glued to shield "
2460 LOCATE ,C:PRINT "═══╧╪╪╧═╕«── Outer shield                     "
2470 LOCATE ,C:PRINT "════╧╧══╧╕«─ Inner conductor                  "
2480 LOCATE ,C:PRINT "════╤╤══╤╛                                    "
2490 LOCATE ,C:PRINT "═══╤╪╪╤═╛                                     "
2500 LOCATE ,C:PRINT "   └┼┼┘                                       "
2510 LOCATE ,C:PRINT "   ┌┴┴┐      SUGGESTED CONSTRUCTION           "
2520 LOCATE ,C:PRINT "   └──┘                                       "
2530 COLOR 7,0:GOSUB 2550:GOTO 280
2540 :REM'
2550 :REM'PRT
2560 KEY OFF:GOSUB 2630:LOCATE 25,5:COLOR 0,2
2570 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2580 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2590 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2590 :ELSE GOSUB 2630
2600 IF Z$="3"THEN RETURN
2610 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2620 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2560
2630 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
