10 :REM'DBLBRG4 - Double Bridge Power Supply 10 MAY 2008, corrected 03/SEP/08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS:KEY OFF
80 COLOR 15,2
90 PRINT " DOUBLE BRIDGE POWER SUPPLY"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 15,2:LOCATE CSRLIN-1,23:PRINT " Designed by Robert J. Dehoney IEEE "
120 COLOR 7,0
130 PRINT :GOSUB 340 :REM'get diagram
140 PRINT
150 PRINT " To get plus and minus outputs from a secondary you normally need ";
160 PRINT "to use plus  "
170 PRINT " and minus half wave rectifiers. Unless the loads are balanced the";
180 PRINT "re will be a "
190 PRINT " net field in the core which might cause it to saturate. The schem";
200 PRINT "e above      "
210 PRINT " avoids this. The symbol │< represents diodes in bridge rectifiers";
220 PRINT ". If V1 is   "
230 PRINT " positive and V2 is negative then the voltage on C2 and C3 will be";
240 PRINT " as shown and"
250 PRINT " electrolytic capacitors can be used. If C2 and C3 are 3 times or ";
260 PRINT "larger than  "
270 PRINT " C4, V1 and V2 will be about the same at any load."
280 PRINT
290 COLOR 0,7:LOCATE ,24:PRINT " Press 1 to continue or 0 to exit ":COLOR 7,0
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN CLS:RUN GO$
320 IF Z$="1"THEN 460
330 GOTO 310
340 :REM'.....diagram
350 COLOR 0,7:J=13
360 LOCATE ,J:PRINT  "                                                        "
370 LOCATE ,J:PRINT  " RP─)││(─RS───────┬───────────┤├─────────────┐          "
380 LOCATE ,J:PRINT  " Vp )││( Vs       ├┤<───────┐+C2-┌────────┤<─┤          "
390 LOCATE ,J:PRINT  "    )││(          └>├─┐+C1- │    │ +C4- ┌─>├─┘          "
400 LOCATE ,J:PRINT  "    )││( + ┌» ┌───────┼─┤├──┼──┬─┼──┤├──┼────────┐ «┐ - "
410 LOCATE ,J:PRINT  "    )││(  V1 RL1  ┌>├─┘     │  ╧ │      └──>├─┐ RL2 V2  "
420 LOCATE ,J:PRINT  "    )││( ─ └» ╧   ├┤<───────┘+C3-└─────────┤<─┤  ╧ «┘ + "
430 LOCATE ,J:PRINT  "  ──)││(──────────┴───────────┤├──────────────┘         "
440 LOCATE ,J:PRINT  "               DOUBLE BRIDGE POWER SUPPLY               "
450 COLOR 7,0:RETURN
460 :REM'.....input data
470 CLS:GOSUB 340:PRINT
480 LN =CSRLIN
490 INPUT "Enter desired output voltage";E
500 INPUT "Enter loads RL1 & RL2 (ohms each)";R:RL1=R:RL2=R
510 I=E/R
520 LOCATE LN:PRINT USING " OUTPUT: RL1 and RL2= ###.##Ω @ #.### amp      E1 and E2= ###.#v. and ###.#v.";R;I;E;-E
530 LN=CSRLIN:PRINT STRING$(79,32):LOCATE CSRLIN-1
540 INPUT "Enter line frequency, Hz";F
550 INPUT "Enter line voltage";VP:VP=CINT(VP)
560 LOCATE LN
570 PRINT USING " Line....................................... ##### v. ## Hz";VP,F
580 INPUT "Enter Xfmr. primary winding resistance, ohms ";RP
590 LOCATE CSRLIN-1
600 PRINT USING " Transformer primary resistance............. #####.## Ω";RP
610 INPUT "Enter Xfmr. secondary winding open circuit voltage ";VS
620 LOCATE CSRLIN-1
630 PRINT USING " Transformer seconday open circuit voltage.. #####.## volts";VS
640 INPUT "Enter transformer secondary winding resistance, ohms ";RS
650 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
660 PRINT USING " Tranformer secondary winding resistance.... #####.## Ω";RS
670  INPUT "Enter allowable ripple voltage";R
680  CX=375*I*10^3/F/R
690 LOCATE CSRLIN-1
700 PRINT " For";R"volts ripple  C1 & C4 should be"CX"pF minimum"
710 INPUT "Enter your choice of value for C1 and C4 ";C1:C4=C1
720 LOCATE CSRLIN-1
730 PRINT USING " Power supply input capacitors C1 and C4.... #####.## µF";C1
740 PRINT "BLOCKING CAPACITORS SHOULD BE AT LEAST 3 TIMES THE VALUE OF C4 "
750 INPUT "Enter your choice of value for C2 and C3 ";C2:C3=C2
760 LOCATE CSRLIN-2:PRINT STRING$(79,32)
770 LOCATE CSRLIN-1
780 PRINT USING " Blocking capacitors C2 and C3.............. #####.## µF";C2
790 :REM'.....calculate final values
800 MT=15 :SC=180 :VD=0.800000011920929!
810 UF=9.999999974752427e-07! :VC1=0 :VC2=0 :VC3=0 :VC4=0 :ISQ=0 :VC1SUM=0 :VC2SUM=0 :VC3SUM=0 :VC4SUM=0
820 C1=C1*UF :C2=C2*UF :C3=C3*UF :C4=C4*UF :PI=3.141590118408203! :TP=2*PI
830 IF C2<C1 THEN C=C2 :ELSE C=C1
840 IF C3<C THEN C=C3
850 IF C4<C THEN C=C4
860 S=1/F/SC :IF S>0.04600000008940697!*C THEN S=0.04600000008940697!*C :SC=1/F/S
870 VC1=VS/2 :VC2=VC1 :VC3=VC1 :VC4=VC1 :REM'assumed initial values
880 VC1MIN=2*VS :VC4MIN=VC1MIN :VC1MAX=0 :VC4MAX=0 :REM'initial Vmins
890 NT=VP/VS :RT=RP/NT^2+RS
900 FOR M=1 TO MT :FOR N=1 TO SC
910 ANG=TP*F*N*S :VAC=SQR(2)*VS*ABS(SIN(ANG))
920 IF VAC>I2*RT+2*VD+VC1 THEN I1=(VAC-(I2)*RT-2*VD-VC1)/RT :ELSE I1=0
930 VC1=VC1+S/C1*(I1-VC1/RL1)
940 IF ANG<PI THEN GOSUB 1120
950 IF ANG=>PI THEN GOSUB 1150
960 IF M=MT THEN GOSUB 1050 :REM'Final cycle. We can find average and peak values.
970 NEXT N :PRINT M; :NEXT M
980 LOCATE CSRLIN-1:PRINT STRING$(79,32):LOCATE CSRLIN-1
990 PRINT USING"  V1max= ###.###v.  V1min= ###.###v.  V1= ###.###v.  IL1= ##.### amp";VC1MAX,VC1MIN,VC1SUM/SC,VC1SUM/SC/RL1
1000 PRINT USING"  V2max= ###.###v.  V2min= ###.###v.  V2= ###.###v.  IL2= ##.### amp";-VC4MAX,-VC4MIN,-VC4SUM/SC,-VC4SUM/SC/RL2
1010 PRINT USING" V1 ripple= ##.##v. :   V2 ripple =##.##v.";VC1MAX-VC1MIN,VC4MAX-VC4MIN
1020 VA=VS*SQR(ISQ/SC)
1030 PRINT USING " Transformer minimum rating ###.# VA";VA
1040 GOTO 1190
1050 :REM'          subroutine to get final values
1060 IF VC1>VC1MAX THEN VC1MAX=VC1
1070 IF VC1<VC1MIN THEN VC1MIN=VC1
1080 IF VC4>VC4MAX THEN VC4MAX=VC4
1090 IF VC4<VC4MIN THEN VC4MIN=VC4
1100 VC1SUM=VC1SUM+VC1 :VC2SUM=VC2SUM+VC2 :VC3SUM=VC3SUM+VC3 :VC4SUM=VC4SUM+VC4
1110 ISQ=ISQ+(I1+I2+I3)^2 :RETURN
1120 :REM'        subroutine to find I2 when ANG<PI
1130 IF VAC>I1*RT+VC2+2*VD+VC4-VC3 THEN I2=(VAC-I1*RT-VC2-2*VD-VC4+VC3)/RT :ELSE I2=0
1140 VC2=VC2+I2*S/C2 :VC3=VC3-I2*S/C3 :VC4=VC4+S/C4*(I2-VC4/RL2) :RETURN 960
1150 :REM'        subroutine to find I2 when ANG>PI
1160 IF VAC>I1*RT+VC3+2*VD+VC4-VC2 THEN I2=(VAC-I1*RT-VC3-2*VD-VC4+VC2)/RT :ELSE I2=0
1170 VC2=VC2-I2*S/C2 :VC3=VC3+I2*S/C3 :VC4=VC4+S/C4*(I2-VC4/RL2) :RETURN 960
1180 :REM'.....end
1190 GOSUB 1200:GOTO 60
1200 :REM'.....PRT
1210 KEY OFF:GOSUB 1280:LOCATE 25,5:COLOR 0,2
1220 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1230 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1240 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1240 :ELSE GOSUB 1280
1250 IF Z$="3"THEN RETURN
1260 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1270 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1210
1280 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
