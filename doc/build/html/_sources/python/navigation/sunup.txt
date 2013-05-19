..  _`navigation.sunup`:

sunup -- Sunrise, Sunset, Transit
------------------------------------

This shares a lot of code with :program:`seasons`.

This may have a lot to do with :program:`riseset`, also.

Analysis
~~~~~~~~~

Compute a number of sunrise-sunset values.

Here's an attempt at a step-by-step overview.

**250-370**.  Get Lat, Lon, and time zone.

**380-370**. Some offsets are computed.

-   SX = 60 (AST), to 120 (PST).
    Longitude is used as an estimator of SX for non-US timezones.

    ..  math:: SX = 15 \lfloor LO/15 \rfloor

-   MX, Deg. correction for std. meridian. :math:`MX = LO-SX`.
    Longitude minus time zone longitude.

-   MC, Hrs. correction for std. meridian. :math:`MC = MX/15`.
    15° = 1 hr.

-   MR, Rad equiv. of meridian correction. :math:`MR = MX \times \pi/180`

-   K, Days to degrees. :math:`360/365.2423` or :math:`360/366`.
    Neither of which are exactly correct. 365.2423 is mean solar year
    including leap and non-leap. It's either :math:`360/365.2423` across
    the board, or it's :math:`360/365` for non-leap and :math:`360/366`
    for leap.

**480-670**. A start date, end date, and increment in days is input, also.

**680-790**.  Screen formatting.

**800-810**. For a date, N, in the date range, compute the following:

**820**.  GOSUB 1320 to compute "long.of GP SUN & EQ TIME".

**1320-1440**.  This is a particularly complex (but accurate) Position of the Sun
    calculation. There are more simpler versions of this
    that are reasonably accurate.

    HamCalc Version

    **1330**.   NN is day of year.

    **1340**.   :math:`L_1 = (279.575012 + K \times NN) \times \pi/180`

    **1350**.   :math:`G_1 = (356.96701 + K \times NN) \times \pi/180`

    **1360**.   :math:`L_D = L_1+(1.916 \sin(G_1)+0.02 \sin(2 G_1)) \times \pi/180`

    Wikipedia "Position of Sun" Version.

    -   *n* is days since 1 Jan 2000. :math:`n = JD - 2451545.0`.

    -   Mean Longitude of the Sun. :math:`L = 280.460 + 0.9856474 n`.

    -   Mean anomaly of the Sun. :math:`g = 357.528 + 0.9856003 n`.

    -   Ecliptic Longitude. :math:`\lambda = L + 1.915 \sin g + 0.020 \sin 2g`.
        Convert to radians via :math:`\lambda \pi/180`.

    HamCalc calculation of Z and EL.

    **1370**.   :math:`D_L = 0.39782 \sin(L_D)`. :math:`0.39778850739794974 = sin(23.44^{\circ})`. Declination of Sun.

    **1380**.   :math:`Z = \arctan { \frac{D_L}{\sqrt{1-D_L^2}} }`.  This is an output. Equatorial Latitude of the sun, perhaps?

    **1390-1400**. This may be the Equation of Time to provide an offset
        between due south for local apparent noon and actual position.

        ..  math::

            e = -104.7 \sin( L_1 ) + 596.2 \sin( 2 L_1 ) + 4.3 \sin( 3 L_1 ) - 12.7

            EL= e \sin(4 L_1)-429.3 \cos (L_1)-2 \cos (2 L_1)+19.2 \cos(3 L_1)

        This is an output.  It's the time of transit, perhaps.

    **1410**.   :math:`ET=-EL/3600` -- Time (hours specifically)

    **1420**.   :math:`ED= 15 ET` -- Degrees (15° = 1 hr.)

    **1430**.   :math:`ER=ED \times \pi/180` -- Radians

**830-850**. Calculate Azimuth, ``T``, of noon sun.

    -   If LA (Latitude in radians) < Z:  Sun is N of observer.
        :math:`T = ED-MG+MX+0.5`.  Degrees - 0 + MX Correction + .5.
        ``MG`` defaults to zero.

    -   IF LA (Latitude in radians) >= Z: Sun is S of observer.
        :math:`T = 180-ED-MG-MX-0.5`.  Degrees - 0 + MX Correction + .5.
        ``MG`` defaults to zero.

    -   Compute T mod 360.

**860-950**.  Calculate Azimuth of sunrise, AZ.

**960-1050**.  Sunrise Time, R and string RT$.

**1060-1150**.  Sunset Time, S and string ST$.

**1160**.  Calculate Altitude, ``AL``, of noon sun.

    -   IF LA < Z: AL=FIX(90-(Z-LA)*RD-0.5!)

    -   IF LA >= Z: AL=(90-(LA-Z)*RD-0.5!)

    RD is :math:`180/\pi`, the radian to degree conversion.

**1170**.  Gosub 1460 to print date.

**1180-1190**.  RISE is sunrise azimuth, AZ.  SET is sunset azimuth, 360-RISE.

**1200-1270**.  Print various times.  S-R is hours of daylight.

Alternative Sunrise and Sunset
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See "Sunrise Equation" in Wikipedia.

http://en.wikipedia.org/wiki/Sunrise_equation

..  math::

    \cos \omega_0 = - \tan \phi \times \tan \delta

Where :math:`\omega_0` is hour angle at sunrise (or sunset), :math:`\phi` is the latitude and :math:`\delta` is the sun's declination.

The procedure is this.  It depends on :math:`l_w` is Longitude (west is positive) of the observer, which is reversed from many calculations where
East is positive.

**Calculate current Julian Cycle**

    ..  math::

        n^{*} = J_{date} - 2451545.0009 - \frac{l_w}{360 ^{\circ}}

        n = \lfloor n^{*} + \frac{1}{2} \rfloor

    Where :math:`J_{date}` is the Julian date, :math:`l_w` is Longitude (west is positive) of the observer.  *n* is Julian Cycle since Jan 1, 2000.

    Note that "west-is-positive" is backwards from many other calculations.

    Below, longitude is :math:`\lambda_o`.

**Approximate Solar Noon**

    ..  math::

        J^{*} = 2451545.0009 + \frac{l_w}{360^{\circ}} + n

    Where :math:`J^{*}` is an approximation of solar noon at :math:`l_w`.

**Solar Mean Anomaly**

    ..  math::

        M =  [ 357.5291 + 0.98560028 \times ( J^{*} - 2451545)] \mod 360

**Equation of Center**

    ..  math::

        C = 1.9148 \sin M + 0.0200 \sin 2M + 0.0003 \sin 3M

**Ecliptic Longitude**

    ..  math::

        \lambda = ( M + 102.9372 + C + 180 ) \mod 360

**Solar Transit**

    ..  math::

        J_{transit} = J^{*} + 0.0053 \sin M - 0.0069 \sin 2\lambda

    The Hour Angle for Solar Noon.

**Declination of the Sun**

    ..  math::

        \sin \delta = \sin \lambda \times \sin 23.45 ^{\circ}

        \sin 23.45^{\circ} = 0.3979486313076104

    Solve for :math:`\delta` to get declination of the sun.

**Hour Angle**

    This includes corrections for refraction and solar disk diameter.

    ..  math::

        \cos \omega_0 = \frac{ \sin(-0.83^{\circ}+d) - \sin \phi_o \times \sin \delta }{\cos \phi_o \times \cos \delta}

        \sin -0.83^{\circ} = -0.014485726138606464

    To correct for height of eye above the horizon, we apply the dip angle.

    ..  math::

        d &= \frac{-1.15^{\circ}\sqrt{h_f}}{60^{\circ}} \\
        d &= \frac{-2.076^{\circ}\sqrt{h_m}}{60^{\circ}}

    For height in feet, :math:`h_f`, or height in meters, :math:`h_m`.
    Assuming 10' above the horizon, this is -0.0606.

    Note that for celestial navigation sight reductions, this is
    computed as a positive number and subtracted from the observed height.

    Where :math:`\phi_o` is the latitude of the observer, north is positive.

    Solve for :math:`\omega_0` to get the hour angle.

**Sunset**

    ..  math::

        J_{set} &= 2451545.0009 + \frac{\omega_0+l_w}{360^{\circ}} + n + 0.0053 \sin M - 0.0069 \sin 2\lambda \\
        J_{rise} &= J_{transit} - ( J_{set} - J_{transit} )

Notes on Azimuth and Elevation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

See "Position of the Sun".

http://en.wikipedia.org/wiki/Position_of_the_Sun

To get the azimuth and elevation, we need to do a three-step operation.

1.  Calculate coordinates in Ecliptic Coordinates.

    This is essentially :math:`\lambda` above. The latitude, :math:`\beta = 0` for all practical purposes.

    However, the above calculation has longitude sense reversed.

2.  Convert to Equatorial: Right Ascension, :math:`\alpha`, and Declination, :math:`\delta`.

    ..  math::

        \epsilon &= 23.439^{\circ} - 0.0000004^{\circ} \times n \\
        \alpha &= \arctan (\cos \epsilon \tan \lambda) \\
        \delta &= \arcsin (\sin \epsilon \sin \lambda)

3.  Convert to Observer's Horizontal Coordinates to determine where to look in the sky. Specifically, the altitude, *a*, is

    ..  math::

        \sin a = \sin \phi_o \sin \delta + \cos \phi_o \cos \delta \cos \omega_0

    Where :math:`\phi_o` is observer's latitude, :math:`\delta` is declination,
    and :math:`\omega_0` is the Hour Angle.

    The Azimuth, *A*, is

    ..  math::

        \tan A = \frac{\sin \omega_0}{\cos \omega_0 \sin \phi_o - \tan \delta \cos \phi_o }

The NOAA Model
~~~~~~~~~~~~~~~~

See the NOAA Solar Calculation.

http://www.esrl.noaa.gov/gmd/grad/solcalc/calcdetails.html

Also, see http://www.esrl.noaa.gov/gmd/grad/solcalc/glossary.html

There are four inputs:

:phi_o:
    Latitude of observer in degrees.

:lambda_o:
    Longitude of the observer in degrees.

:z_o:
    GMT offset of the observer in hours.

:date:
    :class:`datetime.datetime` for which the sun's position is requested

The calculation works like this:

**F**.  Julian Day for requested date + time.

**G**.  Julian Century. :math:`(F-2451545)/36525`

**I**.  Geom Mean Long Sun (deg).

    ..  math::

        [280.46646+G(36000.76983+0.0003032 G)] \mod 360

**J**.  Geom Mean Anom Sun (deg).

    ..  math::

        357.52911+G(35999.05029-0.0001537 G)

**K**.  Eccent Earth Orbit.

    ..  math::

        0.016708634-G(0.000042037+0.0000001267 G)

**L**.  Sun Eq of Ctr.

    ..  math::

        &\sin J \times (1.914602-G(0.004817+0.000014 G))
        \\ + &\sin 2J \times (0.019993-0.000101 G)\\
        + &\sin 3J \times 0.000289

**M**.  Sun True Long (deg). :math:`I + L`

**N**.  Sun True Anom (deg). :math:`J + L`

**O**.  Sun Rad Vector (AUs).

    ..  math::

        \dfrac{(1.000001018(1-K^2))}{(1+K \cos N)}

**P**.  Sun App Long (deg).

    ..  math::

        M-0.00569-0.00478 \sin (125.04-1934.136 G)

**Q**.  Mean Obliq Ecliptic (deg).

    ..  math::

        23+\dfrac{26+\dfrac{21.448-G(46.815+G(0.00059-G0.001813))}{60}}{60}

**R**.  Obliq Corr (deg).

    :math:`Q+0.00256 \cos (125.04-1934.136 G)`

**S**.  Sun Rt Ascen (deg).

    ..  math::

        \arctan \frac{\cos R \sin P}{\cos P}

**T**.  Sun Declin (deg).

    ..  math::

        \arcsin (\sin R \sin P)

**U**.  var y. :math:`\tan^2 \frac{R}{2} = (\tan R/2)^2`

**V**.  Eq of Time (minutes).

    ..  math::

        4(U \sin 2I - 2K\sin J + 4KU \sin J \cos 2I - 0.5 U^2 \sin 4I - 1.25 K^2\sin 2J)

**W**.  HA Sunrise (deg).

    ..  math::

        \arccos (\frac{\cos 90.833^{\circ}}{\cos \phi_o \cos T} - \tan \phi_o \tan T )

    Latitude of observer is :math:`\phi_o`.

    Alternate form? This is used in the hour angle above, as well
    as the Stargazing version below, as well as the legacy HamCalc.

    ..  math::

        \delta = T

        \arccos (\frac{\sin -0.833^{\circ} - \sin \phi_o \sin \delta}{\cos \phi_o \cos \delta })

**X**.  Solar Noon (LST).

    ..  math::

        \frac{720 - 4 \lambda_o - V + 60 z_o}{1440}

    Longitude of the observer is :math:`\lambda_o`.
    Timezone offset from UTC is :math:`z_o`.

**Y**.	Sunrise Time (LST). :math:`X-\dfrac{4W}{1440}`

**Z**.	Sunset Time (LST). :math:`X+\dfrac{4W}{1440}`

**AA**.	Sunlight Duration (minutes). :math:`8W`

**AB**.	True Solar Time (min).

    :math:`(1440 E + V + 4 \lambda_o - 60 z_o) \mod 1440`

    Where :math:`z_o` is the timezone offset of the observer.
    In hours. :math:`E` is hours past midnight.

**AC**.	Hour Angle (deg).

    ..  math::

        \begin{cases}
        \dfrac{AB}{4}+180&  \text{if $\frac{AB}{4} < 0$}, \\
        \dfrac{AB}{4}-180&  \text{if $\frac{AB}{4} \geq 0$}.
        \end{cases}

**AD**.	Solar Zenith Angle (deg).

    :math:`\arccos (\sin \phi_o \sin T + \cos \phi_o \cos T \cos AC)`

**AE**.	Solar Elevation Angle (deg). :math:`90-AD`

**AF**.	Approx Atmospheric Refraction (deg)

    ..  math::

        \frac{1}{3600} \times
        \begin{cases}
        0& \text{if $AE > 85$} \\
        \dfrac{58.1}{\tan AE} - \dfrac{0.07}{(\tan AE)^3} + \dfrac{0.000086}{(\tan AE)^5}& \text{if $5 < AE \leq 85$} \\
        1735 + AE(-518.2+AE(103.4+AE(-12.79+0.711AE)))& \text{if $-0.575 < AE \leq 5$} \\
        \dfrac{-20.772}{\tan AE}& \text{if $AE < -0.575$}
        \end{cases}


**AG**.	Solar Elevation corrected for atm refraction (deg). :math:`AE+AF`.

**AH**.	Solar Azimuth Angle (deg cw from N)

    ..  math::

        \begin{cases}
        \arccos (\dfrac{\sin \phi_o \cos AD-\sin T}{\cos \phi_o \sin AD}) + 180  \mod 360 & \text{if $AC > 0$},\\
        [540 - \arccos (\dfrac{\sin \phi_o \cos AD - \sin T}{\cos \phi_o \sin AD})] \mod 360& \text{otherwise}
        \end{cases}

The Stargazing Model
~~~~~~~~~~~~~~~~~~~~~~~

http://www.stargazing.net/kepler/sunrise.html


Implementation
~~~~~~~~~~~~~~~~~

Yes. The name of the calculation module differs from the legacy applications,
:program:`sunup`, :program:`seasons` and :program:`riseset`.

This computes more than sunrise, and includes timezones for local time
conversion.

Sunrise
^^^^^^^^^^^

..  automodule:: hamcalc.navigation.sunrise
    :members:

sunrise.timezone
^^^^^^^^^^^^^^^^^^^

..  automodule:: hamcalc.navigation.sunrise.timezone
    :members:

Legacy Output
~~~~~~~~~~~~~~~~~

Input values include::

    Name of your location.......? ? Annapolis
    ENTER: Your latitude  (XX.X degrees, minus if SOUTH).....? 38.9
    ENTER: Your longitude (XX.X degrees, minus if EAST)......? 76.3
    Press number in ( ) to indicate your Time Zone:
     (1) Atlantic
     (2) Eastern
     (3) Central
     (4) Mountain
     (5) Pacific
     (6) Other
    ENTER: Year to be used in calculations (yyyy)............? 2013
    ENTER: First date? (No. of Month, Day)...................? 5, 1
    ENTER: Last date?  (No. of Month, Day)...................? 5, 20

Output Format::

                  Hours     Sunrise (EST)        Sunset (EST)        Elev.& Azimuth
                  of        and Azimuth          and Azimuth          of Noon Sun
       Date       Daylight   (degrees)            (degrees)            (degrees)

Legacy Quirks
~~~~~~~~~~~~~~

There's a lot of clearly irrelevant ``GOSUB 1600`` lines in this program. This is the middle of a routine from 1570 to 1640 to convert a date to a day number.

Variable ``MG`` is used in several equations, but never set.
