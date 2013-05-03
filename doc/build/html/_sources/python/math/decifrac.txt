decifrac -- Decimal/Fraction Converter
----------------------------------------

Analysis
~~~~~~~~~~

Converting feet, inches and fractions to decimal feet is done as follows.

Given feet, :math:`f`, inch, :math:`i`, numerator, :math:`n`, denominator, :math:`d`, we can compute decimal feet, :math:`f_d`.

..  math::

    f_d  = f + \frac{i + \frac{n}{d}}{12} = f + \frac{id+n}{12d}

Converting the other way involves approximating the decimal fraction.

HamCalc uses 128ths; so we can develop an integer which is in 128ths of
an inch, via :math:`i_d = 12 \times 128 \times fd`. We can then
work out a foot, inch and fraction for this value.

..  math::

    n/d = \lfloor 12 \times 128 \times f_d \rfloor \mod 128 / 128

The :math:`n/d` fraction may get reduced to some smaller power of 2.

..  math::

    i = \lfloor 12 \times f_d \rfloor \mod 12

..  math::

    f = \lfloor f_d \rfloor

We can also do the entire thing in inches instead of feet.

..  math::

    i_d  = 12f + i + \frac{n}{d}

This doesn't change much, really.

Implementation
~~~~~~~~~~~~~~~

These are unit conversions.

..  automodule:: hamcalc.math.decifrac
    :members:

Legacy
~~~~~~~~

This program isn't really what it appears to be.

This is not **simple** decimals to fractions and fractions to decimals.

This is really about converting linear measurements in feet, inches and fractions to feet. And about converting decimal measuremnts of length
(inches, feet, mm, cm, meter) to feet, inches and fractions.

Sample Output
~~~~~~~~~~~~~~~~

::

     ENTER: number of whole feet................................? 13
    13'-
     ENTER: number of whole inches..............................? 3
    13'- 3
     ENTER: fraction enumerator (top number of fraction)........? 5
    13'- 3 5/
     ENTER: fraction denominator (bottom number of fraction)....? 8
    13'- 3 5/8"
     =  13.302 feet
     = 159.625 inches
     =   4.054 metres


