10 :REM'\hamcalc\prog\FOXLOG - QRP Fox Hunt Logging Program - 02 NOV 2000
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$
50 DIM N$(128,5)
60 UL$=STRING$(80,205)
70 COLOR 7,0,1
80 :REM'
90 :REM'.....title page
100 CLS
110 COLOR 15,2
120 PRINT " QRP Fox Hunt Log"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);
140 COLOR 7,0
150 :REM'
160 PRINT " This program requires a printer. You will be prompted when to turn";
170 PRINT " it on, with"
180 PRINT " paper loaded, and ready to go."
190 PRINT
200 PRINT " At each QSO, type in call sign, name, & QTH of the contact. The";
210 PRINT " date and time"
220 PRINT " of the QSO are automatically recorded from your computer's";
230 PRINT " internal clock."
240 PRINT
250 PRINT " You may type entries in either upper or lower case letters. All";
260 PRINT " letters are"
270 PRINT " converted to display in upper case (caps) by the computer."
280 PRINT
290 PRINT " You may include commas in the QTH, e.g., ";
300 PRINT CHR$(34);"toronto, on";CHR$(34);"."
310 PRINT UL$;
320 PRINT
330 COLOR 0,7:PRINT " Press 1 to continue or 0 to quit now . . . ":COLOR 7,0
340 Z$=INKEY$
350 IF Z$="0"THEN CLS:RUN EX$
360 IF Z$="1"THEN CLS:GOTO 380
370 GOTO 340
380 INPUT  " ENTER: Your (the Fox's) callsign.....";FX$
390 FOR Z=1 TO LEN(FX$)
400 C$=MID$(FX$,Z,1):C=ASC(C$)
410 IF C>=65 AND C<=90 THEN C=C+32:MID$(FX$,Z,1)=CHR$(C)
420 NEXT Z
430 PRINT
440 COLOR 0,7:PRINT " Press any key to continue . . . ":COLOR 7,0
450 IF INKEY$=""THEN 450
460 :REM'
470 CLS:N=0
480 INPUT " ENTER: Hound's call sign or 0 (zero) to end session...";CS$
490 IF CS$="0"THEN 770
500 FOR Z=1 TO LEN(CS$)
510 C$=MID$(CS$,Z,1):C=ASC(C$)
520 IF C>=97 AND C<=122 THEN C=C-32:MID$(CS$,Z,1)=CHR$(C)
530 NEXT Z
540 INPUT " ENTER: Hound's name...................................";NA$
550 FOR Z=1 TO LEN(NA$)
560 C$=MID$(NA$,Z,1):C=ASC(C$)
570 IF C>=97 AND C<=122 THEN C=C-32:MID$(NA$,Z,1)=CHR$(C)
580 NEXT Z
590 LINE INPUT " ENTER: Hound's QTH....................................? ";QTH$
600 FOR Z=1 TO LEN(QTH$)
610 C$=MID$(QTH$,Z,1):C=ASC(C$)
620 IF C>=97 AND C<=122 THEN C=C-32:MID$(QTH$,Z,1)=CHR$(C)
630 NEXT Z
640 :REM'
650 N=N+1
660 N$(N,1)=DATE$:N$(N,2)=TIME$
670 N$(N,3)=CS$:N$(N,4)=NA$
680 N$(N,5)=QTH$
690 CLS
700 FOR Z=1 TO N
710 PRINT USING " ###)  ";Z;
720 PRINT N$(Z,1);TAB(20)N$(Z,2);
730 PRINT TAB(32)N$(Z,3);TAB(40)N$(Z,4);" (";N$(Z,5);")"
740 NEXT Z
750 GOTO 480
760 :REM'
770 CLS
780 FIL$="C:\"+DATE$+" "+FX$+".fox"
790 PRINT
800 PRINT " Load your printer with paper and turn it on NOW!"
810 PRINT
820 PRINT " Press any key when ready . . ."
830 IF INKEY$=""THEN 830 :ELSE 840
840 LPRINT " Fox Hunt Log: (filename ";FIL$;")"
850 FOR Z=1 TO N
860 LPRINT USING " ###)  ";Z;
870 LPRINT N$(Z,1);TAB(20)N$(Z,2);
880 LPRINT TAB(32)N$(Z,3);TAB(40)N$(Z,4);" (";N$(Z,5);")"
890 NEXT Z
900 LPRINT " END"
910 LPRINT CHR$(12);
920 CLS
930 OPEN "O",1,FIL$
940 FOR X=1 TO N
950 PRINT #1,N$(X,1),N$(X,2),N$(X,3),N$(X,4),N$(X,5)
960 NEXT X
970 CLOSE
980 PRINT " The log has been saved as ";FIL$
990 PRINT
1000 PRINT " Press any key . . . ."
1010 IF INKEY$=""THEN 1010
1020 GOTO 90
