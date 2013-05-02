"""Unit Test for HamCalc modules."""

import unittest
import doctest

import hamcalc.lib
import hamcalc.electronics.awgexact
import hamcalc.electronics.decibel
import hamcalc.math.accelr
import hamcalc.math.baromtr
import hamcalc.math.deciconv
import hamcalc.math.decifrac
import hamcalc.math.fibon
import hamcalc.math.propcirc

# Make the discovery of doctests a much more visible.
FINDER_VERBOSITY=False
# Make the test output somewhat more visible
RUNNER_VERBOSITY=1

if __name__ == "__main__":
    suite = unittest.TestSuite()

    finder= doctest.DocTestFinder( verbose=FINDER_VERBOSITY )

    suite.addTests(doctest.DocTestSuite(hamcalc.lib,test_finder=finder))
    for mod in (hamcalc.electronics.awgexact, hamcalc.electronics.decibel):
        suite.addTests(doctest.DocTestSuite(mod,test_finder=finder))
    for mod in (hamcalc.math.accelr, hamcalc.math.baromtr,
        hamcalc.math.deciconv, hamcalc.math.decifrac, hamcalc.math.fibon,
        hamcalc.math.propcirc ):
        suite.addTests(doctest.DocTestSuite(mod,test_finder=finder))

    runner = unittest.TextTestRunner(verbosity=RUNNER_VERBOSITY)
    runner.run(suite)
