"""Calendar, Perpetual/Universal

"CALENDAR",", perpetual","","CALTODAY"
"DAYS BETWEEN DATES","","","CALTODAY"
"""
import calendar
import datetime
import runpy

def three_month( year, month ):
    """Print three months side-by-side.

    :param year: year
    :param month: middle month to display
    """
    cal_seq= []
    for i in -1, 0, 1:
        ym = (year*12 + month-1) + i
        cal_year, cal_mon = divmod( ym, 12 )
        cal_seq.append( calendar.month( cal_year, cal_mon+1 ).splitlines() )
    # Longest month
    size = max( map( len, cal_seq ) )
    # Examine each month week-by-week
    for i in range(size):
        try:
            col_0= cal_seq[0][i]
        except IndexError:
            col_0= ''
        try:
            col_1= cal_seq[1][i]
        except IndexError:
            col_1= ''
        try:
            col_2= cal_seq[2][i]
        except IndexError:
            col_2= ''
        print( "{0:21s}      {1:21s}      {2:21s}".format(col_0, col_1, col_2) )
    print( "{0:21s}      {1:21s}      {2:21s}".format("LAST MONTH", "THIS MONTH", "NEXT MONTH") )

def any_month():
    """
    Prompt for year and month and print calendar.

    Two-digit years are converted according to the POSIX or X/Open standard: values 69-99 are mapped to 1969-1999, and values 0–68 are mapped to 2000–2068.
    """
    y= int( input( " ENTER: Year.............? " ) )
    if 69 <= y <= 99: y = y + 1900
    elif 0 <= y <= 68: y = y + 2000
    m= int( input( " ENTER: Month number.....? " ) )
    calendar.prmonth( y, m )

def any_year():
    """
    Prompt for year and print calendar.

    Two-digit years are converted according to the POSIX or X/Open standard: values 69-99 are mapped to 1969-1999, and values 0–68 are mapped to 2000–2068.
    """
    y= int( input( " ENTER: Year.............? " ) )
    if 69 <= y <= 99: y = y + 1900
    elif 0 <= y <= 68: y = y + 2000
    calendar.prcal( y )

calendar.setfirstweekday(calendar.SUNDAY)
z= None
while z != '0':
    print()
    print("  < 1 >  Current 3 months" )
    print("  < 2 >  Any month of any year after 1752" )
    print("  < 3 >  12 month calendar for any year after 1752" )
    print("  < 4 >  Count days between dates" )
    print("  < 5 >  Sunrise/Sunset calendar" )
    print()
    print("  < 0 >  EXIT" )

    today= datetime.date.today()
    z = input( "CHOICE? " )
    if z == '1':
        three_month( today.year, today.month )
    elif z == '2':
        any_month()
    elif z == '3':
        any_year()
    elif z == '4':
        runpy.run_module( 'hamcalc.stdio.days' )
    elif z == '5':
        runpy.run_module( 'hamcalc.stdio.sunup' )
