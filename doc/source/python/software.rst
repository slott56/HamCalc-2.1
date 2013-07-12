software -- Software Engineering, Programming and Computers
================================================================================

Software Engineering, Programming and Computers.

numsort, Number Sorter
-------------------------

From the code::

    10 :REM'NUMSORT' - Number Sorter  - 01 JAN 2003
    280 REM  (Shell-Metzner algorithm) QST Dec 1985, page 53

This program has no real use.
While the algorithm may be interesting, it isn't used elsewhere in HamCalc.
And, it's not easily used outside of HamCalc.

Part of the value proposition for rewriting HamCalc into Python is
to leverage the amazingly fast Python ``list.sort()`` feature.

More importantly, who would type data into an interactive program?
After you're done typing, the input needs to be saved somewhere
for further use.

A far better use case is simply to use interactive Python.  Like this:

::

    >>> a = [ x, y, z, ... ] # your data values.
    >>> a.sort()
    >>> a

Practical use cases for sorting involve two things:

1.  Displaying calculated or gathered data values in an intelligable order.
    This means that there's more data than just the
    numbers to be sorted.

2.  Rank-ordering data to filter or weight the items
    in further calculations.

Neither these are supported a stand-alone programs in HamCalc.

Both use cases are first-class features of Python, however.

::

    for item in sorted( some_data, key=lambda x: x.attribute ):
        print( item )

or

::

    rank_order= []
    for rank, item in enumerate( sorted( some_data, key=lambda x: x.attribute ) ):
        score= f( item, rank )
        rank_order.append( score, item )


page437, ASCII Character Code Page 437
---------------------------------------

This is it.

::

    ASCII Character Code Page 437 (Codes 1 to 31 are control codes)

     32  │ 33 !│ 34 "│ 35 #│ 36 $│ 37 %│ 38 &│ 39 '│ 40 (│ 41 )│ 42 *│ 43 +│ 44 ,│
     45 -│ 46 .│ 47 /│ 48 0│ 49 1│ 50 2│ 51 3│ 52 4│ 53 5│ 54 6│ 55 7│ 56 8│ 57 9│
     58 :│ 59 ;│ 60 <│ 61 =│ 62 >│ 63 ?│ 64 @│ 65 A│ 66 B│ 67 C│ 68 D│ 69 E│ 70 F│
     71 G│ 72 H│ 73 I│ 74 J│ 75 K│ 76 L│ 77 M│ 78 N│ 79 O│ 80 P│ 81 Q│ 82 R│ 83 S│
     84 T│ 85 U│ 86 V│ 87 W│ 88 X│ 89 Y│ 90 Z│ 91 [│ 92 \│ 93 ]│ 94 ^│ 95 _│ 96 `│
     97 a│ 98 b│ 99 c│100 d│101 e│102 f│103 g│104 h│105 i│106 j│107 k│108 l│109 m│
    110 n│111 o│112 p│113 q│114 r│115 s│116 t│117 u│118 v│119 w│120 x│121 y│122 z│
    123 {│124 |│125 }│126 ~│127  │128 Ç│129 ü│130 é│131 â│132 ä│133 à│134 å│135 ç│
    136 ê│137 ë│138 è│139 ï│140 î│141 ì│142 Ä│143 Å│144 É│145 æ│146 Æ│147 ô│148 ö│
    149 ò│150 û│151 ù│152 ÿ│153 Ö│154 Ü│155 ¢│156 £│157 ¥│158 ₧│159 ƒ│160 á│161 í│
    162 ó│163 ú│164 ñ│165 Ñ│166 ª│167 º│168 ¿│169 ⌐│170 ¬│171 ½│172 ¼│173 ¡│174 «│
    175 »│176 ░│177 ▒│178 ▓│179 ││180 ┤│181 ╡│182 ╢│183 ╖│184 ╕│185 ╣│186 ║│187 ╗│
    188 ╝│189 ╜│190 ╛│191 ┐│192 └│193 ┴│194 ┬│195 ├│196 ─│197 ┼│198 ╞│199 ╟│200 ╚│
    201 ╔│202 ╩│203 ╦│204 ╠│205 ═│206 ╬│207 ╧│208 ╨│209 ╤│210 ╥│211 ╙│212 ╘│213 ╒│
    214 ╓│215 ╫│216 ╪│217 ┘│218 ┌│219 █│220 ▄│221 ▌│222 ▐│223 ▀│224 α│225 ß│226 Γ│
    227 π│228 Σ│229 σ│230 µ│231 τ│232 Φ│233 Θ│234 Ω│235 δ│236 ∞│237 φ│238 ε│239 ∩│
    240 ≡│241 ±│242 ≥│243 ≤│244 ⌠│245 ⌡│246 ÷│247 ≈│248 °│249 ∙│250 ·│251 √│252 ⁿ│
    253 ²│254 ■│

Page 2. This doesn't look good except with Courier font.

::

                                 ASCII Graphic Symbols
    ┌─vert─horiz─vert─╥─vert─horiz─vert─╥─vert─horiz─vert─╥─vert─horiz─vert─┐
    ││179  ─196  │179 ║║186  ═205  ║186 ║║186  ─196  ║ 186║│179  ═205  │179 │
    ╞═════════════════╬═════╤═════╤═════╬═════╤═════╤═════╬═════╤═════╤═════╡
    │┌ 218│┬ 194│┐ 191║╔ 201│╦ 203│╗ 187║╓ 214│╥ 210│╖ 183║╒ 213│╤ 209│╕ 184│
    ├─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────┤
    │├ 195│┼ 197│┤ 180║╠ 204│╬ 206│╣ 185║╟ 199│╫ 215│╢ 182║╞ 198│╪ 216│╡181 │
    ├─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────╫─────┼─────┼─────┤
    │└ 192│┴ 193│┘ 217║╚ 200│╩ 202│╝ 188║╙ 211│╨ 208│╜ 189║╘ 212│╧ 207│╛ 190│
    └─────┴─────┴─────╨─────┴─────┴─────╨─────┴─────┴─────╨─────┴─────┴─────┘

     Other codes used frequently:
    │ ü 129 │ é 130 │ è 138 │ ¢ 155 │ £ 156 │ ƒ 159 │ ½ 171 │ ¼ 172 │ π 227 │ Σ 228
    │ µ 230 │ Φ 232 │ Ω 234 │ ÷ 246 │ √ 251 │ ² 253 │

sorter, Sorter
----------------

From the code::

    10 :REM'SORTER3  -  Character String Sorter - 07 JAN 2003
    350 REM  (Shell-Metzner algorithm) QST Dec 1985, page 53

See `numsort, Number Sorter`_ above. This program isn't useful.
