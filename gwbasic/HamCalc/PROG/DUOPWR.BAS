10 :REM'DUOPWR - dual output power supply - 09 MAY 2008
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2
90 PRINT " POWER SUPPLY - DUAL OUTPUT"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 7,0
110 :REM'.....start
120 GOSUB 500
130 LN=CSRLIN
140 PRINT " This design by Robert J. Dehoney IEEE is for a power sypply with ";
150 PRINT "2 DC outlets,"
160 PRINT " one positive and the other negative."
170 PRINT
180 PRINT " Press 1 to continue or 0 to exit....."
190 Z$=INKEY$:IF Z$=""THEN 190
200 IF Z$="0"THEN CLS:RUN GO$
210 IF Z$="1"THEN GOSUB 620:GOTO 230
220 GOTO 200
230 :REM'.....data input
240 INPUT " ENTER: Desired voltage to RL1 and RL2";E
250 INPUT " ENTER: Current through RL1 (amps)";I1
260 GOSUB 620:       PRINT " V1 output.........";E"volts @"I1"amps         "
270 RL1=E/I1
280                  PRINT USING " Load RL1.......... #####.# ohms         ";RL1
290 INPUT " ENTER: Current through RL2 (amps)";I2
300 LOCATE CSRLIN-1: PRINT " V2 output.........";-E"volts @"I2"amps        "
310 RL2=E/I2
320                  PRINT USING " Load RL2.......... #####.# ohms         ";RL2
330 INPUT " ENTER: AC mains frequency (Hz)...";F
340 LOCATE CSRLIN-1: PRINT " AC mains frequency";F"Hz.                     "
350 INPUT " ENTER: V1 Ripple peak-to-peak volts";R1
360 LOCATE CSRLIN-1: PRINT USING " V1 P-to-P ripple.. #####.# volts        ";R1
370 C1=375*10^3*I1/F/R1
380                  PRINT USING " C1................ #####.# µF          ";C1
390 INPUT " ENTER: V2 Ripple peak-to-peak volts";R2
400 LOCATE CSRLIN-1: PRINT USING " V2 P-to-P ripple.. #####.# volts        ";R2
410 C4=375*10^3*I2/F/R2
420                  PRINT USING " C4................ #####.# µF          ";C4
430                  PRINT USING " C2................ #####.# µF          ";C4*5
440                  PRINT USING " C3................ #####.# µF          ";C4*5
450 TE=2+E/1.409999966621399! :TI=1.7999999523162842!*(I1+I2)
460                  PRINT USING " Transformer secondary: ####.# volts";TE;
470 PRINT USING " @ ##.# amps";TI
480 PRINT " Note: all capacitors are electrolytic.";
490 GOTO 650
500 :REM'.....diagram
510 COLOR 0,7:J=2
520 LOCATE ,J:PRINT  "                                                        "
530 LOCATE ,J:PRINT  "  ──)││(──────────┬───────────┤├─────────────┐          "
540 LOCATE ,J:PRINT  "    )││(          ├┤<───────┐+C2-┌────────┤<─┤          "
550 LOCATE ,J:PRINT  "    )││(          └>├─┐+C1- │    │ +C4- ┌─>├─┘          "
560 LOCATE ,J:PRINT  "    )││( + ┌» ┌───────┼─┤├──┼──┬─┼──┤├──┼────────┐ «┐ - "
570 LOCATE ,J:PRINT  "    )││(  V1 RL1  ┌>├─┘     │  ╧ │      └──>├─┐ RL2 V2  "
580 LOCATE ,J:PRINT  "    )││( ─ └» ╧   ├┤<───────┘+C3-└─────────┤<─┤  ╧ «┘ + "
590 LOCATE ,J:PRINT  "  ──)││(──────────┴───────────┤├──────────────┘         "
600 LOCATE ,J:PRINT  "                                                        "
610 COLOR 7,0:RETURN
620 :REM'.....clear screen
630 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
640 RETURN
650 :REM'.....end
660 GOSUB 670:GOTO 60
670 :REM'.....PRT
680 KEY OFF:GOSUB 750:LOCATE 25,5:COLOR 0,2
690 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
700 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
710 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 710 :ELSE GOSUB 750
720 IF Z$="3"THEN RETURN
730 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
740 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 680
750 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
