10 :REM'BATTCHG Step-up switcher - 06 FEB 07
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS:COLOR 15,2,1
80 PRINT " Battery Charger"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 1,0:PRINT STRING$(80,223);
100 COLOR 15,2:LOCATE CSRLIN-1,26:PRINT " Algorithm by R.J.Dehoney IEEE "
110 COLOR 7,0
120 :REM'.....start
130 GOSUB 1320:PRINT
140 PRINT " This program designs a step up switcher that uses 2 size C batteri";
150 PRINT "es to charge"
160 PRINT " a 12 volt automotive battery."
170 PRINT :LN=CSRLIN:LOCATE LN,26:COLOR 0,7
180 PRINT " Press 1 to continue or 0 to exit. ":COLOR 7,0
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="0"THEN CHAIN EX$
210 IF Z$="1"THEN 230
220 GOTO 180
230 COLOR 7,0,0:CLS:GOSUB 1320
240 PRINT
250 :REM'.....description
260 PRINT "This program analyzes a step up switcher with a diode and RC load. Given V1,"
270 PRINT "V2,RL,R1,R2,L,& K it solves for the switch ON time T1, the OFF time T2,"
280 PRINT "the average input current Iave, and the efficiency. R1 is the net resistance"
290 PRINT "when the switch is closed. R2 is the net resistance when the switch is open"
300 PRINT "and the current flows into the load filter, C. When the switch is closed,"
310 PRINT "the current through L increases from I2 to I1. When the switch opens, the"
320 PRINT "current decreases from I1 to I2. Depending on T1 and T2, I2 can vary from 0"
330 PRINT "to near I1. K is the ratio I2/I1 and should be .2 to .6 for best efficiency."
340 PRINT "The program operates by calculating the average load current IL for an"
350 PRINT "initial value of T1, comparing IL with V2/RL, then increasing T1 until"
360 PRINT "IL=V2/RL. If the load is a battery, set RL=V2/IL, where V2 is the battery"
370 PRINT "voltage and IL is the desired current."
380 PRINT
390 PRINT "Units are volts, ohms, µH, and µs. VD is the diode voltage, VS is the"
400 PRINT "switch voltage, and TR accounts for the finite rise time of the inductor."
410 GOSUB 1400
420 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 7
430 PRINT " The design, prototype and testing of this circuit were developed";
440 PRINT " using a"
450 PRINT " 216 µH ferrite inductor, but other values may be used."
460 PRINT
470 PRINT " The power source V1 for this circuit is two size C cells in series,"
480 PRINT " assuming a total life capacity of about 2 amp hours."
490 PRINT
500 PRINT " Low inductances produce small coils, high currents and short charg";
510 PRINT "ing times."
520 V1=3: PRINT
530 L=41:V2=13.800000190734863!
540 INPUT " ENTER: Input Inductance (µH) (minimum 32.4)....L=";L
550 IF L=0 THEN 530
560 VIEW PRINT 6 TO 24:CLS:VIEW PRINT:LOCATE 7
570 :REM'.....data inputs
580 Z=60
590 IL=Z*1000:RL=V2/IL*1000000.0!
600 R1=0.5!: R2=0.5!: VD=0.6000000238418579!: VS=0.20000000298023224!: TR=0.20000000298023224!: K=0.5!
610 VIEW PRINT 6 TO 24 :CLS:VIEW PRINT:LOCATE 7
620 :REM'---------------calculation is for I2=K*I1----------------
630 IL=V2/RL :IM1=(V1-VS)/R1 :FOR N=1 TO 100000.0! :X1=N*9.999999747378752e-05!
640 T1=X1*L/R1 :I1=IM1*(1-EXP(-X1))/(1-K*EXP(-X1))
650 IF X1>0.019999999552965164! THEN IA1=IM1-I1*(1-K)/X1 :ELSE IA1=I1*(1+K)/2
660 IA1=(IA1*T1+I1*TR)/(T1+TR)
670 IM2=(V1-V2-VD)/R2 :X2=-LOG((IM2-K*I1)/(IM2-I1)) :T2=X2*L/R2
680 IF X2>0.019999999552965164! THEN IA2=IM2+I1*(1-K)/X2 :ELSE IA2=I1*(1+K)/2
690 IF ILX>ILM THEN ILM=ILX
700 IAVE=(IA1*(T1+TR)+IA2*T2)/(T1+T2+TR) :ILX=IA2*T2/(T1+T2+TR)
710 IF IAVE <=0.3499999940395355! THEN 740
720 PRINT "With a";L;"µH inductor the average current is greater than 350 mA.!"
730 PRINT :PRINT "Too high! Try again with a higher inductance!":GOTO 1300
740 IF ILX<IL THEN 750 :ELSE 760
750 NEXT N
760 I2=K*I1 :M=1000
770 :REM'
780 :REM'.....display results
790 VIEW PRINT 6 TO 24 :CLS:VIEW PRINT:LOCATE 7
800 PRINT USING " Inductance L.......... ####.# µH";L
810 PRINT USING " Input DC voltage V1... ####.# volts";V1
820 PRINT USING " Output DC voltage V2.. ####.# volts";V2
830 PRINT USING " Loss resistance R1.... ####.# ohms";R1
840 PRINT USING " Loss resistance R2.... ####.# ohms";R2
850 PRINT USING " Drop across D......... ####.# volts";VD
860 PRINT USING " Drop across SW........ ####.# volts";VS
870 PRINT USING " Time rise TR.......... ####.# µsec.";TR
880 PRINT USING " ON time T1............ ####.# µsec.";T1
890 PRINT USING " OFF time T2........... ####.# µsec.";T2
900 PRINT USING " Average Current....... ####.# ma.";IAVE*M
910 PRINT USING " Output current........ ####.# ma.";ILX*M
920 EF=V2*ILX/(V1*IAVE)*100
930 PRINT USING " Efficiency............ ####.# %";EF
940 AH=1.7200000286102295! :REM'effectice amp hours of 2 size C cells
950 TC=AH/IAVE:REM' charging time in hours
960 PRINT USING " Charging time......... ####.# hrs.";TC
970 GOSUB 1400 :REM'PRT
980 :REM'.....screen display
990 CLS
1000 PRINT"    SCHEMATIC                 ";L;"µH"
1010 PRINT"    ┌ A─┬───────────────────┬────L1─────┬──────>├───────┬─────┐"
1020 PRINT"    │   │               ┌───┼─────┐     │    1N5818     │     │"
1030 PRINT" off\on │             ┌─4───8─┐ 220Ω    │               │     │+"
1040 PRINT"   +│   │           ┌─2       │   │     │ c            15v   to 12v."
1050 PRINT"   3v.  │  ┌────────┤ │  CMOS │   │ b │/              Zener  battery"
1060 PRINT"   Vdc  │  │        └─6  555  7───┴───┤ Q1   ┌──┐c      │     │-"
1070 PRINT"   -│  +│  ├R─>│─Rb─┐ │       │       │\     │   \│     │     │"
1080 PRINT"    │   C  │        ├─3       5─┐       │ e  │ Q2 ├──┬──┴──┬──┘"
1090 PRINT"    │  -│  ├R─│<─Ra─┘ └───1───┘ │       │    │   /│  │     │+"
1100 PRINT"    │   │470pf            │     └─220kΩ─│────┘  │e  10Ω   100µF"
1110 PRINT"    └───┴──┴──────────────┴─────────────┴───────┴────┴─────┘-"
1120 PRINT
1130 PRINT "    Meter A=0-1A.:C=150µF:R=1kΩ:Ra,Rb=20kΩ pots:Q1=D1469:Q2=2N2222"
1140 PD=1.950600028038025!: WIRE=0.025299999862909317!: PITCH=2*WIRE: NT=0
1150 NT=NT+0.10000000149011612!: LG=PITCH*NT: Z=(PD^2*NT^2)/(18*PD+40*LG): Z$=CHR$(34)
1160 IF Z<L THEN 1150 :REM'iteration
1170 PRINT USING "    L1=### turns AWG 22 wire###.###";NT,LG;:PRINT Z$;" long";
1180 PRINT " on a";:PRINT USING"##.###";PD-(2*WIRE);:PRINT Z$;" dia. coil form."
1190 PRINT "    ( 1½";Z$" PVC pipe is 1.900";Z$;" diameter )."
1200 PRINT
1210 PRINT " 1. Make sure switch is off. Set Ra at minimum resistance."
1220 PRINT " 2. Set Rb at maximum resistance. Turn switch on."
1230 PRINT " 3. Slowly increase resistance Ra until the current starts to rise."
1240 Z=INT(IAVE*1000)
1250 PRINT " 4. Slowly decrease resistance Rb until current reaches";Z;"mA."
1260 PRINT " 5. Change resistance Rb no further. The current will slowly decre";
1270 PRINT "ase."
1280 PRINT " 6. Charging ends when current reaches zero. Turn switch off."
1290 :REM'.....end
1300 GOSUB 1400:GOTO 20
1310 :REM'
1320 :REM'.....block diagram
1330 PRINT "  ┌──L──┬─>D─R2──┬──┬──┐  SW=NPN transistor,>D=schottky diode."
1340 PRINT "  │+    R1       │  │  +  During ON time T1 SW is closed and current"
1350 PRINT " V1     │        RL C V2  thru inductor L ramps up from K*I1 to I1."
1360 PRINT "  │-    SW       │  │  -  During OFF time T2 SW is open and current"
1370 PRINT "  └─────┴────────┴──┴──┘  through L ramps down from I1 to K*I1."
1380 RETURN
1390 :REM'
1400 :REM'.....PRT
1410 KEY OFF:GOSUB 1480:LOCATE 25,5:COLOR 0,2
1420 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1430 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1440 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1440 :ELSE GOSUB 1480
1450 IF Z$="3"THEN RETURN
1460 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1470 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1410
1480 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
1490 PRINT "ase."
