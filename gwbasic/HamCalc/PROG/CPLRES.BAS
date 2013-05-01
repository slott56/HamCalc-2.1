10 :REM'CPLRES  Capacitor Coupled Resonators  21 NOV 09
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 PI=4*ATN(1)
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " CAPACITY COUPLED RESONATORS"TAB(57)"by George Murphy VE3ERP ";
90 LOCATE ,24:PRINT " Algorithm by R.J.Dehoney IEEE "
100 COLOR 7,0
110 PRINT
120 PRINT " This program is derived from CPLRES, a BASIC version of CAPCPL, a";
130 PRINT " C++ program"
140 PRINT " for designing bandpass filters using LC resonators. This program ";
150 PRINT "uses short  "
160 PRINT " lengths of shorted tranmission line to replace the LC resonators.";
170 PRINT " Other      "
180 PRINT " capacitors can be made from short lengths of unshorted cable."
190 PRINT " (Ref. ARRL Handbook 2007, pp. 12.18 - 12.21)"
200 PRINT
210 LL=CSRLIN:D=10:GOSUB 1770
220 PRINT
230 PRINT " INSTALL IN A GROUNED METAL ENCLOSURE"
240 PRINT :PRINT
250 PRINT " To run this program press <1>"
260 PRINT " To see program notes press <2>"
270 PRINT " To EXIT press <0>"
280 Z$=INKEY$:IF Z$=""THEN 280
290 IF Z$="0"THEN RUN GO$
300 IF Z$="1"THEN 330
310 IF Z$="2"THEN 2360
320 GOTO 280
330 :REM'.....start
340 CLS
350 DEF FNHT(X)=(EXP(X)-EXP(-X))/(EXP(X)+EXP(-X))
360 DEF FNHS(X)=(EXP(X)-EXP(-X))/2 :DEF FNHC(X)=(EXP(X)+EXP(-X))/2
370 PI=4*ATN(1) :NH=9.999999717180685e-10! :PF=9.999999960041972e-13! :MHZ=10^6 :V0=30000001024.0!/2.5399999618530273!/12 :REM'FT/SEC
380 Z=CSRLIN
390 LL=2:GOSUB 1770 :REM'print schematic
400 INPUT " ENTER: Filter center frequency (MHz) ";F0 :F0=F0*MHZ :W0=2*PI*F0
410 INPUT " ENTER: Passband ripple in db (Max 3) ";AM
420 IF AM>3 THEN 410
430 RHO=SQR(1-10^(-AM/10)):VSWR=(1+RHO)/(1-RHO)            :REM'SWR=VSWR
440 MX=F0/MHZ*0.20000000298023224!
450 PRINT " ENTER: Ripple bandwidth in MHz (max";MX;") ";:INPUT BW
460 IF BW=0 OR BW>MX THEN BW=0
470 IF BW=0 THEN 450
480 BW=BW*MHZ
490 COLOR 0,7:PRINT " NOTE The more sections the steeper the skirts ":COLOR 7,0
500 INPUT " ENTER: Number of resonator sections (maximum 9) ";N
510 IF N<1 OR N>9 THEN 500
520 INPUT " ENTER: Filter source impedance (Ω) ";R0
530 INPUT " ENTER: Filter load impedance (Ω) ";RL
540 GOSUB 1940    :REM'select cable
550 V=V0*VF :REM'propagation velocity of selected cable
560 LDB=LT/100 :REM'cable attenuation in dB/foot
570 L=R0/W0 :WL=V/F0:REM' cable wavelength in feet
580 CLS
590 :REM'.....calculate
600 BETA=LOG(1/FNHT(AM/17.3700008392334!))
610 NU=FNHS(BETA/2/N)
620 FOR M=1 TO N
630   A(M)=SIN((2*M-1)*PI/2/N)
640   B(M)=NU*NU+(SIN(M*PI/N))^2
650 NEXT M
660 R=(FNHT(BETA/4))^2
670 G(0)=1 :G(1)=2*A(1)/NU
680 FOR M=2 TO N
690   G(M)=4*A(M-1)*A(M)/B(M-1)/G(M-1)
700 NEXT M
710 IF INT(N/2)=N/2 THEN G(N+1)=1/R :ELSE G(N+1)=1
720 Q(1)=G(0)*G(1)
730 Q(N)=G(N)*G(N+1)
740 FOR M=1 TO N-1
750   K(M)=1/SQR(G(M)*G(M+1))
760 NEXT M
770 W=2*PI*F0
780 QBP=F0/BW
790 Q=QBP*Q(1)
800 CN=1/W/W/L
810 R=W*L*Q
820 CS1=SQR(1/W/W/R0/(R-R0))
830 CP1=CS1*(R0-R)/R
840 CS2=SQR(1/W/W/RL/(R-RL))
850 CP2=CS2*(RL-R)/R
860 C(0)=0
870 C(N)=0
880 FOR M=1 TO N-1
890   K1(M)=K(M)/QBP
900   C(M)=K1(M)*CN :IF C(M)<0 THEN L=L/1.100000023841858! :GOTO 800
910   S(M)=V/W0*ATN(W0*C(M)*ZR)
920 NEXT M
930 FOR M=1 TO N
940   C1(M)=CN-C(M-1)-C(M) :IF C1(M)<0 THEN L=L/1.100000023841858! :GOTO 800
950 NEXT M
960 C1(1)=C1(1)+CP1 :IF C1(1)<0 THEN L=L/1.100000023841858! :GOTO 800
970 C1(N)=C1(N)+CP2 :IF C1(N)<0 THEN L=L/1.100000023841858! :GOTO 800
980 C(0)=CS1 :S(0)=V/W0*ATN(W0*C(0)*ZR)
990 C(N)=CS1 :S(N)=V/W0*ATN(W0*C(N)*ZR)
1000 :REM'.....calculate capacitances
1010 CLS
1020 S1=V/W0*ATN(W0*L/ZR)
1030 PRINT " RESONATORS"TAB(22)"Length (mm)"
1040 PRINT USING "## S1 elements, ea.    ###.#";N,S1*30.479999542236328!
1050 FOR M=1 TO N
1060 S2(M)=V/W0*ATN(W0*C1(M)*ZR)
1070 PRINT USING " S2(##)                ###.#";M;S2(M)*30.479999542236328!
1080 NEXT M
1090 PRINT " COUPLERS"TAB(22)"Length (mm)"
1100 TT=0:FOR M=0 TO N
1110 AA=C(M)/PF:BB(M)=S(M)*30.479999542236328!:TT=TT+S(M)
1120   PRINT USING " C(# ##)= ###.### pF   ###.# ";M;M+1;AA;S(M)*30.479999542236328!
1130 NEXT M
1140 :REM'.....display
1150 LL=1 :D=40:E=41:GOSUB 1770    :REM'pr1nt diagram
1160 J=CSRLIN-2
1170 LOCATE J+1,E:PRINT "Cable: ";C$(NC,1)
1180 LOCATE J+2,E:PRINT USING "Center Frequency......... ####.### MHz";F0/MHZ
1190 LOCATE J+3,E:PRINT USING "Number of resonators..... ####";N
1200 LOCATE J+4,E:PRINT USING "Line velocity factor..... ###.##";VF
1210 LOCATE J+5,E:PRINT USING "Line impedance........... ####.# ohms";ZR
1220 LOCATE J+6,E:PRINT USING "Passband ripple.......... ####.### dB";AM
1230 LOCATE J+7,E:PRINT USING "Passband width........... ####.### MHz";BW/10^6
1240 LOCATE J+8,E:PRINT USING "Source impedance......... ####.### Ω";R0
1250 LOCATE J+9,E:PRINT USING "Load impedance........... ####.### Ω";RL
1260 LOCATE J+10,E:PRINT USING "SWR...................... ####.#";VSWR
1270 PRINT
1280 LOCATE J+14,E :PRINT "Press (a) to analyze filter."
1290 LOCATE J+15,E :PRINT "Press (b) for enclosure details"
1300 LOCATE J+16,E :PRINT "Press (v) for L & C equivilents"
1310 LOCATE J+17,E :PRINT "Press <0> to finish."
1320 LOCATE 24,26:PRINT "CAPACITY COUPLED RESONATORS";
1330 A$=INKEY$:IF A$="" THEN 1330
1340 IF A$="0" THEN GOSUB 1840:CLS:RUN
1350 IF A$="a" THEN 1390
1360 IF A$="v" THEN GOSUB 2800:GOSUB 1840:CLS:GOTO 1000
1370 IF A$="b" THEN GOSUB 2580:GOSUB 1840:CLS:GOTO 1000
1380 GOTO 1330
1390 :REM'----------------routine to find insertion loss--------------------
1400 ALPHA=LDB/8.685999870300293!
1410 F=F0 :VS=1 :XX=4
1420 PRINT "  Frequency, MHz         Power Loss, dB"
1430 FOR P=0 TO 18 :F=F0+BW*(XX/9*P-XX)
1440 R=RL :X=0 :RP(N+1)=RL :W=2*PI*F
1450 GOSUB 1710 :REM'get GL and BL at each frequency
1460 R=RL :X=0 :RP(N+1)=RL :W=2*PI*F
1470 FOR M=N TO 1 STEP-1
1480   GOSUB 1740 :REM'get GC(M) and BC(M) at each frequency
1490   XS=X-ZR/TAN(W/V*S(M)) :RS=R :GOSUB 1660 :REM'find Geq, Req(m), & Beq
1500   BP=BEQ+BL+BC(M) :GP=GEQ+GL+GC(M) :RP(M)=1/GP :XP=-1/BP :GOSUB 1690
1510 NEXT M
1520 X=X-ZR/TAN(W/V*S(0)) :REQ(0)=R :V(0)=VS*R/SQR((R+R0)^2+X^2)
1530 FOR M=1 TO N+1
1540   V(M)=V(M-1)*SQR(RP(M)/REQ(M-1))
1550 NEXT M
1560 PIN=VS^2/4/R0 :POUT=V(N+1)^2/RL :LOSS=10*LOG(PIN/POUT)/LOG(10)
1570 PRINT USING "    ####.###              ##.### ";F/MHZ;LOSS
1580 NEXT P :REM'LOCATE 18
1590 PRINT "Press <2> for narrow range, <1> for wide range, or <0> to QUIT"
1600 A$=INKEY$
1610 IF A$="0"THEN GOSUB 1840:CLS:GOTO 1000
1620 IF A$="1" THEN CLS :XX=4 :GOTO 1420
1630 IF A$="2" THEN CLS :XX=0.5! :GOTO 1420
1640 IF A$="3" THEN CLS :XX=0.25! :GOTO 1420
1650 GOTO 1600
1660 :REM'--------------subroutine to find parallel Beq & Geq--------------
1670 XEQ=(XS^2+RS^2)/XS :REQ(M)=(RS^2+XS^2)/RS
1680 BEQ=-1/XEQ :GEQ=1/REQ(M) :RETURN
1690 :REM'--------------subroutine to find series R & X--------------------
1700 R=RP(M)*XP^2/(RP(M)^2+XP^2) :X=XP*RP(M)^2/(RP(M)^2+XP^2) :RETURN
1710 :REM'---------------subroutine to find GL & BL--------------
1720 XS=2*ALPHA*S1 :YS=2*W*S1/V :DENOM=FNHC(XS)-COS(YS)
1730 GL=FNHS(XS)/DENOM/ZR :BL=-SIN(YS)/DENOM/ZR :RETURN
1740 :REM'---------------subroutine to find GC(M) and BC(M)-------------
1750 XS=2*ALPHA*S2(M) :YS=2*W*S2(M)/V :DENOM=FNHC(XS)+COS(YS)
1760 GC(M)=FNHS(XS)/DENOM/ZR :BC(M)=SIN(YS)/DENOM/ZR :RETURN
1770 :REM'-------------------Schematic----------------------------
1780 LOCATE LL+0,D:PRINT "*─C(0,1)─┬───┬─C(1,2)─┬───┬─\─C(N,N+1)─┐"
1790 LOCATE LL+1,D:PRINT "        ║│║ ║│║      ║│║ ║│║           │"
1800 LOCATE LL+2,D:PRINT "        ║│║ ║│║S2(1) ║│║ ║│║S2(2)      RL"
1810 LOCATE LL+3,D:PRINT "      S1║│║ ║│║    S1║│║ ║│║«─shield   │"
1820 LOCATE LL+4,D:PRINT "*───────╨┴╨───┴──────╨┴╨───┴─\─────────┘"
1830 PRINT :RETURN
1840 :REM'.....PRT
1850 KEY OFF:GOSUB 1920:LOCATE 25,5:COLOR 0,2
1860 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1870 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1880 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1880 :ELSE GOSUB 1920
1890 IF Z$="3"THEN RETURN
1900 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1910 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1850
1920 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
1930 END
1940 :REM'--------------subroutine to select cable and get parameters---------
1950 :REM'Given F0 from the calling program, this program gets coax data from
1960 :REM'COAXFIL.FIL, then uses the selected cable data to get values for ZR, VF,
1970 :REM'and dB/100'.
1980 :REM'
1990 DIM C$(60,9)
2000 :REM'            ----read data----
2010 OPEN "I",1,"C:\HAMCALC\COAXFILE\COAXIAL.FIL"
2020 FOR Z=1 TO 40 :FOR Y=1 TO 9
2030     INPUT#1,Z$
2040     C$(Z,Y)=Z$
2050 NEXT Y :NEXT Z
2060  CLOSE
2070 FOR X=1 TO 40 :REM'calculate attenuation/100ft
2080  Z0=VAL(C$(X,5))         :REM'impedance
2090  D=VAL(C$(X,4))          :REM'ID of outer conducter
2100  E=VAL(C$(X,3))          :REM'dielectric constant
2110  VF=INT(1/SQR(E)*1000)/1000
2120  C$(X,3)=STR$(VF)        :REM'velocity factor
2130  B=10^(Z0*SQR(E)/138)    :REM'D/d constant
2140  IF RIGHT$(C$(X,7),1)="f"THEN K1= 0.9390000104904175! :ELSE K1=1
2150  K2=1:K=K1+K2
2160  A=0.4350000023841858!/Z0/D*B*K*SQR(F0)/1000   :REM'attenuation per 100 feet
2170  A=INT(A*1000)/1000
2180 C$(X,6)=STR$(A)          :REM'enter attenuation value into array
2190 NEXT X
2200 CLS: PRINT "            ----------Select a Cable Type-----------"
2210 PRINT " For"F0/10^6"MHz select a cable with........"
2220 PRINT"       Type          ZR     Velocity Factor  dB Loss per 100 feet"
2230 FOR P=1 TO 19
2240 PRINT P;TAB(6);C$(P,1);TAB(21);C$(P,5);TAB(34);C$(P,3);TAB(50);C$(P,6)
2250 NEXT P
2260 PRINT "            Press any key for more"
2270 A$=INKEY$ :IF A$="" THEN 2270 :ELSE CLS
2280 PRINT "       Type          ZR     Velocity Factor  dB Loss per 100 feet"
2290 FOR P=20 TO 40
2300 PRINT P;TAB(6);C$(P,1);TAB(21);C$(P,5);TAB(34);C$(P,3);TAB(50);C$(P,6)
2310 NEXT P
2320 INPUT"Enter <0> to review the cables or to select one, enter its number ",P
2330 IF P<1 THEN 2220 :ELSE IF P>40 THEN 2220
2340 ZR=VAL(C$(P,5)) :VF=VAL(C$(P,3)) :LT=VAL(C$(P,6)):NC=P
2350 CLS :RETURN
2360 CLS :PRINT "        -------------Program Notes---------------------"
2370 PRINT"This program is derived from a C++ program by Glen V.Rosenbaum, in the October"
2380 PRINT "1998 issue of `Applied Microvaves & Wireless'. His program used the Chebychev"
2390 PRINT "synthesis methods found in Zverev and others. Here, we replace the Ls and Cs"
2400 PRINT "with lengths of coax. Since the equivalence is only true at a single frequency,"
2410 PRINT "the resulting filter differs from the LC filter. You'll find that the rolloff"
2420 PRINT "is better than the LC version, the insertion loss is greater, due to the cable"
2430 PRINT "cable Q being lower than the Q of high quality RF capacitors, and the band"
2440 PRINT "width is much less, about half the LC version. Coupled resonator filters have"
2450 PRINT "the ability to act as matching filters, with no restrictions on source or load"
2460 PRINT "resistance. This makes them attractive for use with antennas which often have"
2470 PRINT "odd ball input impedances."
2480 PRINT "            ----------Program Description--------------"
2490 PRINT "The ripple, source and load, and frequency data is used to calculate the Ls"
2500 PRINT "and Cs. After the user selects a cable type, the cable lengths are calculated"
2510 PRINT "and displayed. The analysis section does a brute strength ladder analysis,"
2520 PRINT "using the hyperbolic transmission line equations to represent the R and X of"
2530 PRINT "the open and shorted cables. The resistance values are saved at each stage, so"
2540 PRINT "the power loss can be tracked from input to output. Both cable and LC versions"
2550 PRINT "can be analyzed."
2560 PRINT :PRINT "Press any key to return "
2570 A$=INKEY$ :IF A$="" THEN 2570 :ELSE 20
2580 :REM'.........enclosure
2590 CLS
2600 PRINT "       ╔═════════\═╗"
2610 PRINT " line ──a┬─┬a┬─┬a─\──to next a"
2620 PRINT "     ┌─╢ b c b c   ╟─«─ ground"
2630 PRINT "     ╧ ╚═╧═╧═╧═╧═\═╝"
2640 PRINT "      METAL ENCLOSURE"
2650 PRINT ""
2660 PRINT
2670 PRINT "        ╒══════╕«┐"
2680 PRINT " a= ──────────── └─connect shield to next <a>"
2690 PRINT "        ╘══════╛"
2700 PRINT "        ╒══════╕«┐"
2710 PRINT " b= ────────────«┴─connect shield and inner conductor to ground"
2720 PRINT "        ╘══════╛"
2730 PRINT "        ╒══════╕«─ connect shield to ground"
2740 PRINT " c= ────────────«─ cut off flush with dielectric and shield"
2750 PRINT "    │   ╘══════╛"
2760 PRINT "    │   │      │"
2770 PRINT "    │«┬»│«────»│«─ cut shield & dielectric to lengths specified"
2780 PRINT "      └ 50 mm inner conductor"
2790 RETURN
2800 :REM'........Filter L and C values"
2810 CLS :LOCATE 2,2 :PRINT USING "Inductor Value...... ####.## nH";L/NH
2820 FOR M=1 TO N
2830 LOCATE 2+M,5 :PRINT USING "C2(#).... ###.## pF";M;C1(M)/PF
2840 NEXT M
2850 FOR M=0 TO N
2860 LOCATE 2+N+2+M,3 :PRINT USING "C(## ##).... ###.## pF";M;M+1;C(M)/PF
2870 NEXT M :LOCATE 23,1
2880 PRINT "Press (1) to see insertion loss values or (0) to return"
2890 A$=INKEY$ :IF A$="" THEN 2890
2900 IF A$="1" THEN 2920
2910 RETURN
2920 CLS:REM'----------------routine to find insertion loss--------------------
2930 PRINT " For a perfomance report ENTER an inductor Q at"F0/MHZ"Mhz ";:INPUT QU
2940 RQ=W*L*(1+QU^2)/QU
2950 F=F0 :VS=1 :XX=4
2960 PRINT "  Frequency, MHz   Power Loss, dB   VSWR"
2970 FOR P=0 TO 18 :F=F0+BW*(XX/9*P-XX)
2980 R=RL :X=0 :RP(N+1)=RL :W=2*PI*F
2990 FOR M=N TO 1 STEP-1
3000   XS=X-1/W/C(M) :RS=R :GOSUB 1660 :REM'find Geq, Req(m), & Beq
3010   BP=BEQ+W*C1(M)-1/W/L :GP=GEQ+1/RQ :RP(M)=1/GP :XP=-1/BP :GOSUB 1690
3020 NEXT M
3030 X=X-1/W/C(0) :REQ(0)=R :V(0)=VS*R/SQR((R+R0)^2+X^2)
3040 NUM=(R-R0)^2+X^2 :DENOM=(R+R0)^2+X^2 :RHO=SQR(NUM/DENOM)
3050 SWR=(1+RHO)/(1-RHO) :IF SWR>900 THEN SWR=900
3060 FOR M=1 TO N+1
3070   V(M)=V(M-1)*SQR(RP(M)/REQ(M-1))
3080 NEXT M :IF V(N+1)<1.000000045813705e-18! THEN V(N+1)=1.000000045813705e-18!
3090 PIN=VS^2/4/R0 :POUT=V(N+1)^2/RL :LOSS=10*LOG(PIN/POUT)/LOG(10)
3100 PRINT USING "    ####.###         ###.###    ######.###";F/MHZ;LOSS;SWR
3110 NEXT P
3120 PRINT "Press (1),(2),or (3) for different ranges, or <0> to return"
3130 A$=INKEY$
3140 IF A$="0"THEN CLS :GOTO 2910
3150 IF A$="1" THEN CLS :XX=4 :GOTO 2960
3160 IF A$="2" THEN CLS :XX=0.75! :GOTO 2960
3170 IF A$="3" THEN CLS :XX=0.25! :GOTO 2960
3180 GOTO 3130
3190 END
