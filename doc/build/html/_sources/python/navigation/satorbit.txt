satorbit -- Satellite Orbit Parameters
----------------------------------------

Analysis
~~~~~~~~~~

The core issue here is to map orbital minutes to altitude.
Given minutes, *m*, we can compute a *z* factor and the
altitude, *h*.

..  math::

    Y = \left(\frac{144}{88}\right)^{1/16}

    z = \frac{\log m - \log 88}{\log Y} + 1

Where R is the radius of the earth, 3963.34 miles.

-   Altitude.  :math:`h = 100z`

-   radio horizon.

    ..  math::

        C = 2 \pi R

        X = \frac{R}{R+h}

        MR = \frac{\arccos X}{2 \pi} \times C

-   Apex angle of signal cone. :math:`2(90-\arccos X)`.

-   Diameter of area covered by signal cone. :math:`2 \times MR`.

-   Period. Input value, :math:`M`.

-   orbital speed. :math:`\frac{2 \pi (R+h)}{M}` miles per minute.

-   signal time. :math:`\frac{2h}{c}` where :math:`c` is the speed
    of light, here given as :math:`186 \times 10^3` miles per second.

-   Doppler shift. :math:`\frac{\lvert u-d \rvert}{20}`.


Implementation
~~~~~~~~~~~~~~

..  automodule:: hamcalc.navigation.satorbit
    :members:

Legacy Output
~~~~~~~~~~~~~~~

Some of these outputs are not correct; what's relevant is the format.

::

    ENTER: Period (time for single orbit) (87-157 min.) ? 94
        Satellite altitude...........................    314 miles
        Satellite signal map range (radio horizon)...      0 miles
        Apex angle of satellite signal cone..........    136°
        Diameter of area covered by signal cone......      0 miles
        Period (time for single orbit)...............     94 minutes
        Satellite orbital speed......................  17155 miles per hour
                                                    =      0 feet per sec.
        Up-and-Back signal time .....................      0.0034 sec.

        UPLINK frequency.............................     10.000 MHz
        DOWNLINK frequency...........................     11.000 MHz
        Approximate maximum Doppler shift............      0 KHz


Legacy Notes
~~~~~~~~~~~~~~~

Different from the introduction seen in so many HamCalc programs,
this program has "notes" at the end.

::

         The calculations used in this program were interpolated from
         graphs appearing on page 111 of the Electronics Data Book
         publication No. 27 of the ARRL. The results of these calculations
         are sufficiently accurate for fast reference purposes but may not
         be suitable for very accurate satellite tracking.

Legacy Quirks
~~~~~~~~~~~~~~~~

The calculation involves a set of approximations in a ``B`` array.

..  math::

    H = 144, L = 88, R_i = 100

    Y = \left(\frac{H}{L}\right)^{1/16}

For Y, the comment is "HI & LO 1600 miles apart on 100 mi.increment graph".

..  math::

    B_{z,1} = h_z = \lbrace R + R_i \times z \vert 1 \leq z < 21 \rbrace

    B_{z,2} = t_z = \left\lbrace \left(\frac{L}{Y}\right)Y^z \vert 1 \leq z < 21 \right\rbrace

    \left(\frac{L}{Y}\right)Y^z = LY^{z-1}

    B_{z,3} =  \lbrace h_z/t_z  \vert 1 \leq z < 21  \rbrace

The calculation of the altitude is :math:`h = J_6 \times M - R`, where :math:`J_6` is an interpolated value between :math:`B_{z,3} = h_z/t_z` and
:math:`B_{z-1,3} = h_{z-1}/t_{z-1}`.

It's not clear why the ``B`` array of values are computed in advance at
discrete intervals and then interpolated.
