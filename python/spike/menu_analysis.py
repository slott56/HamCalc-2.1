"""Extract program names from the menu DATA statements
plus the cross reference file
to create a "complete" list of all applications.
"""
import os
import csv
from collections import defaultdict

root = "../../gwbasic/HamCalc"
xref_file = os.path.join( "../../HCALC_129/HamCalc", "INDEX", "HAMDEX.FIL" )

def get_file_iter(child=""):
    """Yield all .BAS files."""
    for path, dirs, files in os.walk( os.path.join(root,child) ):
        for f in files:
            name, ext = os.path.splitext( f )
            if ext.upper() == ".BAS":
                yield os.path.join(path,f)

def get_stmt_iter(keyword="DATA"):
    """Yield all statements in all .BAS files
    where the first keyword is recognized.

    This is shabby, special-case parsing.
    """
    for f in get_file_iter():
        with open( f ) as source:
            for line in source:
                num, _, stmt = line.partition( ' ' )
                if stmt.startswith(keyword):
                    _, _, body= stmt.partition( ' ' )
                    yield body

def good_filename( name ):
    """Given parsed two-element data statement, is the first element
    the name of a file in the PROG directory?

    :param stmt: the potential .BAS file name
    :returns: Full file name if a file can be found.
        None if the file cannot be found.
    """
    if name.strip().startswith( '\\' ):
        path= name.strip().split( '\\' )
        name = path[-1]
    nm_uu= name.strip().upper() + ".BAS"
    nm_ul= name.strip().upper() + ".bas"
    nm_lu= name.strip().lower() + ".BAS"
    nm_ll= name.strip().lower() + ".bas"
    found= None
    for name in nm_uu, nm_ul, nm_lu, nm_ll:
        full_name= os.path.join( root, "PROG", name )
        if os.path.exists( full_name ):
            return full_name

def menu_data_partition( all_data ):
    """Partition the DATA statements into those that seem
    to describe a menu item (i.e., a program name and a description)
    and those DATA statements that do not seem to describe
    a menu item (i.e., not two elements, first element not a filename.

    :param all_data: an iterator over all DATA statements.
        For example, :func:`get_stmt_iter`
    :returns: 2-tuple with good dict and bad set.
        The good DATA statements create a dictionary with
        full filename as the key and the set of distinct descriptions.
        The bad DATA statements are a simple set of tuples.
    """
    good_name = defaultdict(set)
    bad_stmt = set()
    rdr= csv.reader( all_data, skipinitialspace=True )
    for stmt in rdr:
        if len(stmt) == 2:
            full_name= good_filename( stmt[0] )
            if full_name:
                good_name[full_name].add( stmt[1] )
            else:
                bad_stmt.add( tuple(stmt) )
    return good_name, bad_stmt

def xref_file_partition( ):
    good_xref = defaultdict( set )
    bad_xref = set()
    with open( xref_file ) as xref:
        rdr= csv.reader( xref, skipinitialspace=True )
        for line in rdr:
            if line[0] == '\x1a': continue
            full_name= good_filename( line[3] )
            if full_name:
                good_xref[full_name].add( tuple(line[:3]) )
            else:
                bad_xref.add( tuple(line) )
    return good_xref, bad_xref

def export( good_data ):
    for f in sorted(good_data):
        _, name = os.path.split( f )
        nm, ext = os.path.splitext( name )
        nm_l= nm.lower()
        yield nm_l, name, ';'.join(good_data[f]), doco.get(nm_l,'')

# 1. Get good menu data and bad menu DATA statements
good_data, bad_data = menu_data_partition( get_stmt_iter("DATA") )

# 2. Dump bad data to confirm that a few programs are missing.
#for line in sorted(bad_data):
#    print( line )

# 3. Get all PROG file names.
files = set( get_file_iter("PROG") )

# 4. Display the good menu item list; update the files set.
for name in sorted(good_data):
    print( name, good_data[name] )
    # TODO: handle ".BAS" vs. ".bas" when discarding matching name
    # Menu DATA usually resolves as .BAS, due to order of names
    # and OS X case insensitivity.
    # Actual files are usually .BAS, but sometimes .bas.
    files.discard( name )
    nm, ext = os.path.splitext( name )
    name2= nm+ext.lower()
    name3= nm+ext.upper()
    files.discard( name2 )
    files.discard( name3 )

# 5. Examine the additional .BAS program files not named in a menu.
missing_data= defaultdict(set)
for name in sorted(files):
    with open(name) as source:
        description= "?"
        for line in source:
            num, _, body = line.partition(' ')
            if body.startswith(":REM"):
                description= body.strip()
                break
        missing_data[name].add( description )

# 6. Display the missing files list.
for name in sorted( missing_data ):
    print( name, missing_data[name] )

# 7. Get good xref and bad xref lines
good_xref, bad_xref = xref_file_partition()

# 8. Dump bad data to confirm that a few programs are missing.
#for xref in sorted( bad_xref ):
#    print( xref )

# 9. Additional bad data:
# The (good_data | missing_data) is a complete list of known programs:
# all menu items plus all physically present files.
# How does it compare with the cross references?
#known = set(good_data.keys()) | set( missing_data.keys() )
#print( "Known with no Xref", known - set(good_xref.keys()) )

# 10. Some stats.
print( "Menu ", len(good_data) )
print( "Files", len(missing_data) )
print( "Xref ", len(good_xref) )

# 11. Gather module names and subject areas from the current documentation.
doco= dict()
for path, dirs, files in os.walk( "../../doc/source/python" ):
    for f in files:
        nm, ext = os.path.splitext( f )
        if ext == ".rst":
            _, package = os.path.split( path )
            if package:
                doco[nm]= package

# 12. Emit the final "known" list (good_data | missing_data)
# into a CSV format that we can manually annotate with a "subject area".
good_data.update( missing_data )
with open('menu.csv','w') as target:
    wtr= csv.writer( target )
    wtr.writerows( export( good_data ) )

