10 :REM'PBA - Pseudo-Brewster Angle - 15 DEC 2001 rev. 01 MAR 2002
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PI=4*ATN(1)
50 :REM'
60 :REM'.....title page
70 CLS
80 COLOR 15,2,1
90 PRINT " PSEUDO-BREWSTER ANGLE (Vertical Antennas)";
100 PRINT TAB(57)"by George Murphy VE3ERP ";
110 COLOR 1,0:PRINT STRING$(80,223);
120 COLOR 7,0
130 PRINT " The Pseudo-Brewster Angle (PBA) is the angle at which the reflec";
140 PRINT "ted RF wave is"
150 PRINT " 90° out of phase with respect to the direct wave. Below this ang";
160 PRINT "le the        "
170 PRINT " reflected wave is between 90° and 180° out of phase with the dir";
180 PRINT "ect wave so   "
190 PRINT " some degree of cancellation takes place. The largest amount of c";
200 PRINT "ancellation   "
210 PRINT " occurs near 0°, and less cancellation occurs as the PBA is appro";
220 PRINT "ached from    "
230 PRINT " below."
240 PRINT
250 PRINT " PBA is often referred to as the Takeoff Angle - the angle betwee";
260 PRINT "n the radiated"
270 PRINT " waves and horizontal ground plane.                              "
280 PRINT:LOCATE ,14
290 PRINT "(ref. The ARRL ANTENNA BOOK, 17th edition, page 3-4)"
300 PRINT
310 COLOR 0,7:LOCATE ,23:PRINT " Press 1 to continue or 0 to EXIT ":COLOR 7,0
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="0"THEN CLS:CHAIN EX$
340 IF Z$="1"THEN 370
350 GOTO 320
360 :REM'
370 COLOR 7,0,0:CLS:GOSUB 840
380 K=0:G=0:X=0:Z=0
390 PRINT " The dielectric constant k of the earth's surface below the anten";
400 PRINT "na varies from"
410 PRINT " 1 for air to 81 for salt water. Typical values are:"
420 PRINT
430 PRINT " Air....................................................... 1"
440 PRINT " Cities, heavy industrial areas, high buildings............ 3"
450 PRINT " Cities, industrial area................................... 5"
460 PRINT " Sandy, dry, flat, and coastal areas...................... 10"
470 PRINT " Flat, marshy, or densely wooded country.................. 12"
480 PRINT " Rocky soil, steep hills, or mountainous country....... 12-14"
490 PRINT " Pastoral, medium hills and forestation................... 13"
500 PRINT " Pastoral, low hills, rich soil.........................14-20"
510 PRINT " Fresh water.............................................. 80"
520 PRINT " Salt water............................................... 81"
530 PRINT
540 INPUT " ENTER: Dielectric constant k";K
550 GOSUB 840
560 PRINT " The conductivity of the earth's surface is measured in S/m (siem";
570 PRINT "ens per metre)."
580 PRINT " Some typical values are:"
590 PRINT
600 PRINT " Fresh water, cities................................... 0.001"
610 PRINT " Rocky soil, steep hills, or mountainous country....... 0.002"
620 PRINT " Sandy, dry, flat, and coastal areas....................0.002"
630 PRINT " Pastoral, medium hills and forestation.................0.0055"
640 PRINT " Flat, marshy, or densely wooded country................0.0075"
650 PRINT " Pastoral, low hills, rich soil..................... 0.01-0.03"
660 PRINT " Salt water............................................ 5.0"
670 PRINT
680 INPUT " ENTER: Conductivity ";G
690 GOSUB 840
700 INPUT " ENTER: Frequency of operation (MHz)";F
710 GOSUB 840
720 X=1.7999999523162842!*10^4*G/F
730 XK=(X^2+K^2)^2
740 F1=XK*(K-1)^2
750 F2=XK-1
760 F3=SQR(XK*(K-1)^2+X^2*F2)
770 F4=(K-1+F3)/F2
780 Z=SQR(F4)
790 PBA=ATN(Z/SQR(-Z*Z+1))    :REM'arcsin
800 DEG=PBA*180/PI    :REM'angle in degrees
810 GOSUB 840
820 GOTO 960
830 :REM'
840 :REM'.....display
850 CLS
860 PRINT TAB(20)"PSEUDO-BREWSTER ANGLE (Vertical Antenna)"
870 PRINT STRING$(80,205);
880 IF K   THEN PRINT USING " Dielectric constant....... k= ###.###";K
890 IF G   THEN PRINT USING " Conductivity.............. G= ###.### S/m";G
900 IF F   THEN PRINT USING " Frequency of operation.... ƒ= ###.### MHz";F
910 IF DEG THEN PRINT USING " Pseudo-Brewster Angle... PBA= ###.###°";DEG
920 PRINT STRING$(80,205);
930 PRINT
940 RETURN
950 :REM'
960 :REM'.....end
970 GOSUB 1000
980 GOTO 60
990 :REM'
1000 :REM'.....PRT
1010 KEY OFF:GOSUB 1080:LOCATE 25,5:COLOR 0,2
1020 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1030 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1040 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1040 :ELSE GOSUB 1080
1050 IF Z$="3"THEN RETURN
1060 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1070 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1010
1080 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
