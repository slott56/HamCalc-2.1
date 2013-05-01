10 :REM'RJD - HAMCALC ALGORTHMS BY R.J.DEHONEY - 21 JUL 08, rev. 14 JUN 2010
20 CLS:KEY OFF
30 IF EX$=" "THEN EX$="exit"
40 PROG$="\hamcalc\prog\rjd"
50 COMMON EX$,PROG$
60 DIM A$(60),B$(60)
70 LN=CSRLIN:PRINT
80 CLS
90 N=39 :REM'number of data   (must be an odd number)
100 DATA ANTSYN2,Antenna Matching Network
110 DATA AUDOSC,Audio Oscillator
120 DATA BATCHG,Battery Charger
130 DATA COAXLC3,Coax L/C Tank
140 DATA CAPVAL,Capacitor Measurer
150 DATA CATENARY,Sag in Horizontal wire
160 DATA CMOSC3,CMOS oscillator
170 DATA COILEQUA,Coil Equations
180 DATA COILNEW,Coil Calculator
190 DATA COILTAP,Coil Tap Properties
200 DATA COMFILT,Complementery Filters
210 DATA CONECALC,Cone Calculator
220 DATA COLPOSC,Colpitts Oscillator
230 DATA CPLRES,Filters Coax Stub
240 DATA CURVEFIT,Curve Fit Program
250 DATA DBLBRG4,2 Bridge Power Supply
260 DATA DUOPWR,Power Supply
270 DATA HARTOSC,Hartley Oscillator
280 DATA FILTUT,Filter Tutor
290 DATA GAPLOT,Capacitor Plate Design
300 DATA HUMID,Humidex Calculator
310 DATA IMPANT,Antenna Impedance
320 DATA INLOSS,Insertion Loss
330 DATA LADRSOLV,Ladder Networks
340 DATA LOSSY,SWR vs. Line Loss
350 DATA MATFILT,Matching filters
360 DATA MISMAT,Xmission Line Mismatch
370 DATA PAIRLT, Long-Tailed Pair
380 DATA PHAZDIFF,Phase Difference
390 DATA PULSEGEN,Pulse Generator
400 DATA PSUP,Power Supply Analyzer
410 DATA PSYCHROM,Thermodynamics
420 DATA PSUPERF,Power Supply Rating
430 DATA PULSEGEN,Pulse Generator
440 DATA RANDNUM,Random Numbers
450 DATA QMEAS, Q-L/C Tank circuit
460 DATA SINK,Heat Sink Fins
470 DATA TURNS,Coil Turns Calculator
480 DATA TRISQU,Wave Generator
490 DATA AUDOSC,Audio Programs
500 FOR Z=1 TO N:READ A$(Z),B$(Z):NEXT Z
510 FOR Z=1 TO N STEP 2:PRINT Z;A$(Z),B$(Z)TAB(40)Z+1;A$(Z+1),B$(Z+1):NEXT Z
520 :REM'PRINT
530 LOCATE 25,2:INPUT "ENTER a number to continue or 0 to exit";Z
540 IF Z=0 THEN SYSTEM
550 H$="\hamcalc\prog\"+A$(Z):CHAIN H$
560 GOTO 540
