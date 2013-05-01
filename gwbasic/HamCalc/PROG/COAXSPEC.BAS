10 :REM'COAXSPEC - Coax Cable Primer - 04 AUG 01 rev.28 AUG 01
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PROG$="coaxspec"
60 COMMON EX$,PROG$
70 VIEW PRINT
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " COAXIAL CABLE PRIMER"TAB(54)"by Roland Richardson W4WOI ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 PRINT " Coaxial cables are used for the transmission of high frequency el";
170 PRINT "ectrical     "
180 PRINT " energy from 60 KHz to 26 GHz. There are two basic types, flexible";
190 PRINT " and semi-   "
200 PRINT " rigid. A coaxial cable has a center conductor surrounded by an ou";
210 PRINT "ter          "
220 PRINT " conductor, the two being separated by dielectric material. The in";
230 PRINT "ner conductor"
240 PRINT " is usually a solid or stranded wire, the best conductor being sil";
250 PRINT "ver plated   "
260 PRINT " solid annealed copper wire. The outer conductor is usually a sing";
270 PRINT "le or double "
280 PRINT " braided shield of small copper wire woven into a tight covering. ";
290 PRINT "The          "
300 PRINT " dielectric materials are selected for low loss, temperature and e";
310 PRINT "lectrical    "
320 PRINT " characteristics; polyethylene and air-Teflon types being the best."
330 PRINT
340 PRINT " This program calculates and displays many of the characteristics ";
350 PRINT "of coaxial   "
360 PRINT " cables. These are:"
370 PRINT
380 PRINT "     1. Zo - in ohms     Characteristic impedance"
390 PRINT "     2.  C - in pF/ft    Capacitance"
400 PRINT "     3.  A - in dB/100'  Attenuation"
410 PRINT "     4. VP - in % of e   Velocity of propagation"
420 PRINT "     5. DR - Altitude derated operating voltage"
430 PRINT "     6. TD - 101.67/VP in nanoseconds per foot"
440 PRINT "     7.  e - dielectric constant"
450 COLOR 0,7:LOCATE 24,23
460 PRINT " Press 1 to continue or 0 to EXIT ";:COLOR 7,0
470 Z$=INKEY$:IF Z$=""THEN 470
480 IF Z$="0"THEN CLS:CHAIN EX$
490 IF Z$="1"THEN LOCATE 24,23:PRINT STRING$(36,32);:GOTO 510
500 GOTO 470
510 GOSUB 2250
520 CLS:COLOR 0,7,0
530 PRINT " The following abreviations are used throughout this program:"
540 COLOR 7,0
550 PRINT " C = capacitance in pF/ft.           d = outer dia. of inner cond";
560 PRINT "uctor"
570 PRINT " ƒ = frequency in MHz                PF= power factor"
580 PRINT " D = inner dia. of outer conductor   e = dielectric constant"
590 PRINT " K1= conductor stranding factor      K2= braiding stranding factor"
600 PRINT " Zo= characteristic impedance (Ω)    TD= time delay"
610 PRINT " A = attenuation in dB/100 feet"
620 PRINT " VP= velocity of propagation in % of the speed of light"
630 COLOR 0,7
640 PRINT "  The algorithm used in the calculations is:"
650 COLOR 7,0
660 PRINT "   Zo =  138/√(e)*log(D/d) in ohms"
670 PRINT "   C  =  7.26*(e)/log(D/d) in pF/ft."
680 PRINT "   A1 =  .435/Zo*((Rs/d)+(Rb/D))*√(F)+2.78*(PF*√(e*ƒ)) in dB"
690 PRINT "   A2 =  (4.6*√(ƒ)*(D+d)/D*d*((log(D/d))))*10E-6 in dB"
700 PRINT "   VP =  1/√(e) in %"
710 PRINT "   TD =  101.67/VP in nanoseconds per foot "
720 PRINT "   DR = VBd @ msl*(1-(alt*Pr))"
730 PRINT "   Where:   DR = Derated operating voltage"
740 PRINT "           VBd = rated breakdown voltage at mean sea level"
750 PRINT "           msl = mean sea level; amsl = above mean sea level"
760 PRINT "           alt = altitude amsl in Kft"
770 PRINT "           Pr  = for 1/4 inch coax - Pr = .7857% per K amsl"
780 PRINT "                 for 3/8 inch coax - Pr = .8928% per K amsl"
790 PRINT "                 for 1/2 inch coax - Pr = .9786% per K amsl"
800 PRINT "                 for 3/4 inch coax - Pr = 1.0072% per K amsl";
810 GOSUB 2260
820 CLS
830 PRINT " Some values of dielectric constants (e) of the more common diele";
840 PRINT "ctric cores   "
850 PRINT " are listed here. Select a value to be used in these studies of c";
860 PRINT "oaxial cable. "
870 PRINT " Air=1 is the reference:"
880 PRINT
890 PRINT "   Material                        Diel Const     %VP"
900 PRINT "   ===================================================="
910 PRINT "   Foamed Polyethylene                   1.55     80"
920 PRINT "   Foamed FEP                            1.6      79"
930 PRINT "   Cellular Polyethylene                 1.75     76"
940 PRINT "   Polytetrafluoethylene (PTFE)          2.4 nom  64.5"
950 PRINT "   Flourinated Ethylene Propylene (FEP)  2.15     68"
960 PRINT "   Polyethylene - High Pressure          2.26     66.5"
970 PRINT "   Polyethylene - Nominal                2.3      65.9"
980 PRINT "   Polyethylene - Low Pressure           2.34     65.4"
990 PRINT "   Butyl Rubber                          2.37     65"
1000 PRINT "   Polystyrene                           2.5      63.2"
1010 PRINT "   Nylon                                 3.0      57.7"
1020 PRINT "   Silicon Rubber                        3.1      56.8"
1030 PRINT "   Polysulfone                       3.5-3.9      53.5-50.6"
1040 PRINT "   Magnesium Oxide                       3.6      52.7"
1050 PRINT "   Polyimide G-30                        4.2      48.8"
1060 PRINT "   Epoxy\glass FR-4 Generic              4.3      48.2"
1070 PRINT "   Epoxy\glass G-10 Generic        4.3 ± 0.05     48.5-47.9";
1080 GOSUB 2260
1090 CLS
1100 PRINT " The stranding factors K1 listed below are for the more popular in";
1110 PRINT "nner         "
1120 PRINT " conductor stranded conductors.  The stranding factor for a single";
1130 PRINT " solid       "
1140 PRINT " conductor is 1.000. This is the reference:"
1150 PRINT
1160 PRINT "         1 conductor                      1.000"
1170 PRINT "         7 conductors                      .939"
1180 PRINT "        19 conductors                      .970"
1190 PRINT "        37 conductors                      .980"
1200 PRINT
1210 PRINT " The braiding factor K2 varies from manufacturer to manufacturer b";
1220 PRINT "ut for most  "
1230 PRINT " Amateur radio applications it may be assumed that K2 = 1.0       "
1240 PRINT :LN=CSRLIN
1250 GOSUB 2260:LOCATE LN,19
1260 COLOR 0,7:PRINT " Press 1 to do a calculation or 0 to QUIT ":COLOR 7,0
1270 Z$=INKEY$:IF Z$="" THEN 1270
1280 IF Z$="0"THEN 90
1290 IF Z$="1"THEN 1320
1300 GOTO 1270
1310 :REM'
1320 :REM'.....calculate
1330 D1=0:D2=0:E=0:VP=0:K1=0:K2=0:F=0:PF=0:AL=0:VB=0:DR=0
1340 VIEW PRINT:CLS
1350 LOCATE ,24:PRINT " COAXIAL CABLE CHARACTERISTICS "
1360 VIEW PRINT 2 TO 24
1370 :REM'
1380 CLS
1390 GOSUB 2000
1400 INPUT " ENTER: Inner diameter of outer conductor (inches)";D1
1410 D1$=" Inner diameter of outer conductor.................D= ######.###"
1420 D1$=D1$+CHR$(34)
1430  GOSUB 2000
1440 INPUT " ENTER: Outer diameter of inner conductor (inches)";D2
1450 D2$=" Outer diameter of inner conductor.................d= ######.###"
1460 D2$=D2$+CHR$(34)
1470  GOSUB 2000
1480 INPUT " ENTER: Dielectric constant";E
1490 E$= " Dielectric constant...............................e= ######.###"
1500  GOSUB 2000
1510 VP=1/SQR(E)*100
1520 VP$=" Velocity of propagation (% of speed of light)... VP= ######.###%"
1530  GOSUB 2000
1540 TD=101.66999816894531!/VP
1550 TD$=" Time delay.......................................TD= ######.###"
1560 TD$=TD$+" nanosec./foot"
1570  GOSUB 2000
1580 ZO=138/SQR(E)*LOG(D1/D2)/LOG(10)  :REM'convert to log base 10
1590 ZO$=" Characteristic impedance.........................Zo= ######.### ohms"
1600  GOSUB 2000
1610 C=7.260000228881836!*E/LOG(D1/D2)*LOG(10)
1620 C$=" Capacitance......................................Zo= ######.### pF/ft"
1630  GOSUB 2000
1640 INPUT " ENTER: Inner conductor stranding factor";K1
1650 K1$=" Inner conductor stranding factor.................K1= ######.###"
1660  GOSUB 2000
1670 K2=1
1680 K2$=" Braiding factor (assumed)........................K2= ######.###"
1690  GOSUB 2000
1700 INPUT " ENTER: Frequency, in MHz";F
1710 F$ =" Frequency.........................................ƒ= ######.### MHz"
1720  GOSUB 2000
1730 INPUT " ENTER: Power factor";PF
1740 PF$=" Power factor.....................................PF= ######.###"
1750 IF PF=0 THEN PF=1*10^-8
1760  GOSUB 2000
1770 A=0.4350000023841858!/(ZO*D1)*D1/D2*(K1+K2)*SQR(F)+2.7799999713897705!*SQR(E)*PF*F
1780 A$ =" Attenuation per 100 feet..........................A= ######.### dB"
1790  GOSUB 2000
1800 INPUT " ENTER: Altitude in feet above sea level";AL
1810 AL$=" Altitude above sea level.........................AL= ###### feet"
1820 IF AL=0 THEN AL=1*10^-8
1830  GOSUB 2000
1840 PR=0.7857000231742859!
1850 IF D1>0.375! THEN PR=0.892799973487854!
1860 IF D1>0.5!   THEN PR=0.978600025177002!
1870 IF D1>0.75!  THEN PR=1.007200002670288!
1880 PR$=" Altitude air pressure factor.....................PR= ######.####"
1890 GOSUB 2000
1900 INPUT " ENTER: Max. RMS operating volts at sea level";VB
1910 VB$=" Max. RMS operating volts at sea level............VB= ###### volts"
1920  GOSUB 2000
1930 DR=VB*(1-AL/10^3*PR/100)
1940 DR$=" De-rated breakdown voltage due to altitude.......DR= ###### volts"
1950  GOSUB 2000
1960 VIEW PRINT:COLOR 7,0
1970 GOTO 2230
1980 END
1990 :REM'
2000 :REM'.....display
2010 COLOR 7,0
2020 CLS
2030 IF D1 THEN PRINT USING D1$;D1
2040 IF D2 THEN PRINT USING D2$;D2
2050 IF E  THEN PRINT USING E$ ;E
2060 IF VP THEN PRINT USING VP$;VP
2070 IF TD THEN PRINT USING TD$;TD
2080 IF ZO THEN PRINT USING ZO$;ZO
2090 IF C  THEN PRINT USING C$ ;C
2100 IF K1 THEN PRINT USING K1$;K1
2110 IF K2 THEN PRINT USING K2$;K2
2120 IF F  THEN PRINT USING F$ ;F
2130 IF PF THEN PRINT USING PF$;PF
2140 IF A  THEN PRINT USING A$ ;A
2150 IF AL THEN PRINT USING AL$;AL
2160 IF PR THEN PRINT USING PR$;PR
2170 IF VB THEN PRINT USING VB$;VB
2180 IF DR THEN PRINT USING DR$;DR
2190 PRINT
2200 COLOR 0,7
2210 RETURN
2220 :REM'
2230 :REM'.....end
2240 GOSUB 2260:GOTO 90
2250 :REM'
2260 :REM'.....PRT
2270 GOSUB 2330:LOCATE 25,18:COLOR 0,2
2280 PRINT " Press #»▌1=Print▌2=Print/Form Feed▌3=Continue";:COLOR 7,0
2290 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2290 :ELSE GOSUB 2330
2300 IF Z$="3"THEN RETURN
2310 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2320 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2270
2330 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
