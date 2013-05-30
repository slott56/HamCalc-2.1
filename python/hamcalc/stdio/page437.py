"""ASCII Character Code Page 437

"ASCII CHARACTERS",", Code Page 437","","PAGE437"
"CODE PAGE 437",", ASCII characters","","PAGE437"
"""

def ascii():
    print( "ASCII Character Code Page 437 (Codes 1 to 31 are control codes)" )

    for code in range(32,256):
        print( "{0:3d} {1:s}|".format( code, bytes( [code] ).decode('437') ), end='' )
        if (code-44) % 13 == 0: print()

    print()

def graphic():
    print()
    print( "                         ASCII Graphic Symbols" )
    print( """\
┌─vert─horiz─vert─╥─vert─horiz─vert─╥─vert─horiz─vert─╥─vert─horiz─vert─┐
││179  ─196  │179 ║║186  ═205  ║186 ║║186  ─196  ║ 186║│179  ═205  │179 │
╞═════════════════╬═════╤═════╤═════╬═════╤═════╤═════╬═════╤═════╤═════╡
│┌ 218│┬ 194│┐ 191║╔ 201│╦ 203│╗ 187║╓ 214│╥ 210│╖ 183║╒ 213│╤ 209│╕ 184│
├─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────┤
│├ 195│┼ 197│┤ 180║╠ 204│╬ 206│╣ 185║╟ 199│╫ 215│╢ 182║╞ 198│╪ 216│╡181 │
├─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────┤
│└ 192│┴ 193│┘ 217║╚ 200│╩ 202│╝ 188║╙ 211│╨ 208│╜ 189║╘ 212│╧ 207│╛ 190│
└─────┴─────┴─────╨─────┴─────┴─────╨─────┴─────┴─────╨─────┴─────┴─────┘
""" )
    print()

def other():
    print()
    print("     Other codes used frequently:" )
    for code in 129, 130, 138, 155, 156, 159, 171, 172, 227, 228:
        print( "| {1:s} {0:3d} ".format( code, bytes( [code] ).decode('437') ), end='' )
    print()

    for code in 230, 232, 234, 246, 251, 253:
        print( "| {1:s} {0:3d} ".format( code, bytes( [code] ).decode('437') ), end='' )
    print()


print( "ASCII Character Code Page 437                           by George Murphy VE3ERP" )
z= None
while z != '0':
    z = input( "ENTER <1> to START or <0> to EXIT? " )
    if z == '1':
        ascii()
        graphic()
        other()
