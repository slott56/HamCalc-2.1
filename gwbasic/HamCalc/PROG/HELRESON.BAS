10 :REM'HELRESON - Helical Resonators - 27 DEC 94 rev. 19 AUG 2009
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 PROG$="helreson"
50 IF PROG$=" "THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$,QU
70 COLOR 7,0,1
80 PI=4*ATN(1)  :REM'3.141593
90 UL$=STRING$(80,205)
110 :REM'.....title page
120 IF QU THEN 140
130 FO=0:D=0:QU=0
140 CLS
150 COLOR 15,2
160 PRINT " HELICAL RESONATORS (VHF/UHF)";TAB(57)"by George Murphy VE3ERP ";
170 COLOR 1,0:PRINT STRING$(80,223);
180 COLOR 7,0
190 GOSUB 1080:PRINT UL$;:LN=CSRLIN
200 PRINT TAB(11)"Ref. 1997 ARRL Handbook for Radio Amateurs, pp.16.25 - 16.27"
210 PRINT :PRINT
220 PRINT TAB(11)"Press (1) to continue or......"
230 IF QU THEN 250
240 PRINT TAB(11)"Press (2) to calculate insertion loss or......"
250 PRINT TAB(11)"Press (0) EXIT."
260 Z$=INKEY$:IF Z$=""THEN 260
270 IF Z$="1"THEN 330
280 IF QU THEN 300
290 IF Z$="2"THEN CHAIN"inloss"
300 IF Z$="0"THEN CLS:RUN EX$
310 GOTO 260
320 :REM'
330 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
340 :REM'.....data entry
350 PRINT " Want to enter dimensions in (m)illimetres or (i)nches?  (m/i)"
360 Z$=INKEY$:IF Z$=""THEN 360
370 IF Z$="i"THEN UM=1:UM$="in.":GOTO 400
380 IF Z$="m"THEN UM=25.399999618530273!:UM$="mm.":GOTO 400
390 GOTO 360
400 PRINT " Want a (r)ound or (s)quare shield?  (r/s)"
410 Z$=INKEY$:IF Z$=""THEN 410
420 IF Z$="r"THEN SH=1:  SH$=" Diam. of round ":GOTO 450
430 IF Z$="s"THEN SH=1.2000000476837158!:SH$=" Side of square ":GOTO 450
440 GOTO 400
450 LOCATE 10,T+1:COLOR 0,7
460 IF SH=1 THEN PRINT "Round─":ELSE PRINT "Square"
470 LOCATE ,T+1:PRINT "Shield"
480 COLOR 7,0
490 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
500 IF FO THEN 530
510 INPUT " ENTER: Frequency (enter 0 if unknown).................(MHz)";FO
520 GOSUB 610
530 IF D THEN 560
540 PRINT " ENTER:";SH$;"shield (enter 0 if unknown).....(";UM$;")";:INPUT D
550 D=D*SH/UM:GOSUB 610
560 IF QU THEN 590
570 INPUT " ENTER: Unloaded Q (enter 0 if unknown).....................";QU
580 GOSUB 610
590 GOTO 450
600 :REM'
610 :REM'.....start calculation
620 IF QU=0 AND D*FO<>0 THEN QU=50*D*SQR(FO):GOTO 650
630 IF D=0 AND FO*QU<>0 THEN D=QU/(50*SQR(FO)):GOTO 650
640 IF FO=0 AND QU*D<>0 THEN FO=(QU/(50*D))^2:GOTO 650
650 IF QU*D*FO THEN 670
660 RETURN
670 :REM'.....finish calculation
680 N=1908/(FO*D)    :REM'no. turns
690 P=FO*D^2/2312    :REM'pitch
700 ZO=99000.0!/(FO*D) :REM'impedance
710 PD=0.550000011920929!*D         :REM'pitch diameter
720 LH=N*P           :REM'lgth. of helix
730 LS=1.3250000476837158!*D       :REM'lgth. of shield
740 WMAX=0.6000000238418579!*P:WMIN=0.4000000059604645!*P
750 COLOR 0,7:PRINT " Conductor dia. must be between ";
760 Z$=" ##.##mm (##.### in.) and ##.##mm (##.### in.)"
770 PRINT USING Z$;WMIN*25.399999618530273!,WMIN,WMAX*25.399999618530273!,WMAX:COLOR 7,0
780 PRINT " ENTER: Conductor diameter.............................(";UM$;")";
790 INPUT WD:WD=WD/UM
800 IF WD<WMIN OR WD>WMAX THEN BEEP:LOCATE CSRLIN-1:GOTO 750
810 :REM'.....display
820 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
830 PRINT " Frequency............................";
840  PRINT USING " #####.### MHz";FO
850 PRINT " Unloaded Q........................Qu=";
860  PRINT USING " #####  ";QU
870 PRINT " Characteristic impedance.............";
880  PRINT USING " ##### ohms";ZO
890 PRINT SH$+"shield (inside).....D=";
900  PRINT USING " #####.## mm = ###.### in.";D*25.399999618530273!/SH,D/SH
910 PRINT " Shield length.....................LS=";
920  PRINT USING " #####.#  mm = ###.##  in. ";LS*25.399999618530273!,LS
930 E=(LS-LH)/2
940 PRINT " End clearance......................E=";
950  PRINT USING " #####.#  mm = ###.##  in. ";E*25.399999618530273!,E
960 PRINT " Helix pitch diameter..............PD=";
970  PRINT USING " #####.## mm = ###.### in.";PD*25.399999618530273!,PD
980 PRINT " Helix length......................LH=";
990  PRINT USING " #####.#  mm = ###.##  in.";LH*25.399999618530273!,LH
1000 PRINT " Helix conductor diameter.............";
1010  PRINT USING " #####.## mm = ###.### in.";WD*25.399999618530273!,WD
1020 PRINT " Helix pitch (turn spacing)...........";
1030  PRINT USING " #####.## mm = ###.### in.";P*25.399999618530273!,P
1040 PRINT " Helix number of turns................";
1050  PRINT USING " #####.#  turns";N
1060 GOTO 1220
1080 :REM'.....diagram
1090 COLOR 0,7
1100 T=21
1110 LOCATE ,T:PRINT "                                       "
1120 LOCATE ,T:PRINT "          │«────── LS ──────»│         "
1130 LOCATE ,T:PRINT "        ─»│ E │«── LH ──»│ E │«─       "
1140 LOCATE ,T:PRINT "          ╒══════════════════╕ ──── «┐ "
1150 LOCATE ,T:PRINT "          │   ╔╗╔╗╔╗╔╗╔╗╔╗ ──│─ «┐   │ "
1160 LOCATE ,T:PRINT " Helix ───│──>║║║║║║║║║║║║   │   PD  D "
1170 LOCATE ,T:PRINT "          │   ║╚╝╚╝╚╝╚╝╚╝╚ ──│─ «┘   │ "
1180 LOCATE ,T:PRINT " Shield─->╘═══╩══════════════╛ ──── «┘ "
1190 LOCATE ,T:PRINT "                                       "
1200 COLOR 7,0
1210 RETURN
1220 :REM'.....end
1230 GOSUB 1240:QU=0:GOTO 110
1240 :REM'.....PRT
1250 KEY OFF:GOSUB 1320:LOCATE 25,5:COLOR 0,2
1260 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1270 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1280 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1280 :ELSE GOSUB 1320
1290 IF Z$="3"THEN RETURN
1300 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1310 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1250
1320 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
