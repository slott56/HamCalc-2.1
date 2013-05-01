10 :REM'RJD - HAMCALC ALGORTHMS BY R.J.DEHONEY - 21 JUL 08, rev. 08 JAN 2011
20 CLS:KEY OFF
30 IF EX$=" "THEN EX$="exit"
40 PROG$="\hamcalc\prog\rjd"
50 COMMON EX$,PROG$
60 DIM A$(60),B$(60)
70 LN=CSRLIN:PRINT
80 CLS
90 N=43 :REM'number of data   (must be an odd number)
100 DATA ANTSYN2,Antenna Matching Network
110 DATA AUDOSC,Audio Oscillator
120 DATA BATCHG,Battery Charger
130 DATA BRIDGE,W'stone Bridge #1
140 DATA BRIDGE-2,W'stone Bridge #2
150 DATA COAXLC3,Coax L/C Tank
160 DATA CAPVAL,Capacitor Measurer
170 DATA CATENARY,Sag in Horizontal wire
180 DATA CMOSC3,CMOS oscillator
190 DATA COILEQUA,Coil Equations
200 DATA COILNEW,Coil Calculator
210 DATA COILTAP,Coil Tap Properties
220 DATA COMFILT,Complementery Filters
230 DATA CONECALC,Cone Calculator
240 DATA COLPOSC,Colpitts Oscillator
250 DATA CPLRES,Filters Coax Stub
260 DATA CURVEFIT,Curve Fit Program
270 DATA DBLBRG4,2 Bridge Power Supply
275 DATA DBLFB,Double Feedback Amplifier
280 DATA DUOPWR,Power Supply
290 DATA HARTOSC3,Hartley Oscillator
300 DATA FILTUT,Filter Tutor
310 DATA GAPLOT,Capacitor Plate Design
320 DATA HUMID,Humidex Calculator
330 DATA IMPANT,Antenna Impedance
340 DATA INLOSS,Insertion Loss
350 DATA LADRSOLV,Ladder Networks
360 DATA LOSSY,SWR vs. Line Loss
370 DATA MATFILT,Matching filters
380 DATA MISMAT,Xmission Line Mismatch
390 DATA NOLOSS,Lossless L/C Circuits
400 DATA PAIRLT, Long-Tailed Pair
410 DATA PHAZDIFF,Phase Difference
420 DATA PULSEGEN,Pulse Generator
430 DATA PSUP,Power Supply Analyzer
440 DATA PSYCHROM,Thermodynamics
450 DATA PSUPERF,Power Supply Rating
460 DATA PULSEGEN,Pulse Generator
465 DATA PWRDIV,Power Divider
470 DATA RANDNUM,Random Numbers
480 DATA RCLOAD2,Matching in an R/C Load
490 DATA QFIND5, Q-L/C Tank Circuit
500 DATA SEPAQ,Series/Parallel/Q Ccts.
510 DATA SINK,Heat Sink Fins
520 DATA TFORM3,L/C Net w/o Xformers
530 DATA TURNS,Coil Turns Calculator
540 DATA TRISQU,Wave Generator
550 FOR Z=1 TO N:READ A$(Z),B$(Z):NEXT Z
560 FOR Z=1 TO N STEP 2:PRINT Z;A$(Z),B$(Z)TAB(40)Z+1;A$(Z+1),B$(Z+1):NEXT Z
570 LOCATE 25,2:INPUT "ENTER a number to continue or 0 to exit";Z
580 IF Z=0 THEN SYSTEM
590 H$="\hamcalc\prog\"+A$(Z):CHAIN H$
600 GOTO 580
