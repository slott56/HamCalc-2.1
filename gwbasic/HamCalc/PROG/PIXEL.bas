10 :REM'PIXEL - Pixel Calculator - 09 JUN 2002 rev. 12 DEC 2003
20 CLS:KEY OFF
30 IF EX$=""THEN EX$="EXIT"
40 COMMON EX$,PROG$
50 UL$=STRING$(80,205)
60 :REM'
70 :REM'.....title page
80 VIEW PRINT:CLS
90 COLOR 15,2,1
100 PRINT " PIXEL DATA for SCANNERS & DIGITAL CAMERAS";
110 PRINT TAB(57)"by George Murphy VE3ERP ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0
140 GOSUB 2290   :REM'title page
150 PRINT UL$;
160 :REM'
170 :REM'.....dimensions
180 COLOR 7,0
190 PRINT "  For dimensions in centimetres.... press 1 "
200 PRINT "  For dimensions in inches......... press 2"
210 PRINT "  To EXIT.......................... press 0"
220 Z$=INKEY$:IF Z$=""THEN 220
230 IF Z$="0"THEN COLOR 7,0,0:CLS:CHAIN EX$
240 IF Z$="1"THEN M=2.5399999618530273!:M$="cm.":GOTO 270
250 IF Z$="2"THEN M=1   :M$="in.":GOTO 270
260 GOTO 220
270 PRINT UL$;
280 PRINT "  For Scanners..................... press 3"
290 PRINT "  For Digital Cameras.............. press 4"
300 Z$=INKEY$:IF Z$=""THEN 300
310 IF Z$="3"THEN 350
320 IF Z$="4"THEN 1490
330 GOTO 300
340 :REM'
350 :REM'.....scanners
360 CLS
370 GOSUB 2930
380 COLOR 0,7:LOCATE 24,26:PRINT " Press any key to continue ";:COLOR 7,0
390 IF INKEY$=""THEN 390
400 CLS
410 PRINT
420 GOSUB 2410:GOSUB 2660   :REM'preface
430 COLOR 0,7:LOCATE 24,26:PRINT " Press any key to continue ";:COLOR 7,0
440 IF INKEY$=""THEN 440
450 SW=0:SH=0:SR=0:FW=0:FH=0:IW=0:IH=0:IR=0
460 CLS:COLOR 15,1,0:LOCATE CSRLIN,27
470 PRINT " SCANNER PIXEL CALCULATOR ":COLOR 7,0
480 PRINT UL$;
490 PRINT " Recommended End-Use image resolutions:"
500 GOSUB 2690
510 GOSUB 2790
520 PRINT UL$;
530 LN=CSRLIN
540 :REM'
550 :REM'.....data input
560 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
570 IF IR THEN 610
580 PRINT " ENTER: Desired End-Use Image Resolution (pixels per ";M$;")";
590 INPUT Z:IF Z=0 THEN LOCATE CSRLIN-1:GOTO 580
600 IR=CINT(Z*M)
610 IF SW THEN 650
620 PRINT "  (35mm film frames are 2.4 x 3.6 cm. (.945 x 1.42 in.)"
630 PRINT " ENTER: Width of area being scanned (";M$;")";
640 INPUT Z:SW=Z/M:IF Z=0 THEN LOCATE CSRLIN-1:GOTO 630
650 IF SH THEN 680
660 PRINT " ENTER: Height of area being scanned (";M$;")";
670 INPUT Z:SH=Z/M:IF Z=0 THEN LOCATE CSRLIN-1:GOTO 660
680 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
690 PRINT " Scanned area (";M$;") =";
700 PRINT USING " ##.## wide x ##.## high ";SW*M,SH*M
710 PRINT
720 IF IW THEN 760
730 IF SW*SH*IH<>0 THEN IW=SW/SH*IH:GOTO 760
740 PRINT " ENTER: End-Use Image Width (";M$;")";
750 INPUT Z:IW=Z/M
760 IF IH THEN 800
770 IF SW*SH*IW<>0 THEN IH=SH/SW*IW:GOTO 810
780 PRINT " ENTER: End-Use Image Height (";M$;")";
790 INPUT Z:IH=Z/M
800 IF SW*SH*IR*IW*IH<>0 THEN 830
810 GOTO 610
820 :REM'
830 :REM'.....calculate
840 FW=IW*IR      :REM'file width in pixels
850 FH=IH*IR      :REM'file height in pixels
860 FS=FW*FH      :REM'file size in pixels
870 SR=IW/SW*IR/M :REM'scan resolution
880 :REM'
890 :REM'.....display
900 VIEW PRINT 3 TO 24:CLS:VIEW PRINT:LOCATE 3
910 XX=SR/IR*M*100  :REM'% size change
920 COLOR 12
930 PRINT USING " File size.............. ######,### pixels";FS;
940 PRINT USING " (##.## MegaPixels )";FS*10^-6
950 COLOR 7
960 PRINT USING " File width............. ######,### pixels";FW
970 PRINT USING " File height............ ######,### pixels";FH
980 PRINT UL$;
990 PRINT USING " Scanned area width..... #######.## "+M$;SW*M
1000 PRINT USING " Scanned area height.... #######.## "+M$;SH*M
1010 COLOR 14
1020 PRINT USING " Scanner resolution..... ######,### pixels/"+M$;SR
1030 LOCATE CSRLIN-1,56:PRINT "Set scanner at this value";
1040 COLOR 7
1050 PRINT UL$;
1060 COLOR 0,7:LOCATE CSRLIN-1,1
1070 PRINT USING " Width/height ratio ##.##:1, re-sized @ ###.#% ";FW/FH,XX
1080 COLOR 7,0
1090 PRINT USING " Image width............ #######.## "+M$;IW*M
1100 PRINT USING " Image height........... #######.## "+M$;IH*M
1110 COLOR 10
1120 PRINT USING " Image resolution....... ######,### pixels/"+M$;IR/M;
1130 COLOR 7,0:PRINT TAB(56)USING "Pixel size... #.#### "+M$;1/(IR/M)
1140 PRINT UL$;
1150 LN=CSRLIN:COLOR 15,4
1160 LOCATE 3,67:PRINT " File size is "
1170 LOCATE 4,67:PRINT "  in pixels,  "
1180 LOCATE 5,67:PRINT "  NOT bytes!  "
1190 COLOR 7,0:LOCATE LN,1
1200 :REM'
1210 :REM'.....options
1220 T=28
1230 COLOR 15,1:LOCATE CSRLIN,28:PRINT " Press number in ( ) to: ":COLOR 7,0
1240 PRINT TAB(T)"(0) Quit"
1250 PRINT TAB(T)"(1) Change Scan Width"
1260 PRINT TAB(T)"(2) Change Scan Height"
1270 PRINT TAB(T)"(3) Change Scan Resolution"
1280 PRINT TAB(T)"(4) Change Image Width"
1290 PRINT TAB(T)"(5) Change Image Height"
1300 PRINT TAB(T)"(6) Change Image Resolution"
1310 Z$=INKEY$:IF Z$=""THEN 1310
1320 IF Z$="0"THEN VIEW PRINT 15 TO 24:CLS:VIEW PRINT:GOTO 3360
1330 IF Z$="1"THEN SW=0:IW=0:GOTO 630
1340 IF Z$="2"THEN SH=0:IH=0:GOTO 660
1350 IF Z$="3"THEN SR=0:GOTO 1400
1360 IF Z$="4"THEN IW=0:IH=0:GOTO 740
1370 IF Z$="5"THEN IH=0:IW=0:GOTO 780
1380 IF Z$="6"THEN IR=0:GOTO 580
1390 GOTO 1310
1400 PRINT " ENTER: Desired Scan Resolution (pixels per ";M$;")";:INPUT Z
1410 IF Z=0 THEN LOCATE CSRLIN-1:GOTO 1400
1420 SR=CINT(Z*M/M) :REM'scan resolution
1430 IR=SW/IW*SR*M  :REM'image resolution
1440 FW=SW*SR*M     :REM'file width in pixels
1450 FH=SH*SR*M     :REM'file height in pixels
1460 FS=FW*FH       :REM'file size in pixels
1470 GOTO 830
1480 :REM'
1490 :REM'.....cameras
1500 GOSUB 2930
1510 COLOR 0,7:LOCATE 24,26:PRINT " Press any key to continue ";:COLOR 7,0
1520 IF INKEY$=""THEN 1520
1530 CLS
1540 CW=0:CH=0:NP=0
1550 CLS:COLOR 15,1,0
1560 LOCATE ,21:PRINT " DIGITAL CAMERA/IMAGE SIZE CALCULATOR "
1570 COLOR 7,0:PRINT UL$;
1580 LOCATE CSRLIN-1,21:PRINT " Recommended End-Use image resolution "
1590 GOSUB 2690
1600 GOSUB 2790
1610 PRINT UL$;
1620 LN=13
1630 :REM'
1640 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
1650 IF NP THEN 1710
1660 :REM'PRINT UL$;
1670 COLOR 0,7:
1680 PRINT " ENTER: Desired resolution for end-use image, in pixels per ";M$;
1690 INPUT Z:COLOR 7,0:IF Z=0 THEN LOCATE CSRLIN-1:GOTO 1680
1700 NP=Z*M
1710 IF CW*CH <>0 THEN 2040
1720 COLOR 0,7
1730 PRINT " Press number in ( ) to select camera resolution setting:"
1740 COLOR 7,0
1750 PRINT "   (1)  320 x  240 pixels   (Size  QVGA - 0.08 MegaPixels)"
1760 PRINT "   (2)  640 x  480 pixels   (Size   VGA - 0.31 MegaPixels)"
1770 PRINT "   (3) 1024 x  768 pixels   (Size  XVGA - 0.79 MegaPixels)"
1780 PRINT "   (4) 1280 x  960 pixels   (Size SXVGA - 1.23 Megapixels)"
1790 PRINT "   (5) 1600 x 1200 pixels   (Size UXVGA - 1.92 Megapixels)"
1800 PRINT "   (6) 2000 x 1500 pixels   (           - 3.00 Megapixels)"
1810 PRINT "   (7) 2400 x 1800 pixels   (           - 4.32 Megapixels)"
1820 PRINT "   (8) 2800 x 2100 pixels   (           - 5.80 Megapixels)"
1830 PRINT "   (9) Other"
1840 Z$=INKEY$:IF Z$=""OR VAL(Z$)<1 OR VAL(Z$)>9 THEN 1840
1850 IF Z$="1"THEN CW=320:CH=240
1860 IF Z$="2"THEN CW=640:CH=460
1870 IF Z$="3"THEN CW=1024:CH=768
1880 IF Z$="6"THEN CW=2000:CH=1500
1890 IF Z$="9"THEN 1920
1900 IF Z$="4"THEN CW=1280:CH=960
1910 IF Z$="5"THEN CW=1600:CH=1200
1920 IF Z$="6"THEN CW=2000:CH=1500
1930 IF Z$="7"THEN CW=2400:CH=1800
1940 IF Z$="8"THEN CW=2800:CH=2100
1950 IF Z$="9"THEN 1970
1960 IF CW*CH THEN 2040 :ELSE 1840
1970 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN+2
1980 COLOR 0,7:PRINT " What is the camera resolution setting?":COLOR 7,0
1990 INPUT " ENTER: Width  (pixels) ";CW
2000 IF CW=0 THEN LOCATE CSRLIN-1:GOTO 1770
2010 INPUT " ENTER: Height (pixels) ";CH
2020 IF CH>CW THEN SWAP CH,CW
2030 :REM'
2040 VIEW PRINT LN TO 24:CLS:VIEW PRINT:LOCATE LN
2050 PRINT USING "   Camera resolution setting... #### x #### pixels";CW,CH
2060 IM=CW*CH
2070 PRINT USING "   Image size ................. #######,### pixels";IM;
2080 PRINT USING " (##.## MegaPixels )";IM*10^-6
2090 PRINT USING "   End-use image resolution.... ########### pix/"+M$;NP/M;
2100 PRINT TAB(56)USING "Pixel size... #.#### "+M$;1/(NP/M)
2110 PRINT USING "   End-use image width......... ########.## "+M$;CW/NP*M
2120 PRINT USING "   End-use image height........ ########.## "+M$;CH/NP*M
2130 PRINT " To change end-use image size change the camera resolution settin";
2140 PRINT "g, the end-use"
2150 PRINT " image resolution, or both."
2160 PRINT UL$;
2170 LIN=CSRLIN
2180 T=28
2190 COLOR 15,1:LOCATE LIN-1,28:PRINT " Press number in ( ) to: ":COLOR 7,0
2200 PRINT TAB(T)"(1) Change Camera Resolution Setting"
2210 PRINT TAB(T)"(2) Change End-Use Image Resolution"
2220 PRINT TAB(T)"(0) Quit";
2230 Z$=INKEY$:IF Z$=""THEN 2230
2240 IF Z$="0"THEN VIEW PRINT LIN TO 24:CLS:VIEW PRINT:GOTO 3360
2250 IF Z$="1"THEN CW=0:CH=0:GOTO 1640
2260 IF Z$="2"THEN NP=0:GOTO 1640
2270 GOTO 2230
2280 :REM'
2290 :REM'.....title page
2300 T=10
2310 PRINT TAB(T);
2320 PRINT "This program calculates optimum pixel (picture element) settings"
2330 PRINT TAB(T);
2340 PRINT "for scanners and digital cameras, to suit the size and intended"
2350 PRINT TAB(T);
2360 PRINT "end-use of the image produced from the area being scanned or"
2370 PRINT TAB(T);
2380 PRINT "photographed."
2390 RETURN
2400 :REM'
2410 :REM'.....preface
2420 PRINT " Many scanner software programs require the selection of scanner ";
2430 PRINT "resolution in "
2440 PRINT " pixels per unit of length before scanning begins. Optimum scanne";
2450 PRINT "r resolution  "
2460 PRINT " depends on the intended end use of the image being scanned."
2470 PRINT
2480 PRINT " Low resolutions produce small file sizes at the expense of image";
2490 PRINT " quality.     "
2500 PRINT
2510 PRINT " High resolutions produce excellent quality images at the expense";
2520 PRINT " of file size."
2530 PRINT
2540 PRINT " Extremely high resolutions do not appreciably improve image qual";
2550 PRINT "ity and build "
2560 PRINT " huge files that are impractical to edit, store and transmit elec";
2570 PRINT "tronically.   "
2580 PRINT
2590 PRINT " An appropriate scanner resolution setting can be computed by cor";
2600 PRINT "relating (a)  "
2610 PRINT " physical size of the area being scanned, (b) end-use image size,";
2620 PRINT " and (c) end- "
2630 PRINT " use image resolution. This program performs these calculations."
2640 PRINT
2650 RETURN
2660 PRINT " Typical recommended end-use image resolutions (in pixels per unit";
2670 PRINT " of length):"
2680 PRINT
2690 PRINT "   Monitor screen viewing";TAB(30);
2700 PRINT USING "#### - ### pix/cm. = ### - ### pix/in.";30,40,75,100
2710 PRINT "   Album prints";TAB(30);
2720 PRINT USING "#### - ### pix/cm. = ### - ### pix/in.";40,60,100,150
2730 PRINT "   Gallery prints";TAB(30);
2740 PRINT USING "#### - ### pix/cm. = ### - ### pix/in.";60,120,150,300
2750 PRINT "   Camera-ready artwork";TAB(30);
2760 PRINT USING "#### - ### pix/cm. = ### - ### pix/in.";120,235,300,600
2770 RETURN
2780 :REM'
2790 :REM'PRINT UL$;
2800 PRINT " If the image is to be printed on a digital printer, for best pri";
2810 PRINT "nt quality  "
2820 PRINT " the image pixels-per-";M$;" should not be less than the printer'";
2830 PRINT "s dots-per-";M$
2840 PRINT " resolution, and need not be much more, since quality will not in";
2850 PRINT "crease      "
2860 PRINT " accordingly. Prints made at DPI (Dots Per Inch) settings of abou";
2870 PRINT "t one half  "
2880 PRINT " the image pixels-per-inch resolution are often as acceptable as ";
2890 PRINT "maximum DPI "
2900 PRINT " prints at normal viewing distances."
2910 RETURN
2920 :REM'
2930 :REM'.....definition
2940 CLS
2950 PRINT " Resolution in Pixels vs. Dots-Per-Inch (DPI)"
2960 PRINT UL$;
2970 PRINT " These two terms are sometimes used interchangeably, but should n";
2980 PRINT "ot be, because"
2990 PRINT " they are quite different. Dots-per-inch refer only to a printer'";
3000 PRINT "s dot density,"
3010 PRINT " therefore all image file calculations should be done in pixels o";
3020 PRINT "nly. Dots-per-"
3030 PRINT " inch are relevant only when an image file is being downloaded to";
3040 PRINT " a printer.   "
3050 PRINT
3060 PRINT " Consider a pattern grid of squares in a craft book for either a ";
3070 PRINT "piece of      "
3080 PRINT " needlepoint or a hooked rug. In digital imagery terms each squar";
3090 PRINT "e represents a"
3100 PRINT " pixel (picture element) and the size of an image file is equal t";
3110 PRINT "o the number  "
3120 PRINT " of squares in the pattern, regardless of the physical size of th";
3130 PRINT "e pattern on  "
3140 PRINT " the page of the pattern book."
3150 PRINT
3160 PRINT " The pattern can be applied to a small needlepoint sampler, or a ";
3170 PRINT "large hooked  "
3180 PRINT " rug, on backing material sized to contain the same number and la";
3190 PRINT "yout of       "
3200 PRINT " squares as the pattern. The number of squares per inch on the fi";
3210 PRINT "nished craft  "
3220 PRINT " depends on its size, analogous to the dots-per-inch resolution o";
3230 PRINT "f a printer.  "
3240 PRINT
3250 PRINT " If your camera or scanner asks you for dots-per-inch in order to";
3260 PRINT " create an    "
3270 PRINT " image file, it really means pixels-per-inch. This program can co";
3280 PRINT "mpute an      "
3290 PRINT " appropriate pixels-per-inch value to suit the intended end-use o";
3300 PRINT "f the image   "
3310 PRINT " file. This value should be determined before starting each scan ";
3320 PRINT "or taking each"
3330 PRINT " photograph."
3340 RETURN
3350 :REM'
3360 :REM'.....end
3370 GOSUB 3390:GOTO 70
3380 :REM'
3390 :REM'PRT
3400 KEY OFF:GOSUB 3470:LOCATE 25,5:COLOR 0,2
3410 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
3420 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
3430 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 3430 :ELSE GOSUB 3470
3440 IF Z$="3"THEN RETURN
3450 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
3460 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 3400
3470 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
