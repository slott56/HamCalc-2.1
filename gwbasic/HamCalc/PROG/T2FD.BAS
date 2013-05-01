10 :REM'T2FD Tilted Terminated Folded Dipole - 23 MAY 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 DIM B(9)
70 DIM L(9)
80 PI=4*ATN(1)
90 GOTO 120
100 :REM'.....clear acreen to bottom
110 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
120 :REM'.....start
130 CLS
140 :REM'.....data
150 DATA 160,1.8,80,3.5,40,7,30,10,20,14,17,18,15,21,12,24,10,28
160 RESTORE
170 FOR Z=1 TO 9
180 READ B(Z),L(Z)
190 NEXT Z
200 COLOR 15,2
210 PRINT " T2FD MULTI-BAND FOLDED DIPOLE"TAB(57)"By George Murphy VE3ERP ";
220 COLOR 7,0
230 PRINT STRING$(80,205);
240 LOCATE CSRLIN-1,24: PRINT " (suggested by J.G.Vidal CO2DC) "
250 COLOR 0,7:T=2
260 LOCATE ,T:PRINT "                                            "
270 LOCATE ,T:PRINT "     │«──────────── A ────────────»│        "
280 LOCATE ,T:PRINT "   ─∞┬╥───╥───╥───╥─R─╥───╥───╥───╥┬∞─ «┐B  "
290 LOCATE ,T:PRINT "     │║   ║   ║<spreaders>║   ║   ║│    │   "
300 LOCATE ,T:PRINT " ┌»─∞┴╨───╨───╨───╨┬x┬╨───╨───╨───╨┴∞─ »┘«┐ "
310 LOCATE ,T:PRINT " │                 └╥┘«─ 4:1 balun       HI "
320 LOCATE ,T:PRINT " LO       feedline─»║«─ 75 Ω coax         │ "
330 LOCATE ,T:PRINT " └─────────<down  slope  up>──────────────┘ "
340 LOCATE ,T:PRINT "              R = 390 Ω resistor            "
350 COLOR 7,0
360 PRINT
370 LN=CSRLIN
380 PRINT " The T2FD (Tilted Terminated Folded Dipole) is essentially a clo";
390 PRINT "sed loop with "
400 PRINT " element ends folded back and joined by a non-inductive resistor.";
410 PRINT " Elements A   "
420 PRINT " are separated by spacers B and installed with ends tilted LO and";
430 PRINT " HI above     "
440 PRINT " ground. Where the feedline enters the shack make a few turns in ";
450 PRINT "the cable to  "
460 PRINT " act as an RF choke."
470 PRINT
480 PRINT " Ref. QST, June 1949, pp.54-55 and TTFD-2 <www.dxzone.com>"
490 PRINT:COLOR 0,7
500 PRINT " Press 1 to continue or 0 to exit....":COLOR 7,0
510 Z$=INKEY$:IF Z$=""THEN 510
520 IF Z$="0"THEN CLS:RUN EX$
530 IF Z$="1"THEN 550
540 GOTO 510
550 :REM'.....data input
560 GOSUB 100:LOCATE CSRLIN-1  :K=CSRLIN
570 PRINT " Length A depends on the frequency of operation. These are some ty";
580 PRINT "pical lengths:"
590 LOCATE CSRLIN-1
600 FOR Z=1 TO 9:PRINT B(Z)"m. band"
610 LOCATE CSRLIN-1,15:PRINT USING " ##.## m. long";100/L(Z)
620 NEXT Z
630 PRINT " You can enter any frequency you want and the length will be calcu";
640 PRINT "lated for you.";
650 INPUT " ENTER: Lowest frequency of operation (MHz)";F:GOSUB 100
660 AM=100/F:AF=AM/0.30480000376701355!
670 BC=3/F*100:AI=BC/2.5399999618530273!
680 LN=K:GOSUB 100
690 PRINT USING " Lowest frequency of operation = ###.### MHz ( ## m.)";F,300/F
700 PRINT USING " A  = ###.## m. ( ##.## ft.)                         ";AM,AF
710 PRINT USING " B  = ###.## cm.( ##.## in.)                         ";BC,AI
720 N=8
730 SC=AM/(N-1)*100:SI=SC/2.5399999618530273!
740 PRINT USING "### spreaders @ ###.# cm.( ##.## in.) c.c.";N,SC,SI
750 LN=CSRLIN
760 COLOR 0,7
770 INPUT " ENTER: Height above ground of low end (metres)";LO:LF=LO/0.30480000376701355!
780 COLOR 7,0:GOSUB 100
790 PRINT USING " LO = ###.## m. ( ##.## ft.) above ground.           ";LO,LF
800 MAX=AM*SIN(20*PI/180):MIN=AM*SIN(40*PI/180):MID=AM*SIN(30*PI/180)
810 LN=CSRLIN:COLOR 0,7
820 PRINT USING" HI may be anywhere between ##.## and ##.## m. above LO";MAX,MIN
830 COLOR 7,0:PRINT USING "(##.## m. rise recommended)";MID
840 COLOR 0,7
850 INPUT " ENTER: Your choice of slope rise (metres)";HI:HF=HI/0.30480000376701355!
860 COLOR 7,0:GOSUB 100
870 PRINT USING" HI = ###.## m. ( ##.## ft.) sloped rise above LO.    ";HI,HF
880 OA=HI+LO:HT=OA/0.30480000376701355!
890 PRINT USING" OA = ###.## m. ( ##.## ft.) overall height to top end";OA,HT
900 DM=AM:DF=DM/0.30480000376701355!
910 PRINT USING" <--> ###.## m. ( ##.## ft.) minimum distance between supports";DM,DF
920 DD=SQR(AM^2-HI^2):L=ATN(HI/DD)*180/PI
930 PRINT USING " Slope angle = ##.#°";L
940 LN=CSRLIN
950 INPUT " ENTER: Transmitter output (watts)";P:GOSUB 100
960 W=P/3:IF W<1 THEN W=1
970 PRINT USING" A ### watt transmitter requires a 390 Ω ## watt resistor R";P,W
980 IF W>3 THEN PRINT "  ("INT((W/3+1))"390 Ω 3-watt resistors in parallel )"
990 :REM'PRINT
1000 :REM'PRINT TAB(35)"Fig.4";
1010 :REM'.....end
1020 GOSUB 1030:GOTO 120
1030 :REM'.....PRT
1040 KEY OFF:GOSUB 1110:LOCATE 25,5:COLOR 0,2
1050 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1060 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1070 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1070 :ELSE GOSUB 1110
1080 IF Z$="3"THEN RETURN
1090 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1100 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1040
1110 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
