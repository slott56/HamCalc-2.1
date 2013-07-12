"""Sort the subject area menu.

..  todo:: Examine actual modules completed and fold
    in status information.

    lib -- in a core calculation package

    stdio, rest, cli, gui -- in a user interface package

"""
import csv
import os
import glob

# relative to the spike directory; change if this is moved to doc
doc_source= "../../doc/source"
package_glob= "../hamcalc/*"
app_root= "../hamcalc"

with open(os.path.join(doc_source,"menu.csv")) as source:
    rdr= csv.reader( source )
    data= list( rdr )

data.sort( key=lambda row:(row[3],row[0]) )

for row in data:
    lib = []
    app = []
    lib= glob.glob( os.path.join( package_glob, row[0] ) )
    lib_txt= ' '.join(lib)
    for app_area in 'stdio', 'rest', 'cli', 'gui':
        if os.path.exists( os.path.join( app_root, app_area, row[0] + ".py" ) ):
            app.append( app_area )
        else:
            app.append( '' )
    print( row + [ lib_txt ] + app )

with open(os.path.join(doc_source,"menu.#"),"w") as target:
    wtr= csv.writer( target )
    wtr.writerows( data )

os.rename( os.path.join(doc_source,"menu.csv"),
    os.path.join(doc_source,"menu.bak") )
os.rename( os.path.join(doc_source,"menu.#"),
    os.path.join(doc_source,"menu.csv") )
os.utime( os.path.join(doc_source,"subjects.rst"), None )
print( len(data), "rows" )
