10 :REM'KFACTOR - for Antennas - 06 MAY 96 rev.11 APR 97
20 :REM'edited-for-HAMCALC version of KNEC.BAS, by L.B.Cebik, W4RNL
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 CLS:KEY OFF
70 COLOR 7,0,1
80 I$=CHR$(34)+" ="
90 UL$=STRING$(80,205)
100 U1$="#####.##"
110 U2$="####.####"
120 X$=STRING$(79,32)
130 :REM'
140 :REM'.....title
150 CLS:F=0
160 COLOR 15,2
170 PRINT " K-FACTOR & ANTENNA LENGTH (NEC-2)";TAB(62);"by L.B.Cebik W4RNL ";
180 PRINT STRING$(80,32);
190 LOCATE CSRLIN-1,20:PRINT "Edited for HAMCALC by George Murphy VE3ERP";
200 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
210 :REM'
220 GOSUB 2160    :REM'preface
230 COLOR 0,7:LOCATE 25,22
240 PRINT " Press 1 to continue or 0 to EXIT.....";
250 COLOR 7,0
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="0"THEN CLS:CHAIN GO$
280 IF Z$="1"THEN CLS:GOTO 300
290 GOTO 260
300 CLS
310 PRINT " Press number in < > to choose standard units of measure:"
320 PRINT UL$;
330 PRINT "  < 1 >  Metric"
340 PRINT "  < 2 >  U.S.A./Imperial"
350 PRINT UL$;
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="1"THEN UM=1:GOTO 400
380 IF Z$="2"THEN UM=2:GOTO 400
390 GOTO 360
400 CLS
410 PRINT " Press number in < > for:"
420 PRINT UL$;
430 PRINT "  < 3 >  Horizontal antenna lengths from 1 to 7 half-wavelengths"
440 PRINT
450 PRINT "  < 4 >  Vertical antenna lengths from 1 to 7 quarter-wavelengths"
460 IF VK=1 THEN 500
470 PRINT
480 PRINT "  < 5 >  Table of values of K, with lengths of ¼-wavelength vertical"
490 PRINT "         and ½-wavelength horizontal antennas"
500 Z$=INKEY$:IF Z$=""THEN 500
510 IF Z$="3"THEN HV=1:GOTO 560
520 IF Z$="4"THEN HV=0.5!:GOTO 560
530 IF Z$="5"THEN VK=1:GOTO 1350
540 GOTO 500
550 :REM'
560 :REM'.....Option A calculations
570 CLS
580 COLOR 15,2:PRINT STRING$(80,32);
590 LOCATE 1,8
600 IF HV=0.5! THEN 630
610 PRINT "Table of Horizontal Antenna Lengths from 1 to 7 Half-Wavelengths"
620 IF HV=1 THEN 640
630 PRINT "Table of Vertical Antenna Lengths from 1 to 7 Quarter-Wavelengths"
640 COLOR 7,0
650 PRINT
660 PRINT " AWG Wire sizes are copper. Other conductor sizes are aluminum.";
670 IF HV=0.5! THEN PRINT " Vertical antennas assumed to be over perfect ground."
680 PRINT UL$;
690 IF F*WLF THEN 750
700 COLOR 0,7:INPUT " ENTER: Frequency of interest in MHz......",F
710 COLOR 7,0
720 IF F<3 OR F>30 THEN LOCATE CSRLIN-1:PRINT X$:LOCATE CSRLIN-1:GOTO 700
730 WLF=983.5712280273438!/F       :REM'speed of light = 983.5712 feet per second
740 LOCATE CSRLIN-1:PRINT X$:LOCATE CSRLIN-1
750 PRINT" Frequency =";F;"MHz";
760 IF UM=1 THEN M=0.30480000376701355!:F$="metres"
770 IF UM=2 THEN M=1:F$="feet"
780 IF HV=1 THEN W$="½"
790 IF HV=0.5! THEN W$="¼"
800 M$=" Lengths in "+F$+" for N no. of "+W$+"-wavelengths "
810 PRINT TAB(25)"Wavelength in Free Space =";:PRINT USING "####.##";WLF*M;
820 PRINT" ";F$
830 PRINT UL$;
840 PRINT " ┌──── Wire Size ────┐";
850 PRINT TAB(25)"┌───────";SPC(39);"───────┐"
860 LOCATE CSRLIN-1,(52-LEN(M$)/2):PRINT M$
870 PRINT " AWG";
880 PRINT TAB(27);"N=1     N=2     N=3     N=4     N=5     N=6     N=7"
890 PRINT UL$;
900 FOR A=1 TO 14
910 ONA GOTO 930,940,950,960,970,980,990,1000,1010,1020,1030,1040,1050,1060
920 :REM'
930 W$=" #18-0.0403":LQL=959.4349975585938!:LQH=95.33499908447266!:LTL=6848.8701171875!:LTH=684.8200073242188!:GOTO 1080
940 W$=" #16-0.0508":LQL=959.1829833984375!:LQH=95.25199890136719!:LTL=6850.52978515625!:LTH=684.7999877929688!:GOTO 1080
950 W$=" #14-0.0641":LQL=958.885009765625!:LQH=95.15399932861328!:LTL=6851.669921875!:LTH=684.7680053710938!:GOTO 1080
960 W$=" #12-0.0808":LQL=958.47802734375!:LQH=95.04798889160156!:LTL=6852.43017578125!:LTH=684.698974609375!:GOTO 1080
970 W$=" #10-0.1019":LQL=958.0009765625!:LQH=94.93099975585938!:LTL=6852.81005859375!:LTH=684.6179809570312!:GOTO 1080
980 W$=" 0.125"     :LQL=957.219970703125!:LQH=94.80699920654297!:LTL=6850.9501953125!:LTH=684.4500122070312!:GOTO 1080
990 W$=" 0.250"     :LQL=955.3599853515625!:LQH=94.3499984741211!:LTL=6851.31005859375!:LTH=684.0819702148438!:GOTO 1080
1000 W$=" 0.500"     :LQL=952.8499755859375!:LQH=93.73400115966797!:LTL=6850.0498046875!:LTH=683.5499877929688!:GOTO 1080
1010 W$=" 0.750"     :LQL=951.030029296875!:LQH=93.2750015258789!:LTL=6848.58984375!:LTH=683.1439819335938!:GOTO 1080
1020 W$=" 1.000"     :LQL=949.5800170898438!:LQH=92.89800262451172!:LTL=6847.4599609375!:LTH=682.8200073242188!:GOTO 1080
1030 W$=" 1.250"     :LQL=948.3099975585938!:LQH=92.57499694824219!:LTL=6846.2001953125!:LTH=682.5549926757812!:GOTO 1080
1040 W$=" 1.500"     :LQL=947.219970703125!:LQH=92.29199981689453!:LTL=6845.25!:LTH=682.3319702148438!:GOTO 1080
1050 W$=" 1.750"     :LQL=946.219970703125!:LQH=92.03800201416016!:LTL=6844.27978515625!:LTH=682.1400146484375!:GOTO 1080
1060 W$=" 2.000"     :LQL=945.2999877929688!:LQH=91.8119888305664!:LTL=6843.4501953125!:LTH=681.9829711914062!:GOTO 1080
1070 :REM'
1080 Q=2950.7136#:LQW=Q/F:LQWH=Q/30:LQWL=Q/3:KQH=LQH/LQWH:KQL=LQL/LQWL
1090 KTH=LTH/(3*LQWH):KTL=LTL/(3*LQWL)
1100 EE=(((F/3)-1)*0.03333330154418945!)+0.6100000143051147!:KQW=KQH+((0.4343000054359436!*LOG(30/F))^EE)*(KQL-KQH)
1110 KTQ=KTH+((0.4343000054359436!*LOG(30/F))^EE)*(KTL-KTH)
1120 LQ=KQW*LQW:LT=KTQ*(3*LQW):KE=(6*LQ)/(LT-LQ):KM=KQW/KE
1130 IF A<=5 THEN MM=VAL(RIGHT$(W$,5)):ELSE MM=VAL(W$)
1140 MM=MM*25.399999618530273!
1150 IF A>5 THEN PRINT SPC(6);
1160 PRINT W$;I$;
1170 LOCATE CSRLIN,15:PRINT USING "##.#";MM;:PRINT "mm";
1180 LOCATE CSRLIN,23
1190 FOR B=1 TO 7
1200 BB=B-1:LD=(2*LQW)/12:LL=((BB*LD)*KM)+(KQW*LD)
1210 PRINT USING U1$;LL*M*HV;
1220 NEXT B
1230 NEXT A
1240 :REM'
1250 GOSUB 2380     :REM'screen dump
1260 LOCATE 25,1:PRINT X$;:LOCATE 25,8:COLOR 15,2
1270 PRINT " Do you want (a)nother run, (v)alues of K, or (q)uit?    (a/v/q) ";
1280 COLOR 7,0
1290 Z$=INKEY$:IF Z$=""THEN 1290
1300 IF Z$="a"THEN F=0:GOTO 560
1310 IF Z$="v"THEN VK=1:GOTO 1350
1320 IF Z$="q"THEN 140
1330 GOTO 1290
1340 :REM'
1350 :REM'.....Option B calculations
1360 CLS
1370 COLOR 15,2:PRINT STRING$(80,32);
1380 LOCATE 1,16:PRINT "Calculation of K, the Antenna Shortening Factor"
1390 COLOR 7,0
1400 LOCATE 3,1
1410 PRINT" KT is the total shortening factor. KM is the shortening factor";
1420 PRINT" due to element"
1430 PRINT" material. KE is the shortening factor due to end effect. Values";
1440 PRINT" calibrated to"
1450 PRINT" NEC-2 models for 3-30 MHz.  AWG sizes are copper. Other sizes";
1460 PRINT" are aluminum."
1470 PRINT UL$;
1480 IF F*WLF THEN 1550
1490 COLOR 0,7
1500 INPUT " ENTER: Frequency of interest in MHz......",F
1510 COLOR 7,0
1520 IF F<3 OR F>30 THEN LOCATE CSRLIN-1:PRINT X$:LOCATE CSRLIN-1:GOTO 1490
1530 WLF=983.5712280273438!/F
1540 LOCATE CSRLIN-1:PRINT X$
1550 IF UM=1 THEN M$=" metres":Z=0.30480000376701355!
1560 IF UM=2 THEN M$=" feet":Z=1
1570 LOCATE 7,1:PRINT" Frequency =";F;"MHz.    Wavelength in Free Space =";
1580 PRINT USING "####.##";WLF*Z;:PRINT M$
1590 IF UM=1 THEN M$="Lgth (m.)"
1600 IF UM=2 THEN M$="Lgth (ft)"
1610 LOCATE 8:PRINT "┌──── Wire Size ────┐"
1620 LOCATE 8,49:PRINT " ¼-wave Vertical  ½-wave Dipole ";
1630 LOCATE 9:PRINT " AWG"
1640 LOCATE 9,26:PRINT"KT       KM       KE"
1650 LOCATE 9,53:PRINT M$;SPC(7);M$
1660 LOCATE 10:PRINT UL$;
1670 FOR A=1 TO 14
1680 ONA GOTO 1700,1710,1720,1730,1740,1750,1760,1770,1780,1790,1800,1810,1820,     1830
1690 :REM'
1700 W$=" #18-0.0403":LQL=959.4349975585938!:LQH=95.33499908447266!:LTL=6848.8701171875!:LTH=684.8200073242188!:GOTO 1840
1710 W$=" #16-0.0508":LQL=959.1829833984375!:LQH=95.25199890136719!:LTL=6850.52978515625!:LTH=684.7999877929688!:GOTO 1840
1720 W$=" #14-0.0641":LQL=958.885009765625!:LQH=95.15399932861328!:LTL=6851.669921875!:LTH=684.7680053710938!:GOTO 1840
1730 W$=" #12-0.0808":LQL=958.47802734375!:LQH=95.04798889160156!:LTL=6852.43017578125!:LTH=684.698974609375!:GOTO 1840
1740 W$=" #10-0.1019":LQL=958.0009765625!:LQH=94.93099975585938!:LTL=6852.81005859375!:LTH=684.6179809570312!:GOTO 1840
1750 W$=" 0.125"     :LQL=957.219970703125!:LQH=94.80699920654297!:LTL=6850.9501953125!:LTH=684.4500122070312!:GOTO 1840
1760 W$=" 0.250"     :LQL=955.3599853515625!:LQH=94.3499984741211!:LTL=6851.31005859375!:LTH=684.0819702148438!:GOTO 1840
1770 W$=" 0.500"     :LQL=952.8499755859375!:LQH=93.73400115966797!:LTL=6850.0498046875!:LTH=683.5499877929688!:GOTO 1840
1780 W$=" 0.750"     :LQL=951.030029296875!:LQH=93.2750015258789!:LTL=6848.58984375!:LTH=683.1439819335938!:GOTO 1840
1790 W$=" 1.000"     :LQL=949.5800170898438!:LQH=92.89800262451172!:LTL=6847.4599609375!:LTH=682.8200073242188!:GOTO 1840
1800 W$=" 1.250"     :LQL=948.3099975585938!:LQH=92.57499694824219!:LTL=6846.2001953125!:LTH=682.5549926757812!:GOTO 1840
1810 W$=" 1.500"     :LQL=947.219970703125!:LQH=92.29199981689453!:LTL=6845.25!:LTH=682.3319702148438!:GOTO 1840
1820 W$=" 1.750"     :LQL=946.219970703125!:LQH=92.03800201416016!:LTL=6844.27978515625!:LTH=682.1400146484375!:GOTO 1840
1830 W$=" 2.000"     :LQL=945.2999877929688!:LQH=91.8119888305664!:LTL=6843.4501953125!:LTH=681.9829711914062!:GOTO 1840
1840 Q=2950.7136#:LQW=Q/F:LQWH=Q/30:LQWL=Q/3:KQH=LQH/LQWH:KQL=LQL/LQWL
1850 KTH=LTH/(3*LQWH):KTL=LTL/(3*LQWL)
1860 EE=(((F/3)-1)*0.03333330154418945!)+0.6100000143051147!:KQW=KQH+((0.4343000054359436!*LOG(30/F))^EE)*(KQL-KQH)
1870 KTQ=KTH+((0.4343000054359436!*LOG(30/F))^EE)*(KTL-KTH)
1880 LQ=KQW*LQW:LT=KTQ*(3*LQW):KE=(6*LQ)/(LT-LQ):KM=KQW/KE
1890 IF KM>0.9998999834060669! THEN KM=0.9998999834060669!
1900 V=KQW*(245.89280700683594!/F):D=V*2
1910 IF A<=5 THEN MM=VAL(RIGHT$(W$,5)):ELSE MM=VAL(W$)
1920 MM=MM*25.399999618530273!
1930 IF A>5 THEN PRINT SPC(4);
1940 PRINT W$;I$;
1950 LOCATE CSRLIN,15:PRINT USING "##.#";MM;:PRINT "mm";
1960 LOCATE CSRLIN,21
1970 PRINT USING U2$;KQW;KM;KE;
1980 IF UM=1 THEN Z=0.30480000376701355!
1990 IF UM=2 THEN Z=1
2000 PRINT SPC(4);USING U1$;V*Z;
2010 PRINT SPC(8);USING U1$;D*Z;
2020 IF A<14 THEN PRINT ""
2030 NEXT A
2040 GOSUB 2380     :REM'screen dump
2050 :REM'
2060 LOCATE 25,1:PRINT X$;:LOCATE 25,8:COLOR 15,2
2070 PRINT " Do you want (a)nother run, (w)ire lengths, or (q)uit?   (a/w/q) ";
2080 COLOR 7,0
2090 Z$=INKEY$:IF Z$=""THEN 2090
2100 IF Z$="a"THEN F=0:GOTO 1350
2110 IF Z$="w"THEN VK=1:GOTO 400
2120 IF Z$="q"THEN 140
2130 GOTO 2090
2140 END
2150 :REM'
2160 :REM'.....preface
2170 T=7
2180 PRINT TAB(T);
2190 PRINT "This program calculates values of the antenna shortening factor and"
2200 PRINT TAB(T);
2210 PRINT "and antenna lengths, including quarter-wave verticals over perfect"
2220 PRINT TAB(T);
2230 PRINT "ground, half-wavelength dipoles in free space, and long wire"
2240 PRINT TAB(T);
2250 PRINT "vertical and horizontal antennas. The frequency limits are 3 to 30"
2260 PRINT TAB(T);
2270 PRINT "MHz. All dimensions are calibrated to NEC-2 antenna models."
2280 PRINT
2290 PRINT TAB(T);
2300 PRINT "Programmed materials are AWG #18 (1.0mm) to AWG #10 (2.6mm) copper"
2310 PRINT TAB(T);
2320 PRINT "wire, and aluminum rod or tubing from 1.125";CHR$(34);" (3.2mm) to";
2330 PRINT " 2";CHR$(34);" (50.8mm)"
2340 PRINT TAB(T);
2350 PRINT "diameter."
2360 RETURN
2370 :REM'
2380 :REM'PRT
2390 KEY OFF:GOSUB 2460:LOCATE 25,5:COLOR 0,2
2400 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2410 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2420 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2420 :ELSE GOSUB 2460
2430 IF Z$="3"THEN RETURN
2440 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2450 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2390
2460 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
