10 :REM'DBLFB - 18 NOV 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " DOUBLE FEEDBACK AMPLIDIER"TAB(61)"by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....start
110 PRINT
120 PRINT "This program finds Gain, Zin and Zout for an amplifier with emitter and"
130 PRINT "collector-base feedback."
140 PRINT ""
150 PRINT "                        ┌──Rf──┬─────────┐«──┐"
160 PRINT "                        ├──Cob─┤         │   │"
170 PRINT "                        │    │/          │   │              Vout"
180 PRINT "               ┌»───Rs──┴────┤   <─Zout  RL Vout     Gain = ─────"
190 PRINT "               │     Zin─>   │\          │   │               Vin"
200 PRINT "               │               │         │   │"
210 PRINT "              Vin            ┌─┴─┐       │   │"
220 PRINT "               │             Re  Ce      │   │"
230 PRINT "               └»╧           ╧   ╧       ╧  «┘"
240 PRINT ""
250 PRINT :PRINT "Press <1> to continue, <2> to see program notes, <0> to exit"
260 A$=INKEY$ :IF A$="" THEN 260
270 IF A$="1"THEN 310
280 IF A$="2" THEN 1060
290 IF A$="0" THEN RUN EX$
300 GOTO 270
310 :REM'...... run program
320 CLS:PRINT :PRINT "Enter trial values at the prompts. Later, you'll be able to change Rs,Rf,RL,"
330 PRINT "Re, and Ce." :PRINT
340 INPUT "Enter Rs, ohms ",RS
350 INPUT "Enter Rf, ohms ",RF
360 INPUT "Enter RL, ohms ",RL
370 INPUT "Enter Re, ohms ",RE
380 INPUT "Enter Ce, pF ",C2 :C2=C2*9.999999960041972e-13!
390 INPUT "Enter COB, pF ",C1 :C1=C1*9.999999960041972e-13!
400 INPUT "Enter transistor Beta ",B0
410 INPUT "Enter transistor DC current, ma ",IE
420 INPUT "Enter transistor Ft, MHz ",FT
430 TP=8*ATN(1) :GM=IE/26 :RP=B0/GM :WT=TP*FT*1000000.0! :CP=GM/WT-COB
440 GOSUB 750  :CLS
450 PRINT "  Freq   Gain   Ang        Zin    Ang        Zout    Ang"
460 FOR N=1 TO 17 :F=100*(N-1)/16 :W=TP*F*1000000.0!
470 A=DX-W^2*BX :B=W*CX :C=HX-W^2*FX :D=W*(GX-W^2*EX) :GOSUB 710
480 GAIN=MAG :ANG1=ANG :REM'the 2 factor makes the gain "insertion gain"
490 A=DY-W^2*BY :B=W*CY :C=HY-W^2*FY :D=W*(GY-W^2*EY) :GOSUB 710
500 ZIN=MAG :ANG2=ANG
510 A=DZ-W^2*BZ :B=W*CZ :C=HZ-W^2*FZ :D=W*(GZ-W^2*EZ) :GOSUB 710
520 ZOUT=MAG :ANG3=ANG
530 PRINT USING "###.##  ##.## ####.##    ####.## ####.##    ####.## ####.##   ";                 F;GAIN;ANG1;ZIN;ANG2;ZOUT;ANG3
540 NEXT N
550 PRINT "Rs="RS"  Rf="RF"  RL="RL"  Re="RE"  Ce="C2*999999995904.0!
560 PRINT :PRINT "You can increase the value of Rs through Ce by pressing `z' through `b'."
570 PRINT "To decrease the values, use `Z' through `B'. To quit, press <1>."
580 A$=INKEY$ :IF A$="" THEN 580
590 IF A$="1"THEN CLS:GOTO 60
600 IF A$="z" THEN RS=RS*1.0099999904632568! :GOTO 440
610 IF A$="Z" THEN RS=RS/1.0099999904632568! :GOTO 440
620 IF A$="x" THEN RF=RF*1.0099999904632568! :GOTO 440
630 IF A$="X" THEN RF=RF/1.0099999904632568! :GOTO 440
640 IF A$="c" THEN RL=RL*1.0099999904632568! :GOTO 440
650 IF A$="C" THEN RL=RL/1.0099999904632568! :GOTO 440
660 IF A$="v" THEN RE=RE*1.0099999904632568! :GOTO 440
670 IF A$="V" THEN RE=RE/1.0099999904632568! :GOTO 440
680 IF A$="b" THEN C2=C2*1.0099999904632568! :GOTO 440
690 IF A$="B" THEN C2=C2/1.0099999904632568! :GOTO 440
700 IF A$="1" THEN END :ELSE GOTO 580
710 DENOM=C^2+D^2 :REAL=(A*C+B*D)/DENOM :IM=(B*C-A*D)/DENOM
720 MAG=SQR(REAL^2+IM^2)
730 ANGR=-TP/2*(REAL<0)+ATN(IM/REAL) :ANG=ANGR*360/TP                                    :IF ANG>180 THEN ANG=ANG-360
740 RETURN
750 :REM'...... formulae
760 BX=RP*CP*RF*C1*RE*RL + RP*RF*C1*RE*C2*RL
770 CX=RP*RF*C1*RL +RP*CP*RE*RL + RF*C1*RE*RL + RP*RE*C2*RL - RP*RF*C1*RE*GM*RL      + RP*RF*RE*C2*GM*RL
780 DX=RP*RL + RE*RL + RP*RF*GM*RL - RP*RE*GM*RL
790 EX=RS*RP*CP*RF*C1*RE*C2*RL
800 :REM'
810 FX1=RS*RP*CP*RF*C1*RE + RS*RP*CP*RF*RE*C2 + RS*RP*RF*C1*RE*C2                    + RS*RP*CP*RF*C1*RL
820 FX2= RP*CP*RF*C1*RE*RL + RS*RP*CP*RE*C2*RL + RP*RF*C1*RE*C2*RL                     +RS*RF*C1*RE*C2*RL - RS*RP*RF*C1*RE*C2*GM*RL
830 :REM'
840 GX1=RS*RP*CP*RF + RS*RP*RF*C1 +RS*RP*CP*RE + RP*CP*RF*RE + RS*RF*C1*RE +        RS*RP*RE*C2 + RP*RF*RE*C2
850 GX2 = RS*RF*RE*C2 - RS*RP*RF*C1*RE*GM + RS*RP*CP*RL + RP*RF*C1*RL                 + RS*RF*C1*RL + RP*CP*RE*RL
860 GX3 = RF*C1*RE*RL+ RP*RE*C2*RL + RS*RE*C2*RL - RS*RP*RF*C1*GM*RL                  -RP*RF*C1*RE*GM*RL - RS*RP*RE*C2*GM*RL
870 HX=RS*RP + RP*RF+ RS*RF + RS*RE + RF*RE - RP*RF*RE*GM - RS*RP*RE*GM+RP*RL        +RS*RL+RE*RL - RS*RP*GM*RL - RP*RE*GM*RL
880 :REM'dblfdbk2
890 BY= RP*CP*RF*C1*RE*RL + RP*+RF*C1*RE*C2*RL
900 CY=RP*CP*RF*RE + RP*RF*RE*C2 + RP*RF*C1*RL + RP*CP*RE*RL + RF*C1*RE*RL +        RP*RE*C2*RL - RP*RF*C1*RE*GM*RL
910 DY=RP*RF + RF*RE - RP*RF*RE*GM + RP*RL + RE*RL - RP*RE*GM*RL
920 EY= RP*CP*RF*C1*RE*C2*RL
930 FY1= RP*CP*RF*C1*RE + RP*CP*RF*RE*C2 +RP*RF*C1*RE*C2 + RP*CP*RF*C1*RL
940 FY2= RP*CP*RE*C2*RL + RF*C1*RE*C2*RL - RP*RF*C1*RE*C2*GM*RL
950 GY=RP*CP*RF + RP*RF*C1 + RP*CP*RE + RF*C1*RE + RP*RE*C2 + RF*RE*C2 -            RP*RF*C1*RE*GM+RP*CP*RL+RF*C1*RL+ RE*C2*RL- RP*RF*C1*GM*RL- RP*RE*C2*GM*RL
960 HY = RP + RF + RE - RP*RE*GM + RL - RP*GM*RL
970 :REM'dblfdbk3
980 BZ= RS*RP*CP*RF*RE*(C1+C2) + RS*RP*RF*C1*RE*C2
990 CZ = RS*RP*CP*RF + RS*RP*RF*C1 + RS*RP*CP*RE + RP*CP*RF*RE + RS*RF*C1*RE  +          RS*RP*RE*C2 +RP*RF*RE*C2 + RS*RF*RE*C2 - RS*RP*RF*C1*RE*GM
1000 DZ = RS*RP + RP*RF + RS*RF + RS*RE + RF*RE - RP*RF*RE*GM - RS*RP*RE*GM
1010 EZ = RS*RP*CP*RF*C1*RE*C2
1020 FZ = RS*RP*CP*RF*C1 + RP*CP*RF*C1*RE + RS*RP*CP*RE*C2 + RP*RF*C1*RE*C2 +             RS*RF*C1*RE*C2 - RS*RP*RF*C1*RE*C2*GM
1030 GZ = RS*RP*CP + RP*RF*C1 + RS*RF*C1 + RP*CP*RE + RF*C1*RE + RP*RE*C2              + RS*RE*C2 - RS*RP*RF*C1*GM - RP*RF*C1*RE*GM - RS*RP*RE*C2*GM
1040 HZ = RP + RS + RE - RS*RP*GM - RP*RE*GM
1050 FX=FX1+FX2 :GX=GX1+GX2+GX3 :FY=FY1+FY2 :RETURN
1060 CLS :PRINT "               -------------Program Notes-------------------"
1070 PRINT "These amplifiers are often used as broad band amplifiers where the input and"
1080 PRINT "output impedances are important. For this use, the concept of `Insertion Gain'"
1090 PRINT "must be mentioned. This is equivalent to insertion loss--the net result when"
1100 PRINT "the device under consideration is inserted between the source and load. Under"
1110 PRINT "matched conditions, the insertion gain is twice the gain calculated as"
1120 PRINT "Vout/Vin, thus, if our amplifier has a Zin and Zout of 50 ohms and Vout/Vin"
1130 PRINT "equals 2, then with a 50 source and load, we'll find that inserting our"
1140 PRINT "amplifier increases our output by 12 dB, a factor of 4."
1150 PRINT
1160 PRINT "The formulas for Gain, Zin, and Zout have the same form. They are all"
1170 PRINT
1180 PRINT "                -B*W^2+jC*W+D"
1190 PRINT "              ──────────────────"
1200 PRINT "              -jE*W^3-F*W^2+jG*W+H"
1210 PRINT
1220 PRINT "where the B through G's are functions of the circuit elements."
1230 PRINT
1240 PRINT :PRINT "Press any key"
1250 A$=INKEY$ :IF A$="" THEN 1250 :ELSE CLS:GOTO 100
