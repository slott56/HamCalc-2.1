latlong -- Latitude/Longitude Data Base
----------------------------------------

Analysis
~~~~~~~~~~~

This is a tiny "wrapper" that chooses between :program:`pathfind` and
:program:`equiv`. It presents an introduction and a menu.

::

           LATITUDE and LONGITUDE DATA BASE

       Some HAMCALC programs ask you to enter the latitude and longitude
       of a location, usually your own QTH. The data base contains this
       information for many places in the world, and you may add, delete
       or edit the data at any time. Solar time zones (±UTC) are calculated
       automatically for each location.

       Enter data in decimal degrees - to the nearest 0.1 degree is close
       enough for most amateur radio applications. Enter data as follows:

       LATITUDE:  as Positive (+) values if NORTH of the equator
                  as Negative (-) values if SOUTH of the equator

       LONGITUDE: as Positive (+) values if EAST of Greenwich, England
                  as Negative (-) values if WEST of Greenwich, England

       If you wish to find the latitude and longitude of any location in
       the database, you need only enter the first few letters of a city,
       state or country and the program will display a list from which you
       may select the location of your choice.

However.

Inside :program:`pathfind`, we find this comment:

::

    10 :REM'PATHFIND - Combined GRCIRCL & LATLONG programs - 02 APR 92 rev. 17 APR 2010

And this code, too:

::

    4100 :REM'.....LATLONG - 20 NOV 85 rev. 12 FEB 94
    4110 CLS
    4120 IF FAR$<>""THEN 5410
    4130 COLOR 15,2
    4140 PRINT " LATITUDE & LONGITUDE Data Base";TAB(57);"by George Murphy VE3ERP ";

It appears that an earlier :program:`latlong` program was a simple database
manager and an earlier :program:`grcircl` program did the calculations
we now find in :program:`pathfind`.

Implementation
~~~~~~~~~~~~~~~~

Perhaps the right thing to do is to uncombine the :program:`latlong` program from the :program:`grcircl` program.

Perhaps we should make the lat-lon database update a stand-alone program.

We can easily import it into :program:`pathfind` or use it separately.
