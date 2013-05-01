10 :REM'NOLOSS - 01 AUG 2010
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
50 COMMON EX$,PROG$
60 :REM'.....title page
70 COLOR 15,2
80 PRINT " LOSSLESS L/C CIRCUIT PARAMETERS"TAB(61)"by R.J.Dehoney IEEE ";
90 COLOR 7,0
100 :REM'.....start
110 LOCATE 3
120 PRINT "Circuit analysis programs often give the circuit's output voltage vs frequency."
130 PRINT "If the circuit being analysed contains only L's and C's, it can often  be"
140 PRINT "considered lossless. This is a collection of routines to find various"
150 PRINT "parameters of lossless L/C circuits. " :PRINT
160 PRINT "Press (1) to find the VSWR of the circuit given the source and load resistance, and the input and output voltages.":PRINT
180 PRINT "Press (2) to find the output voltage, given the source and load resistance,the source voltage and the VSWR.":PRINT
200 PRINT "Press (3) to find the maximum VSWR, given the minimum VSWR and the dB ripple." :PRINT
210 PRINT "Press (4) to find the dB ripple, given the maximum and minimum VSWR.":PRINT
220 PRINT "Press (5) to find the dB ripple, given the maximum and minimum output voltage.":PRINT
230 PRINT "Press (6) to find insertion loss, given the VSWR.":PRINT
240 PRINT "Press (0) to EXIT"
250 A$=INKEY$:IF A$=""OR VAL(A$)>6 THEN 250
260 IF A$="0"THEN CLS:RUN GO$
270 IF A$="1"THEN 330
280 IF A$="2"THEN 430
290 IF A$="3"THEN 510
300 IF A$="4"THEN 580
310 IF A$="5"THEN 660
320 IF A$="6"THEN 720
330 GOSUB 810:PRINT "------------------SWR GIVEN VS,VL,RS,RL-------------"
340 INPUT "Enter the source ohms= ",RS
350 INPUT "Enter the load ohms= ",RL
360 INPUT "Enter the input voltage= ",VS
370 VLMAX=VS/2*SQR(RL/RS)
380 INPUT "Enter the output voltage =",VL :IF VL=0 THEN 100
390 IF VL^2/RL>VS^2/4/RS THEN PRINT "Vout must be less than"VLMAX"volts"            :GOTO 380
400 PS=VS^2/4/RS :PL=VL^2/RL :PR=PS-PL :PRR=PR/PS :RHO=SQR(PRR)
410 SWR=(1+RHO)/(1-RHO)
420 PRINT "SWR= "SWR:GOTO 770
430 GOSUB 810:PRINT "-----------------Vout given RS,RL,VS,VSWR---------------"
440 INPUT "Enter the source ohms=. ",RS
450 INPUT "Enter the load ohms= ",RL
460 INPUT "Enter the input voltage= ",VS
470 INPUT "Enter VSWR= ",SWR :IF SWR=0 THEN 100
480 RHO=(SWR-1)/(SWR+1) :PF=1-RHO^2
490 VO=VS/2*SQR(PF*RL/RS)
500 PRINT "Vout="VO :GOTO 770
510 GOSUB 810:PRINT "-----------------maximum VSWR given minimum SWR and dB ripple------------"
520 INPUT "Enter minimum VSWR= ",SWR
530 INPUT "Enter dB ripple= ",RIP :IF RIP=0 THEN 100
540 RHO=(SWR-1)/(SWR+1) :PFMAX=1-RHO^2
550 K=10^(-RIP/10)
560 PFMIN=K*PFMAX :RHOMAX=SQR(1-PFMIN) :SWRMAX=(1+RHOMAX)/(1-RHOMAX)
570 PRINT "SWRmax="SWRMAX :GOTO 770
580 GOSUB 810:PRINT "--------------------ripple given VSWRs----------------------"
590 INPUT "Enter the Minimum VSWR= ",SWRMIN
600 IF SWRMIN=0 THEN 100
610 INPUT "Enter the Maximum VSWR ",SWRMAX
620 RHOMIN=(SWRMIN-1)/(SWRMIN+1) :POMAX=1-RHOMIN^2
630 RHOMAX=(SWRMAX-1)/(SWRMAX+1) :POMIN=1-RHOMAX^2
640 RIP=10*LOG(POMAX/POMIN)/LOG(10)
650 PRINT "Ripple="RIP"dB" :GOTO 770
660 GOSUB 810:PRINT "----------------ripple given output voltages--------------"
670 INPUT "Enter Minimum output voltage= ",VMIN
680 IF VMIN=0 THEN 100
690 INPUT "Enter Maximum output voltage= ",VMAX
700 RIP=20*LOG(VMAX/VMIN)/LOG(10)
710 PRINT "Ripple="RIP"dB" :GOTO 770
720 GOSUB 810:PRINT "-----------------insertion loss given VSWR----------------"
730 INPUT "Enter VSWR= ",VSWR
740 IF VSWR=0 THEN 100
750 RHO=(VSWR-1)/(VSWR+1) :PL=1-RHO^2 :IL=-10/LOG(10)*LOG(PL)
760 PRINT "Insertion Loss="IL"dB" :GOTO 770
770 :REM'.....end
780 LOCATE 24:PRINT ".....press any key....."
790 A$=INKEY$:IF A$=""THEN 790
800 CLS:GOTO 60
810 :REM'.....clear window
820 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3:RETURN
