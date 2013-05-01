10 :REM'ELECLENG - Electrical vs. Physical length - 17 NOV 96 rev. 30 JUL 2001
20 :REM'ref THE 1997 ARRL HANDBOOK for RADIO AMATEURS, pages 19.1 - 19.2
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 CLS:KEY OFF
70 K=299.7900085449219!   :REM'speed of light factor
80 U$="#####.###"
90 UL$=STRING$(80,205)
100 X$=STRING$(80,32)
110 :REM'
120 COLOR 15,2,1
130 PRINT " TRANSMISSION LINE LENGTH";TAB(57);"by George Murphy VE3ERP ";
140 COLOR 1,0:PRINT STRING$(80,223);
150 COLOR 7,0
160 :REM'
170 :REM'.....start
180 F=0:L=0:FT=0:N=0:V=0:E=0:W=0:D=0:LN=0
190 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
200 GOSUB 1100    :REM'preface
210 PRINT UL$;
220 COLOR 0,7:LOCATE ,23
230 PRINT " Press 1 to continue or 0 to EXIT..."
240 COLOR 7,0
250 Z$=INKEY$:IF Z$=""THEN 250
260 IF Z$="0"THEN CLS:CHAIN GO$
270 IF Z$="1"THEN 290
280 GOTO 250
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
300 GOTO 370
310 :REM'
320 :REM'.....format input line
330 LOCATE CSRLIN-1:PRINT SPC(7);
340 LOCATE CSRLIN,54:PRINT USING U$;ZZ;
350 RETURN
360 :REM'
370 :REM'.....input data
380 IF F THEN 430
390 INPUT " ENTER: Frequency of operation in MHz................";F
400 IF F=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 430
410 GOSUB 760
420 :REM'
430 IF L OR FT OR N OR D THEN 490
440 INPUT " ENTER: Length of line in metres.....................";L
450 IF L=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 490
460 FT=L/0.30480000376701355!
470 GOSUB 760
480 :REM'
490 IF FT OR L OR N OR D THEN 550
500 INPUT " ENTER: Length of line in feet.......................";FT
510 IF FT=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 550
520 L=FT*0.30480000376701355!
530 GOSUB 760
540 :REM'
550 IF N OR L OR FT OR D THEN 600
560 INPUT " ENTER: Length of line in wavelengths................";N
570 IF N=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 600
580 GOSUB 760
590 :REM'
600 IF D OR L OR FT OR N THEN 650
610 INPUT " ENTER: Length of line in electrical degrees.........";D
620 IF D=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 650
630 GOSUB 760
640 :REM'
650 IF V THEN 700
660 INPUT " ENTER: Velocity factor of line (decimal)............";V
670 IF V=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 700
680 GOSUB 760
690 :REM'
700 IF E THEN 740
710 INPUT " ENTER: Dielectric constant..........................";E
720 IF E=0 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 740
730 GOSUB 760
740 GOTO 380
750 :REM'
760 :REM'.....calculate
770 :REM'....L,N,F,V
780 IF L=0 AND N*F*V<>0 THEN L=K*V*N/F :GOTO 760
790 IF N=0 AND L*F*V<>0 THEN N=L*F/K/V :GOTO 760
800 IF F=0 AND L*N*V<>0 THEN F=K*V*N/L :GOTO 760
810 IF V=0 AND L*N*F<>0 THEN V=L*F/K/N :GOTO 760
820 :REM'....L,D,F,V
830 IF L=0 AND D*F*V<>0 THEN L=D*K*V/(360*F) :GOTO 760
840 IF D=0 AND L*F*V<>0 THEN D=360*L*F/(K*V) : GOTO 760
850 IF F=0 AND L*D*V<>0 THEN F=D*K*V/(360*L) :GOTO 760
860 IF V=0 AND L*D*F<>0 THEN V=360*L*F/(D*K) :GOTO 760
870 :REM'....V,E
880 IF V=0 AND E<>0     THEN V=1/SQR(E) :GOTO 760
890 IF E=0 AND V<>0     THEN E=(1/V)^2  :GOTO 760
900 IF FT=0 AND L<>0    THEN FT=L/0.30480000376701355! :GOTO 760
910 IF L*N*D*F*V*E THEN 940
920 RETURN
930 :REM'
940 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 4
950 PRINT "        Frequency of operation in MHz................";USING U$;F
960 W=K/F
970 PRINT "        Operating wavelength in free space...........";USING U$;W;
980 PRINT " metres"
990 PRINT
1000 PRINT "        Electrical length of line....................";USING U$;D;
1010 PRINT " degrees"
1020 PRINT "         Length of line in wavelengths...............";USING U$;N
1030 PRINT "         Length of line in metres....................";USING U$;L
1040 PRINT "         Length of line in feet......................";USING U$;FT
1050 PRINT "        Velocity factor of line......................";USING U$;V
1060 PRINT "        Dielectric constant of line..................";USING U$;E
1070 GOSUB 1470:GOTO 170
1080 END
1090 :REM'
1100 :REM'.....preface
1110 TB=8
1120 PRINT TAB(TB);
1130 PRINT "This program solves equations involving the following factors:"
1140 PRINT
1150 PRINT TAB(TB);
1160 PRINT "  -  Frequency of operation"
1170 PRINT TAB(TB);
1180 PRINT "  -  Line length in metres"
1190 PRINT TAB(TB);
1200 PRINT "  -  Line length in feet"
1210 PRINT TAB(TB);
1220 PRINT "  -  Line length in wavelengths"
1230 PRINT TAB(TB);
1240 PRINT "  -  Line length in electrical degrees"
1250 PRINT TAB(TB);
1260 PRINT "  -  Velocity factor of line"
1270 PRINT TAB(TB);
1280 PRINT "  -  Dielectric constant of line"
1290 PRINT
1300 PRINT TAB(TB);
1310 PRINT "You will be asked to enter known data in the order shown above."
1320 PRINT TAB(TB);
1330 PRINT "If the data requested is unknown press <ENTER> to bypass the"
1340 PRINT TAB(TB);
1350 PRINT "request. If the data requested is essential, you will be asked"
1360 PRINT TAB(TB);
1370 PRINT "for it again."
1380 PRINT
1390 PRINT TAB(TB);
1400 PRINT "The data input requests are repeated in continuous rotation. When"
1410 PRINT TAB(TB);
1420 PRINT "sufficient data has been entered for the equations to be solved,"
1430 PRINT TAB(TB);
1440 PRINT "the values of all the above factors are displayed."
1450 RETURN
1460 :REM'
1470 :REM'PRT
1480 KEY OFF:GOSUB 1550:LOCATE 25,5:COLOR 0,2
1490 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1500 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1510 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1510 :ELSE GOSUB 1550
1520 IF Z$="3"THEN RETURN
1530 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1540 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1480
1550 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
