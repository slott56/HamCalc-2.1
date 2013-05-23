pathfind -- Great Circle Paths & Distances
-------------------------------------------

And "Beam Heading".

Plus, apparently, a database of 535 international lat/lon coordinates in
:file:`"/hamcalc/latlong/LATLONG.DAT"`

Bonus. The original :program:`latlong` program that maintained a database
of latitude and longitude information

Analysis
~~~~~~~~~~~~~~~~~~~~~

There are several feature sets here.

1.  A database of international locations.

2.  A simple great-circle range-and-bearing calculation.

3.  A tabular display showing 11 intermediate points along
    the creat circle route.

International Locations
^^^^^^^^^^^^^^^^^^^^^^^^

This is seeded with 535 locations. There's a kind of text filter, as
well as a distance filter.

Also there's an add-change-delete functionality, too.

This includes some clever search capability for locating
a place by name or by location coordinates.

Range and Bearing
^^^^^^^^^^^^^^^^^^

This seems like the essential equations from :ref:`navigation.gridsq`
for range and bearing from latitude and longitude.

Great Circle Route
^^^^^^^^^^^^^^^^^^^

This seems like a matter of dividing the range into 12 segments,
each with the same bearing, and computing tese 11 intermediate positions
using :math:`r\times\frac{s}{12}`.

This requires the inverse calculation of end-point latitude
and longitude from starting point, range and bearing.

From Chris Veness we have this algorithm.

See http://www.movable-type.co.uk/scripts/latlong.html, |copy| 2002-2010 Chris Veness

Angular Distance, :math:`\alpha`.

..  math::

    \alpha = d / R

Latitude

..  math::

    lat_2 = lat_1 + \alpha \times cos(\theta)

..  math::

    \Delta\varphi = \ln \left[ \frac{\tan( lat_2 / 2 + \pi / 4 )}{\tan( lat_1 / 2 + \pi / 4 )} \right]

If this is an E:W line (i.e., :math:`\Delta \varphi \approx 0`):

..  math::

    q = \cos lat_1

Otherwise:

..  math::

    q = {\Delta lat} / {\Delta \varphi}

Longitude

..  math::

    \Delta lon = \alpha \times \frac{\sin{\theta}}{q}

..  math::

    lon_2 = [lon_1+\Delta lon+\pi \pmod {2 \pi} ] - \pi


where ln is natural log
:math:`\Delta lon` is taking shortest route (:math:`< 180 \textdegree`).

:math:`R` is the earth's mean radius: 6,371.009 km (3,958.761 mi; 3,440.069 nm).

Implementation
~~~~~~~~~~~~~~~~~~~~~

Yes. The name of the calculation module differs from the legacy application,
:program:`pathfind` and :program:`gridsq`.

The lot-long database management seems like it should be broken into two parts:

-   Search by regular expression, soundex or coordinate.
    This is a proper part of :program:`pathfind`.

-   Add-Change-Delete maintenance. This is a separate program.

The distinction, however, is not crystal clear. For example,
we can easily see a use case for adding a new location to the database
while  doing navigation calculations.

navigation.distance
^^^^^^^^^^^^^^^^^^^

..  automodule:: hamcalc.navigation.distance
    :members:
    :noindex:


Legacy Introduction
~~~~~~~~~~~~~~~~~~~~~~~~

::

     GREAT CIRCLE PATHS, BEARINGS and DISTANCES              by George Murphy VE3ERP
           This program calculates Great Circle paths, bearings and distances
           between any two points on earth, including those on or very close
           to the same meridian, the equator, or the earth's poles. Several
           intermediate points are also calculated as an aid in plotting the
           path on a flat chart or map drawn in any projection. Solar time
           difference between the two end points is also shown.

           Also included is a data base of over 500 locations that can be
           inserted into the program, and which can be edited by the user.

::

    NOTE:

    Enter latitude and longitude as decimal degrees, to the nearest 1/10th of a
    degree, e.g. 47.3 for 48°20'. If you enter data with more than one place of
    decimals the data entered will be used in all calculations, even though all
    data displayed will be rounded-off to the nearest 1/10th degree.

    1/10th of a degree longitude is equal to about 11 kilometres at the equator,
    less than 6 Km. at 60° latitude.


Legacy Output
~~~~~~~~~~~~~~

::

            Path between A  .....................................   38.0°N    76.0°W  Solar zone UTC-5
                      andB  .....................................   39.0°N    76.0°W
            Solar zone UTC-5
            Great Circle distance ( Naut.Miles )....     60.0
            Solar Time difference (hr:min)..........      0: 0
                         Bearing from A .........................      0.00°
                         Bearing from B .........................    180.00°

     To A                         INTERMEDIATE  PLOTS                        To B
       └─« Naut.Miles«─ Bearing«─ ┌── From Plot ──┐ ─»Bearing ─» Naut.Miles  »─┘
    ════════════════════════════════════════════════════════════════════════════════
     -1           0.0    180.0°  «─  38.9°N   76.0°W  ─»    0.0°        60.0
     0            0.0    180.0°  «─  38.8°N   76.0°W  ─»    0.0°        60.0
     1            0.0    180.0°  «─  38.8°N   76.0°W  ─»    0.0°        60.0 1/4 way

     2            0.0    180.0°  «─  38.7°N   76.0°W  ─»    0.0°        60.0 1/3 way

     3            0.0    180.0°  «─  38.6°N   76.0°W  ─»    0.0°        60.0
     4            0.0    180.0°  «─  38.5°N   76.0°W  ─»    0.0°        60.0 1/2 way

     5            0.0    180.0°  «─  38.4°N   76.0°W  ─»    0.0°        60.0
     6            0.0    180.0°  «─  38.3°N   76.0°W  ─»    0.0°        60.0 1/3 way

     7            0.0    180.0°  «─  38.3°N   76.0°W  ─»    0.0°        60.0 1/4 way

     8            0.0    180.0°  «─  38.2°N   76.0°W  ─»    0.0°        60.0
     9            0.0    180.0°  «─  38.1°N   76.0°W  ─»    0.0°        60.0


Quirks
~~~~~~~

Lines 4100-6890 is a :program:`latlon` program entirely embedded within
this great circle path-finding program.

This :program:`latlon` program is nothing like the version that's
available in HamCalc.
