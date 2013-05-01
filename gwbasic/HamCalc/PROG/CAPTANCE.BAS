10 :REM'CAPTANCE - Capacitor Design Calculator - 05 JAN 08
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 U$="######.##"
80 DIM DK$(20,3)
90 :REM'.....title page
100 CLS
110 COLOR 15,2,1
120 PRINT " CAPACITOR DESIGN CALCULATOR"TAB(57)"by George Murphy VE3ERP ";
130 COLOR 7,0,0
140 U$="###,###.###"
150 U1$="#######"
160 UL$=STRING$(80,205)
170 VIEW PRINT 3 TO 14:CLS:VIEW PRINT:LOCATE 3
180 :REM'.....read data
190 FOR Z=1 TO 19
200  FOR Y=1 TO 3:READ DK$(Z,Y):NEXT Y
210 NEXT Z:RESTORE
220 :REM'.....start
230 :REM'.....diagram
240 PRINT " ┌─────────    This program designs capacitors with two or more"
250 PRINT " │ ─────────┐  plates, the altenate plates being connected to form"
260 PRINT " ├────────  │  two sets with the plates being insulated from each"
270 PRINT " │ ─────────┘  other by a layer of dielectric material."
280 PRINT " └─────────    (ref. ARRL 2007 Handbook, pages 4.19 & 4.20)"
290 PRINT "               (ref. www.gcronline.com/cbrauda)"
300 PRINT
310 PRINT TAB(12)"....press 1 to continue or 0 to exit...."
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="0"THEN RUN EX$
340 IF Z$="1"THEN 360
350 GOTO 320
360 :REM'.....print reference table
370 CLS
380 PRINT "     DIELECTRIC MATERIAL   ";TAB(29);" CONSTANT (K) ";
390 PRINT TAB(43);" PUNCTURE VOLTAGE per .001";CHR$(34);" air gap"
400 PRINT
410 FOR Z=1 TO 19
420  DOT$=STRING$(26-LEN(DK$(Z,1)),".")+" "
430  PRINT " <";CHR$(96+Z);"> ";
440  PRINT DK$(Z,1);DOT$;DK$(Z,2);TAB(45);DK$(Z,3)
450 NEXT Z
460 PRINT UL$;
470 COLOR 0,7:LOCATE CSRLIN,22
480 PRINT" Press 1 for dims. in centimetres, 2 for dims. in inches, 0 to EXIT ";
490 COLOR 7,0
500 Z$=INKEY$:IF Z$=""THEN 500
510 IF Z$="0"THEN CLS:RUN GO$
520 IF Z$="1"THEN UM=2.5399999618530273!:UM$=" cm.":SQ=6.451600074768066!:SQ$=" cm²":GOSUB 550:GOTO 560
530 IF Z$="2"THEN UM=1   :UM$=" in.":SQ=1     :SQ$=" in²":GOSUB 550:GOTO 560
540 GOTO 500
550 VIEW PRINT 23 TO 24:CLS:VIEW PRINT:LOCATE 23:RETURN
560 :REM'.....inputs
570 IF K THEN 710
580 INPUT " ENTER: Letter in < > in above table to select dielectric....";Z$
590 IF Z$=""THEN GOSUB 550:GOTO 580
600 Z=ASC(Z$)-96:MATL$=DK$(Z,1):K=VAL(DK$(Z,2)):MV=VAL(DK$(Z,3))
610 VM$=" "+DK$(Z,3)
620 GOTO 630
630 VIEW PRINT 22 TO 24:CLS:VIEW PRINT:LOCATE 22:COLOR 0,7
640 PRINT " Input the following or press ENTER if unknown....."
650 COLOR 15,0
660 GOSUB 550
670 IF C THEN 700
680 INPUT " ENTER: Capacitance in pF....";C
690 GOSUB 820:GOSUB 550
700 IF A THEN 740
710 PRINT " ENTER: Area common to adjacent plates (";SQ$;")....";
720 INPUT Z:A=Z/SQ
730 GOSUB 820:GOSUB 550
740 IF N THEN 770
750 INPUT " ENTER: Number of plates....";N
760 GOSUB 820:GOSUB 550
770 IF D THEN 810
780 PRINT " ENTER: Gap between adjacent plates (";UM$;")....";
790 INPUT Y:D=Y/UM
800 GOSUB 820:GOSUB 550
810 GOTO 660
820 :REM'.....compute unknown factor
830 J=0.2248000055551529!
840 IF K*A*N*D THEN C=J*K*A*(N-1)/D:GOTO 880
850 IF K*C*N*A THEN D=A/(C/J/K/(N-1)):GOTO 880
860 IF C*K*N*D THEN A=C/J/K/(N-1)*D:GOTO 880
870 IF C*K*A*D THEN X=C/J/K/A*D:N=X+1:GOTO 880
880 IF C*K*A*N*D THEN 900
890 RETURN
900 :REM'.....print results
910 GOSUB 550
920 CLS:COLOR 7,0,0
930 PRINT " CAPACITOR DESIGN CALCULATOR";TAB(57);"by George Murphy VE3ERP ";
940 PRINT UL$;
950 PRINT" Dielectric .........................";" ";MATL$
960 PRINT" Dielectric volts per mil............";VM$
970 PRINT" Dielectric constant K...............";USING U$;K
980 PRINT" Puncture voltage....................";USING U$;D*1000*MV;
990 PRINT " volts"
1000 PRINT" Area common to adjacent plates......";USING U$;A*SQ;:PRINT SQ$
1010 IF INT(N)=N THEN N$=U1$ :ELSE N$=U$
1020 PRINT" Number of plates....................";USING N$;N
1030 PRINT" Gap between plates..................";USING U$;D*UM;:PRINT UM$
1040 PRINT" Capacitance.........................";USING U$;C;:PRINT " pF"
1050 PRINT UL$;
1060 MATL$="":C=0:K=0:PV=0:A=0:N=0:D=0:T=0:S=0:X=0:Y=0:Z=0
1070 :REM'.....data
1080 DATA Air,1.0,21,Alsimag 196,5.7,240,Bakelite,4.4-5.4,300
1090 DATA Bakelite (mica filled),4.7,325-375, Cellulose acetate,3.3-3.9,250-600
1100 DATA Fibre,5-7.5,150-180,Formica,4.6-4.9,450,Glass (window),7.6-8,200-250
1110 DATA Glass (Pyrex),4.8,335,Mica (ruby),5.4,2800-5600,Mycalex,7.4,250
1120 DATA Paper (no ink),3,200,Plexiglas,2.8,990,Polyethylene,2.3,1200
1130 DATA Polystyrene,2.6,500-700,Porcelain,5.1-5.9,40-100
1140 DATA Quartz (fused),3.8,1000,Steatite (low loss),5.8,150-315
1150 DATA Teflon,2.1,1000-2000
1160 :REM'.....end
1170 GOSUB 1180:CLS:GOTO 90
1180 :REM'.....PRT
1190 KEY OFF:GOSUB 1260:LOCATE 25,5:COLOR 0,2
1200 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1210 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1220 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1220 :ELSE GOSUB 1260
1230 IF Z$="3"THEN RETURN
1240 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1250 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1190
1260 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
