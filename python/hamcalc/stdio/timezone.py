"""Time Zones (UTC)

"TIME ZONE CALCULATOR","","","TIMEZONE"
"UTC",", Coordinated Universal Time","","TIMEZONE"
"""
import re
import datetime
from hamcalc.navigation.solar.timezone import utc, FixedOffset

# The HamCalc Zones
zone_data="""\
70 DATA ADAK (ALASKA) & AUCKLAND,NEW CALEDONIA,PAPUA & SAIPAN
80 DATA VLADIVOSTOK & ADELAIDE,SHANGHAI & MAYLASIA,CHRISTMAS ISLAND & CHUNKING
90 DATA BANGLADESH & RANGOON,PAKISTAN & MUMBAI,OMAN & KANDAHAR
100 DATA KUWAIT & MADAGASCAR,CAIRO & ISTANBUL,PRAGUE & STOCKHLOM
110 DATA "GREENWICH, ENGLAND",CANARY ISLANDS & CHAD,THE AZORES & SCORESBYSUND
120 DATA RIO de JANEIRO & NEWFOUNDLAND,BERMUDA & GOOSE BAY,OTTAWA & NASSAU
130 DATA NEW ORLEANS & GUATEMALA,WYOMING & CHIHUAHUA,LOS ANGELES & VANCOUVER
140 DATA PITCAIRN ISAND & WHITEHORSE,HAWAII & FAIRBANKS,RARATONGA & NOME
"""

def data_parse( text ):
    """Parse a block of DATA statements.

    This separates quoted strings (which can include ",",
    from non-quoted data (strings and numbers) which can't include ",".
    And, of course, the intervening "," tokens.
    """
    _data_pat= re.compile(r'"([^"]*?)"\s*,?\s*|([^,]*),?\s*')
    lines= ( x[x.find(" DATA ")+6:] for x in text.splitlines() )
    for line in lines:
        if len(line) <= 1: continue
        data= ( q if q else nq for q,nq in _data_pat.findall(line) if q or nq )
        for d in data:
            yield d

zones= list( data_parse( zone_data ) )

introduction="""\
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
"""

def show_lon( lat ):
    if lat < 0:
        return "{0:5.1f}°W".format( abs(lat)%180 )
    else:
        return "{0:5.1f}°E".format( abs(lat)%180 )

print( introduction )
ref_raw= None
while ref_raw != '':
    ref_raw= input( " ENTER: Reference time in UTC (e.g. 0517, 1625, etc.)....? " )
    if len(ref_raw) == 0: break
    try:
        ref_int= int(ref_raw)
        hr, min = divmod( ref_int, 100 )
        ref_time= datetime.time( hour=hr, minute=min, tzinfo=utc )
    except ValueError:
        continue
    ref_date_time= datetime.datetime.combine( datetime.datetime.now().date(), ref_time )
    day_num = ref_date_time.toordinal()
    for i, tz_name in enumerate( reversed( zones ) ):
        hr= i-11
        lon = hr*15
        local= FixedOffset( hr*60 )
        offset_day= ref_date_time.astimezone(local).toordinal() - day_num
        day= {-1:"yesterday", 0:"today", 1:"tomorrow"}[offset_day]
        print( "{0:7s} {1:7s} UTC {2:+3d} {4:9s} in {5:s}".format(
            show_lon(lon-7.5), show_lon(lon+7.5), hr, ref_date_time.astimezone(local).strftime("%H:%M"), day,
            tz_name ) )
