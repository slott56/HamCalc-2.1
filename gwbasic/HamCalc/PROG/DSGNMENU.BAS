10 :REM'DSGNMENU - R/L/C/ Circuits Menu - 05 JUL 96 rev.11 APR 97
20 IF EX$=""THEN EX$="EXIT"
25 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
30 COMMON UL$,U$,PI,EX$,CKT$,T$,PROG$
40 CLS:KEY OFF:COLOR 7,0,1
50 UL$=STRING$(80,205)
60 U$="#####,###.###"
80 PI=3.1415929794311523!
90 :REM'
100 COLOR 15,2
110 PRINT " RESISTOR/INDUCTOR/CAPACITOR CIRCUIT DESIGN";
120 PRINT TAB(57);"by George Murphy VE3ERP ";
130 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
140 LOCATE 3:K=15:GOSUB 400
150 PRINT
160 PRINT " Press number in ( ) for:"
170 PRINT UL$;
180 PRINT "   (1) R/C Circuit Design"
190 PRINT "   (2) R/L Circuit Design"
200 PRINT "   (3) L/C Circuit Design"
210 PRINT "   (4) R/L/C Circuit Design"
220 PRINT
230 PRINT "   (0) EXIT";
240 LOCATE 16,31:PRINT "┌";STRING$(46,"─");"┐"
250 LOCATE 17,31:PRINT "│ This program is based on data presented in   │"
260 LOCATE 18,31:PRINT "╡ ";CHR$(34);"Programs for Electronic Circuit Design";
270 PRINT CHR$(34);" by  ╞"
280 LOCATE 19,31:PRINT "│ David Leithauser (Radio Shack Cat.# 62-1054) │"
290 LOCATE 20,31:PRINT "└";STRING$(46,"─");"┘"
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="0"THEN CLS:CHAIN GO$
320 IF Z$="1"THEN CLS:CKT$="RC":T$=" RESISTOR/CAPACITOR CIRCUITS":CHAIN"dsgnrc"
330 IF Z$="2"THEN CLS:CKT$="RL":T$=" RESISTOR/INDUCTOR CIRCUITS":CHAIN"dsgnrc"
340 IF Z$="3"THEN CLS:CKT$="LC":T$=" INDUCTOR/CAPACITOR CIRCUITS":CHAIN"dsgnrc"
350 IF Z$="4"THEN CLS:CKT$="RLC":CHAIN"dsgnrlc"
360 GOTO 300
370 :REM'
380 END
390 :REM'
400 :REM'.....R/C diagrams
410 COLOR 0,7
420 LOCATE ,K:PRINT "               ┌───R───┐                            "
430 LOCATE ,K:PRINT " »──R───C──»  »┤       ├»       R/C CIRCUITS        "
440 LOCATE ,K:PRINT "               └───C───┘                            "
450 LOCATE ,K:PRINT "               ┌───R───┐                            "
460 LOCATE ,K:PRINT " »──R───L──»  »┤       ├»       R/L CIRCUITS        "
470 LOCATE ,K:PRINT "               └───L───┘                            "
480 LOCATE ,K:PRINT "               ┌───L───┐                            "
490 LOCATE ,K:PRINT " »──L───C──»  »┤       ├»       L/C CIRCUITS        "
500 LOCATE ,K:PRINT "               └───C───┘                            "
510 LOCATE ,K:PRINT "               ┌───R───┐    ┌─R───L─┐    ┌─R───L─┐  "
520 LOCATE ,K:PRINT " »─R──L──C─»  »┼───L───┼»  »┤       ├»  »┤       ├» "
530 LOCATE ,K:PRINT "               └───C───┘    └───C───┘    └─R───C─┘  "
540 LOCATE ,K:PRINT "                                R/L/C CIRCUITS      "
550 COLOR 7,0
560 RETURN
