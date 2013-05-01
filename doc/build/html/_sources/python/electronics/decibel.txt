decibel -- Decibel Calculator
-------------------------------

Analysis
~~~~~~~~~~

The essential rule of decibels (dB) appears to be this.

..  math::

    dB = M \log_{10} \frac{f_s}{f_l}

Where M is either 10 or 20, depending on whether we're talking about
Power, Voltage or Current. Power uses 10. Voltage and Current use 20.

The value of :math:`f_s` is the "source" and :math:`f_l` is the "load".

We can solve this two other ways.

..  math::

    f_s = f_l \times 10^{dB/M}

..  math::

    f_l = f_s \times 10^{-dB/M}

The other half of the program is a kind of units conversion from
Volts, Watts or Amps to dBm.

    dBm with 1 mW/50Ω as reference (= 0 dBm)

In this case, the program does a simple units conversion among
nine source units and the dBm value.

This involves a magical constants.  0.2236 V, for example, is part of the
1 mW/50Ω calculation.

..  math::

    V = \sqrt{P \times R} = \sqrt{ 0.001 W \times 50 \Omega } = 0.2236 V

The legacy form depends on natural logarithms. :math:`20\log_{10}{e} = 8.685889638065037`, a constant that shows up the legacy program.

..  math::

    dBm = 20 \log_{10}{e} \times \ln{ \frac{A}{0.2236} }

Using base 10 logarithms:

..  math::

    dBm = 20 \log_{10} \frac{A}{0.2236}

Implementation
~~~~~~~~~~~~~~~

This is two closely-related three-variable **Solver** class definitions.

-   Power (uses M=10)

-   Voltage and Current (use M=20)

We can create a common superclass and three instances that are tailored
for the various detailed calculations.

There is also a set of nine units which can convert back and forth between
various scales of Volts, Amps and Watts to dBm.

..  automodule:: hamcalc.electronics.decibel
    :members:

Introduction
~~~~~~~~~~~~~~

Almost none, really.

Quirks
~~~~~~~~~

In option 2, the dBm calculation,
the flag for working with Power, in watts, is never reset. It's the ``P`` variable, set on lines 1360-1380. It is used on line 1590, but never reset for other units. Once you use Watts, any further attempt to use Volts or Amps produces wrong answers.

Sample Output 1
~~~~~~~~~~~~~~~

::

     DECIBEL CALCULATOR                                      by George Murphy VE3ERP
     Press number in < > to:

       <1>  Calculate unknown factor from two known factors.
            (factors: input value, output value, dB).

       <2>  Calculate dBm for any given value and dB change between a consecutive
            series of values.

       <0>  EXIT
       Press number in < > to select factor you want to FIND :

       POWER                      VOLTAGE                    CURRENT
       ─────                      ───────                    ───────
       <1> WATTS in (source)      <4> VOLTS in (source)      <7> CURRENT in (source)

       <2> WATTS out (load)       <5> VOLTS out (load)       <8> CURRENT out (load)
       <3> dB gain/loss           <6> dB gain/loss           <9> dB gain/loss

       <0> EXIT
        Input and Output values are expressed in the same unit of measurement.

     ENTER Voltage in (source):? 13.2
     ENTER Voltage out (load):? 12

            Voltage in (source):    13.200
            Voltage out (load):     12.000
            Voltage gain/loss:     -0.828 dB

Sample Output 2
~~~~~~~~~~~~~~~

::

     DECIBEL CALCULATOR                                         by Erik Madsen OZ8EM
     Edited for HAMCALC by George Murphy VE3ERP

     This program gives the level in dBm with 1 mW/50Ω as reference (= 0 dBm). It
     also gives the ratio in dB of consecutive voltage, current or power levels.

     Press number in < > to select:

     VOLTAGE:   <1> V
       (RMS)    <2> mV
                <3> µV

     CURRENT:   <4> A
       (RMS)    <5> mA
                <6> µA

     POWER:     <7> W
                <8> mW
                <9> µW

     EXIT       <0>
     ENTER: First value (V)? 12.36

             12.36 V =34.85 dBm
     ENTER: Next value (V)...(or 0 to Quit)? 13.4

             13.40 V =35.55 dBm:    12.36 V to  13.40 V = 0.70 dB
     ENTER: Next value (V)...(or 0 to Quit)? 14.2

              14.20 V =36.06 dBm:    13.40 V to  14.20 V = 0.50 dB
     ENTER: Next value (V)...(or 0 to Quit)?


