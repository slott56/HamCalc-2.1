decifrac -- Decimal/Fraction Converter
----------------------------------------

Analysis
~~~~~~~~~~

Converting feet, inches and fractions to decimal feet is simply this.

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

Implementation
~~~~~~~~~~~~~~~

These are unit conversions.



Legacy
~~~~~~~~

This program isn't really what it appears to be.

This is not simple dcimals to fractions and fractions to decimals.

This is really about converting linear measurements in feet, inches and fractions to feet. And about converting decimal measuremnts of length
(inches, feet, mm, cm, meter) to feet, inches and fractions.




