"""Days Between Dates

"DAYS BETWEEN DATES","","","CALTODAY"
"""
import datetime
import calendar

yr_s= int( input( " Start Year ............? " ) )
mo_s= int( input( " Start Month No. .......? " ) )
dy_s= int( input( " Start Day No. .........? " ) )
start= datetime.date( yr_s, mo_s, dy_s )
print( "Start date ................ ", start.strftime("%A, %B %d, %Y") )

yr_e= int( input( " End Year ............? " ) )
mo_e= int( input( " End Month No. .......? " ) )
dy_e= int( input( " End Day No. .........? " ) )
end= datetime.date( yr_e, mo_e, dy_e )
print( "End date ................ ", end.strftime("%A, %B %d, %Y") )

x = (end-start).days
print( " Days between dates .....{0:12d}".format(abs(x)) )
print( " Weeks between dates ....{0:12,.2f}".format(abs(x)/7) )
print( " Months between dates ...{0:12,.2f}".format(abs(x)/365.25*12) )
print( " Years between dates ....{0:12,.2f}".format(abs(x)/365.25) )
print()
print( "              (Weeks, months & years calculated to nearest full day)" )
calendar.setfirstweekday(calendar.SUNDAY)
print()
calendar.prmonth( start.year, start.month )
print("START  DATE")
print()
calendar.prmonth( end.year, end.month )
print("END  DATE")
print()
