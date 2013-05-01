10 :REM'VERTPATT - Radiation Plots of Phased Verticals - 12 FEB 2000 rev. 07 APR 00
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 A$=""
50 :REM'
60 :REM'.....title page
70 COLOR 15,2,1
80 PRINT " RADIATION PLOTS, Phased Verticals";
90 PRINT TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 7,0
120 IF A$="a"THEN 440
130 PRINT " Adapted from ";CHR$(34);"VPATTERN.BAS";CHR$(34);
140 PRINT ", by C.H.Stewart, KD5DL"
150 PRINT " World Radio, February 2000 issue, pp. 38-39"
160 PRINT
170 PRINT " This program plots radiation azimuth patterns of 2-element vertic";
180 PRINT "al antenna   "
190 PRINT " arrays. The pattern shapes are relative only to each other, and a";
200 PRINT "re not       "
210 PRINT " related to the enclosing circle, as in a Smith chart."
220 PRINT
230 PRINT " Patterns are plotted on a linear scale as opposed to the log scal";
240 PRINT "es used in   "
250 PRINT " Smith charts, e.g., The ARRL Antenna Book, 18th edition, pp. 8-6 ";
260 PRINT "and 8-7.     "
270 PRINT
280 PRINT " Depending on your particular computer and monitor, the reference ";
290 PRINT "circle       "
300 PRINT " enclosing the plot may appear distorted. Since this circle DOES N";
310 PRINT "OT represent "
320 PRINT " any finite value as in a Smith chart, the distortion can be ignor";
330 PRINT "ed. The      "
340 PRINT " pattern shapes are not affected by this distortion."
350 PRINT
360 PRINT " See also HAMCALC's ";CHR$(34);"Vertical Antenna Array Feed Metho";
370 PRINT "d";CHR$(34);" program."
380 PRINT
390 COLOR 0,7:PRINT " Press 1 to continue or 0 to EXIT....":COLOR 7,0
400 Z$=INKEY$:IF Z$=""THEN 400
410 IF Z$="0"THEN 820
420 IF Z$="1"THEN VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:GOTO 440
430 :REM'
440 :REM'....start
450 INPUT " ENTER: Operating frequency in MHz...................";F
460 :REM'
470 IF C=0 THEN INPUT " ENTER: Spacing between elements, in degrees.........";C
480 IF D=0 THEN INPUT " ENTER: Phase difference between elements, in degrees";D
490 :REM'
500 CLS:SCREEN 9
510 PRINT TAB(15)"AZIMUTH RADIATION PATTERN OF PHASED VERTICAL ANTENNAS"
520 COLOR 7:LOCATE ,15
530 J=984*C/(F*360):K=J*0.30480000376701355!
540 PRINT USING " ###.### Mhz Antennas ###.## m. ( ###.## ft.) apart";F,K,J
550 W=ATN(1)/45:X=320:Y=200
560 COLOR 2:LINE(X,Y-100)-(X,Y+100):LINE(X-137,Y)-(X+137,Y)
570 COLOR 12
580 CIRCLE(X,Y+5),2
590 CIRCLE(X,Y-5),2
600 COLOR 2,0
610 CIRCLE(X,Y),137
620 LINE-(X,Y)
630  FOR B=0 TO 360
640 COLOR 14
650 K=C*COS(B*W)+D
660 A=(1+COS(K*W))*50
670 M=A*SIN(B*W):N=A*COS(B*W)
680 X=M+320:Y=N+200
690 LINE-(X,Y)
700  NEXT B
710 COLOR 7
720 PRINT USING " Spacing between elements............. ###.# degrees";C
730 PRINT USING " Phase difference between elements.... ###.# degrees";D
740 LOCATE 22
750 PRINT " Another (s)pacing, another (p)hase difference, (q)uit ?  (s/p/q) "
760 A$=INKEY$:IF A$=""THEN 760
770 IF A$="s"THEN C=0:SCREEN 0:CLS:GOTO 470
780 IF A$="p"THEN D=0:SCREEN 0:CLS:GOTO 470
790 IF A$="q"THEN C=0:D=0:F=0:SCREEN 0:GOTO 60
800 GOTO 760
810 :REM'
820 :REM'.....end
830 CLS:SCREEN 0:RUN EX$
