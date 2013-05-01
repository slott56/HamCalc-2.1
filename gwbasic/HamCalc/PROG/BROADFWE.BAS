10 :REM'BROADFER - Toroid Baluns & Transformers - rev. 26 DEC 2001
20 :REM'Broadband Ferrite Transformers - 31 DEC 1997 rev. 19 MAY 2001
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN PROG$="broadfer"
50 COMMON EX$,PROG$,FRQ,ZP,ZS,XS,LS,L
60 CLS:KEY OFF
70 COLOR 7,0,1
80 PI=3.1415929794311523!
90 UL$=STRING$(80,205)
100 U$="#####.###"
110 GOTO 180
120 :REM'
130 :REM'.....format input line
140 LOCATE LN:PRINT SPC(7);
150 LOCATE LN,47:PRINT STRING$(7,".");USING U$;ZZ;
160 RETURN
170 :REM'
180 :REM'.....start
190 CLS
200 COLOR 15,2
210 PRINT " TOROID BALUNS AND TRANSFORMERS (Ferrite)";
220 PRINT TAB(57)"by George Murphy VE3ERP ";
230 COLOR 1,0:PRINT STRING$(80,223);
240 COLOR 0,7
250 LOCATE 2,23:PRINT " Broadband Ferrite RF Transformer ":COLOR 7,0
260 IF AL<>0 THEN 920
270 GOSUB 1380  :REM'diagram
280 PRINT:LN=CSRLIN
290 PRINT " Conventional broadband transformers require resistive loads."
300 PRINT " Loads with reactive components should use appropriate networks to";
310 PRINT " cancel the  "
320 PRINT " reactance."
330 PRINT " (Ref.  2000 ARRL Handbook for Radio Amateurs, pp. 6.47-6.49)"
340 PRINT UL$;
350 IF PROG$="balun"THEN PROG$="broadfer":GOTO 480 :ELSE 360
360 PRINT " Press number in < > to:"
370 PRINT UL$;
380 IF PROG$="balun"THEN PRINT "":PROG$="broadfer":GOTO 640
390 PRINT "   <1> Run RF Transformer/Balun program"
400 PRINT "   <2> Run Off-Centre-Fed Dipole program"
410 PRINT
420 PRINT "   <0> EXIT"
430 Z$=INKEY$:IF Z$=""THEN 430
440 IF Z$="0"THEN CLS:RUN EX$
450 IF Z$="1"THEN 480
460 IF Z$="2"THEN CLS:RUN"ocfdipol"
470 GOTO 430
480 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
490 :REM'
500 :REM'.....input data
510 LN=CSRLIN:PRINT " ENTER: Lowest frequency of operation...........(MHz)";
520 IF FRQ THEN PRINT "":GOTO 540
530 INPUT FRQ
540 ZZ=FRQ:GOSUB 130:PRINT " MHz"
550 LN=CSRLIN:PRINT " ENTER: Impedance of primary (hi-Z) winding....(ohms)";
560 IF ZP THEN PRINT "":GOTO 580
570 INPUT ZP
580 ZZ=ZP:GOSUB 130:PRINT " Ω"
590 LN=CSRLIN:PRINT " ENTER: Impedance of secondary (lo-Z) winding..(ohms)";
600 IF ZS THEN PRINT "":GOTO 620
610 INPUT ZS
620 ZZ=ZS:GOSUB 130:PRINT " Ω"
630 :REM'
640 IF ZS>ZP THEN SWAP ZS,ZP
650 R=ZP/ZS:V$="#####.###:1"
660 PRINT "        Impedance ratio..............................";USING V$;R
670 XS=4*ZS:V$="#####.### Ω"
680 PRINT "        Reactance of secondary (lo-Z) winding........";USING V$;XS
690 LS=XS/(2*PI*FRQ)/10^3:V$="#####.## mH"
700 PRINT "        Inductance of secondary (lo-Z) winding.......";USING V$;LS
710 PRINT
720 PRINT TAB(7);
730 PRINT "In the next step you will be asked to select a core and the size"
740 PRINT TAB(7);
750 PRINT "of wire to be used for the windings. The wire must be large enough"
760 PRINT TAB(7);
770 PRINT "to handle the currents involved."
780 PRINT: COLOR 0,7
790 LOCATE ,5
800 PRINT " ƒ= 1.8-30 MHz:  Use a Ferrite core with a permeability of";
810 PRINT " µ=850       "
820 LOCATE ,5
830 PRINT " ƒ= over 30 MHz: Use a Ferrite core with a permeability of";
840 PRINT " µ=42 to 12  "
850 LOCATE ,5:COLOR 4,7
860 PRINT "       . . . . . Press any key to select a suitable core .";
870 PRINT " . . . .     ";
880 COLOR 7,0
890 IF INKEY$="" THEN 890
900 CLS:L=INT(LS*10^3+0.5!)/10^3:CHAIN"\hamcalc\prog\toroid"
910 :REM'
920 :REM'.....display results
930 V$="#####.### MHz"
940 PRINT " Lowest frequency of operation................";USING V$;FRQ
950 V$="#####.#### Ω"
960 PRINT " Impedance of primary (hi-Z) winding..........";USING V$;ZP
970 PRINT " Impedance of secondary (lo-Z) winding........";USING V$;ZS
980 R=ZP/ZS:R$="#####.###:1"
990 PRINT " Impedance ratio..............................";USING R$;R
1000 PRINT " Reactance of secondary (lo-Z) winding........";USING V$;XS
1010 PRINT " Inductance of secondary (lo-Z) winding.......";USING V$;L
1020 C$="FT-"+CAT$
1030 PRINT " AMIDON or PALOMAR ferrite core...............";SPC(6);C$;
1040 PRINT " Mix #";MX
1050 PRINT " Permeability.................................";SPC(6);F$
1060 PRINT " Manufacturer's AL value......................";USING "#####";AL;
1070 PRINT " µH per 100 turns"
1080 W$="#####.#### in.="
1090 PRINT " Wire diameter................................";USING W$;WIRD;
1100 PRINT USING "###.## mm";WIRD*25.399999618530273!
1110 GA=CSRLIN:IF GA$<>"" THEN LOCATE GA-1,36:PRINT "(AWG ";GA$;")":LOCATE GA
1120 NS=10^3*SQR(L/AL):N$="#####.# turns"
1130 PRINT " Secondary (lo-Z) winding.....................";USING N$;NS
1140 NP=NS*SQR(ZP/ZS)
1150 PRINT " Primary (hi-Z) winding.......................";USING N$;NP
1160 PRINT " Capacity of core.............................";USING N$;MAX
1170 PRINT UL$;
1180 IF NP<MAX THEN 1260
1190 COLOR 0,7:BEEP
1200 PRINT " THE CORE MAY BE TOO SMALL FOR THE NUMBER OF TURNS REQUIRED . . . ";
1210 PRINT "     "
1220 PRINT " RUN THE PROGRAM AGAIN AND SELECT EITHER A LARGER CORE OR SMALLER ";
1230 PRINT "WIRE "
1240 COLOR 7,0:GOTO 1340
1250 :REM'
1260 PRINT " Primary (hi-Z) winding to occupy entire core."
1270 PRINT " Secondary (lo-Z) winding to be wound over primary winding."
1280 PRINT UL$;
1290 PRINT " If the turns capacity of the core is considerably greater than";
1300 PRINT " the number of  "
1310 PRINT " primary turns, you may want to re-run the program and select a";
1320 PRINT " smaller core or"
1330 PRINT " a larger wire size."
1340 GOSUB 1490
1350 FRQ=0:ZP=0:ZS=0:L=0:AL=0:MAX=0
1360 GOTO 180
1370 :REM'
1380 :REM'.....diagram
1390 COLOR 0,7:J=32:LOCATE 3,J
1400 LOCATE ,J:PRINT "                "
1410 LOCATE ,J:PRINT "   │  lo-Z  │   "
1420 LOCATE ,J:PRINT "   └──∩∩∩∩──┘   "
1430 LOCATE ,J:PRINT "     ══════     "
1440 LOCATE ,J:PRINT "   ┌─∩∩∩∩∩∩─┐   "
1450 LOCATE ,J:PRINT "   │  hi-Z  │   "
1460 LOCATE ,J:PRINT "                "
1470 COLOR 7,0:RETURN
1480 :REM'
1490 :REM'PRT
1500 KEY OFF:GOSUB 1570:LOCATE 25,5:COLOR 0,2
1510 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1520 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1530 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1530 :ELSE GOSUB 1570
1540 IF Z$="3"THEN RETURN
1550 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1560 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1500
1570 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
