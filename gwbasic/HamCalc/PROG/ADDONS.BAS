10 :REM'ADDONS - 04 DEC 2010
20 COMMON EX$
30 CLS
40 PRINT
50 COLOR 0,7
60 PRINT " HAMCALC & USB PRINTERS/64 bit OS":COLOR 7,0
70 PRINT
80 COLOR 12,0
90 PRINT " HAMCALC cannot drive printers connected to USB computer ports."
100 PRINT
110 COLOR 14
120 PRINT " However, software is available to correct this anomaly at <www.dos2usb.com>"
130 PRINT " for a free 15 day trial download of DOS2USB, which can become permanently "
140 PRINT " licensed for a nominal $19.99 fee."
150 PRINT
160 PRINT " Each time you run HAMCALC, run DOS2USB first, then run HAMCALC from within "
170 PRINT " DOS2USB."
180 PRINT
190 COLOR 14
200 PRINT " WINDOWS 7 and other 64 bit Operating Systems "
210 PRINT " may require running HamCalc from within DosBox, a free download available"
220 PRINT " at <www.dosbox.com>."
230 PRINT
240 COLOR 0,2
250 PRINT " Running HAMCALC in conjunction with DOS2USB and/or DosBox is recommended "
260 COLOR 7,0
270 PRINT
280 COLOR 12:PRINT" If you run HAMCALC alone your USB connected printer may not work! "
290 GOSUB 310:CLS:RUN"\hamcalc\menu\hcal"
300 :REM'
310 :REM'.....end
320 KEY OFF:GOSUB 390:LOCATE 25,5:COLOR 0,2
330 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
340 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
350 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 350 :ELSE GOSUB 390
360 IF Z$="3"THEN RETURN
370 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
380 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 320
390 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
