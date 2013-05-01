10 :REM'\hamcalc\menu\HCAL - HAMCALC Main menu - 03 JUN 94 - rev. 25 JAN 2011
20 :REM'.....see STRAYS, Oct.1993 QST, page 23
30 CLS:KEY OFF
40 KEY 10,"SYSTEM"+CHR$(13)
50 COMMON EX$,V$,D$,Z$
60 V$="129,"          :REM'version
70 D$="25 JAN 2011"   :REM'date of latest version
80 IF EX$="\hamcalc\menu\hcal"THEN 110
90 IF EX$=""THEN EX$="\hamcalc\menu\hcal":CHAIN"\hamcalc\prog\intro"
100 :REM'
110 COLOR  15,0,0
120 U$=STRING$(80,205)
130 DIM A$(21),B$(21),C$(21)
140 ON ERROR  GOTO 350
150 COLOR 14,1
160 PRINT "    H  A  M  C  A  L  C    ";
170 COLOR 11,1
180 PRINT " Version ";V$;"   ";D$;" ";
190 COLOR 14,1
200 PRINT TAB(56);" by George Murphy VE3ERP ";
210 COLOR 7,1:PRINT STRING$(80,223);
220 COLOR 14,1
230 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3   :REM'set screen background color
240 COLOR 14,1
250 LOCATE ,24:PRINT " PAINLESS MATH for RADIO AMATEURS "
260 COLOR 14,4
270 LOCATE ,31:PRINT " M A I N    M E N U "
280 COLOR 15,1:PRINT STRING$(80,205);
290 COLOR 15,1:PRINT TAB(10)" Turn ";
300 COLOR 14,4:PRINT " Caps Lock OFF ";
310 COLOR 15,1:PRINT " then press any letter in ( ) to select:"
320 PRINT U$;
330 N=0:GOTO 370
340 :REM'
350 PRINT "Error ";ERR;" in line ";ERL:END
360 :REM'
370 NM=15 :REM'number of menu items
380 FOR N=1 TO NM:A$(N)=CHR$(N+95):IF N=1 THEN A$(N)="z"
390  IF N=1 OR N=11 THEN COLOR 14,4 :ELSE COLOR 15,1
400  READ B$(N),C$(N)
410  LOCATE CSRLIN,24:PRINT "(";A$(N);")  ";C$(N);" "
420 NEXT N
430 COLOR 15,1
440 COLOR 7:LOCATE 24:PRINT STRING$(80,220);
450 COLOR 14,1:LOCATE 25:PRINT "   ";CHR$(34);
460 PRINT "Aversion to mathematics is not an acquired distaste - ";
470 PRINT "it comes naturally";CHR$(34);"   ";
480 COLOR 7,0
490 Z$=INKEY$:IF Z$=""THEN 490
500 FOR Z=1 TO NM
510 IF ASC(Z$)>=65 AND ASC(Z$)<=80 THEN 600
520 IF Z$=A$(Z)THEN 560
530 NEXT Z
540 GOTO 490
550 :REM'
560 IF B$(Z)=""THEN 490
570 CLS:CHDIR"\hamcalc\prog"
580 COLOR 7,0,1:CHAIN B$(Z)
590 :REM'
600 :REM'.....caps lock warning
610 CLS:BEEP:COLOR 14,4
620 PRINT
630 PRINT " Please turn your CAPS LOCK off and make all entries in lower case ";
640 PRINT " characters only."
650 PRINT
660 PRINT " The computer will provide upper case characters where appropriate."
670 PRINT
680 PRINT " Turn CAPS LOCK off NOW then press any key to continue............."
690 IF INKEY$=""THEN 690
700 CLS:CLEAR:COLOR 7,0,0:GOTO 10
710 :REM'
720 DATA \hamcalc\prog\quiktabl,QuikTables
730 DATA \hamcalc\menu\hcal-a,Program Menu A  ( A.C.- Cap )
740 DATA \hamcalc\menu\hcal-b,Program Menu B  ( Cap - Cos )
750 DATA \hamcalc\menu\hcal-c,Program Menu C  ( Cro - Guy )
760 DATA \hamcalc\menu\hcal-d,Program Menu D  ( Guy - Log )
770 DATA \hamcalc\menu\hcal-e,Program Menu E  ( Log - Op  )
780 DATA \hamcalc\menu\hcal-f,Program Menu F  ( Op  - S-  )
790 DATA \hamcalc\menu\hcal-g,Program Menu G  ( Sag - Tor )
800 DATA \hamcalc\menu\hcal-h,Program Menu H  ( Tra - Whe )
810 DATA \hamcalc\menu\hcal-i,Program Menu I  ( Win - Zep )
820 DATA \hamcalc\prog\hamdex,INDEX
830 DATA \hamcalc\prog\helphint,READ ME
840 DATA \hamcalc\prog\logoclok,Clock Screen Saver
850 DATA \hamcalc\prog\newsince,Recent program additions & upgrades
860 :REM'DATA \hamcalc\prog\printip,Printer Tips
870 DATA \hamcalc\prog\zexit,EXIT
880 END
