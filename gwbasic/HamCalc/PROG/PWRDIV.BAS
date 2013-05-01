10 :REM'PWRDIV - 08 JAN 2011
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " POWER DIVIDER"TAB(60)" by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....start
110 PRINT
120 GOSUB 300      :REM'get schematic
130 PRINT "This program is based on an article by Greg Adams in the December 2010 issue of"
140 PRINT "High Frequency Electronics, titled `Generalized Power Divider Design'."
150 PRINT :PRINT "Matched resistive Tee attenuators can be modified to provide an auxiliary"
160 PRINT "matched port. Because of the requirement that the ports be matched, the"
170 PRINT "minimum attenuation to the auxiliary port depends on the main port attenuation"
180 PRINT "and the aux port impedance, and cannot be independently specified. The"
190 PRINT "attenuation will be minimum when Z1 is chosen to be near its maxmimum"
200 PRINT "allowable value. A simple impedance matching filter can be used to change Z1."
210 PRINT "Attenuation is given in dB. It represents the ratio of the power delivered to"
220 PRINT "the port load to the power which the source could deliver to a matched load."
230 PRINT
240 PRINT "Press 1 to continue or 0 to exit"
250 A$=INKEY$:IF A$=""THEN 250
260 IF A$="0"THEN CLS:CHAIN GO$
270 IF A$="1"THEN 400
280 GOTO 250
290 GOSUB 300:GOTO 400
300 :REM'.....schematic
310 PRINT "    ┌─Z0──*─Rs─┬─Rs─*──┐  Main"
320 PRINT "    │          Rt      Z0 Port"
330 PRINT "   Vs          │       ╧"
340 PRINT "    │          ├────*──┐"
350 PRINT "    │          Ru      Z1 Auxiliary"
360 PRINT "    ╧          ╧       ╧  Port"
370 LN=CSRLIN:PRINT
380 RETURN
390 PRINT
400 :REM'......display values
410 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
420 INPUT " ENTER: Z0 (ohms)";Z0
430 INPUT " ENTER: Desired attenuation to the main port (dB)";ATT1
440 K1=10^(-ATT1/20)
450 RS=Z0*(1-K1)/(1+K1) :RA=(Z0+RS)/2
460 RX=(Z0^2-RS^2)/2/RS
470 Z1MAX=(Z0*RS+Z0^2)/4/RS :GOSUB 890
480 PRINT " ENTER: Z1 (ohms) less than"Z1MAX"ohms.";:INPUT R1
490 RU=SQR(R1^2*(RA+RX)/(RA+RX-2*R1))
500 RT=RX-RU*R1/(RU+R1)
510 RU1=R1*RU/(R1+RU) :REQ=(RS+Z0)*(RT+RU1)/(RS+Z0+RT+RU1)
520 K3=RU1/(RT+RU1)*REQ/(RS+REQ) :ATT2=-10*LOG(K3^2*Z0/R1)/LOG(10)
530 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
540 PRINT USING " Attenuation to main port...... ###.### dB";ATT1;:PRINT " into"Z0"Ω (Z0)"
550 PRINT USING " Attenuation to auxiliary port. ###.### dB";ATT2;:PRINT " into"R1"Ω (Z1)"
560 PRINT USING " Rs........................... ####.### Ω";RS
570 PRINT USING " Rt........................... ####.### Ω";RT
580 PRINT USING " Ru........................... ####.### Ω";RU
590 CL=CSRLIN
600 PRINT :PRINT "To see the performance with actual values, press <1>. To end press <0>"
610 A$=INKEY$ :IF A$=""THEN 610 :ELSE IF A$="1" THEN 630
620 LOCATE CSRLIN-1:PRINT STRING$(79,32):GOSUB 930:GOTO 10 :REM'........end
630 VIEW PRINT CL TO 24:CLS:VIEW PRINT:LOCATE CL
640 PRINT "   - Actual values to be used -"
650 INPUT " ENTER: Z0 (ohms)";R0:LOCATE CSRLIN-1
660 PRINT USING " Z0........................... ####.### Ω";R0
670 INPUT " ENTER: Z1 (ohms)";R1:LOCATE CSRLIN-1
680 PRINT USING " Z1........................... ####.### Ω";R1
690 INPUT " ENTER: Rs (ohms)";RS:LOCATE CSRLIN-1
700 PRINT USING " Rs........................... ####.### Ω";RS
710 INPUT " ENTER: Rt (ohms)";RT:LOCATE CSRLIN-1
720 PRINT USING " Rt........................... ####.### Ω";RT
730 INPUT " ENTER: Ru (ohms)";RU:LOCATE CSRLIN-1
740 PRINT USING " Ru........................... ####.### ";RU
750 RU1=RU*R1/(RU+R1)
760 ZIN=RS+(RS+R0)*(RT+RU1)/(RS+R0+RT+RU1)
770 VO=2*ZIN/(Z0+ZIN)*(ZIN-RS)/ZIN*R0/(RS+R0)
780 V1=2*(ZIN-RS)/(Z0+ZIN)*RU1/(RT+RU1)
790 ROS=RS+(Z0+RS)*(RT+RU1)/(Z0+RS+RT+RU1)
800 RZ=(RS+R0)*(RS+Z0)/(2*RS+R0+Z0) :R1S=RU*(RT+RZ)/(RU+RT+RZ)
810 ATTM=-10*LOG(VO^2*Z0/R0)/LOG(10):REM''PRINT "Main Port Attenuation ="ATTM"dB
820 LOCATE 15,45:PRINT USING "Main port attenuation...... ##.# dB";ATTM
830 ATTA=-10*LOG(V1^2*Z0/R1)/LOG(10)
840 LOCATE 16,45:PRINT USING "Aux port attenuation....... ##.# dB";ATTA
850 LOCATE 17,45:PRINT USING "Main port source impedance. ###.# Ω";ROS
860 LOCATE 18,45:PRINT USING "Aux port source impedance.. ###.# Ω";R1S
870 LOCATE 19,45:PRINT USING "Input impedance............ ###.# Ω";ZIN
880 GOSUB 930:GOTO 10
890 :REM'----------subroutine to find Z1max-------------
900 R1=0.9990000128746033!*Z1MAX :RU=SQR(R1^2*(RA+RX)/(RA+RX-2*R1))
910 RT=RX-RU*R1/(RU+R1) :IF RT<0 THEN Z1MAX=0.9900000095367432!*R1 :GOTO 900
920 Z1MAX=R1 :GOTO 480
930 :REM'.....PRT
940 KEY OFF:GOSUB 1010:LOCATE 25,5:COLOR 0,2
950 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
960 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
970 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 970 :ELSE GOSUB 1010
980 IF Z$="3"THEN RETURN
990 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1000 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 940
1010 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
