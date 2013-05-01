10 :REM'COAXCALC - characteristics calculator - 10 JAN 2000
20 CLS
30 IF EX$=""THEN EX$="EXIT"
40 IF PROG$=""THEN GO$=EX$ :ELSE GO$=EX$
50 COMMON EX$,PROG$
60 PRINT " Many coaxial cable equations stem from the dielectric constant Σ."
70 PRINT " Most published coaxial cable tables do not show this constant."
80 PRINT " Most published tabular data appear to be rounded off."
90 PRINT " The least rounding-off appears to be in the listed pF/ft. values."
100 PRINT " Using published values of impedance and pF/ft., this program comp";
110 PRINT "utes all"
120 PRINT " other values using equations on p.24-18, the ARRL Antenna Book, 1";
130 PRINT "8th edition."
140 PRINT
150 INPUT "INPUT: Nominal published characteristic impedance";Z
160 INPUT "INPUT: Published capacity (pF/ft.)";C
170 EC=0.10000000149011612!:N=0.10000000149011612!
180 EC=EC+N
190 EZ=((7.260000228881836!*EC*138)/(C*Z))^2
200 IF ABS(EC-EZ)<0.0010000000474974513! THEN 230
210 IF EZ>EC THEN EC=EC-N:N=N/10:GOTO 180
220 GOTO 180
230 D=EXP(7.260000228881836!*EC/C)   :REM'natural log
240 DD=10^(7.260000228881836!*EC/C)  :REM'log base 10
250 Z0=138/SQR(EC)*LOG(D)
260 PRINT " Re-calculated characteristic impedance (ohms)=";Z0
270 PRINT " Dielectric constant=";EC
280 PRINT " Velocity factor=";100/SQR(EC)/100
290 PRINT "CONSTANT: Capacity (pF/ft.)=";7.260000228881836!*EC/LOG(D)
300 PRINT " Inductance (uH/ft.)=";0.14000000059604645!*LOG(D)
310 PRINT " D/d ratio=";DD
320 INPUT "INPUT: OD of inner conductor (in.)";OD
330 ID=OD*DD
340 PRINT " Calculated ID of outer conductor (in.)=";ID
350 K=2   :REM'strand factor + braid factor
360 F=0.10000000149011612!
370 F=F*10
380 A=0.4350000023841858!/(Z0*ID)*(DD*K)*SQR(F)      :REM'+2.78*SQR(EC*F)
390 PRINT " Attenuation in dB/100 ft. at";F;" MHz=";A
400 IF F<=100 THEN 370
410 PRINT
420 PRINT "Assumed: Manufacturer's K1=1, K2=1.  Ignored: Power Factor effect."
430 GOSUB 450:CLS:CHAIN GO$
440 :REM'
450 :REM'PRT
460 GOSUB 530:LOCATE 25,18:COLOR 0,2
470 PRINT " Press #»▌1=Print▌2=Print/Form Feed▌3=Continue";:COLOR 7,0
480 COLOR 7,0
490 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 490 :ELSE GOSUB 530
500 IF Z$="3"THEN RETURN
510 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
520 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 460
530 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
