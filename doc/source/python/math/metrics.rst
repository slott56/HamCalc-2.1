..  _math.metrics:

metrics -- Metric Conversions
-------------------------------

See :ref:`math.equiv` for yet more of this kind of thing.

Analysis
~~~~~~~~~~

We have the following groups of units, rearranged and grouped.

Weight::

    990 DATA ounces(weight),grams,28.3495
    1000 DATA lb.,Kg(kilograms),.4535925
    1010 DATA short tons,tonnes,.907185
    1020 DATA long tons,tonnes,1.016047

ounce, pound, short ton, long ton

gram, kilogram, metric ton

Volume::

    1030 DATA fl.oz. (Impl.),ml,28.41167
    1040 DATA fl.oz. (U.S.),ml,29.57285
    1050 DATA pints  (Impl.),litres,.56823
    1060 DATA pints  (U.S.),litres,.47317
    1070 DATA quarts (Impl.),litres,1.13647
    1080 DATA quarts (U.S.),litres,.94633
    1090 DATA gallons(Impl.),litres,4.546092
    1100 DATA gallons(U.S.),litres,3.785412
    1190 DATA cu.in.,cu.cm.(c.c.),16.38706
    1200 DATA cu.in.,litres,.0163873
    1210 DATA cu.ft.,cu.metres,.02832
    1220 DATA cu.ft.,litres,28.317
    1230 DATA cu.yd.,cu.metres,.7646

fluid ounce (imperial), fluid ounce (US),
pint (imperial), pint (US),
quart (imperial), quart (US),
gallon (imperial), gallon (US),
cu. in., cu. ft., cu. yd

millilitre, litre, cu. cm, cu. metre

Length or Distance::

    1110 DATA inches,mm,25.4
    1120 DATA inches,cm,2.54
    1130 DATA feet,metres,.3048
    1140 DATA yards,metres,.9144
    1150 DATA miles,Km(kilometres),1.609347

inch, foot, yard, mile

mm, cm, metre, kilometre

Area::

    1160 DATA sq.in.,sq.cm,6.4516
    1170 DATA sq.ft.,sq.metres,.0929
    1180 DATA sq.yd.,sq.metres,.836
    1240 DATA Acres,Hectares,.4047

sq.in., sq.ft., sq.yd., acre

sq.cm., sq.metre, hectare

Pressure::

    1250 DATA P.S.I.,kPa(kilopascal),6.894757
    1260 DATA P.S.I.,MPa(megapascal),.006894757
    1270 DATA P.S.I.,bar,.068621
    1280 DATA lb/sq.in,Kg/sq.metre,.07030697
    1290 DATA lb/sq.ft,Kg/sq.metre,4.882429
    1360 DATA in.mercury,KPa,3.408024

PSI, lb/sq.in., lb/sq.ft., in.Hg

kPa, mPa, bar, Kg/sq.metre

Energy::

    1300 DATA ft/lb,BTU,778.26

ft/lb

BTU

Power::

    1310 DATA HP,kW(kilowatt),.7456999

Horsepower

Kilowatt

Force::

    1320 DATA lb.force,newtons,4.448222

lb.(force)

newton

Torque or Moment::

    1330 DATA lb/in,newton-metres,.1129848
    1340 DATA lb/ft,newton-metres,14.5939

lb/in, lb/ft

newton-metres

Temperature::

    1350 DATA fahrenheit,celsius,1

Note that line 1350 is a special case to handle temperatures.

The original use case is one-to-one conversions. This precluded
conversions within one system of measurement. It also eliminated
any combination not explicitly provided for.

We can slightly modify the use case to this:

1.  Picks a system (Imperial or Metric).

2.  Pick a unit from the master list.

3.  See that value in all other units of the relevant
    dimension (Weight, Volume, Length, Area,
    Presure, Energy, Power, Force, Torque or Temperature)

This is slightly different from the original user story,
but seems a bit simpler.

Legacy Output
~~~~~~~~~~~~~~

Introduction::

    METRIC CONVERTER                                            by George C. Murphy

      Press number in < > for desired conversion

      < 1 >  Imperial to Metric
      < 2 >  Metric to Imperial

      < 0 >  EXIT


ASCII art menu for the metric to imperial. The items are reversed for
imperial to metric. There are 38 conversions in two columns of 19.
Using just 19 pairs means tht the 80x24 screen is completely filled with
menu and introduction.

::


                                           │
    (a)  grams          to  ounces(weight) │(t)   sq.metres      to  sq.yd.
    (b)  Kg(kilograms)  to  lb.            │(u)   cu.cm.(c.c.)   to  cu.in.
    (c)  tonnes         to  short tons     │(v)   litres         to  cu.in.
    (d)  tonnes         to  long tons      │(w)   cu.metres      to  cu.ft.
    (e)  ml             to  fl.oz. (Impl.) │(x)   litres         to  cu.ft.
    (f)  ml             to  fl.oz. (U.S.)  │(y)   cu.metres      to  cu.yd.
    (g)  litres         to  pints  (Impl.) │(z)   Hectares       to  Acres
    (h)  litres         to  pints  (U.S.)  │(0)   kPa(kilopascal)to  P.S.I.
    (i)  litres         to  quarts (Impl.) │(1)   MPa(megapascal)to  P.S.I.
    (j)  litres         to  quarts (U.S.)  │(2)   bar            to  P.S.I.
    (k)  litres         to  gallons(Impl.) │(3)   Kg/sq.metre    to  lb/sq.in
    (l)  litres         to  gallons(U.S.)  │(4)   Kg/sq.metre    to  lb/sq.ft
    (m)  mm             to  inches         │(5)   BTU            to  ft/lb
    (n)  cm             to  inches         │(6)   kW(kilowatt)   to  HP
    (o)  metres         to  feet           │(7)   newtons        to  lb.force
    (p)  metres         to  yards          │(8)   newton-metres  to  lb/in
    (q)  Km(kilometres) to  miles          │(9)   newton-metres  to  lb/ft
    (r)  sq.cm          to  sq.in.         │(-)   celsius        to  fahrenheit
    (s)  sq.metres      to  sq.ft.         │(=)   KPa            to  in.mercury
                                           ╧

    Press character in ( ) for required conversion...

Implementation
~~~~~~~~~~~~~~

This gives us pause. We have units scattered all over the place.

-   :mod:`hamcalc.math.baromtr` - pressure

-   :mod:`hamcalc.math.centrif` - force and velocity

-   :mod:`hamcalc.math.decifrac` - distance

-   :mod:`hamcalc.math.equiv` - distance and temperature

-   :mod:`hamcalc.navigation.satorbit` - velocity

These involve a few duplicate definitions. Distance is the biggest
offender.

Rather than try to centralize all unit definitions, we'll just
throw more definitions into the mix.

..  automodule:: hamcalc.math.metrics
    :members:
