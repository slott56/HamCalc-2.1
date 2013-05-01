10 :REM'QSK Break-in module -16 DEC 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....start
70 PRINT ""
80 PRINT " +12v,DC» ────S1───┬────┐ K1n.o.──*┐+DC to transmitter"
90 PRINT "                  R1«┐  │ K1c.p.──*┘+DC from source"
100 PRINT "                   ├─┘  ├─┬─┤<┐"
110 PRINT "                  R2 ┌──┴─┴┐D1│K1"
120 PRINT " *──PTT line K2c.p.├─┤6 8 4│  │coil"
130 PRINT " *──PTT line K2n.o.├─┤7 U 2├──┴───*┐"
140 PRINT "           ┌>├──┬──│─┤3   5│       key"
150 PRINT "           │D2 K2  │ └┬───┬┘  ┌───*┘"
160 PRINT "           │  coil C2 │  C1   │"
170 PRINT " -12v.DC»  ╧    ╧  ╧  ╧   ╧   ╧"
180 PRINT ""
190 PRINT " PTT=    Push-to-Talk"
200 PRINT " n.o.=   relay normally open contact"
210 PRINT " c.p.=   relay centre pole contact"
220 PRINT " S1 =    SPST switch"
230 PRINT " K1,K2 = Reed relay Radio Shack #275-233"
240 PRINT " R1 =    10KΩ pot Radio Shack #271-234"
250 PRINT " U  =    555 timer"
260 PRINT " D1,S2 = 1N914 silicon diode"
270 PRINT " R2 =    4.7 KΩ resistor"
280 PRINT " C1 =    .01 µF disc ceramic capacitor"
290 PRINT " C2 =    10 µF electrolytic capacitor"
300 T=42
310 LOCATE +5,T:PRINT " ┌─────────────────────────────────────"
320 LOCATE +6,T:PRINT " │ This simple device fools you into"
330 LOCATE +7,T:PRINT " │ thinking your rig has full break-in"
340 LOCATE +8,T:PRINT " │ capabilities when it really hasn't."
350 LOCATE +9,T:PRINT " │ At the first tap of your key, four"
360 LOCATE 10,T:PRINT " │ things happen:"
370 LOCATE 11,T:PRINT " │ 1. K2 activates your PTT circuit."
380 LOCATE 12,T:PRINT " │ 2. U turns on, latching K2."
390 LOCATE 13,T:PRINT " │ 3. K1 keys your transmitter."
400 LOCATE 14,T:PRINT " │ 4. After pause set by R1 timer turns"
410 LOCATE 15,T:PRINT " │    off and rig returns to Receive."
420 LOCATE 16,T:PRINT " └─────────────────────────────────────"
430 LOCATE 22,T::PRINT "          QSK BREAK-IN MODULE"
440 LOCATE 23,T::PRINT "          ═══════════════════"
450 KEY OFF:GOSUB 520:LOCATE 25,5:COLOR 0,2
460 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
470 PRINT "(3)QUIT? (1/2/3)";:COLOR 7,0
480 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 480 :ELSE GOSUB 520
490 IF Z$="3"THEN CLS:RUN EX$
500 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
510 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 450
520 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
