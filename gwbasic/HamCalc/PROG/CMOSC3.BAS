10 :REM'CMOSC3.....CMOS OSCILLATOR - 08 JUN 09
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)
70 :REM'.....title page
80 CLS:KEY OFF
90 COLOR 15,2
100 PRINT " CMOS OSCILLATOR"TAB(61)"by R.J.Dehoney IEEE ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 :REM'----------GATEOSC.BAS, rjd, 6/1/09-----------------
140 GOSUB 250
150 PRINT " Given Fo, L or XL, Q, and M=C1/C2, this program finds C1, C2, and Gmin for"
160 PRINT " an oscillator which uses a two-in CMOS gate as the active element. One use"
170 PRINT " is as the oscillator in a CD4060 divider, or as a one chip, 3 frequency"
180 PRINT  " oscillator with a buffered output and DC switching. The CMOS inverter can be"
190 PRINT " modeled as a gain of about -23 with an RC roll off of .008 µS and an output"
200 PRINT " resistance of 8500 ohms, with about 5 pF on input and output."
210 PRINT
220 PRINT " Optimimum values of capacitance and inductance are calculated, but you"
230 PRINT " have the option to substitute actual values to be used."
240 GOTO 380
250 :REM'......diagram
260 PRINT "  +9vdc────┬───────┐16                  ═════ CMOS OSCILLATOR ═════"
270 PRINT "           │ 1 ┌───┴────┐"
280 PRINT "           └───┤   one  │3"
290 PRINT "             2 │ section├────┬───Out             Notes:"
300 PRINT "           ┌───┤ CD4011 │    │           C1 and C2 values include"
310 PRINT "           │   └────┬───┘    │           about 5 pF chip and stray"
320 PRINT "           │        ╧ 7      │           capacitance. R1 accounts for"
330 PRINT "           ├──── L────R1─────┤           loss in coil L."
340 PRINT "           C2                C1"
350 PRINT "           ╧                 ╧"
360 LN=CSRLIN
370 RETURN
380 PRINT :PRINT TAB(18)" .....Press (1) to continue or (0) to EXIT....."
390 Z$=INKEY$:IF Z$=""THEN 390
400 IF Z$="0"THEN RUN GO$
410 IF Z$="1"THEN CLS:GOSUB 250:GOTO 430
420 GOTO 400
430 :REM'.....data entry
440 TP=8*ATN(1) :MHZ=1000000.0! :PF=9.999999960041972e-13! :UH=9.999999974752427e-07! :US=9.999999974752427e-07!
450 INPUT " ENTER: Frequency (MHz)";F :W=TP*F*MHZ
460 INPUT " ENTER: XL (Ω) or <ENTER> ";XL :IF XL<>0 THEN 480
470 INPUT " ENTER: L (uH)";L :XL=W*L*UH :IF L=0 THEN 450
480 L=XL/W
490 INPUT " ENTER: Q VALUE";Q
500 :REM'NOTE: M = C1 /C2....( suggested value is 1 )
510 M=1   :REM'...initial ratio C1/C2
520 :REM'NOTE: CMOS gate Tx in µS (suggested value .008)
530 TX=7.999999773744548e-09!
540 :REM'NOTE: MOS gate Rs (suggested value 8500 Ω)
550 RS=8500
560 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
570 PRINT
580 PRINT USING " Frequency............ ####.### MHz";F
590 PRINT USING " Reactance............ ####.### Ω";XL
600 PRINT USING " Q.................... ####.###";Q
610 P=RS*M*L*W^2*(W*TX/Q+1) :S=W^2*TX*L-RS*(M+1)-W*L/Q
620 C2=(SQR(S^2+4*P*TX)-S)/2/P :C1=C2*M
630 PRINT USING " C1................... ####.### pF";C1/PF
640 PRINT USING " C2................... ####.### pF";C2/PF
650 G=W^2*(TX*(RS*(C1+C2)+W*L*C2/Q)+RS*C1*C2*W*L/Q+L*C2)-W^4*TX*RS*C1*C2*L-1
660 PRINT USING " Inductance L......... ####.### µH";L/UH
670 PRINT USING " R1................... ####.### Ω";W*L/Q
680 PRINT USING " Minimum gain......... ####.###";G
690 J=10:K=38
700 LOCATE J+1,K:PRINT "  ACTUAL:"
710 LOCATE LN:PRINT STRING$(K,32)
720 LOCATE LN:INPUT " Enter actual C1 (pF)";C1 :C1=C1*PF
730 LOCATE J+5,K:PRINT USING "####.### pF";C1*10^12
740 LOCATE LN:PRINT STRING$(K,32)
750 LOCATE LN:INPUT " Enter actual inductance (µH)";L :L=L*UH
760 LOCATE J+7,K:PRINT USING "####.### µH";L*10^6
770 LOCATE LN:PRINT STRING$(K,32)
780 LOCATE LN:INPUT " Enter actual Q";Q
790 LOCATE J+4,K:PRINT USING "####.###";Q
800 LOCATE LN:PRINT STRING$(K,32)
810 LOCATE LN:INPUT " Enter actual C2 (pF)";C2 :C2=C2*PF
820 LOCATE J+6,K:PRINT USING "####.### pF";C2*10^12
830 WX=(L*C2/Q+SQR(L^2*C2^2/Q/Q+4*RS^2*C1*C2*L*(C1+C2)))/2/RS/C1/C2/L
840 X=L*WX:LOCATE J+3,K:PRINT USING "####.### Ω";X
850 DW=1000.0! :W=WX+DW
860 W=W-DW
870 ER=W^3*TX*RS*C1*C2*L/Q+W^2*(TX*L*C2+RS*C1*C2*L)-W*L*C2/Q-TX-RS*(C1+C2)
880 IF ABS(ER)<1.0000000116860974e-07! THEN 900 :ELSE IF ER<0 THEN W=W+DW :DW=DW/2 :GOTO 860
890 GOTO 860
900 F=W/MHZ/TP:LOCATE J+2,K:PRINT USING " ###.### MHz";F
905 R1=W*L/Q:LOCATE J+8,K:PRINT USING "####.### Ω";R1
910 G=W^2*(TX*(RS*(C1+C2)+W*L*C2/Q)+RS*C1*C2*W*L/Q+L*C2)-W^4*TX*RS*C1*C2*L-1
920 LOCATE LN+8,K:PRINT USING " ###.###";G
930 LOCATE LN:PRINT " OPTIMUM:                              "
940 GOSUB 950:GOTO 70
950 :REM'.....PRT
960 KEY OFF:GOSUB 1030:LOCATE 25,5:COLOR 0,2
970 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
980 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
990 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 990 :ELSE GOSUB 1030
1000 IF Z$="3"THEN RETURN
1010 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1020 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 960
1030 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
