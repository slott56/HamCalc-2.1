10 :REM'TRISQU - 22 APR 2010  12:12
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " DUAL OP AMP SQUARE & TRIANGLE WAVE GENERATOR"TAB(61)"by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....start
110 PRINT
120 PRINT " This program analyzes the dual op amp square wave & triangle wave generator."
130 PRINT " It asks you to enter a frequency, then prints out recommended circuit values."
140 PRINT " It then lets you enter the actual circuit values and calculates the frequency."
150 PRINT
160 GOSUB 260
170 PRINT
180 PRINT " Press <1> to run program ...............OR"
190 PRINT "       <2> to see Theory of Operation....OR"
200 PRINT "       <0> to EXIT"
210 A$=INKEY$ :IF A$=""THEN 210 :REM'ELSE IF A$="t" THEN 720
220 IF A$="1"THEN 380
230 IF A$="2"THEN 730
240 IF A$="0"THEN RUN GO$
250 GOTO 210
260 :REM'.....circuit diagram
270 COLOR 0,7
280 PRINT " Square Wave Out┐     U1 = LF353 Dual Op Amp   ════════════════════ "
290 PRINT "     ┌─────┐    │     ┌────C1─────┐            DUAL OP AMP SQUARE & "
300 PRINT " ┌───┤-    │    │     │  ┌─────┐  │            TRIANGLE WAVE        "
310 PRINT " ╧   │ U1a ├───┬┴─R3──┴──┤+    │  ├─ Triangle  GENERATOR            "
320 PRINT "   ┌─┤+    │   │         │ U1b ├──┤  Wave Out  ════════════════════ "
330 PRINT "   │ └─────┘   R1      ┌─┤-    │  │                                 "
340 PRINT "   │           │       ╧ └─────┘  │                                 "
350 PRINT "   └───────────┴──────R2──────────┘                                 "
360 COLOR 7,0
370 RETURN
380 :REM'.....calculate
390 CLS:GOSUB 260
400 PRINT " The circuit can tolerate a wide range of values for R3 which can then act as"
410 PRINT " a frequency control. 500 to 100k ohms will give a 200:1 frequency range."
420 PRINT
430 INPUT " ENTER Desired frequency (kHz) ";F :F=F*1000
440 R1=120000.0! :R2=100000.0! :C1=0.009999999776482582! :UF=9.999999974752427e-07! :C1=C1*UF :K=1000
450 R3=R1/4/C1/R2/F
460 LOCATE CSRLIN-1
470 PRINT USING " Desired Operating frequency..... ######.### kHz";F/K
480 PRINT USING " R1.............................. ######.### kΩ";R1/K
490 PRINT USING " R2.............................. ######.### kΩ";R2/K
500 PRINT USING " R3.............................. ######.### kΩ";R3/K
510 PRINT USING " C1.............................. ######.### µF";C1/UF
520 R1OLD=R1:R2OLD=R2
530 LN=CSRLIN
540 GOSUB 960   :REM'erase
550 COLOR 15:PRINT " Press number in < > to:":COLOR 7
560 PRINT " <0> Finish"
570 PRINT " <1> Change R1"
580 PRINT " <2> Change R2"
590 PRINT " <3> Change R3"
600 PRINT " <4> Change C1"
610 A$=INKEY$
620 IF A$="0"THEN GOSUB 960:GOTO 980
630 IF A$="1" THEN INPUT "Enter new value for R1 in kΩ";R1 :R1=R1*K:GOSUB 960:GOTO 690
640 IF A$="2" THEN INPUT "Enter new value for R2 in kΩ";R2 :R2=R2*K:GOSUB 960:GOTO 690
650 IF A$="3" THEN INPUT "Enter new value for R3 in kΩ";R3 :R3=R3*K:GOSUB 960:GOTO 690
660 IF A$="4" THEN INPUT "Enter new value for C1 in µF";C1 :C1=C1*UF:GOSUB 960:GOTO 690
670 IF R2>R1 THEN PRINT:COLOR 14,4:PRINT " *****R2 must be less than R1***** " :R1=R1OLD :R2=R2OLD :COLOR 7,0:GOTO 980
680 GOTO 610
690 CLS :GOSUB 260
700 F=R1/4/C1/R3/R2 :PRINT "F="F/K"kHz"
710 GOTO 460
720 :REM'
730 :REM'.....Theory of operation
740 CLS :PRINT "                 Theory of operation"
750 PRINT "Since the inverting input of U1b is grounded, the + input is at virtual"
760 PRINT "ground, thus the current through R3 and into C1 is simply VS/R3. When"
770 PRINT "VS is positive, VT goes negative as current flows out of C1 and, after T"
780 PRINT "seconds, has a value V0-VS/R3*T/C1, where V0 is the voltage when VS went"
790 PRINT "went positive. Current flows from VS to VT through R1 and R2. When I*R1=VS"
800 PRINT "the voltage at U1a's + input goes through zero and VS switches from + to -."
810 PRINT "At this instant, VT=-I*R2. Current now flows back through C1, and VT starts"
820 PRINT "to increase. When I*R1 again equals VS, U1a's input will go positive and VS"
830 PRINT "will switch positive. VT is equal to I*R2 at this instant. We can now find"
840 PRINT "T. For a good op amp with equal + and - supplies, VS+ will equal VS-, and I"
850 PRINT "charging will be the same as I discharging. This means VT will switch at"
860 PRINT "I*R2 and -I*R2, a total change of 2*I*R2. Thus, the change in VT due to"
870 PRINT "current flowing into or out of C1 which we know to be VS/R3*T/C1 must equal"
880 PRINT "2*I*R2 or, since I=VS/R1, VS/R3*T/C1=2*VS/R1*R2. VS cancels out, so"
890 PRINT "T=2*C1*R2*R3/R1 and the complete period TT = 2*T. One thing these formulas"
900 PRINT "don't take into account is the finite output limit of U1b. Since VT can't"
910 PRINT "exceed VS, R2 must be kept smaller than R1."
920 PRINT
930 PRINT ".....press any key....."
940 A$=INKEY$:IF A$=""THEN 940 :ELSE CLS:GOTO 60
950 :REM'
960 :REM'.....erase
970 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN:RETURN
980 :REM'.....end
990 GOSUB 1000:CLS:GOTO 60
1000 :REM'.....PRT
1010 KEY OFF:GOSUB 1080:LOCATE 25,5:COLOR 0,2
1020 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1030 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1040 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1040 :ELSE GOSUB 1080
1050 IF Z$="3"THEN RETURN
1060 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1070 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1010
1080 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
