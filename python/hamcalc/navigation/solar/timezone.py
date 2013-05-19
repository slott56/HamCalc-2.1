"""hamcalc.navigation.solar.timezone --  North American Time Zones.

The sunrise and sunset times are in UTC.  Localtime offsets need to be applied,
based on local knowledge of timezones and Daylight Savings Time
to get to proper local times.

This includes many of the North American DST Rules for US and Canada.

From the Python documentation.

    # This is a simplified (i.e., wrong for a few cases) set of rules for US
    # DST start and end times. For a complete and up-to-date set of DST rules
    # and timezone definitions, visit the Olson Database (or try pytz):
    # http://www.twinsun.com/tz/tz-link.htm
    # http://sourceforge.net/projects/pytz/ (might not be up-to-date)

See http://pytz.sourceforge.net for a more complete list.

To convert from UTC to local time, the following kind of thing
is done.

::

    rise, transit, set = solar.rise_transit_set( 38.98, 76.47, today.date() )
    rise.astimezone(solar.Eastern).isoformat()

This will display the rise time in North American Eastern Time.

Since the time zone data has some of the calendar rules back to 1966, the daylight savings time rules are applied as well as possible to historical
dates.

It's quite easy to add timezones to cover other historical periods or
other places on earth.

This module defines the following timezones:

-   utc, abbreviated "UTC"

-   Newfoundland = NATimeZone(-3.5, "Newfoundland", "NST", "NDT")

-   Atlantic = NATimeZone(-4, "Atlantic", "AST", "ADT")

-   Eastern  = NATimeZone(-5, "Eastern",  "EST", "EDT")

-   Central  = NATimeZone(-6, "Central",  "CST", "CDT")

-   Mountain = NATimeZone(-7, "Mountain", "MST", "MDT")

-   Pacific  = NATimeZone(-8, "Pacific",  "PST", "PDT")


"""
import datetime

ZERO = datetime.timedelta(0)
HOUR = datetime.timedelta(hours=1)

class UTC(datetime.tzinfo):
    """UTC Timezone definition"""
    def utcoffset(self, dt): return ZERO
    def tzname(self, dt): return "UTC"
    def dst(self, dt): return ZERO

utc = UTC()

class FixedOffset(datetime.tzinfo):
    """Fixed offset in minutes east from UTC."""
    def __init__(self, offset):
        self.__offset = datetime.timedelta(minutes = offset)
        hr, min = divmod( offset, 60 )
        self.__name= "GMT{0:+03.0f}:{1:02.0f}".format(hr,min)
    def utcoffset(self, dt):
        return self.__offset
    def tzname(self, dt):
        return self.__name
    def dst(self, dt):
        return ZERO

# A more complete implementation of current DST rules for major US time zones.

def first_sunday_on_or_after(dt):
    """Determine if a date is within the defined period."""
    days_to_go = 6 - dt.weekday()
    if days_to_go:
        dt += datetime.timedelta(days_to_go)
    return dt

# In the US, since 2007, DST starts at 2am (standard time) on the second
# Sunday in March, which is the first Sunday on or after Mar 8.
DSTSTART_2007 = datetime.datetime(1, 3, 8, 2)
# and ends at 2am (DST time; 1am standard time) on the first Sunday of Nov.
DSTEND_2007 = datetime.datetime(1, 11, 1, 1)
# From 1987 to 2006, DST used to start at 2am (standard time) on the first
# Sunday in April and to end at 2am (DST time; 1am standard time) on the last
# Sunday of October, which is the first Sunday on or after Oct 25.
DSTSTART_1987_2006 = datetime.datetime(1, 4, 1, 2)
DSTEND_1987_2006 = datetime.datetime(1, 10, 25, 1)
# From 1967 to 1986, DST used to start at 2am (standard time) on the last
# Sunday in April (the one on or after April 24) and to end at 2am (DST time;
# 1am standard time) on the last Sunday of October, which is the first Sunday
# on or after Oct 25.
DSTSTART_1967_1986 = datetime.datetime(1, 4, 24, 2)
DSTEND_1967_1986 = DSTEND_1987_2006

# For Canada, starting in 2007, clocks following the new North American standard
# for Daylight Saving Time are to be turned forward by one hour on the second
# Sunday of March and turned back on the first Sunday of November.

class NATimeZone(datetime.tzinfo):
    """Superclass for North American timezone definitions."""
    def __init__(self, hours, reprname, stdname, dstname):
        self.stdoffset = datetime.timedelta(hours=hours)
        self.reprname = reprname
        self.stdname = stdname
        self.dstname = dstname
    def __repr__(self):
        return self.reprname
    def tzname(self, dt):
        if self.dst(dt):
            return self.dstname
        else:
            return self.stdname
    def utcoffset(self, dt):
        return self.stdoffset + self.dst(dt)
    def dst(self, dt):
        if dt is None or dt.tzinfo is None:
            # An exception may be sensible here, in one or both cases.
            # It depends on how you want to treat them. The default
            # fromutc() implementation (called by the default astimezone()
            # implementation) passes a datetime with dt.tzinfo is self.
            return ZERO
        assert dt.tzinfo is self
        # Find start and end times for US DST. For years before 1967, return
        # ZERO for no DST.
        if 2006 < dt.year:
            dststart, dstend = DSTSTART_2007, DSTEND_2007
        elif 1986 < dt.year < 2007:
            dststart, dstend = DSTSTART_1987_2006, DSTEND_1987_2006
        elif 1966 < dt.year < 1987:
            dststart, dstend = DSTSTART_1967_1986, DSTEND_1967_1986
        else:
            return ZERO
        start = first_sunday_on_or_after(dststart.replace(year=dt.year))
        end = first_sunday_on_or_after(dstend.replace(year=dt.year))
        # Can’t compare naive to aware objects, so strip the timezone from
        # dt first.
        if start <= dt.replace(tzinfo=None) < end:
            return HOUR
        else:
            return ZERO

Newfoundland = NATimeZone(-3.5, "Newfoundland", "NST", "NDT")
Atlantic = NATimeZone(-4, "Atlantic", "AST", "ADT")
Eastern  = NATimeZone(-5, "Eastern",  "EST", "EDT")
Central  = NATimeZone(-6, "Central",  "CST", "CDT")
Mountain = NATimeZone(-7, "Mountain", "MST", "MDT")
Pacific  = NATimeZone(-8, "Pacific",  "PST", "PDT")
