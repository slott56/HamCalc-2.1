..  _`math.equiv`:

equiv -- Unit Conversions
----------------------------------

From the QuickTables menu, we see the following four labels for this program.

- Degrees to radians

- Equivalent values

- Radians to degrees

- Temperature

Analysis
~~~~~~~~~~

There are 14 entries on the :program:`equiv` menu. One is a referene to the :program:`deciconv` program. One is copy-and-paste from :program:`deciconv`.
Two are actually versions of one **Solver** that is the :program:`elecleng` program.
Nine of the remaining ten are pretty simple **Equivalents** conversions.
The tenth has a simple **Solver** in it.

Capacitance

    This is the conversion among the following units::

        960 U$(1)="Farads..............(F)":X(1)=1
        970 U$(2)="Microfarads........(µF)":X(2)=10^6
        980 U$(3)="Nanofarads.........(nF)":X(3)=10^9
        990 U$(4)="Picofarads.........(pF)":X(4)=10^12

Current

    This is the conversion among the following units::

        1170 U$(1)="Amperes.............(A)":X(1)=1
        1180 U$(2)="Milliamperes.......(mA)":X(2)=10^3
        1190 U$(3)="Microamperes.......(µA)":X(3)=10^6

Degrees / Minutes / Seconds

    See :ref:`math.deciconv`. This is copy-and-paste code
    that's very similar to :program:`deciconv`.

Degrees / Radians

    Here's the Radians to Degrees equation. Solve for :math:`d` or :math:`r`.

    ..  math::

        \frac{r}{\pi} = \frac{d}{180}

Frequencies/Wavelengths

    This is the conversion among the following units::

        1260 U$(1)="hertz..............(Hz)":X(1)=1
        1270 U$(2)="kilohertz.........(kHz)":X(2)=10^-3
        1280 U$(3)="megahertz.........(MHz)":X(3)=10^-6
        1290 U$(4)="gigahertz.........(GHz)":X(4)=10^-9
        1300 U$(5)="wavelength (metres)....":X(5)=999

    The "999" is code for the frequency-wavelength equivalence.
    This is actually a piece of a **Solver**.

    ..  math::

        c = \lambda \nu

    The speed of light is wavelength (km) times frequency (per second).

    The constant HamCalc uses is :math:`c=299792.458 \; km/s`.

Inductance

    This is the conversion among the following units::

        1060 U$(1)="Henrys..............(H)":X(1)=1
        1070 U$(2)="Millihenrys........(mH)":X(2)=10^3
        1080 U$(3)="Microhenrys........(µH)":X(3)=10^6
        1090 U$(4)="Nanohenrys.........(nH)":X(4)=10^9
        1100 U$(5)="Picohenrys.........(pH)":X(5)=10^12

Length / Distance

    This is the conversion among the following units::

        1370 U$(1)="Millimetres........(mm)":X(1)=10^3
        1380 U$(2)="Centimeters........(cm)":X(2)=10^2
        1390 U$(3)="Metres..............(m)":X(3)=1
        1400 U$(4)="Kilometres.........(km)":X(4)=0.001
        1410 U$(5)="Inches.............(in)":X(5)=39.370079
        1420 U$(6)="Feet...............(ft)":X(6)=39.370079/12
        1430 U$(7)="Miles..............(mi)":X(7)=39.370079/12/5280


Transmission Line Length

    See :ref:`electronics.elecleng`.

    Nothing like any of the other conversions. This is a **Solver**
    for Frequency, Length (physical), Length Electrical ("degrees") and
    Velocity Factor of the line.

    :L:
        Line length in feet

    :N:
        Line length, electrical, in degrees

    :F:
        Frequency

    :V:
        Velocity Factor

    ..  math::

        L = 984 \frac{V N}{360 F}

    ..  math::

        N = L F \frac{360}{984 V}

Resistance

    This is the conversion among the following units::

        1500 U$(1)="Ohms................(Ω)":X(1)=1
        1510 U$(2)="Kilohm.............(kΩ)":X(2)=10^-3
        1520 U$(3)="Megohm.............(MΩ)":X(3)=10^-6

Temperature

    This is the conversion among the following units::

        2420 U$(1)="Degrees Fahrenheit....."
        2430 U$(2)="Degrees Celsius........"

Time

    This is the conversion among the following units::

        2150 U$(1)="Seconds................":X(1)=1
        2160 U$(2)="Minutes................":X(2)=1/60
        2170 U$(3)="Hours..................":X(3)=1/3600
        2180 U$(4)="Days...................":X(4)=1/86400.0!
        2190 U$(5)="Weeks..................":X(5)=1/604800.0!
        2200 U$(6)="Years (365.25 days)....":X(6)=1/31557600.0#


Sexigesimal/decimal converter

    See :ref:`math.deciconv`.

Miles per imperial gallon / kilometres per litre

    This is the conversion among the following units::

        2950 PRINT " Is known factor (m)iles per imperial gallon or (k)ilometres ";
        2960 PRINT "per litre?  (m/k)"

        3020 IF Z$="m"THEN A=Z:B=Z*0.354:C=100/B:D=A/1.2
        3030 IF Z$="k"THEN A=Z:B=Z/0.354:C=100/A:D=B/1.2

Electrical length / Physical length

    See :ref:`electronics.elecleng`.

    This is more of the **Solver** shown above under **Transmission Line Length**.

    ::

        3190 PRINT " Is known length in (d)egrees, (i)nches, or (c)entimetres? (d/i/c)"

        3270 IF L$="d"THEN LD=L:LI=L*(32.8/F):LC=LI*2.54:GOTO 3300
        3280 IF L$="i"THEN LI=L:LC=LI*2.54:LD=LI/(32.8/F):GOTO 3300
        3290 IF L$="c"THEN LC=L:LI=LC/2.54:LD=LI/(32.8/F):GOTO 3300

        3310 PRINT USING " Frequency.......... ###.### MHz";F
        3320 PRINT USING " Electrical length.. ###.### deg.";LD
        3330 PRINT USING " Physical length.... ###.### in.";LI
        3340 PRINT USING "                .... ###.### cm.";LC

Implementation
~~~~~~~~~~~~~~~~

We can ignore the electical line length and sexagesimal conversions.
They're simply links to other programs.

..  automodule:: hamcalc.math.equiv
    :members:

Legacy Quirks
~~~~~~~~~~~~~~~

Having multiple paths to a given program (like :program:`deciconv`) is a minor quirk. It can be called good UI design to put popular things in places
where people will look for them.

The "copy-and-paste" repetition of **Degrees / Minutes / Seconds** is quirky.

The presence of the electrical line length solver in this program -- in two places -- seems silly, since there's a separate program that appears to do this.  See :ref:`electronics.elecleng`.

