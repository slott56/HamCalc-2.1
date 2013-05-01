10 :REM'SEPAQ - 25 SEP 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 COLOR 15,2
80 PRINT " SERIES/PARALLEL EQUIVALENTS"TAB(61)"by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....opening page
110 PRINT
120 PRINT "This program documents the formulas relating Rs,Xs,Rp,Xp & Q to any of the"
130 PRINT "other two."
140 PRINT STRING$(79,196)
150 PRINT "It is well known that at any single frequency, a series Rs-Xs is equivalent to"
160 PRINT "a parallel Rp-Xp, and formulas relating the two are common. What is not so well"
170 PRINT "known is that given any two of the five parameters, Rs,Xs,Rp,Xp,and Q, the"
180 PRINT "others may be found. Here, we provides a handy way of calculating the values"
190 PRINT "and provide the formulas relating each element to all other element pairs." :PRINT STRING$(79,196)
200 GOSUB 210:GOTO 310
210 :REM',,,,,diagram
220 PRINT "    Series/Parallel Equivalents"
230 PRINT "    ═══════════════════════════"
240 PRINT "     ───┐       ──┬──┐    We can find the value of all the elements,"
250 PRINT "        Rs        │  │    given the values of any two. To avoid"
260 PRINT "     Qs │      Qp Rp Xp   ambiguity, for some inputs, we must also"
270 PRINT "        Xs        │  │    decide if we want the Q to be greater or"
280 PRINT "     ───┘      ───┴──┘    less than 1."
290 PRINT
300 RETURN
310 PRINT "Press <1> to find a value,<2> to see the formulas, or <0> to exit."
320 A$=INKEY$ :IF A$="" THEN 320
330 IF A$="0"THEN RUN GO$
340 IF A$="1"THEN 360
350 IF A$="2"THEN CLS:GOTO 890
360 CLS:GOSUB 210:PRINT
370 INPUT "Enter value of Rs or just <Enter> ",RS
380 GOSUB 1450
390 INPUT "Enter value of Xs or just <Enter> ",XS
400 GOSUB 1450
410 IF RS*XS THEN 700
420 INPUT "Enter value of Rp or just <Enter> ",RP
430 GOSUB 1450
440 IF RP*RS THEN 720 :REM'calc values
450 IF RP*XS THEN 640 :REM'check for q<1
460 INPUT "Enter value of Xp or just <Enter> ",XP
470 GOSUB 1450
480 IF XP*RS THEN 580 :REM'check for q<1
490 IF XP*XS THEN 740 :REM'calc values
500 IF XP*RP THEN 710 :REM' calc values
510 IF RS+XS+RP+XP=0 THEN GOSUB 1360 :PRINT "You must enter at least one value " :GOTO 370
520 INPUT "Enter value of Q ",Q :IF Q=0 THEN GOSUB 1360 :GOTO 360
530 GOSUB 1450
540 IF Q*RS THEN 760
550 IF Q*XS THEN 770
560 IF Q*RP THEN 780
570 IF Q*XP THEN 790
580 IF XP<2*RS THEN PRINT "Xp must be"2*RS"or greater." :GOTO 460
590 INPUT "Do you want values for a Q greater than 1? (y/n) ",C$
600 GOSUB 1450
610 IF C$<>"n" THEN 630
620 XS=(XP-SQR(XP^2-4*RS^2))/2 :Q=XS/RS :RP=Q*XP :GOTO 800 :REM'for q<1
630 XS=(XP+SQR(XP^2-4*RS^2))/2 :Q=XS/RS :RP=Q*XP :GOTO 800 :REM'for q<1
640 IF RP<2*XS THEN PRINT "Rp must be"2*XS"or greater." :GOTO 420
650 INPUT "Do you want values for a Q greater than 1? (y/n) ",C$
660 GOSUB 1450
670 IF C$<>"n" THEN 690
680 RS=(RP+SQR(RP^2-4*XS^2))/2 :Q=XS/RS :XP=RP/Q :GOTO 800 :REM'for q<1
690 RS=(RP-SQR(RP^2-4*XS^2))/2 :Q=XS/RS :XP=RP/Q :GOTO 800 :REM'for q>1
700 Q=XS/RS :RP=(RS^2+XS^2)/RS :XP=RP/Q :GOTO 800
710 Q=RP/XP :RS=RP/(1+Q^2) :XS=RS*Q :GOTO 800
720 IF RP=<RS THEN PRINT "Rp must be greater than "RS :GOTO 420
730 XS=SQR(RS*(RP-RS)) :Q=XS/RS :XP=RP/Q :GOTO 800
740 IF XP=<XS THEN PRINT "Xp must be greater than "XS :GOTO 460
750 RS=SQR(XS*(XP-XS)) :Q=XS/RS :RP=Q*XP :GOTO 800
760 XS=Q*RS :RP=RS*(1+Q^2) :XP=RP/Q :GOTO 800
770 RS=XS/Q :RP=RS*(1+Q^2) :XP=RP/Q :GOTO 800
780 XP=RP/Q :RS=RP/(Q^2+1) :XS=RS*Q :GOTO 800
790 RP=Q*XP :RS=RP/(1+Q^2) :XS=RS*Q :GOTO 800
800 PRINT USING "              RS=####.### ";RS
810 PRINT USING "              XS=####.### ";XS
820 PRINT USING "              RP=####.### ";RP
830 PRINT USING "              XP=####.### ";XP
840 PRINT USING "               Q=###.### ";Q
850 GOSUB 1460:CLS:GOTO 60
860 PRINT "Press any key "
870 :REM'VIEW PRINT 8 TO 24:CLS:VIEW PRINT:LOCATE 9
880 :REM'A$=INKEY$ :IF A$="" THEN 700 ELSE 10
890 PRINT "------------------Formulas for Rs---------------------"
900 PRINT "RS=RP*XP^2/(RP^2+XP^2)"
910 PRINT "RS=RP/(Q^2+1)"
920 PRINT "RS=(RP+SQR(RP^2-4*XS^2))/2 for Q<1"
930 PRINT "RS=(RP-SQR(RP^2-4*XS^2))/2 for Q>1"
940 PRINT "RS=SQR(XS*(XP-XS))"
950 PRINT "RS=Q*XP/(Q^2+1)"
960 PRINT "RS=XS/Q"
970 PRINT :PRINT "------------------Formulas for Xs---------------------"
980 PRINT "XS=XP*Q^2/(1+Q^2)"
990 PRINT "XS=RP*Q/(Q^2+1)"
1000 PRINT "XS=SQR(RS*(RP-RS))"
1010 PRINT "XS=(XP+SQR(XP^2-4*RS^2))/2 for Q>1"
1020 PRINT "XS=(XP-SQR(XP^2-4*RS^2))/2 for Q<1"
1030 PRINT "XS=XP*Q^2/(1+Q^2)"
1040 PRINT "XS=RS*Q"
1050 PRINT :GOSUB 1460 :REM'PRINT "Press any key
1060 :REM'A$=INKEY$ :IF A$="" THEN 880 ELSE CLS
1070 CLS :PRINT "-----------------------Formulas for Rp----------------------"
1080 PRINT "RP=(XP^2+SQR(XP^4-4*RS^2*XP^2))/2/RS for Q>1"
1090 PRINT "RP=(XP^2-SQR(XP^4-4*RS^2*XP^2))/2/RS for Q<1"
1100 PRINT "RP=RS*(1+Q^2)"
1110 PRINT "RP=(RS^2+XS^2)/RS"
1120 PRINT "RP=XP*SQR(XS/(XP-XS))"
1130 PRINT "RP=Q*XP"
1140 PRINT "RP=XS*(1+Q^2)/Q"
1150 PRINT :PRINT "----------------------Formulas for Xp------------------------"
1160 PRINT "XP=(RP^2+SQR(RP^4-4*XS^2*RP^2))/2/XS for Q<1"
1170 PRINT "XP=(RP^2-SQR(RP^4-4*XS^2*RP^2))/2/XS for Q>1"
1180 PRINT "XP=RP/Q"
1190 PRINT "XP=RP*SQR(RS/(RP-RS))"
1200 PRINT "XP=(RS^2+XS^2)/XS"
1210 PRINT "XP=XS*(1+Q^2)/Q^2"
1220 PRINT "XP=RS*(1+Q^2)/Q"
1230 PRINT :GOSUB 1460 :REM'PRINT "To see previous screen, press `b' else press any other key."
1240 :REM'A$=INKEY$ :IF A$="" THEN 1060 ELSE IF A$="b" THEN CLS :GOTO 710
1250 CLS:PRINT "------------------------Formulas for Q----------------------"
1260 PRINT "Q=XS/RS"
1270 PRINT "Q=SQR(RP/RS-1)"
1280 PRINT "Q=(RP+SQR(RP^2-4*XS^2))/2/XS for Q>1"
1290 PRINT "Q=(RP-SQR(RP^2-4*XS^2))/2/XS for Q<1"
1300 PRINT "Q=SQR(XS/(XP-XS))"
1310 PRINT "Q=RP/XP"
1320 PRINT "Q=(XP+SQR(XP^2-4*RS^2))/2/RS for Q>1"
1330 PRINT :GOSUB 1460 :GOTO 10:REM'PRINT "To see previous screen, press `b' else press any other key."
1340 :REM'A$=INKEY$ :IF A$="" THEN 1160 ELSE IF A$="b" THEN CLS :GOTO 890 ELSE 10
1350 :REM'----------------subroutine to clear part of the screen------------
1360 LOCATE 10,1 :PRINT "                                  "
1370 PRINT "                                          "
1380 PRINT "                                          "
1390 PRINT "                                          "
1400 PRINT "                                          "
1410 PRINT "                                          "
1420 PRINT "                                          "
1430 PRINT "                                           "
1440 LOCATE 10,1 :RETURN
1450 LOCATE CSRLIN-1:PRINT STRING$(79,32):RETURN
1460 :REM'.....PRT
1470 KEY OFF:GOSUB 1540:LOCATE 25,5:COLOR 0,2
1480 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1490 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1500 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1500 :ELSE GOSUB 1540
1510 IF Z$="3"THEN RETURN
1520 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1530 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1470
1540 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
