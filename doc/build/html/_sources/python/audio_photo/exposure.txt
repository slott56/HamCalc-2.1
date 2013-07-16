..  import:: <isomum.txt>

exposure -- Exposure Calculator
-------------------------------

Analysis
~~~~~~~~~~

This is three **Solver** objects, one for `camera`_ exposure,
one for `enlarger`_ exposures and one for `filter`_ exposure
correction.

Camera
^^^^^^^^^^

    "CAMERA EXPOSURES"

    :C: Footcandles (integer, rounded up)
    :I: Film Speed (ISO) (integer)
    :S: Exposure Time (fraction of 4000)
    :F: Aperture ƒ/ (power of :math:`\sqrt{2}`

    Given *C* and *I*, a table of values can be computed.

    Otherwise, these appear to be the relevant calculations
    for aperture and exposure.

    ..  math::

        \text{1380 } F &= \sqrt{CIS/20} \\
        \text{1390 } S &= \dfrac{20F^2}{CI} \\
        \text{1400 } C &= \dfrac{20F^2}{SI} \\
        \text{1410 } I &= \dfrac{20F^2}{CS} \\

    An additional calculation.

    :E: Exposure Value (EV)

    From the code.

    ..  math::

        E_v = \dfrac{ \log{(0.0512 C I)}}{ \log 2 } = \log_2{(0.0512 C I)}

    From http://en.wikipedia.org/wiki/Exposure_value

    ..  math::

        E_v = \log_2 \dfrac{F^2}{S}

    "EQUIVALENT EXPOSURES"

    This is two aperture-exposure tables that show F-stop values and exposure
    for standard F-stop and standard exposure times.

    ..  math::

        \left\lbrace \langle F=\sqrt{2}^P, S=20F^2/C/I \rangle | 1 \leq P \leq 12 \right\rbrace \\
        \left\lbrace \langle F=\sqrt{CIS/20}, S=4000/2^P \rangle | 1 \leq P \leq 12 \right\rbrace

    The exposure times, *S*, are actually tweaked slightly in three ranges.
    Here's one view.

    ..  math::

        \left\lbrace 4000/2^P | 1 \leq P < 6 \right\rbrace
        \bigcup \left\lbrace 3840/2^P | 6 \leq P < 9 \right\rbrace
        \bigcup \left\lbrace 4096/2^P | 9 \leq P < 13 \right\rbrace

    This can also be looked at as "pretty"
    rounding based on the range of the value.

    ..  math::

        S_r &= 4096/2^P \\
        S &= \begin{cases}
        \lfloor S_r \rfloor_{100} &\text{ if $1000 \leq F$ } \\
        \lfloor S_r \rfloor_{25} &\text{ if $100\leq F <1000$ } \\
        \lfloor S_r \rfloor_{15} &\text{ if $15 \leq F <100$ } \\
        \lfloor S_r \rfloor &\text{ if $F <15$ } \\
        \end{cases}

    We define this floor function as follows.

    ..  math::

        \left\lfloor S \right\rfloor_{n} = n \times \left\lfloor \dfrac{S}{n} \right\rfloor

Enlarger
^^^^^^^^

    "ENLARGER EXPOSURES"

    :F: Aperture ƒ/ (power of :math:`\sqrt{2}`
    :S: Exposure Time (fraction of 4000)
    :X: length
    :M: width
    :H_O: Original Lens height

    This use case is confusing, since it seems to ask for
    the same data twice. It could be that it's asking
    for an original exposure and then computing a revised
    enlargement from that original exposure description.

    It requests Aperture, *F*, Exposure Time, *S*, and
    image size information.

    Then it appears to request a new image size: either length of width.
    The other value will be computed from the initial size.

    Then it will request aperture or exposure. Again.
    And compute aperture from exposure or vice versa.
    This appears to be based on values of *Y* and *Q* computed
    from the initial exposure.

    :L: length of new image
    :W: width of new image

    ..  math::

        R &= M/X \\
        Q &= LW/M/X \\
        Y &= 4QS/F^2 \\
        & \begin{cases}
        S &= YF^2/4 \text{ if $F$ given}\\
        F &= 2\sqrt{\frac{S}{Y}} \text{ if $S$ given} \\
        \end{cases} \\
        H &= H_OW/X \text{ if $H_O$ given}

Filter
^^^^^^^^

    See http://en.wikipedia.org/wiki/Filter_factor

    "EXPOSURE FACTOR / FILTER FACTOR"

    :S: Exposure time (sec.) without factor
    :F: Aperture (ƒ/) without factor
    :X: Exposure / Filter factor (a multiplier)
        Typical values range from 1 to 16.
        A 75% filter is 1.3, for example.

    New exposure time, *S_f*, given the filter's factor:

    ..  math::

        S_f = \left\lceil \dfrac{1}{SX} \right\rceil

    New f-stop, *F_f*, given the filter's factor:

    ..  math::

        F_f = \sqrt{ \dfrac{F^2}{X} }

Implementation
~~~~~~~~~~~~~~~

..  automodule:: hamcalc.audio_photo.exposure
    :members:

Legacy Output
~~~~~~~~~~~~~~

::

       The exposures and apertures shown are mathematically correct but,
       due to the reciprocity failure characteristics of each particular
       film emulsion, unusually short (less than 1/1000 sec.) or very long
       (more than 5 sec.) indicated exposures may have to be increased by
       a factor of up to 3x. Unusually long or short exposures can also
       cause colour shifts in some colour films.

Quirks
~~~~~~~~

::

    2700 Z=INT(100*Z+0.5!)/100:RETURN
    2710 Z=INT(10*Z+0.5!)/10:RETURN
    2720 Z=INT(Z+0.5!):RETURN

Apparently, the ``CINT()`` function wasn't available for line 2720.

Also, the ``DEF FN`` statement wasn't used, either.

::

    1680 IF X*M<>0 THEN 1690
    1690 VIEW PRINT 5 TO 24:CLS:VIEW PRINT:LOCATE 5

L and W for desired length and width.
How about moving up one letter L |rarr| M, W |rarr| X for original length and width?
That seems sensible. L1 and W2 might be better, but M and X
would be fine. The quirk is that M became old width instead of X being used for old width.
