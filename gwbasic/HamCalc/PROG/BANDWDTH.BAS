10 :REM'BANDWDTH - 08 OCT 96 rev. 08 APR 97
20 IF EX$=""THEN EX$="EXIT"
30 CLS:KEY OFF
40 COLOR 7,0,0
50 UL$=STRING$(80,205)
60 U$="###.###"
70 M$="###.#"
80 X$=STRING$(80,32)
90 COLOR 15,2
100 PRINT " BANDWIDTHS";TAB(62);"by L.B.Cebik W4RNL ";
110 PRINT STRING$(80,32);
120 LOCATE CSRLIN-1,20:PRINT "Edited for HAMCALC by George Murphy VE3ERP";
130 COLOR 1,0:PRINT STRING$(80,223);:COLOR 7,0
140 :REM'
150 :REM'.....start
160 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
170 GOSUB 650   :REM'preface
180 PRINT
190 LOCATE ,24:COLOR 0,7
200 PRINT " Press 1 to RUN or 0 to EXIT....."
210 COLOR 7,0
220 Z$=INKEY$
230 IF Z$="1"THEN 260
240 IF Z$="0"THEN CLS:RUN EX$
250 GOTO 220
260 VIEW PRINT 4 TO 24:CLS:VIEW PRINT:LOCATE 4
270 INPUT " ENTER any frequency from 3 - 30 MHz....";F
280 IF F>30 OR F<3 THEN LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1:GOTO 270
290 LOCATE CSRLIN-1:PRINT X$;:LOCATE CSRLIN-1,16:COLOR 0,7
300 PRINT " Estimated 2:1 SWR bandwidth in kHz @";USING U$;F;:PRINT " MHz "
310 COLOR 7,0
320 PRINT " AWG ┌ Wire Size ┐┌─kHz┐";
330 PRINT TAB(25)"┌─ Range in Mhz─┐║";
340 PRINT TAB(43)"┌─ Tube Size ─┐┌─kHz┐";
350 PRINT TAB(64)"┌─ Range in Mhz─┐";
360 FOR J=34 TO 0 STEP -2
370 AWG$=MKS$(J):N=J:AWG=J
380 K#=(0.46000000834465027!/0.004999999888241291!)^(1/39):WIRE=0.46000000834465027!/K#^(N+3):DIA=WIRE
390 DIA2=DIA-((0.4343000054359436!*LOG(30/F))*(DIA/(2*(2.559999942779541!/DIA))))
400 BWBASE=(0.04690000042319298!+(((F/3)-1)*(0.011599999852478504!/9)))*F
410 BW=((SQR(DIA2))+0.8999999761581421!)*BWBASE
420 PRINT " #";USING "##";AWG;
430 PRINT USING " .###";WIRE;:PRINT CHR$(34);
440 PRINT USING M$;WIRE*25.399999618530273!;:PRINT "mm";
450 FL=(-BW+SQR(BW^2+4*F^2))/2:FH=FL+BW
460 PRINT USING "######";BW*10^3;
470 PRINT USING "####.### -";FL;:PRINT USING U$;FH
480 NEXT J
490 LOCATE 6
500 FOR J=0.375! TO 2.5! STEP 0.125!
510 DIA=J
520 DIA2=DIA-((0.4343000054359436!*LOG(30/F))*(DIA/(2*(2.559999942779541!/DIA))))
530 BWBASE=(0.04690000042319298!+(((F/3)-1)*(0.011599999852478504!/9)))*F
540 BW=((SQR(DIA2))+0.8999999761581421!)*BWBASE
550 LOCATE ,42
560 PRINT USING "║##.###";J;:PRINT CHR$(34);
570 PRINT USING M$;J*25.399999618530273!;:PRINT "mm";
580 FL=(-BW+SQR(BW^2+4*F^2))/2:FH=FL+BW
590 PRINT USING "######";BW*10^3;
600 PRINT USING "####.### -";FL;:PRINT USING U$;FH
610 NEXT J
620 GOSUB 1030:GOTO 150
630 END
640 :REM'
650 :REM'.....preface
660 T=7
670 PRINT TAB(T);
680 PRINT "This program estimates the 2:1 SWR bandwidth of halfwave dipoles"
690 PRINT TAB(T);
700 PRINT "for a range of common U.S. wire and tubing sizes. Computation is"
710 PRINT TAB(T);
720 PRINT "based on NEC models of lossless wire dipoles in free space with a"
730 PRINT TAB(T);
740 PRINT "feedpoint impedance of 72 ohms. No allowance is made for material"
750 PRINT TAB(T);
760 PRINT "losses, mismatches, or the antenna environment. Accuracy of the"
770 PRINT TAB(T);
780 PRINT TAB(T);
790 PRINT "displayed results averages 5%."
800 PRINT
810 PRINT TAB(T);
820 PRINT "The degree of accuracy of the program is of no concern, since real"
830 PRINT TAB(T);
840 PRINT "antenna systems will introduce large variations that no computation"
850 PRINT TAB(T);
860 PRINT "can account for in advance. Hence, the program is only for getting"
870 PRINT TAB(T);
880 PRINT "some reasonable expectations, not for predicting precise bandwidths."
890 PRINT
900 PRINT TAB(T);
910 PRINT "Bandwidths for conductor diameters other than those shown can be"
920 PRINT TAB(T);
930 PRINT "interpolated from the tabular data displayed."
940 PRINT
950 PRINT TAB(T);
960 PRINT "Bandwidth frequency ranges are shown to 3 decimal places as they"
970 PRINT TAB(T);
980 PRINT "might appear in a typical digital readout at the approximate"
990 PRINT TAB(T);
1000 PRINT "frequencies of the estimated 2:1 SWR bandwidth edges."
1010 RETURN
1020 :REM'
1030 :REM'PRT
1040 KEY OFF:GOSUB 1110:LOCATE 25,5:COLOR 0,2
1050 PRINT " Send this page to:(1)Printer Queue? (2)Printout? ";
1060 PRINT "(3)Next page? (1/2/3)";:COLOR 7,0
1070 Z$=INKEY$:IF Z$<"1"OR Z$>"3"THEN 1070 :ELSE GOSUB 1110
1080 IF Z$="3"THEN RETURN
1090 FOR I%=1 TO 24:FOR J%=1 TO 80:LPRINT CHR$(SCREEN(I%,J%));:NEXT J%:NEXT I%
1100 IF Z$="2"THEN LPRINT CHR$(12) :ELSE 1040
1110 LOCATE 25,1:PRINT STRING$(80,32);:RETURN
