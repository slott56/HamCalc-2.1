"""HamCalc Main Program.

This runs the :mod:`hamcalc.stdio.intro` module.
"""
__version__ = "2.1"
import runpy

if __name__ == "__main__":
    runpy.run_module( "hamcalc.stdio.intro", run_name="__main__" )
