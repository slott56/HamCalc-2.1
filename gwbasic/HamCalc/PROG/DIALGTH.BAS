10 :REM'DIALGTH - Yagi Element Dia. vs Length - 02 FEB 2002 rev. 23 JUN 02
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PI=4*ATN(1)  :REM'3.141593
50 LF=1/LOG(10) :REM'factor to convert LOGn to base 10
60 SL=299.7925109863281!  :REM'speed of light
70 UL$=STRING$(80,205)
80 :REM'
90 :REM'.....title page
100 CLS:XD=0:XL=0:ND=0:NL=0:EL=0:X=0
110 COLOR 15,2,0
120 PRINT " YAGI ELEMENT DIAMETER vs LENGTH"TAB(57)"By George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 :REM'.....title page
170 PRINT " This program calculates new lengths of beam elements if the diam";
180 PRINT "eters of the  "
190 PRINT " elements are changed."
200 PRINT
210 PRINT " Equations by Günter Hoch, DL6WU, taken from page 7-28 of the RSG";
220 PRINT "B publication "
230 PRINT " The VHF/UHF DX Book, edited by Ian White, G3SEK. These equations";
240 PRINT " apply to     "
250 PRINT " linear elements that are reasonably close to 1/2 wavelength, suc";
260 PRINT "h as the      "
270 PRINT " driven and parasitic elements on a long-boom Yagi.              "
280 PRINT UL$;
290 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN COLOR ,,0:CLS:CHAIN EX$
320 IF Z$="1"THEN CLS:GOTO 350
330 GOTO 300
340 :REM'
350 :REM'.....start
360 CLS:COLOR ,,0
370 INPUT " ENTER: Frequency in MHz..........";F
380 IF F=0 THEN 370
390 CLS:PRINT TAB(15)USING "#####.### MHz YAGI ELEMENT DIAMETERS vs. LENGTH";F
400 PRINT UL$;
410 W=SL/F*10^3    :REM'wavelength in mm.
420 PRINT " Do you want measurements in (i)nches or (c)entimetres?   (i/c)"
430 Z$=INKEY$:IF Z$=""THEN 430
440 IF Z$="i"THEN UM$="in.":UM=2.5399999618530273!:T=29:T$="inches ":GOTO 470
450 IF Z$="c"THEN UM$="cm.":UM=1:T=26:T$="centimetres ":GOTO 470
460 GOTO 430
470 LOCATE 2,T:PRINT " dimensions in ";T$:LOCATE 3
480 PRINT " Are all the initial elements the same diameter?   (y/n)       "
490 Z$=INKEY$:IF Z$=""THEN 490
500 IF Z$="y"THEN IFLAG=1 :ELSE IFLAG=0
510 GOTO 530
520 GOTO 490
530 PRINT " Will all the new element diameters be the same?   (y/n)"
540 Z$=INKEY$:IF Z$=""THEN 540
550 IF Z$="y"THEN NFLAG=1 :ELSE NFLAG=0
560 GOTO 580
570 GOTO 540
580 VIEW PRINT 3 TO 24:CLS:VIEW PRINT
590 LN=3:EL=0
600 :REM'
610 EL=EL+1:LOCATE LN
620 IF XD<>0 AND IFLAG=1 THEN 670
630 PRINT USING "(##)";EL;
640 PRINT " ENTER: Initial diameter (";UM$;") or 0 (zero) to quit....";:INPUT XD
650 IF XD=0 THEN VIEW PRINT CSRLIN-1 TO 24:CLS:VIEW PRINT:GOTO 940
660 XD=XD*UM   :REM'diameter
670 PRINT USING "(##)";EL;
680 PRINT " ENTER: Initial length (";UM$;") or 0 (zero) to quit......";:INPUT XL
690 IF XL=0 THEN VIEW PRINT CSRLIN-1 TO 24:CLS:VIEW PRINT:GOTO 940
700 XL=XL*UM   :REM'length
710   XD=XD*10:XL=XL*10  :REM'convert cm. to mm.
720 X=(430.29998779296875!*LOG(2*W/XD)*LF-320)*((2*XL/W)-1)+40  :REM'reactance
730   XD=XD/10:XL=XL/10  :REM'convert mm. to cm.
740 IF ND<>0 AND NFLAG=1 THEN 800
750 PRINT USING "(##)";EL;
760 PRINT " ENTER: New Diameter (";UM$;") or 0 (zero) to quit........";:INPUT ND
770 IF ND=0 THEN VIEW PRINT CSRLIN-1 TO 24:CLS:VIEW PRINT:GOTO 940
780 ND=ND*UM
790 :REM'
800   ND=ND*10           :REM'convert cm.to mm.
810 Q=430.29998779296875!*LOG(2*W/ND)*LF-320
820 NL=W*((X-40)/Q+1)/2
830   ND=ND/10:NL=NL/10  :REM'convert mm. to cm.
840 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
850 GOSUB 880
860 LN=CSRLIN:GOTO 610
870 :REM'
880 :REM'.....display
890 T$="(##) ##.###φ x ###.### element becomes ##.###φ x ###.###"
900 T$=T$+"       ref. X= ####.# Ω"
910 PRINT USING T$;EL,XD/UM,XL/UM,ND/UM,NL/UM,X
920 RETURN
930 :REM'
940 :REM'.....end
950 GOSUB 970:GOTO 90
960 :REM'
970 :REM'.....PRT
980 KEY OFF:GOSUB 1050:LOCATE 25,5:COLOR 0,2
990 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1000 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1010 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1010 :ELSE GOSUB 1050
1020 IF Z$="3"THEN RETURN
1030 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1040 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 980
1050 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
