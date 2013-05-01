10 :REM'COLPOSC' - Colpitts FET Oscillator  13 FEB 09, rev. 03 JUN 09
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2
90 PRINT " COLPITTS FET OSCILLATOR"TAB(60)"by R.J.Dehoney, IEEE ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 GOSUB 280  :REM'diagram
130 PRINT " This program finds the inductance and minimum gaim for the FET Colpits"
140 PRINT " oscillator. The scheme is to break the circuit at an imaginary point"
150 PRINT " inside the FET and apply a voltage to the transconductance gaim. The"
160 PRINT " condition for oscillation is when the voltage across the break equals"
170 PRINT " zero. This scheme preserves the actual circuit configuration and loading"
180 PRINT  " and should give accurate results. See Appendix for the detailed theory."
190 PRINT " After the oscillator has been designed, values can be changed and the new"
200 PRINT " frequency and required gm calculated."
210 PRINT:COLOR 0,7 :LOCATE ,2
220 PRINT " Press (1) to Run, (2) for Appendix, or (0) to EXIT ":COLOR 7,0
230 Z$=INKEY$:IF Z$=""THEN 230
240 IF Z$="0"THEN RUN GO$
250 IF Z$="1"THEN CLS:GOSUB 280:GOTO 390
260 IF Z$="2"THEN CLS:CLS:GOSUB 1030:STOP
270 GOTO 230
280 :REM'.....diagram
290 PRINT "  COLPITTS FET OSCILLATOR"
300 PRINT ""
310 PRINT "            ├───+Vdc  Cgs is FET gate to source. C1 includes Cgs"
320 PRINT "  ┌──┬───┬──┤ «─FET   Cds is FET drain to source. C2 includes Cds"
330 PRINT "  │  L   C1 ├──┐      Cgd is FET gate to drain."
340 PRINT " Cs  │   ├─────┤      Cs is Cgd plus coil and stray"
350 PRINT "  │  RQ  C2    RL        capacitance."
360 PRINT "  ╧  ╧   ╧     ╧      gm is the FET transconductance"
370 PRINT
380 RETURN
390 :REM'......data entry
400 LN=CSRLIN
410 COLOR 0,7:PRINT " RL from 50 to 500 Ω recommended ":COLOR 7,0
420 INPUT "ENTER: RL in ohms";Z :UF=9.999999974752427e-07! :IF Z<>0 THEN RL=Z
430 GOSUB 1290
440 INPUT "ENTER: Desired frequency in MHz ";Z :IF Z<>0 THEN F=Z :ELSE 490
450 TP=8*ATN(1) :W=TP*F :C1A=1/250/W/UF
460 GOSUB 1290
470 INPUT "ENTER: Approximate tank circuit Q ";Z :IF Z<>0 THEN Q=Z
480 GOSUB 1290
490 C1A=1/500/W :C2A=3/RL/W/Q
500 INPUT "ENTER: C1 (trimmer) in pF ";Z :IF Z<>0 THEN C1=Z*UF
510 COLOR 0,7:PRINT " C2 should be greater than"Z"pF ":COLOR 7,0
520 INPUT "ENTER: C2 (tuner) in pF ";Z :IF Z<>0 THEN C2=Z*UF
530 IF C2>C1 THEN 540 :ELSE 490
540 GOSUB 1290
550 COLOR 0,7:PRINT " Cs should be as small as possible.":COLOR 7,0
560 INPUT "ENTER: Cs ";Z :IF Z<>0 THEN CS=Z*UF
570 IF CS>C2 THEN 550
580 GOSUB 1290
590 :REM'......calculate inductance, coil Q, and gm
600 IF Q=1/W/RL/C2 THEN Q=Q*0.9900000095367432!
610 L=RL*(C1+C2)/(RL*C1*C2*W^2-W*C1/Q)
620 IF L<0 THEN PRINT "Increase Q, RL, or C2." :GOTO 420
630 RQ=W*L/Q :BY=RL*RQ*C1*C2+L*C1 :GM=(W^2*BY-1)/RL
640 RP=RQ*(1+Q^2) :LP1=L*(Q^2+1)/Q^2 :LP2=LP1/(1+W^2*LP1*CS) :Q2=RP/W/LP2
650 RQ2=RP/(1+Q2^2) :L2=LP2*Q2^2/(1+Q2^2) :QS2=W*L2/RQ2
660 :REM'......print calculated values
670 PRINT USING " RL............. ####.### Ω";RL
680 PRINT USING " C1............. ####.### pF";C1/UF
690 PRINT USING " C2............. ####.### pF";C2/UF
700 PRINT USING " Cs............. ####.### ";CS*10^6
710 PRINT USING " Frequency...... ####.### MHz";W/TP
720 PRINT USING " Minimum gm..... ####.### mhos";GM
730 PRINT USING " Inductance L... ####.### µH";L2
740 PRINT USING " Coil Q......... ####.### ";QS2
750 :REM'......change values or end
760 LN=CSRLIN:PRINT "Do you want to alter values? (y/n)"
770 A$=INKEY$:IF A$=""THEN 770
780 IF A$="n"THEN LOCATE LN:PRINT STRING$(40,32):GOSUB 1310:GOTO 10
790 IF A$="y"THEN LOCATE LN:PRINT STRING$(40,32):LOCATE LN:GOTO 810
800 GOTO 770
810 :REM'......routine to alter values
820 PRINT " To keep an existing value press <ENTER>, or ENTER a new value"
830 LN=CSRLIN:INPUT  " Press <ENTER> to continue",A$
840 GOSUB 1290:INPUT " RL ";Z :IF Z<>0 THEN RL=Z
850 GOSUB 1290:INPUT " C1 ";Z :IF Z<>0 THEN C1=Z*UF
860 GOSUB 1290:INPUT " C2 ";Z :IF Z<>0 THEN C2=Z*UF
870 GOSUB 1290:INPUT " Cs ";Z :IF Z<>0 THEN CS=Z*UF
880 GOSUB 1290:INPUT " L ";Z :IF Z<>0 THEN L2=Z
890 GOSUB 1290:INPUT " Coil Q ";Z :IF Z<>0 THEN QS2=Z
900 :REM'......calculate with new values
910 CC=C1*C2+CS*(C1+C2) :CP=C1*C2/(C1+C2) :W0=1/SQR(L2*(CP+CS))
920 RQX=RQX+0.10000000149011612! :IF RQX>RL THEN PRINT "Reduce value of Cs." :RQX=0 :GOTO 870
930 A=RL*(C1+C2)+RQX*(C1+CS) :B=RL*RQX*CS :C=RL*RQX*CC+L2*(C1+CS) :D=RL*L2*CS
940 U=RL^2*CC*L2-B*C-A*D :V=L2*RL*CC-A*C :IF U^2+4*V*B*D<0 THEN 920
950 GM=(U-SQR(U^2+4*V*B*D))/(2*B*D) :IF GM<0 THEN PRINT "Reduce value of Cs." :RQX=O :GOTO 910
960 IF A+GM*B<0 THEN PRINT "Reduce value of Cs." :RQX=0 :GOTO 870
970 W=SQR((A+GM*B)/(L2*RL*CC)) :QS=W*L2/RQX :QT=QS*(1-W^2*L2*CS*(1+QS^2)/QS^2)
980 IF QS>QS2 THEN 920 :ELSE RQX=0
990 :REM'
1000 :REM'.....final printout
1010 VIEW PRINT 11 TO 24:CLS:VIEW PRINT:LOCATE 10:GOTO 660:GOSUB 1310:GOTO 10
1020 GOTO 760
1030 :REM'-------------------Appendix------------------------
1040 PRINT "The numerator in the equation for the voltage across the break is:"
1050 PRINT "Vbreak = -jAx*W^3 - Bx*W^2 +j*Cx*W + Dx, where :"
1060 PRINT "Ax = L*RL*CC, where CC = C1*C2+Cs*(C1+C2)"
1070 PRINT "Bx = RL*Rq*CC+RL*gm*L*Cs+L*(C1+Cs), where Rq is the coil loss resistance."
1080 PRINT "Cx = RL*(C1+C2)+RL*gm*Rq*Cs+Rq*(C1+Cs), Dx=1+gm*RL, W=2*pi*F"
1090 PRINT "Vbreak = zero when W^2 = Cx/Ax = Dx/Bx, but since we don't know L, Rq, and"
1100 PRINT "gm, we have to solve for L by using a circuit trick. If we assume Cs = 0,"
1110 PRINT "then Cx = RL*(C1+C2)+(W*L/Q)*C1, and, since W^2 = Cx/Ax, we can solve for L"
1120 PRINT "given RL, C1, C2, and the desired frequency and tank circuit Q."
1130 PRINT "L = RL*(C1+C2)/(RL*C1*C2*W^2-W*C1/Q). Now that we know L, we can find Bx"
1140 PRINT  "since Bx (with Cs=0) = RL*W/Q*C1*C2+L*C1. From this, we can find gm."
1150 PRINT "                  gm = (W^2*Bx-1)/RL"
1160 PRINT "We now account for Cs by converting the series L and Rq to their parallel"
1170 PRINT "form to get Lp and Rp. Assuming Lp results from some Lp2 in parallel with"
1180 PRINT "Cs, we find Lp2=Lp/(1+W^2*Lp*Cs). Then Q2 = Rp/(W*Lp2), Rs = Rp/(1+Q2^2)"
1190 PRINT "and Ls = Lp2*Q2^2/(1+Q2^2), which are the values we are looking for. Note"
1200 PRINT "that Q2, the required coil Q, is greater than the tank circuit Q. This is"
1210 PRINT  "the effect that Cs has on the coil. To change values, we have a different"
1220 PRINT "problem. Here, we know RL,C1,C2,Cs,L,and Qcoil, and we need gm and F. We"
1230 PRINT "back into a solution by trying increasing values of Rq, solving for the"
1240 PRINT "resulting value of gm and W until W*L/Rq = our desired Qcoil. Cs is a key"
1250 PRINT "element. If its value is too great, no solution is possible, so traps are"
1260 PRINT "scattered among the formulas."
1270 GOSUB 1310:GOTO 10
1280 :REM'
1290 :REM'......clear screen to bottom
1300 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
1310 :REM'.....PRT
1320 KEY OFF:GOSUB 1390:LOCATE 25,5:COLOR 0,2
1330 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1340 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1350 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1350 :ELSE GOSUB 1390
1360 IF Z$="3"THEN RETURN
1370 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1380 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1320
1390 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
