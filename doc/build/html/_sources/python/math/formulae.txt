formulae -- Formula Library
-----------------------------

..  note:: Legacy

    This program doesn't really **do** anything. It's just reference material
    cleverly typeset using available ASCII graphics and containing constants
    for standard (metric) as well as imperial units.

Antennas
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

HALF-WAVE FLAT-TOP ( 3-30 MHz )

    ..  math::  L_f = \frac{468}{f}

    ..  math:: L_m = \frac{143}{f}

    L_f = length in feet

    L_m = length in metres

    f = frequency in Mhz

FULL-WAVE LOOP (3-30 MHz )

    ..  math:: DRI_f = \frac{1005}{f}

    ..  math:: DRI_m = \frac{306.3}{f}

    ..  math:: REF = 1.025 \times DRI

    ..  math:: DIR = 0.970 \times DRI

    DRI_f = length of driven element in feet

    DRI_m = length of driven element in metres

    REF = length of reflector

    DIR = length of director

    f = frequency in MHz

FULL-SIZE VERTICAL

    ..  math:: L_f = \frac{234}{f}

    ..  math:: L_m = \frac{71.3}{f}

    L_f = length in feet

    L_m = length in metres

    f = frequency in Mhz

Capacitance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

CAPACITORS

    ..  math::

        C = \frac{0.2248 KA_i}{d_i}(n-1)

        C = \frac{0.0885 KA_m}{d_m}(n-1)

    C = capacitance in pF

    A_i = area of one side of one plate in square inches

    A_m = area of one side of one plate in square centimetres

    K = dielectric constant of material between plates

    d_i = separation of plates in inches

    d_m = separation of plates in cm.

    n = number of plates

COAXIAL CABLE

    ..  math::

        C_f = \frac{7.36 \epsilon}{\log \frac{D}{d}}

        C_m = \frac{24.147 \epsilon}{\log \frac{D}{d}}

    ε = dielectric constant

    C_f = capacitance in pF per foot

    C_m = capacitance in pF per metre

    D = ID of outer conductor

    d = OD of inner conductor

CYLINDRICAL VARIABLE CAPACITOR (ε=1 if air-spaced)

    ..  math::

        C_f = \frac{7.354 \epsilon}{\log \frac{D}{d}}

        C_m = \frac{24.127 \epsilon}{\log \frac{D}{d}}

    ε = dielectric constant

    C_f = capacitance in pF per foot

    C_m = capacitance in pF per metre

    D = ID of outer tube

    d = OD of inner conductor


Copper wire equations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    R_f = \frac{1.67}{(25.4a)^2}

    R_k = \frac{1}{.1822a^2}

R_f = ohms per 1000 feet

R_k = ohms per kilometre

a = radius of wire in decimal inches

..  math::

    D_i = \frac{0.46}{1.229^(n+3)}

    D_m = \frac{11.68}{1.229^(n+3)}

D_i = diameter in inches

D_m = diameter in millimetres

n = AWG number

..  math:: n = \frac{ \log \frac{0.46}{D} }{\log 1.1229}

D = diameter in inches

n = AWG

Decibels
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math:: dB = 10 \log \frac{P2}{P1}

P2 = output power

P1 = input power

..  math:: dB = 20 \log \frac{V2}{V1}

V2 = output voltage

V1 = input voltage

..  math:: dB = 20 \log \frac{I2}{I1}

I2 = output current

I1 = input current

Frequency
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math:: f = \frac{300}{w}

f = frequency in MHz

w = wavelength in metres

..  math:: f = \frac{10^6}{2\pi\sqrt{LC}}

f = frequency in kHz

L = inductance in µH

C = capacity in pF

π = 3.141593

..  math:: F_c = \sqrt{F_1F_2}

F1 = highest frequency

Fc = centre frequency

F2 = lowest frequency


Impedance (transmission lines)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

AIR-INSULATED PARALLEL CONDUCTOR LINE

    ..  math:: Z_o = 276 \log \frac{2S}{d}

    Zo = characteristic impedance

    S = c.c distance between conductors

    d = diameter of conductors ( S & d in same units)

AIR-INSULATED COAXIAL LINE

    ..  math:: Z_o = 138 \log \frac{b}{a}

    Zo = characteristic impedance

    b = ID of outer conductor

    a = OD of inner conductor ( b & a in same units)

ANY TRANSMISSION LINE

    ..  math:: Z_o = \sqrt{\frac{10^6L}{C}}

    Zo = characteristic impedance

    L = inductance (µH) per unit length

    C = capacitance (pF) per unit length


Inductance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SINGLE-LAYER AIR-CORE COIL

..  math::

    L = \frac{d_i^2n^2}{18d_i+40l_i}

    L = \frac{d_m^2n^2}{45.72d_m+101.6l_m}

L = inductance in µH

d_i = coil diameter in inches

d_m = coil diameter in cm

l_i = coil length in inches

l_m = coil length in cm

n = number of turns


..  math::

    n = \frac{\sqrt{L(18d_i+40l_i)}}{d_i}

    n = \frac{\sqrt{L(45.72d_m + 101.6l_m)}}{d_m}

Mathematics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

π = 3.141593

Circumference of circle = :math:`\pi \times d`

d = diameter

Area of circle = :math:`\pi \times r^2`

r = radius

As used in HAMCALC:
-  a METER is an apparatus for measuring (e.g voltmeter).
-  a METRE is a unit of measurement in the metric system.

::

 metres = feet x .3048      feet = metres ÷ .3048
 centimetres = in. x 2.54   inches = cm ÷ 2.54
 millimetres = in. x 25.4   inches = mm ÷ 25.4


Ohm's Law / Power
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OHM's LAW

    ..  math::

        E = I R

        I = \frac{E}{R}

        E = \frac{E}{I}

POWER

    ..  math::

        P = I E

        P = \frac{E^2}{R}

        P = I^2 R

P = power in watts

E = EMF in volts

I = current in amperes

R = resistance in ohms


Reactance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    X_L = 2\pi f L

    X_C = \frac{10^6}{2\pi f C}

X_L = inductive reactance in ohms

X_C = capacitive reactance in ohms

f = frequency in MHz

L = inductance in µH

C = capacitance in pF

π = 3.141593

SWR (STANDING WAVE RATIO)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    p = \sqrt \frac{P_r}{P_f}

    p = \frac{SWR-1}{SWR+1}

    SWR = \frac{1+p}{1-p}


p = reflection coefficient

Pr = reflected power

Pf = forward power

SWR = standing wave ratio



Transmission line physical vs. electrical length
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    L_f = \frac{983.56 V}{f}

    L_m = \frac{299.79 V}{f}

    V = \frac{1}{\sqrt{\epsilon}}

L_f = length (feet) of one wavelength

L_m = length (metres) of one wavelength

V = velocity factor (decimal value)

f = frequency in MHz

ε = dielectric constant



Shortened antenna physical vs. electrical length
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..  math::

    h_i = \frac{32.8L}{f}

    h_m = \frac{83.3L}{f}

h_i = length (inches)

h_m = length (centimetres)

L = electrical length (degrees)

f = frequency in MHz

