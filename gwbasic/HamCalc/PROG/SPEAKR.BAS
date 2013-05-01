10 :REM'SPEAKR - Speaker Equalizer - 13 JUL 2008
20 IF EX$=""THEN EX$="EXIT"
30 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
40 COMMON EX$,PROG$
50 PI=4*ATN(1)  :REM'3.141593
60 TP=2*PI
70 :REM'.....title page
80 CLS:KEY OFF
90 COLOR 15,2
100 PRINT " SPEAKER EQUALIZER"TAB(60)" by R.J.Dehoney IEEE "
110 COLOR 7,0
120 IF QP=0 THEN 180
130 CLS:PRINT "Want printout of the circuit?  (y/n)"
140 P$=INKEY$:IF P$=""THEN 140
150 IF P$="y"THEN QP=0:GOTO 170 :ELSE QP=0:GOTO 80
160 GOTO 140
170 CLS:LOCATE 3 :GOSUB 300:Z$="2":GOSUB 1360:GOTO 80
180 REM Ref. LINK.BAS,rjd,6/27/08
190 PRINT "This program finds the values for the Linkwitz equalizer. See S.H.Linkwitz,"
200 PRINT "`Loudspeaker System Design', Wireless World, Dec.1978,p.80, and Leo Sahlsten,"
210 PRINT "`Use a Linkwitz Circuit to Equalize a Closed Box Audio Loudspeaker',"
220 PRINT "Electronic Engineering Times, June 9, 2008. See also www.linkwitz.com."
230 PRINT
240 GOSUB 300:PRINT
250 PRINT "Press 1 to continue or 0 to exit."
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="1"THEN CLS:GOSUB 300:GOTO 430
280 IF Z$="0"THEN CLS:PROG$="":RUN GO$
290 GOTO 260
300 :REM'.....diagram
310 PRINT "                      LINKWITZ  EQUALIZER               "
320 PRINT "                         ┌──R2───C2──┐                  "
330 PRINT "                      ┌──┤           ├──┐               "
340 PRINT "                      │  └──R3─┬─R3──┘  │               "
350 PRINT "                      │        C        │               "
360 PRINT "                      │        ╧        │               "
370 PRINT " Audio ┌──R2───C2──┐  │  ┌──────────┐   │               "
380 PRINT "  in ──┤           ├──┴──┤-         │   │               "
390 PRINT "       └──R1─┬─C1──┘     │  OP AMP  ├───┴──  Audio out  "
400 PRINT "             C1        ┌─┤+         │                   "
410 PRINT "             ╧         ╧ └──────────┘                   "
420 RETURN
430 :REM'.....procedure
440 LN=CSRLIN
450 PRINT "The procedure is to measure the response of the speaker in the enclosure,"
460 PRINT "then use that information to calculate the R and C values for the circuit"
470 PRINT "above. We need the low frequency relative peak value and the frequency at"
480 PRINT "which that peak occurs. For instance, if the mid-band output is 0.6 volts"
490 PRINT "and there's a peak at 52 Hz of .9 volts, the relative peak is 1.5 at 52 Hz."
500 PRINT "If there is no discernable peak, we must use a different scheme. For this"
510 PRINT "situation, we need the frequencies where the relative output is .8 and .5."
520 PRINT
530 INPUT "Does the response show a discernable low frequency peak (y/n) ",A$
540 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
550 IF A$="n" THEN GOSUB 1180 :PRINT
560 INPUT "ENTER: relative peak value (greater than 1) ";GP
570 INPUT "ENTER: the frequency in Hz of the peak value. ";FPK :PRINT
580 :REM'-----------procedure to calculate Q0 and F0------------
590 TP=2*3.1415927# :Q0=SQR((GP^2+SQR(GP^4-GP^2))/2)
600 F0=FPK*SQR((2-1/Q0^2)/2) :W0=TP*F0
610 PRINT "Q="Q0" F (Hz)="F0 :R=1000 :L=R*Q0/W0 :C=1/L/W0/W0 :REM'simulates speaker
620 PRINT :REM'-----------procedure to find Fp and K-----------------
630 PRINT "The network you are about to design can smooth the existing peak and"
640 PRINT "extend the low frequency response. If you choose the new Q to be .71"
650 PRINT "the response will smoothly fall off to be -3dB at the new F0 you choose."
660 PRINT "Choosing too low a frequency will put a great burden on the amplifier"
670 PRINT "since it will have to overcome the fall off of the exixting speaker system. " :PRINT
680 INPUT "ENTER: a new Q value ";QP :B=Q0/QP
690 PRINT "Choose frequency giving positive value of K"
700 PRINT " Frequency   K "
710 FOR N=1 TO 14 :FP=QP*F0*N/14 :A=F0/FP :K=(A-B)/(B-1/A)
720 PRINT USING "##,###.##  ###.## ";FP,K :NEXT N
730 INPUT "ENTER: a new frequency in Hz";FP :A=F0/FP :K=(A-B)/(B-1/A)
740 :REM'------------------procedure to find circuit values-----------------
750 INPUT "ENTER: a trial value for C2 in uF, for example .047 ",C2 :C2U=C2*9.999999974752427e-07!
760 IF C2=0 THEN C2=0.04699999839067459! :C2U=C2*9.999999974752427e-07!
770 R1=1/TP/F0/C2U/2/Q0/(1+K) :R2=2*K*R1 :C1=C2*(2*Q0*(1+K))^2
780 C3=C1/A^2 :R3=R1*A^2
790 PRINT :PRINT "R1="R1"    R2="R2"     R3="R3
800 PRINT USING "C1= ###.### µF     C2= ###.### µF     C3= ###.### µF";C1,C2,C3
810 PRINT :INPUT "ENTER: Are values OK? (y/n) ";A$ :IF A$="n" THEN 680
820 :REM'---------------calculate response-------------------
830 UF=9.999999974752427e-07! :C1=C1*UF :C2=C2*UF :C3=C3*UF
840 AX=-C2*R1^2*C1*R3^2*C3*C*L
850 BX=-2*C2*R1^2*C1*R3*C*L-R2*C2*R3^2*C3*C*L-2*C2*R1*R3^2*C3*C*L
860 CX=-2*R2*C2*R3*C*L-4*C2*R1*R3*C*L-R3^2*C3*C*L
870 DX=-2*R3*C*L
880 EX=-AX
890 FX=C2*R1^2*C1*R3^2*C3*R*C+R2*C2*R1^2*C1*C*L+2*C2*R1^2*C1*R3*C*L                    +2*C2*R1*R3^2*C3*C*L
900 GX=C2*R1^2*C1*R3^2*C3+R2*C2*R1^2*C1*R*C+2*C2*R1^2*C1*R3*R*C                        +2*C2*R1*R3^2*C3*R*C+2*R2*C2*R1*C*L+R1^2*C1*C*L+4*C2*R1*R3*C*L
910 HX=R2*C2*R1^2*C1+2*C2*R1^2*C1*R3+2*C2*R1*R3^2*C3+2*R2*C2*R1*R*C                    +R1^2*C1*R*C+4*C2*R1*R3*R*C+2*R1*C*L
920 IX=2*R2*C2*R1+R1^2*C1+4*C2*R1*R3+2*R1*R*C
930 JX=2*R1
940 AY=C2*R1^2*C1*R3^2*C3 :REM'constants for the network only to show required gains
950 BY=2*C2*R1^2*C1*R3+R2*C2*R3^2*C3+2*C2*R1*R3^2*C3
960 CY=2*R2*C2*R3+4*C2*R1*R3+R3^2*C3
970 DY=2*R3
980 EY=-AY
990 FY=-R2*C2*R1^2*C1-2*C2*R1^2*C1*R3-2*C2*R1*R3^2*C3
1000 GY=-2*R2*C2*R1-R1^2*C1-4*C2*R1*R3
1010 HY=-2*R1
1020 CLS
1030 PRINT "   Freq Hz  Initial Gain dB  Circuit Gain dB  Overall Gain dB"
1040 FOR N=1 TO 20 :F=F0*2/20*N :W=F*TP :X=F/F0
1050 NUM0=X^2 :DENOM0=(X^2-1)^2+X^2/Q0^2
1060 G0=NUM0/SQR(DENOM0) :G0DB=20*LOG(G0)/LOG(10)
1070 NUMX=(W^4*BX-W^2*DX)^2+(W^5*AX-W^3*CX)^2
1080 DENOMX=(W^4*FX-W^2*HX+JX)^2+(W^5*EX-W^3*GX+W*IX)^2
1090 G1=SQR(NUMX/DENOMX) :G1DB=20*LOG(G1)/LOG(10)
1100 NUMY=(DY-W^2*BY)^2+(W*CY-W^3*AY)^2
1110 DENOMY=(HY-W^2*FY)^2+(W*GY-W^3*EY)^2
1120 G2=SQR(NUMY/DENOMY) :G2DB=20*LOG(G2)/LOG(10)
1130 PRINT USING "###,###.##       ###.###        ###.###       ####.### ";F;G0DB;G2DB;G1DB
1140 NEXT N
1150 PRINT USING " R1= ##### Ω     R2= ##### Ω     R3= ##### Ω";R1,R2,R3
1160 PRINT USING " C1= ###.### µF  C2= ###.### µF  C3= ###.### µF";C1*10^6,C2*10^6,C3*10^6
1170 GOTO 1280
1180 :REM'-----------------subroutine for Q<.8-------------------
1190 INPUT "Enter the frequency where the output is 0.8 of midband ",F1
1200 PRINT "Enter the frequency where the output is 0.5 of midband. For a 2nd order network,this must be larger than"F1*0.4328579902648926!""
1210 INPUT "ENTER: Frequency (Hz)";F2
1220 M1=1/0.800000011920929!^2 :M2=1/0.5!^2
1230 NUM=(F2^2*(M2-1)-F1^2*(M1-1))*F1^2*F2^2
1240 DENOM=F1^2-F2^2
1250 F0=(NUM/DENOM)^0.25! :Y=(F1/F0)^2
1260 Q0= SQR(Y/(M1*Y^2-(Y-1)^2)) :REM':PRINT "F0="F0"  Q0="Q0
1270 W0=TP*F0 :RETURN 610
1280 :REM'.....end
1290 GOSUB 1300:CLS:GOTO 70
1300 :REM'.....PRT
1310 KEY OFF:GOSUB 1380:LOCATE 25,5:COLOR 0,2
1320 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1330 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1340 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1340 :ELSE GOSUB 1380
1350 IF Z$="3"THEN RETURN
1360 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1370 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1310
1380 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
