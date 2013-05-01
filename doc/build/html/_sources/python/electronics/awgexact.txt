awgexact -- AWG wire size calculator
--------------------------------------

Analysis
~~~~~~~~~

Apparently, it works like this.

..  math::

    G(n) = \frac{0.46}{K^n}

Gauges G(0) to G(3) are called "#0000", "#000", "#00" and "#0".

Gauges G(4) to G(43) are called "#1" to "#40".

The value *K* is the multiplier from one gauge to the next.

..  math::

    K = \left(\frac{0.46}{0.05}\right)^{\frac{1}{39}}

Note that gauges beyond 39 ("#36") are what make the math a little more complex.

For gauges 0 ("#0000") to 39 ("#36"), the formula is this.

..  math::

    G(n) = 0.005 \times K^n

For the smallest four gauges (40, 41, 42 and 43), that simple formula doesn't
work as cleanly. Therefore, the formula given above is generally correct for
all defined gauges.

Implementation
~~~~~~~~~~~~~~~~

This is a units conversion between AWG wire gauge units,
inches and millimeters.

If we define inches as the "standard" unit, then we have two other units
that must be converted.

We can throw in the AWG table as a generator function that simply converts
AWG gauges to inches for all values of AWG Gauge.

Note that the wire gauges are represented as strings.
We can't represent ``#0000`` gauge as an integer.
Further, some people write it as ``#0000`` as ``#4/0``.
Also, we have to consider the ``#`` as optional punctuation.

..  automodule:: hamcalc.electronics.awgexact
    :members:

Legacy Intro
~~~~~~~~~~~~

::

    In the A.W.G. system, each size is 1.122932 times
    the diameter of the next smaller size, based on an original
    concept of 40 sizes in arithmetic progression ranging from
    .460 in.(#0000) to .005 in.(#36).

Legacy Output
~~~~~~~~~~~~~~~~

::

    #0000= 0.4600000"
     # 000= 0.4096418"
     #  00= 0.3647966"
     #   0= 0.3248607"
     #  1 = 0.2892968"             # 15 = 0.0570682"             # 29 = 0.0112576"
     #  2 = 0.2576263"             # 16 = 0.0508207"             # 30 = 0.0100252"
     #  3 = 0.2294228"             # 17 = 0.0452571"             # 31 = 0.0089277"
     #  4 = 0.2043069"             # 18 = 0.0403027"             # 32 = 0.0079503"
     #  5 = 0.1819406"             # 19 = 0.0358905"             # 33 = 0.0070800"
     #  6 = 0.1620228"             # 20 = 0.0319615"             # 34 = 0.0063049"
     #  7 = 0.1442854"             # 21 = 0.0284625"             # 35 = 0.0056147"
     #  8 = 0.1284899"             # 22 = 0.0253466"             # 36 = 0.0050000"
     #  9 = 0.1144236"             # 23 = 0.0225718"             # 37 = 0.0044526"
     # 10 = 0.1018971"             # 24 = 0.0201008"             # 38 = 0.0039652"
     # 11 = 0.0907420"             # 25 = 0.0179002"             # 39 = 0.0035311"
     # 12 = 0.0808081"             # 26 = 0.0159406"             # 40 = 0.0031445"
     # 13 = 0.0719617"             # 27 = 0.0141955"
     # 14 = 0.0640837"             # 28 = 0.0126415"


