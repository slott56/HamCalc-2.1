timeq -- Time Quiz
----------------------------------------

Humor!

Do you know what happens daily at these times?

::

    tm= ( (z/11/5)*3600 for z in range(0,60*12,60) )
    hms= ( (int(t//3600), int(t//60)%60, int(t%60)) for t in tm )
    for h, m, s in hms:
        print( "{0:02d}:{1:02d}:{2:02d}".format( h, m, s ) )


Legacy Quirk
~~~~~~~~~~~~~~~

The answer given is incorrect. Only
the hour and minute hands overlap precisely.

Not hour, minute **and** second.

