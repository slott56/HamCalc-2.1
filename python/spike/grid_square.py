#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
Y="───┬───"
print("┌───"+"".join(Y for c in range(9) )+"───┐")
for y in range(9,-1,-1):
    print( "│" + "".join( " xx{0:0d}{1:0d} │".format(x,y) for x in range(10)  ) )
    if y == 0: break
    Y="───┼───"
    print("├───"+"".join(Y for c in range(9) )+"───┤")
Y="───┴───"
print("└───"+"".join(Y for c in range(9) )+"───┘")


