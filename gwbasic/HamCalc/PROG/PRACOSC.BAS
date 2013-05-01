10 :REM'PRACOSC - rjd's version of Code Oscillator - 14 JAN 2011
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " CODE PRACTICE OSCILLATOR"TAB(57)"by George Murphy VE3ERP ";
90 COLOR 7,0
100 PRINT
110 PRINT " ┌──S1──┬──┬─K1──R1────┬─R2─┐"
120 PRINT " │      │  │  ┌──U──┐  │    │"
130 PRINT " │      C1 ├──┤4   7├──┘    │"
140 PRINT " │      │  └──┤8   2├──┬────┤"
150 PRINT " │+     ├─C4──┤5   6├──┘    C3"
160 PRINT " │12vdc ├─────┤1   3├─R3─┐  │"
170 PRINT " │-     │     └─────┘    │  ╧"
180 PRINT " │      │                R4«────* audio"
190 PRINT " │      │                │  ┌───* out"
200 PRINT " ╧      ╧                ╧  ╧"
210 PRINT " ...the code dashes you are hearing are the tones this produces..."
220 PRINT " S1............ SPST switch"
230 PRINT " K1............ Telegraph key"
240 PRINT " U............. 555 CMOS timer"
250 PRINT " C1,C3,........ .01 µF capacitor"
260 PRINT " C4............ 0.1 µF capacitor"
270 PRINT " R1............ 6.8KΩ resistor"
280 PRINT " R2............ 75KΩ resistor"
290 PRINT " R3............ 22 KΩ resistor"
300 PRINT " R4............ 10 KΩ audio taper potentiometer"
310  HZ=1.4429999589920044!/0.009999999776482582!/(6.800000190734863!+2*75)*1000
320 FOR A=1 TO 12
330 SOUND HZ,3:SOUND 0,3:NEXT A
340 PRINT USING " Audio tone = ###.# Hz";HZ
350 GOSUB 360:RUN EX$
360 :REM'.....PRT
370 KEY OFF:GOSUB 440:LOCATE 25,5:COLOR 0,2
380 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
390 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
400 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 400 :ELSE GOSUB 440
410 IF Z$="3"THEN RETURN
420 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
430 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 370
440 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
