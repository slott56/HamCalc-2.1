10 :REM'QFIND5   Q-L/C Tank Circuit - 29 MAR 09, rev 17 SEPT 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2
90 PRINT " Q Measurment - L/C Tank Circuit"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 15,2:LOCATE CSRLIN-1,25:PRINT " Algorithm by R.J.Dehoney, IEEE "
120 COLOR 7,0
130 :REM'......preamble
140 PRINT
150 PRINT " This program finds the influence of the coupling capacitor on the measured Q."
160 PRINT " The procedure is to find the frequency where the output peaks, note that"
170 PRINT " value, switch out a 3 db pad and tune to find the two frequencies F2 and F1"
180 PRINT " where the output is the same as the noted value. Then the measured Q is"
190 PRINT "            Qmeas = Fpeak/(f2-f1)."
200 PRINT " The equations relating the measured Q with the coil Q are surprisingly"
210 PRINT " complex, so this program can be used to help in this determination."
220 PRINT:PRINT :LN=CSRLIN
230 PRINT "      ┌─────────┐ ┌─Cs───┬─────┬─────┐  We assume Vm is measured with"
240 PRINT "      │         ├─┘      │     │     │  a 20 pF, 10 meg scope probe.                  │ SIGNAL  │        │     │     │  Decrease the calculated value"
250 PRINT "      │GENERATOR│       C1    L1    Vm  of C1 by the actual probe"
260 PRINT "      │         ├─┐      │     │     │  capacitance."
270 PRINT "      └─────────┘ └──────┴─────┴─────┘"
280 PRINT
290 LN=CSRLIN
300 IF FLAG THEN FLAG=0:GOTO 410
310 MHZ=1000000.0! :UH=9.999999974752427e-07! :PF=9.999999960041972e-13! :TP=2*3.1415927#
320 VS=1
330 PRINT " ......Press 1 to continue, 2 for theory or 0 to EXIT......"
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$="0"THEN CLS:RUN GO$
360 IF Z$="2"THEN GOSUB 1100:CLS:Z$="1":GOTO 370
370 IF Z$="1"THEN CLS:FLAG=1:PRINT :PRINT " Q - L/C TANK CIRCUIT"
380 IF Z$>"2" THEN 340
390 LOCATE CSRLIN:PRINT  STRING$(22,205):GOTO 220
400 GOTO 340
410 :REM'.....data inputs
420 GOSUB 1300:INPUT " ENTER: Source resistance (usually 50 ohms)";RS
430 GOSUB 1300:INPUT " ENTER: L1 in µH ",L :L1=L*UH
440 PRINT  " ...The smaller Cs is, the less effect it has on measued Q !..."
450 INPUT " ENTER: Coupling capacitor Cs in pF ";C :CS=C*PF
460 GOSUB 1300:INPUT " ENTER: Frequency in MHz";F0 :W0=F0*TP*MHZ
470 C1=1/W0^2/L1-CS :IF C1>0 THEN 500
480 PRINT" Out of range - Reduce either frequency or Cs....press any key...."
490 Z$=INKEY$:IF Z$=""THEN 490 :ELSE 60
500 CT=C1+CS :REQ=RS/((1+C1/CS)^2+(W0*C1*RS)^2) :QMAX=W0*L1/REQ
510 PRINT "The maximum Q that can be measured with these values is"INT(QMAX)
520 PRINT :PRINT "To increase the Q range, decrease Cs, Rs. or F0. Press 1 to continue or"
530 PRINT "2 to change values."
540 A$=INKEY$ :IF A$="" THEN 540 :ELSE IF A$="2" THEN 410
550 GOSUB 1300:INPUT " ENTER measured Q ";QM :IF QM>QMAX OR QM<1 THEN 550
560 RQ=W0*L1/QM :DRQ=RQ/5 :REM'starting values
570 :REM'---------------find resonant frequency---------------
580 DW=W0/18.700000762939453! :W=W0*0.9300000071525574! :VPK=0.0010000000474974513!
590 AX=-W^2*CS*L1 :BX=W*CS*RQ :CX=1-W^2*CT*L1-W^2*RS*RQ*C1*CS
600 DX=W*CT*RQ+W*CS*RS-W^3*RS*CS*C1*L1
610 VSQ=VS*(AX^2+BX^2)/(CX^2+DX^2) :V=SQR(VSQ)
620 :REM'PRINT V;VPK;W;WPK;DW :INPUT Z
630 IF ABS(V/VPK-VPK/V)<9.999999747378752e-06! THEN 670 :REM'we/re there
640 IF V>VPK THEN VPK=V :WPK=W :W=W+DW :GOTO 590 :REM'we're climbing
650 IF W>WPK THEN W=W-2*DW :DW=DW/3.299999952316284! :GOTO 590 :REM'we've passed the peak
660 W=W+DW :GOTO 590 :REM'we're climbing again.
670 WPK=W :FPK=WPK/TP/MHZ :REM'PRINT "Vpk="VPK" Fpk="FPK
680 :REM'------------------find lower 3dB frequency-----------------
690 DW=WPK/2 :W=WPK*0.4000000059604645! :V3=VPK/SQR(2)
700 AX=-W^2*CS*L1 :BX=W*CS*RQ :CX=1-W^2*CT*L1-W^2*RS*RQ*CS*C1
710 DX=W*CT*RQ+W*CS*RS-W^3*RS*CS*C1*L1
720 VLSQ=(AX^2+BX^2)/(CX^2+DX^2) :VL=SQR(VLSQ)
730 :REM'PRINT VL;V3;W;WPK;DW;RQ :INPUT Z
740 IF ABS(VL/V3-V3/VL)<0.0010000000474974513! THEN 780 :REM'we're there
750 IF W>WPK THEN W=W-2*DW :DW=DW/2 :GOTO 700 :REM'we've passed the peak
760 IF VL>V3 THEN W=W-DW :DW=DW/2 :GOTO 700 "oops, we've passed the 3 dB point"
770 W=W+DW :GOTO 700 :REM'we're climbing back, slower.
780 WL=W :FL=WL/TP/1000000.0! :REM':PRINT "VL="VL"  FL="FL
790 :REM'--------------find upper 3 dB frequency------------------
800 DW=WPK/2 :W=5*WPK
810 AX=-W^2*CS*L1 :BX=W*CS*RQ :CX=1-W^2*CT*L1-W^2*RS*RQ*CS*C1
820 DX=W*CT*RQ+W*CS*RS-W^3*RS*CS*C1*L1
830 VHSQ=(AX^2+BX^2)/(CX^2+DX^2) :VH=SQR(VHSQ)
840 :REM'PRINT VL;V3;W;WPK;DW;RQ :INPUT Z
850 IF ABS(VH/V3-V3/VH)<0.0010000000474974513! THEN 890 :REM'we're there
860 IF W<WPK THEN W=W+2*DW :DW=DW/2 :GOTO 810 :REM'we've passed the peak
870 IF VH>V3 THEN W=W+DW :DW=DW/2 :GOTO 810 "oops, we've passed the 3 dB point"
880 W=W-DW :GOTO 810 :REM'we're climbing back, slower.
890 WH=W :FH=WH/TP/1000000.0! :QCOIL=L1*WPK/RQ :REM':PRINT "VH="VH"  FH="FH
900 Q=WPK/(WH-WL) :REM':IF Q<QM THEN RQ=RQ/1.02 :GOTO 580 :PRINT
910 :REM'PRINT ER;RQ;DRQ;Q;QM :INPUT Z
920 ER=Q/QM-QM/Q :IF ABS(ER)<0.009999999776482582! THEN 950
930 IF Q<QM THEN RQ=RQ-DRQ :GOTO 580
940 IF Q>QM THEN RQ=RQ+DRQ :DRQ=DRQ/2 :RQ=RQ-DRQ :GOTO 580
950 GOSUB 1300 :LN=CSRLIN
960 PRINT USING " Frequency at peak.... ####.# MHz";FPK
970 PRINT USING " 3db bandwidth........ #####.# KHz";(FH-FL)*10^3
980 PRINT USING " L1................... ####.# µH";L1/UH
990 PRINT USING " Measured Q........... ####.#";QM
1000 PRINT USING " Calculated coil Q.... ####.#";QCOIL
1010 PRINT USING " C1................... ####.# pF";C1/PF
1020 PRINT USING " Cs................... ####.# pF";CS/PF
1030 PRINT
1040 PC=ABS(QCOIL-QM)/QM*100
1050 IF Q>=QM THEN PRINT USING " Coil Q is within ###.# % of measured Q";PC
1060 PRINT
1070 INPUT " ENTER 1 to quit or press ENTER for another measured Q";QM
1080 IF QM=1 THEN LOCATE CSRLIN-1:PRINT STRING$(79,32):GOTO 1330
1090 GOSUB 1300 :GOTO 550
1100 :REM'-------------------Theory-----------------------------
1110 CLS
1120 PRINT
1130 PRINT " The program first finds C1 from C1=1/W0^2/L1-CS. It then calculates what the"
1140 PRINT " measured Q would have been had the coil been lossless. The user then can"
1150 PRINT " change the values to increase the Q range or continue with the entered values."
1160 PRINT " It then asks for the actual measured Q, then finds the coil Q. To do this, it"
1170 PRINT " calculates a worst case lower 3 dB frequency. It starts scanning up from that"
1180 PRINT " frequency, calculating Vm until Vm no longer increases then stores both"
1190 PRINT " Fpk and Vpk. It goes back to the starting frequency and scans up until the"
1200 PRINT " output exceeds Vpk/SQR(2). It stores that frequency as W1, then moves to a"
1210 PRINT " calculated worst case upper 3 dB frequency and starts scannng down. When the"
1220 PRINT " output again reaches Vpk/SQR(2), it stores W2, then calculates Q=Wpk/(W2-W1)."
1230 PRINT " It compares Q with the actual measured QM and, if Q<QM, decreases Rq and"
1240 PRINT " repeats the process. When Q=>QM, it calculates the coil Q as Qcoil=W0*L1/Rq,"
1250 PRINT " and displays the values."
1260 PRINT
1270 PRINT " .....press any key....."
1280 Z$=INKEY$:IF Z$=""THEN 1280
1290 RETURN
1300 :REM'.....clear bottom of screen
1310 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1320 RETURN
1330 :REM'.....end
1340 GOSUB 1350:GOTO 60
1350 :REM'.....PRT
1360 KEY OFF:GOSUB 1430:LOCATE 25,5:COLOR 0,2
1370 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1380 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1390 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1390 :ELSE GOSUB 1430
1400 IF Z$="3"THEN RETURN
1410 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1420 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1360
1430 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
