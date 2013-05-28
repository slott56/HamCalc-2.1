timezone -- Time Zones (UTC)
----------------------------------------

Analysis
~~~~~~~~~~~~~

This appears to calculate a few things.

1.  The center of a 15°-wide hypothetical time zone.

2.  The UTC offset for this timezone.

3.  A reference time which is offset for each timezone.

It has a small database of 24 locations, one per timezone.

Implementation
~~~~~~~~~~~~~~~

There's no core calculation of real interest.

This is just a small program in the :mod:`hamcalc.stdio` package.

Legacy Output
~~~~~~~~~~~~~~~

Introduction

::

    TIME ZONES (Universal Co-Ordinated Time)                by George Murphy VE3ERP

       TIMES SHOWN ARE LOCAL SIDEREAL (SOLAR) TIMES. Not all countries or
       areas follow the International Time Zone System, but will use the
       time of some principal city as a standard or will have no standard
       time at all. In some areas or on groups of islands the system is
       applied with certain local deviations made necessary by frontiers
       to permit an entire island group to have the same time zone.
         The actual time used in each area, whether it is the time of the
       corresponding zone or modified time, is fixed by law and is called
       legal time, or more generally, standard time. Another deviation is
       that certain areas, for economic reasons, modify their legal time
       for part of the year (especially in summer) by advancing it an hour
       or another fraction of time (e.g., Daylight Saving Time).
         Cities and countries displayed are located within the geographic
       limits indicated by the meridians shown, but may observe a LEGAL
       time different from the sidereal (solar) time shown for that zone.
         The times 0000 & 2400 (midnight) are interchangeable. 0000 refers
       to the day just begun, 2400 to the day just ended. Local times
       shown are SIDEREAL times, and may differ from the LEGAL times
       decreed in individual communities or areas within that zone.

The 24 timezones, in (a quirky) reverse order.

::

    70 DATA ADAK (ALASKA) & AUCKLAND,NEW CALEDONIA,PAPUA & SAIPAN
    80 DATA VLADIVOSTOK & ADELAIDE,SHANGHAI & MAYLASIA,CHRISTMAS ISLAND & CHUNKING
    90 DATA BANGLADESH & RANGOON,PAKISTAN & MUMBAI,OMAN & KANDAHAR
    100 DATA KUWAIT & MADAGASCAR,CAIRO & ISTANBUL,PRAGUE & STOCKHLOM
    110 DATA "GREENWICH, ENGLAND",CANARY ISLANDS & CHAD,THE AZORES & SCORESBYSUND
    120 DATA RIO de JANEIRO & NEWFOUNDLAND,BERMUDA & GOOSE BAY,OTTAWA & NASSAU
    130 DATA NEW ORLEANS & GUATEMALA,WYOMING & CHIHUAHUA,LOS ANGELES & VANCOUVER
    140 DATA PITCAIRN ISAND & WHITEHORSE,HAWAII & FAIRBANKS,RARATONGA & NOME

Each output line looks something like the following. They display the
a reference time (in this case 03:00 UTC) offset into each of the
24 timezones.

::

    157.5°W to 172.5°W = UTC -11 = 0000 today     in RARATONGA & NOME
    7.5°W   to   7.5°E = UTC       0300 TODAY     in GREENWICH, ENGLAND
    172.5°E to 172.5°W = UTC +12 = 0000 tomorrow  in ADAK (ALASKA) & AUCKLAND
