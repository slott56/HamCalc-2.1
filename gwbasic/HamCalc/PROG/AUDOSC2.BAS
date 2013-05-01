10 :REM'AUDOSC2 - AUDIO OSCILLATOR-Dual Wave (LF353)
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 CLS
80 COLOR 15,2,1
90 PRINT " AUDIO OSCILLATOR-Dual Wave LF353"TAB(57)"by George Murphy VE3ERP ";
100 COLOR 1,0:PRINT STRING$(80,223);
110 COLOR 15,2:LOCATE CSRLIN-1,25:PRINT " Algorithm by R.J.Dehoney IEEE "
120 COLOR 7,0
130 :REM'.....diagram
140 COLOR 0,7
150 PRINT "                                                                   "
160 PRINT "       +DC                                      DC--5-12 volts     "
170 PRINT "        │  Square wave                          U1--LF353          "
180 PRINT "     ┌──┴──┐ Out, VS  ┌────C1─────┐             C1--.01uF          "
190 PRINT "   ┌─┤-    │  │       │  ┌─────┐  │             R1--120k           "
200 PRINT "   ╧ │ U1a ├──┴┬──R3──┴──┤+    │  │  Triangle   R2--100k           "
210 PRINT "   ┌─┤+    │   │         │ U1b ├─┬┴─ Wave Out   R3--1k to 100k pot "
220 PRINT "   │ └──┬──┘   R1      ┌─┤-    │ │      VT                         "
230 PRINT "   │   -DC     │       ╧ └─────┘ │                                 "
240 PRINT "   └───────────┴─────R2──────────┘                                 "
250 PRINT "                                                                   "
260 LN=CSRLIN+1
270 COLOR 7,0
280 PRINT " This program anaylyzes the two op amp square wave, triangle ";
290 PRINT "wave, generator."
300 LOCATE LN:PRINT :PRINT "..... Press 1 to continue or 0 to exit....."
310 COLOR 7,0,0
320 Z$=INKEY$:IF Z$=""THEN 320
330 IF Z$="0"THEN RUN EX$
340 IF Z$="1"THEN VIEW PRINT LN-1 TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 370
350 GOTO 320
360 :REM'.....calculate
370 R1=120000.0! :R2=100000.0! :C1=0.009999999776482582! :UF=9.999999974752427e-07! :C1=C1*UF
380 INPUT " ENTER: Frequency in Hz (minimum 300)";F:TT=1/F
390 IF F<300 THEN BEEP:GOTO 380
400 R3=TT/(4*C1*R2/R1)/1000:Z=CINT(R3*10)/10
410 PRINT:PRINT" For";F;"Hz set R3 at";Z;"k"
412 IF F>32767 THEN 440 :REM'GWBBASIC maximum
415 PRINT
420 PRINT " If you can hear as high as";F;"Hz then you just heard it!"
430 SOUND F,40:GOTO 440
440 PRINT :PRINT " .....Try another? (y/n)"
450 Y$=INKEY$:IF Y$=""THEN 450
460 IF Y$="y"THEN VIEW PRINT LN-1 TO 24:CLS:VIEW PRINT:LOCATE LN:GOTO 370
470 IF Y$="n"THEN 60
480 GOTO 450
