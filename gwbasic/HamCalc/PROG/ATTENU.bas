10 :REM'ATTENU - SWR vs. Attenuation loss vs.SWR   6 DEC 2003
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 PI=4*ATN(1)  :REM'3.141593
70 TP=2*3.1415927# :V0=3.2808399200439453!*300000000.0! :REM'ft/sec
80 TP=2*PI:V0=3.2808399200439453!*300000000.0! :REM'ft/sec
90 UL$=STRING$(80,205)
100 :REM'
110 :REM'.....title page
120 CLS
130 COLOR 15,2,1
140 PRINT " SWR vs. Attenuation"TAB(63)"by Robert DeHoney ";
150 COLOR 1,0:PRINT STRING$(80,223);
160 COLOR 7,0:REM'
170 :REM'
180 PRINT "This program proves that line attenuation can be found by measuring";
190 PRINT " the SWR of"
200 PRINT "line terminated in a short or open (or reactance). The program ";
210 PRINT "first asks for"
220 PRINT "SWR and line length, then finds the line loss in dB/100 ft."
230 PRINT
240 :REM'PRINT " Then, using that value of line loss, it asks for a load Z and solves for the ";
250 PRINT "Then, using that value of line loss, it asks for a load Z and ";
260 PRINT "solves for the"
270 PRINT "input SWR."
280 PRINT
290 PRINT "The program can also be used to show how loss reduces load SWR."
300 PRINT
310 COLOR 0,7
320 PRINT " To run program... press 1 "
330 PRINT " To EXIT.......... press 0 ":COLOR 7,0
340 Z$=INKEY$:IF Z$=""THEN 340
350 IF Z$= "0"THEN CHAIN GO$
360 IF Z$= "1"THEN 380
370 GOTO 340
380 :REM'.....start
390 COLOR 7,0,0
400 CLS:PRINT "SWR vs. Attenuatuion - by Robert DeHoney"
410 PRINT UL$;
420 TP=2*3.1415927# :V0=3.2808399200439453!*300000000.0! :REM'ft/sec
430 INPUT "ENTER:frequency (MHz)........................ ";F
440 INPUT "ENTER:Feeder Length (in feet).................";L
450 INPUT "ENTER:Line Velocity Factor (decimal)......... ";K
460 INPUT "ENTER:Line Characteristic impedance (ohms)... ";Z0
470 INPUT "ENTER:SWR of the shorted or open line........ ";SWR
480 ATT=LOG((SWR+1)/(SWR-1))/2/L :REM'nepers/foot
490 ATTDB=ATT*100/0.11509999632835388! :REM'dB/100ft
500 PRINT
510 U$=" Attenuation calculated from SWR is ##.### dB/100 ft."
520 COLOR 0,7:PRINT USING U$;ATTDB:COLOR 7,0
530 PRINT
540 INPUT "ENTER:Load Resistance (ohms)..............RL= ";R:R=R/Z0
550 INPUT "ENTER:Inductive Reactance (ohms)..........XL= ";X:X=X/Z0
560 BETA=TP*F/V0/K :GOSUB 650
570 A=R*HCR-X*HCI+HSR :B=X*HCR+R*HCI+HSI
580 C=HCR+R*HSR-X*HSI :D=HCI+X*HSR+R*HSI :GOSUB 690 :RIN=RE :XIN=IM
590 RC=SQR(((RIN-1)^2+XIN^2)/((RIN+1)^2+XIN^2))
600 SWR2=(1+RC)/(1-RC)
610 PRINT
620 U$=" SWR calculated from ZL and attenuation is ##.###:1"
630 COLOR 0,7:PRINT USING U$;SWR2:COLOR 7,0
640 PRINT :GOTO 720
650 :REM'        Subroutine to calculate hyperbolic functions
660 HS=(EXP(ATT*L)-EXP(-ATT*L))/2 :HC=(EXP(ATT*L)+EXP(-ATT*L))/2
670 HSR=COS(BETA*L)*HS :HSI=SIN(BETA*L)*HC
680 HCR=COS(BETA*L)*HC :HCI=SIN(BETA*L)*HS :RETURN
690 :REM'        Subroutine to calculate (a+jb)/(c+jd)
700 RE=(A*C+B*D)/(C^2+D^2) :IM=(B*C-A*D)/(C^2+D^2) :RETURN
710 END
720 :REM'....end
730  GOSUB 750:GOTO 110
740 :REM'
750 :REM'.....PRT
760 KEY OFF:GOSUB 830:LOCATE 25,5:COLOR 0,2
770 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
780 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
790 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 790 :ELSE GOSUB 830
800 IF Z$="3"THEN RETURN
810 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
820 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 760
830 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
