10 :REM'CURVEFIT - 27 SEP 2005
20 :REM'.....adapted from Bob Dehoney's "FITCURVE" program
30 CLS:KEY OFF
40 IF EX$=""THEN EX$="EXIT"
50 IF PROG$=""THEN GO$=EX$ :ELSE GO$=PROG$
60 COMMON EX$,PROG$
70 :REM'
80 :REM'.....title page
90 CLS
100 COLOR 15,2,1
110 PRINT " CURVEFIT"TAB(60)"by Robert J. Mahoney ";
120 COLOR 1,0:PRINT STRING$(80,223);
130 COLOR 7,0
140 :REM'
150 PRINT " This program uses a least squares procedure to find the constants in an"
160 PRINT " equation in the form Y=A+B*Z+C*Z^2+D*Z^3+E*Z^4 where Z=f(X) and X and Y"
170 PRINT " are data pairs. You are first asked to input the data pairs. A data pair"
180 PRINT " number is used so changes and corrections can be made. If an error is made"
190 PRINT " when entering the data pair number, enter <D> at the X prompt. After all the"
200 PRINT " data is entered, you are asked to select f(X). If, for instance, X covers"
210 PRINT " many more decades than Y, you might try Z=log(X). You are next asked what"
220 PRINT " degree of equation you want--for instance if you want Y=A+B*Z+C*Z^2, enter"
230 PRINT " <2>. Finally, you are asked to choose between procedures that minimize"
240 PRINT " relative or absolute error. If the Y data covers many orders of magnitude,"
250 PRINT " small errors at large Y will cause large errors at small Y when using the"
260 PRINT " absolute routine. If the Y data contains 0, the relative routine cannot"
270 PRINT " be used."
280 PRINT
290 PRINT " (In this program <CR> means 'Press ENTER')."
300 PRINT
310 COLOR 0,7
320 LOCATE ,24:PRINT " To run program......press <1> "
330 LOCATE ,24:PRINT " To exit.............press <0> "
340 COLOR 7,0,0
350 Z$=INKEY$:IF Z$="0"THEN CLS:RUN GO$
360 IF Z$="1"THEN CLS:GOTO 390
370 GOTO 350
380 :REM'
390 :REM'.....start
400 DEFDBL A-H,O-Z :DEFINT I-N
410 DIM X(30),Y(30),P(30),Z(30),YC(30)
420 CLS :FOR N=1 TO NMAX :IF P(N)=0 THEN P(N)=N
430 PRINT P(N);TAB(8);X(N);TAB(16);Y(N) :NEXT N
440 LOCATE 1,40 :PRINT "To correct an entry, enter its number"
450 LOCATE 2,40 :PRINT "After all values are correct, enter <CR>"
460 LOCATE 3,40 :PRINT "To delete an entry, enter its number then"
470 LOCATE 4,40 :PRINT "   enter the letter D as its X value."
480 LOCATE 10,40:INPUT "Enter data pair number or <CR> ",N: IF N=0 THEN 540
490 LOCATE 11,40 :INPUT "Enter X ",X$ :IF X$="D" THEN NMAX=NMAX-1 :GOTO 420         :ELSE X(N)=VAL(X$)
500 LOCATE 12,40 :INPUT "Enter Y ",Y(N)
510 P(N)=N
520 IF N>NMAX THEN NMAX=N
530 GOTO 420
540 IF NMAX<2 THEN CLS :LOCATE 10,10 :INPUT "There must be at least 2 sets of data points. Enter <CR> ",A$ :GOTO 420
550 PRINT :PRINT
560 PRINT "(1) Z=X  (2) Z=(X+K)^P  (3) Z=LOG(X+K)  (4) Z=EXP(X*K)"
570 INPUT "Enter number of desired relation ",Q :IF Q=0 OR Q>4 THEN 570 :ELSE ONQ GOSUB 1250,1260,1270,1280
580 INPUT "Choose order of polynomial (enter 1, 2, 3, or 4) ",NX :NS=NX+1
590 IF NX<1 OR NX>5 THEN 580
600 IF NS>NMAX THEN CLS :LOCATE 10,10 :INPUT "Insufficient data pairs. Press <CR> ",A$ :GOTO 420
610 PRINT "Enter 1 to minimize relative error, 2 to minimize absolute error,"
620 INPUT MX :IF MX<1 OR MX>2 THEN 610
630 ONMX GOSUB 1290,1480 :REM' calculate and load matrix values
640 FOR N=1 TO 5 :C1(N)=0 :NEXT N
650 GOSUB 820 :REM'find A,B,& C using Miller's prog, p74 in "Basic Prog for S & E"
660 XMIN=999999995904.0! :XMAX=-999999995904.0! :YMIN=999999995904.0! :YMAX=-999999995904.0!
670 CLS :PRINT "        X        Y data   Y calculated    Error   % Error"
680 FOR N=1 TO NMAX
690 YC(N)=C1(1)+C1(2)*Z(N)+C1(3)*Z(N)^2+C1(4)*Z(N)^3+C1(5)*Z(N)^4
700 EXX=YC(N)-Y(N) :IF Y(N)=0 THEN EXXPC$="N/A" :GOTO 720
710 EXXPC=INT(10000*EXX/Y(N))/100 :EXXPC$=STR$(EXXPC):IF EXXPC>100 THEN EXXPC$=">100"
720 IF X(N)>XMAX THEN XMAX=X(N)
730 IF X(N)<XMIN THEN XMIN=X(N)
740 :REM'IF Y(N)>YMAX THEN YMAX=Y(N)
750 :REM'IF Y(N)<YMIN THEN YMIN=Y(N)
760 PRINT USING"#######.### ";X(N);Y(N);YC(N);EXX;:PRINT "  ";EXXPC$
770 NEXT N:PRINT:REM'PRINT TAB(30);"Average % Error=";USING "##.###";EXXAVE! :PRINT
780 C1!=C1(1) :C2!=C1(2) :C3!=C1(3) :C4!=C1(4) :C5!=C1(5)
790 PRINT "  A="C1!"  B="C2!"  C="C3!"  D="C4!"  E="C5! :PRINT
800 INPUT "Change data? (<CR> or to plot,<P>) ",A$ :IF A$="" THEN GOSUB 1220 :ELSE IF A$="P"OR A$="p" THEN GOSUB 1610 :ELSE GOTO 10
810 END
820 :REM'Gauss-Jordan routine
830 N1=NS :N2=N1 :E1=0 :I5=1 :N3=1 :REM'   N1= # of simul eq
840 FOR I=1 TO N2 :FOR J=1 TO N2 :B(I,J)=A(I,J) :NEXT J
850 I2(I,3)=0 :NEXT I
860 D3=1
870 FOR I=1 TO N2 :B1=0 :FOR J=1 TO N2 :IF I2(J,3)=1 THEN 940
880 FOR K=1 TO N2
890 IF I2(K,3)>1 THEN 1190
900 IF I2(K,3)=1 THEN 930
910 IF B1>=ABS(B(J,K)) THEN 930
920 I3=J :I4=K :B1=ABS(B(J,K))
930 NEXT K
940 NEXT J
950 I2(I4,3)=I2(I4,3)+1 :I2(I,1)=I3 :I2(I,2)=I4
960 IF I3=I4 THEN 1000
970 D3=-D3 :FOR L=1 TO N2 :H1=B(I3,L) :B(I3,L)=B(I4,L) :B(I4,L)=H1 :NEXT L
980 IF N3<1 THEN 1000
990 FOR L=1 TO N3 :H1=W(I3,L) :W(I3,L)=W(I4,L) :W(I4,L)=H1 :NEXT L
1000 P1=B(I4,I4) :D3=D3*P1 :B(I4,I4)=1
1010 FOR L=1 TO N2 :B(I4,L)=B(I4,L)/P1 :NEXT  L
1020 IF N3<1 THEN 1040
1030 FOR L=1 TO N3 :W(I4,L)=W(I4,L)/P1 :NEXT L
1040 FOR L1=1 TO N2 :IF L1=I4 THEN 1080
1050 T=B(L1,I4) :B(L1,I4)=0
1060 FOR L=1 TO N2 :B(L1,L)=B(L1,L)-B(I4,L)*T :NEXT L :IF N3<1 THEN 1080
1070 FOR L=1 TO N3 :W(L1,L)=W(L1,L)-W(I4,L)*T :NEXT L
1080 NEXT L1 :NEXT I
1090 FOR I=1 TO N2 :L=N2-I+1 :IF I2(L,1)=I2(L,2) THEN 1120
1100 I3=I2(L,1) :I4=I2(L,2)
1110 FOR K=1 TO N2 :H1=B(K,I3) :B(K,I3)=B(K,I4) :B(K,I4)=H1 :NEXT K
1120 NEXT I
1130 FOR K=1 TO N2 :IF I2(K,3)<>1 THEN 1190
1140 NEXT K
1150 E1=0 :FOR I=1 TO N2 :C1(I)=W(I,1) :NEXT I :IF I5=1 THEN 1210
1160 FOR I=1 TO N2 :FOR J=1 TO N2 :PRINT B(I,J); NEXT J :PRINT :NEXT I :PRINT
1170 PRINT "Determinent="D3
1180 RETURN
1190 E1=1
1200 PRINT "Error--matrix singular" :INPUT "Press any key ",A$
1210 RETURN
1220 :REM'.........subroutine to clear arrays, etc
1230 FOR N=1 TO NS :C1(N)=0 :NEXT N :EXXT=0 :CLS :RETURN 420
1240 :REM'........subroutines to define Z(N)
1250 FOR N=1 TO NMAX :Z(N)=X(N) :NEXT N :RETURN
1260 INPUT "Enter K,P ",DD,PP :FOR N=1 TO NMAX :Z(N)=(X(N)+DD)^PP :NEXT N          :RETURN
1270 INPUT "Enter K ",DD :FOR N=1 TO NMAX :Z(N)=LOG(X(N)+DD) :NEXT N :RETURN
1280 INPUT "Enter K ",DD :FOR N=1 TO NMAX :Z(N)=EXP(X(N)*DD) :NEXT N :RETURN
1290 :REM'..........subroutine for minimizing relative error
1300 FOR N=1 TO NMAX :Z=Z(N) :Y=Y(N) : IF Y=0 THEN INPUT "Cannot use relative error routine if Y = 0. Press any key ",A$ :GOTO 420
1310 RY1=RY1+1/Y :RY2=RY2+1/Y^2 :RY1Z1=RY1Z1+Z/Y :RY1Z2=RY1Z2+Z^2/Y
1320 RY1Z3=RY1Z3+Z^3/Y :RY1Z4=RY1Z4+Z^4/Y :RY2Z1=RY2Z1+Z/Y^2
1330 RY2Z2=RY2Z2+Z^2/Y^2 :RY2Z3=RY2Z3+Z^3/Y^2 :RY2Z4=RY2Z4+Z^4/Y^2
1340 RY2Z5=RY2Z5+Z^5/Y^2 :RY2Z6=RY2Z6+Z^6/Y^2 :RY2Z7=RY2Z7+Z^7/Y^2
1350 RY2Z8=RY2Z8+Z^8/Y^2
1360 NEXT N
1370 :REM'........load matrix
1380 A(1,1)=RY2 :A(1,2)=RY2Z1 :A(1,3)=RY2Z2 :A(1,4)=RY2Z3 :A(1,5)=RY2Z4
1390 A(2,1)=RY2Z1 :A(2,2)=RY2Z2 :A(2,3)=RY2Z3 :A(2,4)=RY2Z4 :A(2,5)=RY2Z5
1400 A(3,1)=RY2Z2 :A(3,2)=RY2Z3 :A(3,3)=RY2Z4 :A(3,4)=RY2Z5 :A(3,5)=RY2Z6
1410 A(4,1)=RY2Z3 :A(4,2)=RY2Z4 :A(4,3)=RY2Z5 :A(4,4)=RY2Z6 :A(4,5)=RY2Z7
1420 A(5,1)=RY2Z4 :A(5,2)=RY2Z5 :A(5,3)=RY2Z6 :A(5,4)=RY2Z7 :A(5,5)=RY2Z8
1430 W(1,1)=RY1 :W(2,1)=RY1Z1 :W(3,1)=RY1Z2 :W(4,1)=RY1Z3 :W(5,1)=RY1Z4
1440 :REM'.............clear summations.......
1450 RY1=0 :RY2=0 :RY1Z1=0 :RY1Z2=0 :RY1Z3=0 :RY1Z4=0 :RY2Z1=0 :RY2Z2=0
1460 RY2Z3=0 :RY2Z4=0 :RY2Z5=0 :RY2Z6=0 :RY2Z7=0 :RY2Z8=0
1470 RETURN
1480 :REM'......subroutine for minimizing absolute error...........
1490 FOR N=1 TO NMAX :Z=Z(N) :Y=Y(N)
1500 Y1=Y1+Y :Z1=Z1+Z :Z2=Z2+Z^2 :Z3=Z3+Z^3 :Z4=Z4+Z^4 :Z5=Z5+Z^5 :Z6=Z6+Z^6
1510 Z7=Z7+Z^7 :Z8=Z8+Z^8 :Y1Z1=Y1Z1+Y*Z :Y1Z2=Y1Z2+Y*Z^2 :Y1Z3=Y1Z3+Y*Z^3
1520 Y1Z4=Y1Z4+Y*Z^4 :NEXT N
1530 :REM'.........load matrix
1540 A(1,1)=NMAX :A(1,2)=Z1 :A(1,3)=Z2 :A(1,4)=Z3 :A(1,5)=Z4 :W(1,1)=Y1
1550 A(2,1)=Z1 :A(2,2)=Z2 :A(2,3)=Z3 :A(2,4)=Z4 :A(2,5)=Z5 :W(2,1)=Y1Z1
1560 A(3,1)=Z2 :A(3,2)=Z3 :A(3,3)=Z4 :A(3,4)=Z5 :A(3,5)=Z6 :W(3,1)=Y1Z2
1570 A(4,1)=Z3 :A(4,2)=Z4 :A(4,3)=Z5 :A(4,4)=Z6 :A(4,5)=Z7 :W(4,1)=Y1Z3
1580 A(5,1)=Z4 :A(5,2)=Z5 :A(5,3)=Z6 :A(5,4)=Z7 :A(5,5)=Z8 :W(5,1)=Y1Z4
1590 Y1=0 :Z1=0 :Z2=0 :Z3=0 :Z4=0 :Z5=0 :Z6=0 :Z7=0 :Z8=0 :Y1Z1=0 :Y1Z2=0
1600 Y1Z3=0 :Y1Z4=0 :RETURN
1610 :REM'...............Graphing routine
1620 :REM'C1(1)=3 :C1(2)=8 :C1(3)=4 :XMIN=1 :XMAX=8 :YMIN=15 :YMAX=323
1630 E=10 :SCREEN 9 :WINXMIN=60 :WINXMAX=610 :WINYMIN=15 :WINYMAX=320
1640 LINE(WINXMIN,WINYMIN)-(WINXMAX,WINYMAX),,B
1650 DWINX=WINXMAX-WINXMIN :DWINY=WINYMAX-WINYMIN
1660 DX=XMAX-XMIN :GOSUB 1780 :DY=YMAX-YMIN
1670 FOR M=0 TO DWINX :X=XMIN+DX/DWINX*M :ONQ GOSUB 1880,1890,1900,1910
1680 Y=C1(1)+C1(2)*Z+C1(3)*Z^2+C1(4)*Z^3+C1(5)*Z^4
1690 XP=WINXMAX-E-(DWINX-2*E)/DX*(XMAX-X) :YP=WINYMIN+E+(DWINY-2*E)/DY*(YMAX-Y)
1700 PSET(XP,YP) :NEXT M :REM'draw curve
1710 FOR N=1 TO NMAX
1720 XP=WINXMAX-E-(DWINX-2*E)/DX*(XMAX-X(N))                                        :YP=WINYMIN+E+(DWINY-2*E)/DY*(YMAX-Y(N))
1730 CIRCLE(XP,YP),3 :NEXT N :REM'plot data points
1740 LOCATE 24,8 :PRINT XMIN :LOCATE 23,74 :PRINT XMAX :LOCATE 1,1
1750 LOCATE 23,45 :PRINT "X" :LOCATE 1,1
1760 LOCATE 22,1 :PRINT USING "##.##";YMIN :LOCATE 10,3 :PRINT "Y" :LOCATE 2,1       :PRINT USING "##.##";YMAX :REM' print scales
1770 LOCATE 24,1 :INPUT "Return <CR> or Quit <Q> ",A$ :IF A$="" THEN SCREEN 0        :GOTO 420 :ELSE SCREEN 0 :GOTO 10
1780 :REM'...........subroutine to find Ymax & Ymin
1790 FOR M=0 TO DWINX :X=XMIN+DX/DWINX*M :ONQ GOSUB 1880,1890,1900,1910
1800 Y=C1(1)+C1(2)*Z+C1(3)*Z^2+C1(4)*Z^3+C1(5)*Z^4
1810 IF Y>YMAX THEN YMAX=Y
1820 IF Y<YMIN THEN YMIN=Y
1830 NEXT M
1840 FOR N=1 TO NMAX :IF Y(N)>YMAX THEN YMAX=Y(N)
1850 IF Y(N)<YMIN THEN YMIN=Y(N)
1860 NEXT N :RETURN
1870 :REM'.............subroutine to define Z=f(X)
1880 Z=X :RETURN
1890 Z=(X+DD)^PP :RETURN
1900 Z=LOG(X+DD) :RETURN
1910 Z=EXP(X*DD) :RETURN
