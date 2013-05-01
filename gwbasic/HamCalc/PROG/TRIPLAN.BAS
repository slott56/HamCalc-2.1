10 :REM'TRIPLAN - Trip Planner - 11 APR 01
20 KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 UL$=STRING$(80,205)
50 DIM J$(128,2)
60 :REM'
70 :REM'.....menu
80 CLS
90 PRINT TAB(34)"TRIP PLANNER"
100 PRINT UL$;
110 GOSUB 1870  :REM'prologue
120 PRINT UL$;
130 COLOR 0,7:PRINT " Press number in < > to:":COLOR 7,0
140 PRINT "   < 1 >  COMPILE a new trip plan"
150 PRINT "   < 2 >  VIEW/PRINT an existing trip plan"
160 PRINT "   < 3 >  DELETE an existing trip plan"
170 PRINT "   < 4 >  READ ME"
180 PRINT
190 PRINT "   < 0 >  EXIT";
200 Z$=INKEY$:IF Z$=""THEN 200
210 IF Z$="0"THEN CLS:CHAIN EX$
220 IF Z$="1"THEN 1460
230 IF Z$="2"THEN GOSUB 280:GOTO 380
240 IF Z$="3"THEN GOSUB 280:GOTO 1720
250 IF Z$="4"THEN GOSUB 2160:GOTO 70
260 GOTO 200
270 :REM'
280 :REM'.....existing files
290 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
300 PRINT " These are the trip plans on file:"
310 PRINT UL$;
320 CHDIR"\hamcalc\data"
330 FILES"c:\hamcalc\data\*.txt"
340 CHDIR"\hamcalc\prog"
350 LOCATE CSRLIN-2:PRINT UL$;
360 RETURN
370 :REM'
380 :REM'.....start
390 TOP=0
400 LOCATE CSRLIN-1,16:COLOR 0,7
410 PRINT " (you may enter filename in lower case letters) ":COLOR 7,0
420 INPUT " ENTER: Filename (omitting the .TXT extension)";F$
430 :REM'
440 CLS:PRINT " Filename: ";F$
450 PRINT UL$;
460 :REM'
470 :REM'.....data input
480 PRINT " Enter estimated average speed for the entire trip. If in doubt, ";
490 PRINT "try about 10% "
500 PRINT " less than the maximum speed limit along the route. Your can chan";
510 PRINT "ge the speed  "
520 PRINT " later in the program if you wish.                               "
530 PRINT
540 INPUT " ENTER: Estimated average speed";S
550 IF S>TOP THEN TOP=S
560 T$="c:\hamcalc\data\"+F$+".txt"
570 N=0
580 OPEN "I",1,T$
590 IF EOF(1) THEN 640
600 N=N+1
610 INPUT#1,J$(N,1)
620 INPUT#1,J$(N,2)
630 GOTO 590
640 CLOSE
650 CLS
660 KT=0
670 :REM'
680 :REM'.....screen dispaly
690 FOR Z=1 TO N:KT=KT+VAL(J$(Z,2)):NEXT Z
700 PRINT " ";J$(1,1);" to ";J$(N,1);", Distance";KT;"at average speed";S
710 PRINT UL$;
720 PRINT TAB(23)"Dist.& Time gone    Dist.& Time to go"
730 K1=0:K2=0
740  FOR Z=1 TO N
750 A$=J$(Z,1)
760 K1=VAL(J$(Z,2))
770 K2=K2+K1
780 HRS=K2/S:GOSUB 1350:T1$=HR$
790 K3=KT-K2
800 HRS=K3/S:GOSUB 1350:T2$=HR$
810 PRINT A$;STRING$(22-LEN(A$),".");
820 PRINT USING "#### / ";K2;:PRINT T1$;" .......";
830 PRINT USING "#### / ";K3;:PRINT T2$;
840 IF CSRLIN<24 THEN PRINT "":GOTO 860
850 GOSUB 2410:CLS
860  NEXT Z
870 GOSUB 2410
880 CLS:PRINT:COLOR 0,7
890 PRINT " You estimated";S;"as your average speed.";
900 PRINT " Want to try another speed?   (y/n)":COLOR 7,0
910 Z$=INKEY$:IF Z$=""THEN 910
920 IF Z$="n"THEN 970
930 IF Z$="y"THEN 440
940 GOTO 910
950 END
960 :REM'
970 :REM'.....ETA option
980 PRINT UL$;
990 PRINT " Press number in < > for:"
1000 PRINT UL$;
1010 PRINT "  <1> Table of estimated arrival times at various average speeds."
1020 PRINT
1030 PRINT "  <0> Return to Menu"
1040 Z$=INKEY$:IF Z$=""THEN 1040
1050 IF Z$="0"THEN 70
1060 IF Z$="1"THEN 1090
1070 GOTO 1040
1080 :REM'
1090 :REM'.....ETA table
1100 CLS
1110 S(1)=TOP/0.8999999761581421!:S(2)=TOP:S(3)=TOP*0.8999999761581421!
1120 S(4)=TOP*0.800000011920929!:S(5)=TOP*0.699999988079071!:S(6)=TOP*0.6000000238418579!
1130 K1=0:K2=0
1140 COLOR 15,2:PRINT " ";J$(1,1);" to ";J$(N,1);", Distance";KT
1150 COLOR 7,0:PRINT TAB(13)" Average speed ──»";
1160 FOR Y=1 TO 6:PRINT USING"########";S(Y);:NEXT Y:PRINT ""
1170 PRINT " From:"TAB(19)"┌Dist.to go┐";
1180 PRINT "  ┌───────────── Travel Time To Go ──────────────┐";
1190  FOR Z=1 TO N
1200 A$=J$(Z,1)
1210 K1=VAL(J$(Z,2))
1220 K2=K2+K1
1230 K3=KT-K2
1240 FOR X=1 TO 6:HRS=K3/S(X):GOSUB 1350:T$(X)=HR$:NEXT X
1250 PRINT A$;STRING$(22-LEN(A$),".");
1260 PRINT USING "####";K3;
1270 PRINT ".... ";
1280 FOR X=1 TO 6:PRINT "   "+T$(X);:NEXT X
1290 IF CSRLIN<24 THEN PRINT "":GOTO 1310
1300 GOSUB 2410:LN=0:CLS
1310  NEXT Z
1320 GOTO 2380
1330 END
1340 :REM'
1350 :REM'.....convert decimal hours
1360 REM HRS = decimal hours
1370 HRS$=STR$(INT(HRS))+":"
1380 HRS$=RIGHT$(HRS$,LEN(HRS$)-1)
1390 IF VAL(HRS$)<10 THEN HRS$=" "+HRS$
1400 MIN$=STR$(CINT((HRS-INT(HRS))*60))
1410 MIN$=RIGHT$(MIN$,LEN(MIN$)-1)
1420 IF VAL(MIN$)<10 THEN MIN$="0"+MIN$
1430 HR$=LEFT$(HRS$+MIN$,5)
1440 RETURN
1450 :REM'
1460 :REM'.....compile new
1470 CLS
1480 INPUT "ENTER: Filename (max. 8 characters)";Z$
1490 NAM$="c:\hamcalc\data\"+Z$+".txt"
1500 CLS:PRINT "New file: ";NAM$
1510 PRINT UL$;
1520 N=0:LN=2
1530 :REM'
1540 N=N+1:LN=LN+1:LOCATE LN
1550 INPUT " ENTER: Location name...............................";J$(N,1)
1560 INPUT " ENTER: Distance from last location.................";J$(N,2)
1570 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1580 WRITE J$(N,1),J$(N,2)
1590 COLOR 0,7:PRINT " Want to add (a)nother location or (q)it?  (a/q) "
1600 COLOR 7,0
1610 Z$=INKEY$:IF Z$=""THEN 1610
1620 IF Z$="q"THEN CLS:GOTO 1650
1630 IF Z$="a"THEN 1540
1640 GOTO 1610
1650 OPEN"A",1,NAM$
1660 FOR Z=1 TO N
1670 WRITE#1,J$(Z,1),J$(Z,2)
1680 NEXT Z
1690 CLOSE:GOTO 70
1700 END
1710 :REM'
1720 :REM'.....delete existing file
1730 LOCATE CSRLIN-1,16:COLOR 0,7
1740 PRINT " (you may enter filename in lower case letters) ":COLOR 7,0
1750 INPUT " ENTER: Filename (omitting the .TXT extension) to be deleted:";Z$
1760 T$="\hamcalc\data\"+Z$+".txt"
1770 PRINT
1780 PRINT " Are you SURE you want to delete ";
1790 COLOR 0,7:PRINT " ";T$;" ";
1800 COLOR 7,0:PRINT " ?   (y/n) "
1810 Z$=INKEY$:IF Z$=""THEN 1810
1820 IF Z$="n"THEN 70
1830 IF Z$="y"THEN KILL T$:GOTO 70
1840 GOTO 1810
1850 END
1860 :REM'
1870 :REM'.....prologue
1880 PRINT "   This program plans a trip itinerary listing several points alo";
1890 PRINT "ng the route, "
1900 PRINT " with distance travelled and estimated time and distance to go fr";
1910 PRINT "om each point."
1920 PRINT "   To plan the trip, a highway map or aeronautical/marine chart t";
1930 PRINT "o suit your   "
1940 PRINT " mode of transportation and a means of measuring distances betwee";
1950 PRINT "n points on   "
1960 PRINT " the map/chart are required. Most highway maps have distances bet";
1970 PRINT "ween towns and"
1980 PRINT " junctions already marked along well travelled roads.            "
1990 PRINT "   Select item <1> from the menu below. Enter the name of the sta";
2000 PRINT "rting point   "
2010 PRINT " with 0 (zero) as the distance from last location. Enter names of";
2020 PRINT " subsequent   "
2030 PRINT " points along the route and distance from previous point. When yo";
2040 PRINT "u have entered"
2050 PRINT " the final destination and distance press <q> to save the trip pl";
2060 PRINT "an data file. "
2070 PRINT "   Distances and speeds can be in kilometres, statute miles, or n";
2080 PRINT "autical miles."
2090 PRINT " When viewing an existing trip plan you will be asked to enter yo";
2100 PRINT "ur estimated  "
2110 PRINT " average speed for the trip. To view an existing trip plan (inclu";
2120 PRINT "ding the one  "
2130 PRINT " you just made) select <2> in the menu below.                    "
2140 RETURN
2150 :REM'
2160 :REM'.....read me
2170 CLS
2180 PRINT " Files are located at \HAMCALC\DATA\filename.txt, and may be edit";
2190 PRINT "ed or added to"
2200 PRINT " using any text editor."
2210 PRINT
2220 PRINT " Each line of a file consists of two fields, each field enclosed ";
2230 PRINT "in quotation  "
2240 PRINT " marks, with the two fields separated by a comma."
2250 PRINT
2260 PRINT " The first field is the name of a location. The second field is t";
2270 PRINT "he distance   "
2280 PRINT " from the previous location."
2290 PRINT
2300 PRINT " Since commas and quotation marks function as delimiters, they ma";
2310 PRINT "y not be used "
2320 PRINT " as part of the text in any field."
2330 PRINT
2340 COLOR 0,7:PRINT " Press any key to continue.....":COLOR 7,0
2350 IF INKEY$=""THEN 2350
2360 RETURN
2370 :REM'
2380 :REM'.....end
2390 GOSUB 2410:GOTO 70
2400 :REM'
2410 :REM'.....PRT
2420 KEY OFF:GOSUB 2490:LOCATE 25,5:COLOR 0,2
2430 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
2440 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
2450 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 2450 :ELSE GOSUB 2490
2460 IF Z$="3"THEN RETURN
2470 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
2480 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 2420
2490 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
