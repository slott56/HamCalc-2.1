elflash -- Electronic Flash
----------------------------

This is a **Solver** for electronic flash problems.

Legacy Output
~~~~~~~~~~~~~~~

::

     ENTER: Guide Number (metres)...............? 3
     ENTER: Subject distance (metres) ..........? 4
     Aperture ...................... ƒ/0.8
     Guide Number (metres) .........    3.0
     Guide Number (feet) ...........    9.8
     Subject distance (metres) .....    4.0
     Subject distance (feet) .......   13.1

     Use ƒ/1.4  ....................... 23.1 m. (  7.0 ft.)
     Use ƒ/2    ....................... 16.1 m. (  4.9 ft.)
     Use ƒ/2.8  ....................... 11.5 m. (  3.5 ft.)
     Use ƒ/4    .......................  8.1 m. (  2.5 ft.)
     Use ƒ/5.6  .......................  5.8 m. (  1.8 ft.)
     Use ƒ/8    .......................  4.0 m. (  1.2 ft.)
     Use ƒ/11   .......................  2.9 m. (  0.9 ft.)
     Use ƒ/16   .......................  2.0 m. (  0.6 ft.)
     Use ƒ/22   .......................  1.5 m. (  0.4 ft.)
     Use ƒ/32   .......................  1.0 m. (  0.3 ft.)
     Use ƒ/45   .......................  0.7 m. (  0.2 ft.)
     Use ƒ/64   .......................  0.5 m. (  0.2 ft.)


Analysis
~~~~~~~~~~

Variables

:F: Aperture, ƒ/
:G: Guide number in feet (:math:`0.3048G` metres)
:A: Film speed, ISO
:B: Beam Candle Power Seconds
:D: Subject distance in feet (:math:`0.3048D` metres)

Formulae

Part one is the Aperture, Guide Number, Subject distance
calculation.

..  math::

    F &= \dfrac{G}{D} \\
    D &= \dfrac{G}{F} \\
    G &= DF

Part two is Beam Candle Power Seconds, Film speed and Guide number

..  math::

    B &= \dfrac{20 G^2}{A} \\
    A &= \dfrac{20 G^2}{B} \\
    G &= \sqrt{ \dfrac{AB}{20} }

Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.audio_photo.elflash
    :members:

Quirk
~~~~~~~~

Input in metres first, if no input, then the prompt switches
to feet. Almost every other program prompts for the measurement
system first.

The relevant calculations are iterated four times.

The standard F-stops are listed in **DATA** instead of computed.

..  math::

    F = \left\lbrace (\sqrt 2)^P | 1 \leq P \leq 12 \right\rbrace

