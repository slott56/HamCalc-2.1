"""Intro.

Displays the introductory "splash" page.

The default behavior is to run the :program:`menu` application.

If the menu was run from the command line, then it will run this intro
program with the ``menu=False`` parameter to prevent recursively invoking the menu.
"""

import hamcalc.stdio.menu

text="""\
 H A M C A L C - PAINLESS MATH for RADIO AMATEURS
 ╔════════════════════════════════════════════════════════════════════════════╗
 ║  THIS SOFTWARE IS FREE AND IS NOT TO BE SOLD! If you use these programs, a ║
 ║  donation to the CANADIAN NATIONAL INSTITUTE for the BLIND - AMATEUR RADIO ║
 ║  PROGRAM, c/o the author at the address below, would be appreciated.       ║
 ╚════════════════════════════════════════════════════════════════════════════╝
                                     -∙∙∙-
HAMCALC is frequently being expanded and upgraded. This is version 129, release
date:25 JAN 2011: To find the number of the latest version contact the author.
Comments, suggestions and ideas for new programs are welcomed by the author>.

                             George Murphy, VE3ERP
                                77 McKenzie St.
                          Orillia, ON L3V6A6, Canada
                          e-mail < ve3erp@rac.ca >
                                     -∙∙∙-
 HAMCALC is available as a free download at <www.cq-amateur-radio.com>. Versions
 offered by other sources are unauthorized, probably outdated and may not run
 properly.
                                     -∙∙∙-
The ARRL Handbook For Radio Amateurs, Antenna Book, Electronics Data Book and
other ARRL publications are gratefully acknowledged as primary sources of data
and reference material for these programs.
                                     -∙∙∙-
"""

def run( menu=True ):
    """Show the splash page and (optionally) launch the menu.

    :param menu: If False, suppress the menu. Generally this is only
        used by the menu when it's showing the intro page.
    """
    print( text )
    input( "Hit Enter to continue." )
    if menu:
        hamcalc.stdio.menu.run( intro=False )

if __name__ == "__main__":
    run()
