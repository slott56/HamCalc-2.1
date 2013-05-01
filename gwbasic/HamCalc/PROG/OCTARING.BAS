10 :REM'OCTARING - Octagonal Loop Antenna - 12 DEC 2005
20 CLS
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 UL$=STRING$(80,205)
80 U1$="#####.###"
90 :REM'
100 :REM'.....start
110 CLS
120 COLOR 15,2,1
130 PRINT " OCTARING Miniature Octagonal Loop Antenna";
140 PRINT TAB(57)"by George Murphy VE3ERP ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0
170 PRINT " The OctaRing is a version of the W2AHW Octaloop antenna. The Octa";
180 PRINT "loop program "
190 PRINT " contains some desigm data supplemental to that contained in the O";
200 PRINT "ctaRing      "
210 PRINT " program."
220 PRINT  UL$;
230 PRINT " Press 1 to run OctaRing"
240 PRINT " Press 2 to run Octaloop (Contains more data also applicable to";
250 PRINT " OctaRing)"
260 PRINT " Press 3 for design data applying to ALL small transmitting loops"
270 PRINT " Press 4 for coaxial cable properties"
280 PRINT
290 PRINT " Press 0 to EXIT"
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN COLOR 7,0,0:CLS:RUN EX$
320 IF Z$="1"THEN LN=2:GOSUB 380:GOSUB 1160:GOSUB 1020:GOTO  420
330 IF Z$="2"THEN CLS:CHAIN "octaloop"
340 IF Z$="3"THEN CLS:CHAIN "loopxmit"
350 IF Z$="4"THEN CHAIN"coaxchar"
360 GOTO 300
370 :REM'
380 :REM'.....erase previous line
390 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
400 RETURN
410 :REM'
420 :REM'.....enter data
430 LN=CSRLIN:PRINT " Want dimensions in metric or USA units?   (m/u)"
440 Z$=INKEY$:IF Z$=""THEN 440
450 J$=Z$:GOSUB 380:GOTO 470
460 GOTO 440
470 INPUT " ENTER: Frequency (MHz)";F
480 LN=12:GOSUB 380
490 PRINT USING " Frequency................  ###.### MHz.";F
500 COLOR 0,7
510 PRINT " Note: Efficiency increases with the diameter of the cable. "
520 PRINT " Do not use a cable slimmer than RG-8.                      "
530 PRINT " Measure the braid O.D. of the cable you want to use.       "
540 COLOR 7,0
550 IF J$="m"THEN J$="(cm.)":ELSE J$="(in.)"
560 PRINT " ENTER: Outside diameter of braid ";J$;:INPUT D
570 IF J$="(cm.)"THEN D=D*2.5399999618530273!
580 LN=CSRLIN-4:GOSUB 380
590 DCM=D*2.5399999618530273! :REM'diameter in centimetres
600 PRINT USING " Diameter of braid........  ###.## cm.=  ##.### in.";DCM,D
610 DIA=D
620 COLOR 0,7
630 PRINT " If possible also measure the actual capacitance per foot of the ";
640 PRINT " cable, otherwise look up the value in published tables.         "
650 COLOR 7,0
660 INPUT " ENTER: Capacity per foot in pF";CPF
670 LN=CSRLIN-3:GOSUB 380
680 PRINT USING " Capacity per foot........  ###.### pF";CPF
690 CPI=CPF/12 :REM'capacity per inch
700 B=0 :REM'length in inches
710 :REM'
720 :REM'....iteration
730 B=B+0.009999999776482582!         :REM'cable length in inches
740 CCAB=CPI/12*B*8  :REM'capacity of cable
750 CLOOP=CCAB*8     :REM'capacity of loop
760 X=10^6/(2*PI*F*CLOOP) :REM'reactance ofloop
770 BCM=B*2.5399999618530273! :REM'length of side in cm.
780 E1=0.01600000075995922!*BCM
790 E2=2.61299991607666!*BCM/2^DCM
800 E3=0.07152999937534332!*2^DCM/BCM
810 LUH=E1*(LOG(E2)+0.7514299750328064!+E3) :REM'inductance of loop
820 CRES=25330.2890625!/F^2/LUH :REM'capacity required to resonate
830 XL=10^6/(2*PI*F*CRES) :REM'reactance
840 IF SGN(X-XL)=-1 THEN 860
850 GOTO 730
860 P=B*8  :REM'perimeter of loop
870 A=B/TAN(30*PI/180) : C=B/SIN(30*PI/180)
880 PRINT USING " Perimeter of loop........ ####.## cm.= ###.### in.";P*2.5399999618530273!,P
890 PRINT USING " Each side (dim. B)....... ####.## cm.= ###.### in.";B*2.5399999618530273!,B
900 PRINT USING " Side to side (dim. A).... ####.## cm.= ###.### in.";A*2.5399999618530273!,A
910 PRINT USING " Corner to corner......... ####.## cm.= ###.### in.";C*2.5399999618530273!,C
920 PRINT USING " Capacity of loop......... ####.### pF";CLOOP
930 PRINT USING " Inductance of loop....... ####.### Ω";LUH
940 PRINT USING " Reactance of loop........ ####.### µH";XL;
950 COLOR 0,7
960 LOCATE 12,58:PRINT " Thread the cable  "
970 LOCATE 13,58:PRINT " through the four  "
980 LOCATE 14,58:PRINT " tee heads of the  "
990 LOCATE 15,58:PRINT " PVC pipe frame.   "
1000 COLOR 7,0:GOSUB 1430:GOTO 100
1010 :REM'
1020 :REM'.....prologue
1030 LOCATE 12
1040 PRINT " The OctaRing is a variation of Harold Kane's W2AHW miniature Oct";
1050 PRINT "aloop antenna "
1060 PRINT " which consists of a loop of coaxial cable whose braid is the rad";
1070 PRINT "iating element"
1080 PRINT " and the center conductor is left unconnected. It has a non-radia";
1090 PRINT "ting cable    "
1100 PRINT " `capacitor' tuning stub hanging from the loop at the gap (2). Th";
1110 PRINT "e OctaRing is "
1120 PRINT " the same but without the tuning stub."
1130 PRINT UL$;
1140 RETURN
1150 :REM'
1160 :REM'.....diagram
1170 T=5
1180 LOCATE 3
1190 COLOR 0,7
1200 LOCATE ,T:PRINT "    ╔════(2)════╗                                  "
1210 LOCATE ,T:PRINT "    ║           ║    1» Coaxial cable loop         "
1220 LOCATE ,T:PRINT "  1»║           ║   (2)= 1 inch gap                "
1230 LOCATE ,T:PRINT "    ║<─── A ───>║    C = distance between sides    "
1240 LOCATE ,T:PRINT "    ║  │<-B->│  ║    B = 1/8 of loop perimeter     "
1250 LOCATE ,T:PRINT "    ╚══╤═════╤══╝                                  "
1260 LOCATE ,T:PRINT "       └─┐ ┌─┘«─Delta match to 50 Ω coax feedline  "
1270 COLOR 0,3
1280 LOCATE ,T:PRINT "(4-sided loop shown, but octagonal loop described.)"
1290 COLOR 0,7
1300 LOCATE 3:T=58
1310 LOCATE ,T:PRINT "      ═══╦═══      "
1320 LOCATE ,T:PRINT "         ║         "
1330 LOCATE ,T:PRINT " ║       ║       ║ "
1340 LOCATE ,T:PRINT " ╠═══════╬═══════╣ "
1350 LOCATE ,T:PRINT " ║       ║       ║ "
1360 LOCATE ,T:PRINT "         ║         "
1370 LOCATE ,T:PRINT "      ═══╬═══      "
1380 COLOR 0,3
1390 LOCATE ,T:PRINT "  PVC Pipe frame   "
1400 COLOR 7,0
1410 RETURN
1420 :REM'
1430 :REM'.....PRT
1440 KEY OFF:GOSUB 1510:LOCATE 25,5:COLOR 0,2
1450 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1460 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1470 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1470 :ELSE GOSUB 1510
1480 IF Z$="3"THEN RETURN
1490 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1500 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1440
1510 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
