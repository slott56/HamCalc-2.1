"""Sort the subject area menu; optionally fold in status.

Synopsis
========

::

    python3.2 build_menu -u ../hamcalc source

..  option:: <source>

    Source directory for documentation. This must include
    the :file:`menu.csv` and :file:`subjects.rst` files.

..  option:: -u <hamcalc>, --update <hamcalc>

    Update status by locating modules in the hamcalc source.  T
    his is examined to locate core library modules as well as various
    applications, including stdio, gui, cli and rest.

    This is the directory to search, usually :file:`../python/hamcalc`.

..  option:: -s, --sort

    Sort only, do not update status. This is the default.

..  option:: -t <subjects>, --touch <subjects>

    Name of the :file:`subjects.rst` file.

Description
============

The ``source`` directory must have :file:`source/menu.csv` which is the list of all Hamcalc modules.

This file has nine columns.

1.  Module name.

2.  Legacy .BAS file name.

3.  Description from menu **DATA** statements,
    the :file:`INDEX/HAMDEX.FIL`, or **REM** lines.

4.  Subject area assigned.

#.  Documentation reference

#.  Core calculation Package location.

#.  File in the :file:`stdio` package.

#.  File in the :file:`rest` package.

#.  File in the :file:`cli` package.

#.  File in the :file:`gui` package.

If the :option:`-s` option is provided, then these are simply sorted by subject area and module name, columns 4 and 1.

If the :option:`-u` option is provided, then the given directory tree is
searched for library module as well as an application script that matches
the module name.  This is used to update the various other columns.

In either case, the :file:`source/subjects.rst` file is touched so that
the Make script will properly update the HTML output.

Files
======

:file:`source/menu.csv`. A backup is made to :file:`source/menu.bak`

:file:`source/subjects.rst`

:file:`hamcalc/*/package` for all core library packages.

:file:`hamcalc/stdio/module.py`, :file:`hamcalc/rest/module.py`, :file:`hamcalc/cli/module.py`, :file:`hamcalc/gui/module.py` for the
various applications.

"""
import argparse
import csv
import os
import glob
import logging
import sys

class Operation:
    """An individual Operation this program can perform.
    There are several subclasses, including a "composite" operation
    which combines other operations.

    Global status
    """
    def __init__( self ):
        self.log= logging.getLogger( self.__class__.__name__ )
    def options( self, options ):
        """Set the :class:`argparse.Namespace` with options and result values."""
        self.opts= options
    def execute( self ):
        pass

class Composite( Operation ):
    def __init__( self, *steps ):
        self.steps= steps
    def options( self, options ):
        self.opts= options
        for step in self.steps:
            step.options( options )
    def execute( self ):
        for step in self.steps:
            step.execute()

class Load( Operation ):
    """Loads data from :file:`doc_source/menu.csv`
    into ``data`` attribute.
    """
    def execute( self ):
        with open(os.path.join(self.opts.source,"menu.csv")) as source:
            rdr= csv.reader( source )
            self.opts.data= list( rdr )

class Save( Operation ):
    """Saves data to :file:`doc_source/menu.csv`
    from given ``data`` attribute.
    Also, create backup file and touch :file:`doc_source/subjects.rst`.
    """
    def execute( self ):
        with open(os.path.join(self.opts.source,"menu.#"),"w") as target:
            wtr= csv.writer( target )
            wtr.writerows( self.opts.data )

        os.rename( os.path.join(self.opts.source,"menu.csv"),
            os.path.join(self.opts.source,"menu.bak") )
        os.rename( os.path.join(self.opts.source,"menu.#"),
            os.path.join(self.opts.source,"menu.csv") )
        os.utime( os.path.join(self.opts.source, self.opts.subjects), None )

        self.log.info( "{0:d} rows".format(len(self.opts.data)) )

class Sort( Operation ):
    def execute( self ):
        self.opts.data.sort( key=lambda row:(row[3],row[0]) )

class Update( Operation ):
    @staticmethod
    def tail_2( path ):
        h, t = os.path.split( path )
        h2, t2 = os.path.split( h )
        return os.path.join( t2, t )
    @staticmethod
    def tail_3_noext( path ):
        h, t = os.path.split( path )
        h2, t2 = os.path.split( h )
        h3, t3 = os.path.split( h2 )
        t, _ = os.path.splitext( t )
        return os.path.join( t3, t2, t )
    def execute( self ):
        revised= []
        for row in self.opts.data:
            lib = []
            app = []
            lib= glob.glob( os.path.join( self.opts.hamcalc, '*', row[0] ) )
            lib_tail= map( self.tail_2, lib )
            lib_txt= ' '.join(lib_tail)
            doc= glob.glob( os.path.join( self.opts.source, 'python', '*', row[0] + ".rst" ) )
            doc_tail= ( ':doc:`{0:s}`'.format(self.tail_3_noext(d)) for d in doc )
            doc_txt= ' '.join( doc_tail )
            self.log.debug( row[0], doc_txt )

            for app_area in 'stdio', 'rest', 'cli', 'gui':
                if os.path.exists( os.path.join( self.opts.hamcalc, app_area, row[0] + ".py" ) ):
                    app.append( app_area )
                else:
                    app.append( '' )
            revised.append( row[:4] + [ doc_txt, lib_txt ] + app )
        self.opts.data= revised

def sort( options ):
    """Do the sort.

    :params options: an :class:`argparse.Namespace` with option values.

    source= "source"

    hamcalc= "../hamcalc"

    subjects= "subjects.rst"

    """
    cmd= Composite(
        Load(),
        Sort(),
        Save()
    )
    cmd.options( options )
    cmd.execute()

def update( options ):
    """Do the sort and update.

    :params options: an :class:`argparse.Namespace` with option values.

    source= "source"

    hamcalc= "../hamcalc"

    subjects= "subjects.rst"
    """
    cmd= Composite(
        Load(),
        Sort(),
        Update(),
        Save()
    )
    cmd.options( options )
    cmd.execute()

def main():
    """Parse command-line arguments.
    """
    log= logging.getLogger( "main" )
    parser= argparse.ArgumentParser()
    parser.add_argument( "-u", "--update", metavar='hamcalc', action='store', dest='hamcalc' )
    parser.add_argument( "-s", "--sort", action='store_true' )
    parser.add_argument( "-d", "--debug", action='store_const', dest='log_level', default=logging.INFO, const=logging.DEBUG )
    parser.add_argument( "-t", "--touch", metavar='subjects', action='store', dest='subjects', default='subjects.rst' )
    parser.add_argument( "source", action='store' )
    options= parser.parse_args()

    logging.getLogger().setLevel( options.log_level )
    log.debug( options )

    if options.hamcalc:
        update( options )
    else:
        sort( options )

if __name__ == "__main__":
    logging.basicConfig( stream=sys.stderr, level=logging.INFO )
    main()
    logging.shutdown()
