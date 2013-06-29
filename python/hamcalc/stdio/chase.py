"""Speed Chase

"SPEED CHASE","","","CHASE"
"""

introduction = """\
 SPEED CHASE                                             by George Murphy VE3ERP

 If two entities are launched along the same path from the same spot at
 different times and speeds they will eventually meet. This program describes
 the meeting. Times, speeds and distances can be in any units.
"""


def solve():
    r_1= float( input( "ENTER: speed of one of the entities? " ) )
    w= float( input( "ENTER: Time delay between launches? " ) )
    r_2= float( input( "ENTER: speed of the other entity? " ) )

    if r_1 < r_2:
        pass
    elif r_1 > r_2:
        r_1, r_2 = r_2, r_1
    else:
        print( "The two speeds cannot be equal" )
        return

    t = r_1*w / (r_2 - r_1)
    d = r_2*t

    print("     TIME     EVENT" )
    print("  {0:7.2f}     Slower entity launched at speed {1:f}".format(0.0,r_1) )
    print("  {0:7.2f}     Faster entity launched at speed {1:f}".format(w,r_2) )
    print("  {0:7.2f}     Entities meet at distance {1:f}".format(t,d) )

print( introduction )

solve()
