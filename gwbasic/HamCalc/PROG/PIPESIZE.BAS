10 :REM'PIPESIZE - Standard Pipe Sizes - 03 FEB 97 rev. 24 NOV 2001
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="###.###"+CHR$(34)
70 V$="####.##"+" cm"
80 :REM'
90 DIM D$(19,2)
100 DATA 1/8,1/4,3/8,1/2,3/4,1,1DEFSTR,1RENUM,2,2RENUM,3,3RENUM,4,5,6,8,10
110  FOR Z=1 TO 17:READ D$(Z,1):NEXT Z
120 DATA .405,.540,.675,.84,1.05,1.315,1.66,1.9,2.375,2.875
130 DATA 3.5,4,4.5,5.563,6.625,8.625,10.75
140  FOR Z=1 TO 17:READ D$(Z,2):NEXT Z
150 :REM'
160 DIM N$(15)
170 DATA 1/4,3/8,1/2,5/8,3/4,1,1DEFSTR,1RENUM,2,2RENUM,3,3RENUM,4,5,6
180  FOR Z=1 TO 15:READ N$(Z):NEXT Z
190 DIM  D(15,5)
200 DATA .375,.5,.625,.75,.875,1.125,1.375,1.625,2.125,2.625,3.125,3.625
210 DATA 4.125,5.125,6.125
220  FOR Z=1 TO 15:READ D(Z,1):NEXT Z   :REM'O.D.
230 DATA .03,.035,.04,.042,.045,.05,.055,.06,.07,.08,.09,.1,.11,.125,.14
240  FOR Z=1 TO 15:READ D(Z,2):NEXT Z   :REM'type L
250 DATA .035,.049,.049,.049,.065,.065,.065,.072,.083,.095,.109,.120
260 DATA .134,.16,.192
270  FOR Z=1 TO 15:READ D(Z,3):NEXT Z   :REM'type K
280 DATA 0,0,0,0,0,0,.042,.049,.058,.065,.072,.083,.095,.109,.122
290  FOR Z=1 TO 15:READ D(Z,4):NEXT Z   :REM'type M
300 DATA 0,0,0,0,0,0,.04,.042,.042,0,.045,0,.058,.072,.083
310  FOR Z=1 TO 15:READ D(Z,5):NEXT Z   :REM' type DWV
320 RESTORE
330 :REM'
340 CLS
350 COLOR 15,2
360 PRINT " PIPE SIZES";
370 PRINT TAB(57);"by George Murphy VE3ERP ";
380 LOCATE 1,13:PRINT "- Wrought Steel and Plastic Pipe"
390 COLOR 1,0:PRINT STRING$(80,223);
400 COLOR 7,0
410 PRINT "⌐Nom. Size¬";TAB(13);"⌐Outside Diameter¬ │"
420 PRINT STRING$(31,205);"╡"
430 FOR Z=1 TO 17:PRINT TAB(4)D$(Z,1);CHR$(34);
440 X=VAL(D$(Z,2))
450 PRINT TAB(11)USING U$;X;
460 PRINT TAB(21)USING V$;X*2.5399999618530273!;
470 PRINT " │"
480 NEXT Z
490 :REM'
500 T=34:LOCATE 3,12
510 LOCATE ,T:PRINT "The word ";CHR$(34);"pipe";CHR$(34);
520 PRINT " as distinguished from ";CHR$(34);"tube";CHR$(34)
530 LOCATE ,T:PRINT "is used to apply to tubular products of"
540 LOCATE ,T:PRINT "dimensions commonly used for pipelines and"
550 LOCATE ,T:PRINT "piping systems. Pipe outside diameters are"
560 LOCATE ,T:PRINT "larger than corresponding nominal sizes"
570 LOCATE ,T:PRINT "whereas outside diameters of tubes (except"
580 LOCATE ,T:PRINT "copper) are identical to nominal sizes."
590 PRINT
600 LOCATE ,T:PRINT "The size of all pipe is identified by the"
610 LOCATE ,T:PRINT "nominal pipe size, and is based on a standard"
620 LOCATE ,T:PRINT "outside diameter. This OD was originally"
630 LOCATE ,T:PRINT "selected so that pipe with a standard OD and"
640 LOCATE ,T:PRINT "having a wall thickness typical of the period"
650 LOCATE ,T:PRINT "would have an inside diameter approximately"
660 LOCATE ,T:PRINT "equal to the nominal size. Although there is"
670 LOCATE ,T:PRINT "now no such relation between existing standard"
680 LOCATE ,T:PRINT "wall thicknesses, OD's and nominal sizes"
690 LOCATE ,T:PRINT "these nominal sizes and OD's continue in use"
700 LOCATE ,T:PRINT "as ";CHR$(34);"standard";CHR$(34);"."
710 LOCATE 22,1:PRINT UL$;
720 LOCATE 22,9:COLOR 0,7
730 PRINT " (Machinery's Handbook, Revised 21st Edition, pages 2323-2324) ";
740 COLOR 7,0:GOSUB 1300
750 LOCATE 25,18:COLOR 0,7
760 PRINT " Press 1 for Copper Tubing data, or 0 to EXIT ";:COLOR 7,0
770 Z$=INKEY$:IF Z$=""THEN 770
780 IF Z$="0"THEN CLS:RUN EX$
790 IF Z$="1"THEN 810
800 GOTO 770
810 GOSUB 1300
820 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 1,13:COLOR 15,2
830 PRINT " - Copper Tubing";SPC(20):COLOR 7,0:LOCATE 3,1
840 PRINT " Copper tubing (commonly sold as ";CHR$(34);"pipe";CHR$(34);
850 PRINT " in hardware and building s";
860 PRINT "upply stores)"
870 PRINT " is available in four types and hard (rigid) or soft (flexible) te";
880 PRINT "mpers:       "
890 PRINT
900 PRINT "  Type L, standard plumbing. Type L Hard is available in most hard";
910 PRINT "ware stores. "
920 PRINT
930 PRINT "  Type K, thick walled, used for all underground applications.    "
940 PRINT
950 PRINT "  Type M, thin walled, for heating and pressure lines. Not made in";
960 PRINT " some sizes. "
970 PRINT
980 PRINT "  Type DWV (Drain, Waste and Vent). Hard only.  Not made in some s";
990 PRINT "ome sizes.   "
1000 GOSUB 1300:LOCATE 3
1010 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
1020 PRINT " Nom. │   Outside   ";
1030 PRINT "│                   Inside Diameter                     │"
1040 PRINT " Size │   Diameter  ";
1050 PRINT "│   Type L    │   Type K    │   Type M    │  Type DWV   │"
1060 PRINT "      │  in.    cm. ";
1070 PRINT "│  in.    cm. │  in.    cm. │  in.    cm. │  in.    cm. │"
1080 FOR Z=1 TO 15
1090 PRINT " "+N$(Z)+CHR$(34);
1100 PRINT TAB(7)USING "│ #.###  ##.##";D(Z,1),D(Z,1)*2.5399999618530273!;
1110 A=D(Z,1)-2*D(Z,2)
1120 PRINT TAB(21)USING "│ #.###  ##.##";A,A*2.5399999618530273!;
1130 A=D(Z,1)-2*D(Z,3)
1140 PRINT TAB(35)USING "│ #.###  ##.##";A,A*2.5399999618530273!;
1150 A=D(Z,1)-2*D(Z,4):IF A=D(Z,1)THEN A=0
1160 IF A=0 THEN PRINT "│   -      -  ";:GOTO 1180
1170 PRINT TAB(49)USING "│ #.###  ##.##";A,A*2.5399999618530273!;
1180 A=D(Z,1)-2*D(Z,5):IF A=D(Z,1)THEN A=0
1190 IF A=0 THEN PRINT "│   -      -  │":GOTO 1220
1200 PRINT TAB(63)USING "│ #.###  ##.##";A,A*2.5399999618530273!;
1210 PRINT "│"
1220 NEXT Z
1230 LOCATE 23,17
1240 PRINT "(POCKET REF, Sequoia Publishing Inc., page 339)"
1250 GOSUB 1300:GOTO 340
1260 END
1270 :REM'
1280 DATA .03,.035,.04,.042,.045,.05,.056,.06,.07,.08,.09,.1,.11,.125,.14
1290 :REM'
1300 :REM'PRT
1310 KEY OFF:GOSUB 1380:LOCATE 25,5:COLOR 0,2
1320 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1330 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1340 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1340 :ELSE GOSUB 1380
1350 IF Z$="3"THEN RETURN
1360 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1370 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1310
1380 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
