"""Solution of Triangles

"TRIANGLES",", solution of","","SOLUTRI"
"""
import hamcalc.math.solutri as solutri

def right_triangle(z):
    global args
    args['A_h']= solutri.radians(90)
    if z == 'a':
        args['A_f']= solutri.radians( float( input( "ENTER: Angle (a)? " ) ) )
    elif z == 'b':
        args['A_g']= solutri.radians( float( input( "ENTER: Angle (b)? " ) ) )
    elif z == 'c':
        args['S_k']= float( input( "ENTER: Side <c>? " ) )
    elif z == 'd':
        args['S_i']= float( input( "ENTER: Side <d>? " ) )
    elif z == 'e':
        args['S_j']= float( input( "ENTER: Side <e>? " ) )
    args= solutri.triangle( **args )
    report= {
        'a': solutri.degrees(args.A_f) if 'A_f' in args else "",
        'b': solutri.degrees(args.A_g) if 'A_g' in args else "",
        'c': args.S_k if 'S_k' in args else "",
        'd': args.S_i if 'S_i' in args else "",
        'e': args.S_j if 'S_j' in args else "",
    }
    print( "   |\\" )
    print( "   | \\" )
    print( "   |(a)\\ <-- {a}°".format(**report) )
    print( "   |    \\" )
    print( "   |     \\<e> <-- {e}".format(**report) )
    print( "<d>|      \\ <-- {d}".format(**report) )
    print( "   |    (b)\\ <-- {b}°".format(**report) )
    print( "   |_ _ _ _ _\\" )
    print( "        <c>     <-- {c}".format(**report) )
    print()

def general_triangle( z ):
    global args
    if z == 'f':
        args['A_f']= solutri.radians( float( input( "ENTER: Angle (f)? " ) ) )
    elif z == 'g':
        args['A_g']= solutri.radians( float( input( "ENTER: Angle (g)? " ) ) )
    elif z == 'h':
        args['A_h']= solutri.radians( float( input( "ENTER: Angle (h)? " ) ) )
    elif z == 'i':
        args['S_i']= float( input( "ENTER: Side <i>? " ) )
    elif z == 'j':
        args['S_j']= float( input( "ENTER: Side <j>? " ) )
    elif z == 'k':
        args['S_k']= float( input( "ENTER: Side <k>? " ) )
    args= solutri.triangle( **args )
    report= {
        'f': solutri.degrees(args.A_f) if 'A_f' in args else "",
        'g': solutri.degrees(args.A_g) if 'A_g' in args else "",
        'h': solutri.degrees(args.A_h) if 'A_h' in args else "",
        'i': args.S_k if 'S_k' in args else "",
        'j': args.S_i if 'S_i' in args else "",
        'k': args.S_j if 'S_j' in args else "",
    }
    print( "              /^\\" )
    print( "            / (f) \\ <-- {f}°".format(**report) )
    print( "          /         \\" )
    print( "     <i>/             \\ <-- {i}".format(**report) )
    print( "      /                 \\<j> <-- {j}".format(**report) )
    print( "    /                     \\".format(**report) )
    print( "  / (h)                 (g) \\ <-- {h}°  {g}°".format(**report) )
    print( "/_ _ _ _ _ _ _ _ _ __ _ _ _ _ _\\" )
    print( "        <k>     <-- {k}".format(**report) )
    print()

menu="""\
                  |\\                                     /^\\
                  |  \\                                 / (f) \\
                  |(a) \\                             /         \\
                  |      \\                      <i>/             \\<j>
                  |        \\<e>                  /                 \\
                  |          \\                 /                     \\
               <d>|        (b) \\             / (h)                 (g) \\
                  |_ _ _ _ _ _ _ \\         /_ _ _ _ _ _ _ _ _ _ _ _ _ _ _\\
                        <c>                              <k>

               RIGHT-ANGLED TRIANGLE           OBLIQUE-ANGLED TRIANGLE
               ─────────────────────           ───────────────────────
             (a),(b) are the angles          (f),(g),(h) are the angles
             <c>,<d>,<e> are the sides       <i>,<j>,<k> are the sides
"""

print( solutri.intro() )

print( menu )
args= dict()

z= None
while z != '':
    z= input( "ENTER: a known side or angle? " )
    if z in 'abcde':
        right_triangle(z)
    elif z in 'fghijk':
        general_triangle(z)
    if len(args) == 6:
        print( menu )
        args= dict()
