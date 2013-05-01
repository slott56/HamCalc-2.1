10 :REM'SERPAR-q 23 SEP 2010
20 KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 CLS
80 COLOR 15,2
90 PRINT " SERIES/PARALLEL/Q EQUIVALENTS"TAB(61)"by R.J.Dehoney IEEE ";
100 COLOR 7,0
110 :REM'.....opening page
120 PRINT
130 PRINT "This program documents the formulas relating Rs,Xs,Rp,Xp & Q to any of the"
140 PRINT "other two."
150 PRINT STRING$(79,196)
160 PRINT "It is well known that at any single frequency, a series Rs-Xs is equivalent to"
170 PRINT "a parallel Rp-Xp, and formulas relating the two are common. What is not so well"
180 PRINT "known is that given any two of the five parameters, Rs,Xs,Rp,Xp,and Q, the"
190 PRINT "others may be found. Here, we provides a handy way of calculating the values"
200 PRINT "and provide the formulas relating each element to all other element pairs." :PRINT STRING$(79,196)
210 GOSUB 220:GOTO 320
220 :REM',,,,,diagram
230 PRINT "    Series/Parallel Equivalents"
240 PRINT "    ═══════════════════════════"
250 PRINT "     ───┐       ──┬──┐    We can find the value of all the elements,"
260 PRINT "        Rs        │  │    given the values of any two. To avoid"
270 PRINT "     Qs │      Qp Rp Xp   ambiguity, for some inputs, we must also"
280 PRINT "        Xs        │  │    decide if we want the Q to be greater or"
290 PRINT "     ───┘      ───┴──┘    less than 1."
300 PRINT
310 RETURN
320 PRINT "Press <1> to find a value,<2> to see the formulae, or <0> to exit."
330 A$=INKEY$ :IF A$="" THEN 330
340 IF A$="0"THEN RUN GO$
350 IF A$="1"THEN 370
360 IF A$="2"THEN CLS:GOTO 1490
370 CLS:GOSUB 220:PRINT :INPUT "Enter value of Rs or just <Enter> ",RS
380 GOSUB 1370
390 INPUT "Enter value of Xs or just <Enter> ",XS
400 GOSUB 1370
410 IF RS*XS THEN 690
420 INPUT "Enter value of Rp or just <Enter> ",RP
430 GOSUB 1370
440 IF RP*RS THEN 710 :REM'calc values
450 IF RP*XS THEN 630 :REM'check for q<1
460 INPUT "Enter value of Xp or just <Enter> ",XP
470 GOSUB 1370
480 IF XP*RS THEN 580 :REM'check for q<1
490 IF XP*XS THEN 730 :REM'calc values
500 IF XP*RP THEN 700 :REM' calc values
510 IF RS+XS+RP+XP=0 THEN GOSUB 1280 :PRINT "You must enter at least one value " :GOTO 370
520 INPUT "Enter value of Q ",Q :IF Q=0 THEN GOSUB 1280 :GOTO 370
530 GOSUB 1370
540 IF Q*RS THEN 750
550 IF Q*XS THEN 760
560 IF Q*RP THEN 770
570 IF Q*XP THEN 780
580 IF XP<2*RS THEN PRINT "Xp must be"2*RS"or greater." :GOTO 460
590 INPUT "Do you want values for a Q greater than 1? (y/n) ",C$
600 IF C$<>"n" THEN 620
610 XS=(XP-SQR(XP^2-4*RS^2))/2 :Q=XS/RS :RP=Q*XP :GOTO 790 :REM'for q<1
620 XS=(XP+SQR(XP^2-4*RS^2))/2 :Q=XS/RS :RP=Q*XP :GOTO 790 :REM'for q<1
630 IF RP<2*XS THEN PRINT "Rp must be"2*XS"or greater." :GOTO 420
640 INPUT "Do you want values for a Q greater than 1? (y/n) ",C$
650 GOSUB 1370
660 IF C$<>"n" THEN 680
670 RS=(RP+SQR(RP^2-4*XS^2))/2 :Q=XS/RS :XP=RP/Q :GOTO 790 :REM'for q<1
680 RS=(RP-SQR(RP^2-4*XS^2))/2 :Q=XS/RS :XP=RP/Q :GOTO 790 :REM'for q>1
690 Q=XS/RS :RP=(RS^2+XS^2)/RS :XP=RP/Q :GOTO 790
700 Q=RP/XP :RS=RP/(1+Q^2) :XS=RS*Q :GOTO 790
710 IF RP=<RS THEN PRINT "Rp must be greater than "RS :GOTO 420
720 XS=SQR(RS*(RP-RS)) :Q=XS/RS :XP=RP/Q :GOTO 790
730 IF XP=<XS THEN PRINT "Xp must be greater than "XS :GOTO 460
740 RS=SQR(XS*(XP-XS)) :Q=XS/RS :RP=Q*XP :GOTO 790
750 XS=Q*RS :RP=RS*(1+Q^2) :XP=RP/Q :GOTO 790
760 RS=XS/Q :RP=RS*(1+Q^2) :XP=RP/Q :GOTO 790
770 XP=RP/Q :RS=RP/(Q^2+1) :XS=RS*Q :GOTO 790
780 RP=Q*XP :RS=RP/(1+Q^2) :XS=RS*Q :GOTO 790
790 PRINT USING "              RS=###.### ";RS
800 PRINT USING "              XS=###.### ";XS
810 PRINT USING "              RP=###.### ";RP
820 PRINT USING "              XP=###.### ";XP
830 PRINT USING "               Q=###.### ";Q
840 PRINT "Press any key "
850 A$=INKEY$:IF A$=" "THEN 850
860 LOCATE CSRLIN-1:PRINT STRING$(79,32)
870 GOSUB 1400:GOTO 60
880 :REM'.....formulas
890 PRINT "------------------Formulae for Rs---------------------"
900 PRINT "RS=RP*XP^2/(RP^2+XP^2)"
910 PRINT "RS=RP/(Q^2+1)"
920 PRINT "RS=(RP+SQR(RP^2-4*XS^2))/2 for Q<1"
930 PRINT "RS=(RP-SQR(RP^2-4*XS^2))/2 for Q>1"
940 PRINT "RS=SQR(XS*(XP-XS))"
950 PRINT "RS=Q*XP/(Q^2+1)"
960 PRINT "RS=XS/Q"
970 PRINT :PRINT "------------------Formulae for Xs---------------------"
980 PRINT "XS=XP*Q^2/(1+Q^2)"
990 PRINT "XS=RP*Q/(Q^2+1)"
1000 PRINT "XS=SQR(RS*(RP-RS))"
1010 PRINT "XS=(XP+SQR(XP^2-4*RS^2))/2 for Q>1"
1020 PRINT "XS=(XP-SQR(XP^2-4*RS^2))/2 for Q<1"
1030 PRINT "XS=XP*Q^2/(1+Q^2)"
1040 PRINT "XS=RS*Q"
1050 PRINT :PRINT "Press any key"
1060 LOCATE CSRLIN-1:PRINT STRING$(79,32)
1070 A$=INKEY$ :IF A$="" THEN 950 :ELSE CLS
1080 CLS :PRINT "-----------------------Formulae for Rp----------------------"
1090 PRINT "RP=(XP^2+SQR(XP^4-4*RS^2*XP^2))/2/RS for Q>1"
1100 PRINT "RP=(XP^2-SQR(XP^4-4*RS^2*XP^2))/2/RS for Q<1"
1110 PRINT "RP=RS*(1+Q^2)"
1120 PRINT "RP=(RS^2+XS^2)/RS"
1130 PRINT "RP=XP*SQR(XS/(XP-XS))"
1140 PRINT "RP=Q*XP"
1150 PRINT "RP=XS*(1+Q^2)/Q"
1160 PRINT :PRINT "----------------------Formulae for Xp------------------------"
1170 PRINT "XP=(RP^2+SQR(RP^4-4*XS^2*RP^2))/2/XS for Q<1"
1180 PRINT "XP=(RP^2-SQR(RP^4-4*XS^2*RP^2))/2/XS for Q>1"
1190 PRINT "XP=RP/Q"
1200 PRINT "XP=RP*SQR(RS/(RP-RS))"
1210 PRINT "XP=(RS^2+XS^2)/XS"
1220 PRINT "XP=XS*(1+Q^2)/Q^2"
1230 PRINT "XP=RS*(1+Q^2)/Q"
1240 PRINT :PRINT "To see previous screen, press `b' else press any other key."
1250 A$=INKEY$ :IF A$="" THEN 1250 :ELSE IF A$="b" THEN CLS :GOTO 890
1260 CLS:PRINT "------------------------Formulae for Q----------------------"
1270 PRINT "Q=XS/RS"
1280 PRINT "Q=SQR(RP/RS-1)"
1290 PRINT "Q=(RP+SQR(RP^2-4*XS^2))/2/XS for Q>1"
1300 PRINT "Q=(RP-SQR(RP^2-4*XS^2))/2/XS for Q<1"
1310 PRINT "Q=SQR(XS/(XP-XS))"
1320 PRINT "Q=RP/XP"
1330 PRINT "Q=(XP+SQR(XP^2-4*RS^2))/2/RS for Q>1"
1340 PRINT :PRINT "To see previous screen, press `b' else press any other key."
1350 A$=INKEY$:IF A$=" "THEN 1350
1360 IF A$="b"THEN  CLS:GOTO 890 :ELSE GOSUB 1400:GOTO 60
1370 :REM'.....erase input line
1380 LOCATE CSRLIN-1:PRINT STRING$(79,32):RETURN
1390 :REM'----------------subroutine to clear part of the screen------------
1400 :REM'.....PRT
1410 KEY OFF:GOSUB 1480:LOCATE 25,5:COLOR 0,2
1420 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1430 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1440 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1440 :ELSE GOSUB 1480
1450 IF Z$="3"THEN RETURN
1460 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1470 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1410
1480 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
1490 :REM'......display formulae
1500 PRINT :PRINT
1510 COLOR 0,7
1520 PRINT " To continue when 'OK'appears at the end of a display, press the F2 key "
1530 COLOR 7,0:PRINT :PRINT
1540 PRINT " For Rs and Xs formulae press <1>"
1550 PRINT " For Rp and Xp formulae press <2>"
1560 PRINT " For Q formulae press <3>"
1570 A$=INKEY$:IF A$=""THEN 1570
1580 IF A$="1"THEN CLS:LIST 890-1040
1590 IF A$="2"THEN CLS:LIST 1080-1230
1600 IF A$="3"THEN CLS:LIST 1260-1330
1610 END
