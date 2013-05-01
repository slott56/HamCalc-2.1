10 :REM'COMFILT - 26 JAN 2010
20 :REM'COMFILc.BAS rev 26 JAN 2010
30 CLS:KEY OFF
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 :REM'.....title page
80 COLOR 15,2
90 PRINT " COMPLEMENTARY FILTERS"TAB(61)"by R.J.Dehoney IEEE ";
100 COLOR 7,0
110 :REM'.....start
120 PRINT
130 :REM'---------------CONIMP2.BAS,rjd,1/22/10--------------
140 PRINT "Most filters obtain their insertion loss by reflecting the incoming energy back"
150 PRINT "to the source, thus their impedance match in the pass band is very good and"
160 PRINT "their VSWR in the reject band is very high. Some sources are ill behaved when"
170 PRINT "improperly loaded. This program gives element values for a filter with a"
180 PRINT "Butterworth characteristic that maintains a low input VSWR over a very wide"
190 PRINT "band. It consists of a low pass filter in parallel with a high pass filter,"
200 PRINT "with element values adjusted to maintain match. At low frequencies, the input"
210 PRINT "sees the desired load; at high frequencies, the input sees the intermal load.":PRINT
220 PRINT "The program was taken from CP Hearn's RF Design, 9/95 article-Design"
230 PRINT "Parameters for 2 Thru 7 Pole Input Matched Lowpass/Highpass Filters."
240 PRINT "It uses his tabulated prototype values scaled to the desired F0 & Z0."
250 MHZ=10^6:UH=9.999999974752427e-07! :PF=9.999999960041972e-13! :TP=8*ATN(1) :GOSUB 680 :PRINT
260 PRINT "Press <1> to run or <0> to EXIT."
270 Z$=INKEY$:IF Z$=""THEN 270
280 IF Z$="0"THEN RUN GO$
290 IF Z$="1"THEN LOCATE CSRLIN-1:GOTO 310
300 GOTO 270
310 INPUT "Enter passband 3dB cutoff frequency, MHz ",F0 :FCO=F0*MHZ
320 INPUT "Enter desired Z0, ohms ",Z0
330 INPUT "Enter number of poles (2 to 7), or press <ENTER> to calculate N ",N
340 IF N=0 THEN 370
350 IF N<2 OR N>7 THEN 330
360 IF N>1 AND N<8 THEN 430
370 INPUT "Enter desired loss in dB for a frequency in the reject band ";LDB
380 INPUT "Enter reject band frequency in MHz";FR:K=FR/F0
390 KF=FR/F0
400 N=CINT(0.5!*LOG(10^(LDB/10)-1)/LOG(KF))
410 PRINT "Number of poles="N""
420 INPUT "OK? ENTER:(y/n) ",A$ :IF A$="n" THEN 330
430 IF FR=0 THEN X=1+2^(2*N) :LDB=10*LOG(X)/LOG(10) :FR=2*F0
440 FOR P=1 TO N
450 IF N=2 THEN GL(P)=GL2(P) :GH(P)=GH2(P)
460 IF N=3 THEN GL(P)=GL3(P) :GH(P)=GH3(P)
470 IF N=4 THEN GL(P)=GL4(P) :GH(P)=GH4(P)
480 IF N=5 THEN GL(P)=GL5(P) :GH(P)=GH5(P)
490 IF N=6 THEN GL(P)=GL6(P) :GH(P)=GH6(P)
500 IF N=7 THEN GL(P)=GL7(P) :GH(P)=GH7(P)
510 NEXT P
520 :REM'.....display
530 CLS
540 LOCATE 2,30:PRINT "COMPLEMENTARY FILTERS"
550 LOCATE 4
560 PRINT "     Series L        Shunt C           Shunt L        Series C"
570 FOR P=1 TO N STEP 2 :LL(P)=GL(P)*Z0/TP/FCO :CL(P+1)=GL(P+1)/TP/FCO/Z0
580 CH(P)=GH(P)/TP/FCO/Z0 :LH(P+1)=GH(P+1)*Z0/TP/FCO
590 PRINT USING " LL(#)###.###uH  CL(#)####.###pF      ";P;LL(P)/UH;P+1;CL(P+1)/PF;
600 PRINT USING " LH(#)###.###uH  CH(#)####.###pF";P+1;LH(P+1)/UH;P;CH(P)/PF
610 NEXT P :ONN-1 GOSUB 930,1030,1130,1230,1330,1430
620 PRINT USING " Passband 3 dB cutoff frequency....... ####.### MHz";FCO/MHZ
630 PRINT USING " Desired Z0........................... ####.### Ω";Z0
640 PRINT USING " Number of poles...................... ####";N
650 PRINT USING " Reject band frequency................ ####.### Mhz";FR
660 PRINT USING " Loss in dB at reject band frequency.. ####.# dB";LDB
670 FR=0 :GOTO 820
680 :REM'-----------subroutine to tabulate values-----------
690 GL2(1)=1.4129999876022339! :GL2(2)=0.7063000202178955!
700 GL3(1)=1.4989999532699585! :GL3(2)=1.3329999446868896! :GL3(3)=0.5!
710 GL4(1)=1.531000018119812! :GL4(2)=1.5779999494552612! :GL4(3)=1.0850000381469727! :GL4(4)=0.3840999901294708!
720 GL5(1)=1.5429999828338623! :GL5(2)=1.6920000314712524! :GL5(3)=1.3830000162124634! :GL5(4)=0.9013000130653381! :GL5(5)=0.31520000100135803!
730 GL6(1)=1.5529999732971191! :GL6(2)=1.7599999904632568! :GL6(3)=1.5549999475479126! :GL6(4)=1.2020000219345093! :GL6(5)=0.7548999786376953!            :GL6(6)=0.25619998574256897!
740 GL7(1)=1.555999994277954! :GL7(2)=1.7999999523162842! :GL7(3)=1.6619999408721924! :GL7(4)=1.3980000019073486! :GL7(5)=1.0520000457763672!             :GL7(6)=0.6366000175476074! :GL7(7)=0.22390000522136688!
750 GH2(1)=0.7063000202178955! :GH2(2)=1.4129999876022339!
760 GH3(1)=0.666100025177002! :GH3(2)=0.7493000030517578! :GH3(3)=1.9980000257492065!
770 GH4(1)=0.6531999707221985! :GH4(2)=0.6334999799728394! :GH4(3)=0.9218999743461609! :GH4(4)=2.6029999256134033!
780 GH5(1)=0.646399974822998! :GH5(2)=0.589900016784668! :GH5(3)=0.7245000004768372! :GH5(4)=1.1230000257492065! :GH5(5)=3.253000020980835!
790 GH6(1)=0.6437000036239624! :GH6(2)=0.5674999952316284! :GH6(3)=0.6407999992370605! :GH6(4)=0.8206999897956848! :GH6(5)=1.2790000438690186!            :GH6(6)=3.674999952316284!
800 GH7(1)=0.6412000060081482! :GH7(2)=0.5540000200271606! :GH7(3)=0.597599983215332! :GH7(4)=0.7028999924659729! :GH7(5)=0.9273999929428101!           :GH7(6)=1.524999976158142! :GH7(7)=4.698999881744385!
810 RETURN
820 :REM'....end
830 GOSUB 840:CLS:GOTO 110
840 :REM'.....PRT
850 KEY OFF:GOSUB 920:LOCATE 25,5:COLOR 0,2
860 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
870 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
880 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 880 :ELSE GOSUB 920
890 IF Z$="3"THEN RETURN
900 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
910 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 850
920 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
930 :REM'--------2 pole schematic------
940 PRINT ""
950 PRINT ""
960 PRINT "              ┌───┬─CH1─┬─LL1─┬────┐«───┐"
970 PRINT "              │   │     Z0    │    │    │"
980 PRINT "            R=Z0 LH2    │    CL2 RL=Z0 Vout"
990 PRINT "              │   │    Vin    │    │    │"
1000 PRINT "              └───┴─────┴─────┴────┘«───┘"
1010 PRINT ""
1020 RETURN
1030 :REM'--------3 pole schematic------
1040 PRINT ""
1050 PRINT ""
1060 PRINT "            ┌──CH3─┬─CH1─┬─LL1─┬─LL3──┐«───┐"
1070 PRINT "            │      │     Z0    │      │    │"
1080 PRINT "          R=Z0    LH2    │    CL2   RL=Z0 Vout"
1090 PRINT "            │      │    Vin    │      │    │"
1100 PRINT "            └──────┴─────┴─────┴──────┘«───┘"
1110 PRINT ""
1120 RETURN
1130 :REM'--------4 pole schematic------
1140 PRINT ""
1150 PRINT ""
1160 PRINT "         ┌───┬─CH3─┬─CH1─┬─LL1─┬─LL3─┬────┐«───┐"
1170 PRINT "         │   │     │     Z0    │     │    │    │"
1180 PRINT "       R=Z0 LH4   LH2    │    CL2   CL4 RL=Z0 Vout"
1190 PRINT "         │   │     │    Vin    │     │    │    │"
1200 PRINT "         └───┴─────┴─────┴─────┴─────┴────┘«───┘"
1210 PRINT ""
1220 RETURN
1230 :REM'--------5 pole schematic------
1240 PRINT ""
1250 PRINT ""
1260 PRINT "        ┌─CH5─┬─CH3─┬─CH1─┬─LL1─┬─LL3─┬─LL5─┐«───┐"
1270 PRINT "        │     │     │     Z0    │     │     │    │"
1280 PRINT "      R=Z0   LH4   LH2    │    CL2   CL4  RL=Z0 Vout"
1290 PRINT "        │     │     │    Vin    │     │     │    │"
1300 PRINT "        └─────┴─────┴─────┴─────┴─────┴─────┘«───┘"
1310 PRINT ""
1320 RETURN
1330 :REM'--------6 pole schematic------
1340 PRINT ""
1350 PRINT ""
1360 PRINT "     ┌───┬─CH5─┬─CH3─┬─CH1─┬─LL1─┬─LL3─┬─LL5─┬────┐«───┐"
1370 PRINT "     │   │     │     │     Z0    │     │     │    │    │"
1380 PRINT "   R=Z0 LH6   LH4   LH2    │    CL2   CL4   CL6 RL=Z0 Vout"
1390 PRINT "     │   │     │     │    Vin    │     │     │    │    │"
1400 PRINT "     └───┴─────┴─────┴─────┴─────┴─────┴─────┴────┘«───┘"
1410 PRINT ""
1420 RETURN
1430 :REM'--------7 pole schematic------
1440 PRINT ""
1450 PRINT ""
1460 PRINT "    ┌─CH7─┬─CH5─┬─CH3─┬─CH1─┬─LL1─┬─LL3─┬─LL5─┬─LL7─┐«───┐"
1470 PRINT "    │     │     │     │     Z0    │     │     │     │    │"
1480 PRINT "  R=Z0   LH6   LH4   LH2    │    CL2   CL4   CL6  RL=Z0 Vout"
1490 PRINT "    │     │     │     │    Vin    │     │     │     │    │"
1500 PRINT "    └─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘«───┘"
1510 PRINT ""
1520 RETURN
