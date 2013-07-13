"""HamCalc Python.

https://github.com/slott56/HamCalc-2.1

http://hamcalc.wikispaces.com
"""
from distutils.core import setup

setup(
    name='HamCalc',
    version='2.1',
    description='H A M C A L C -- PAINLESS MATH for RADIO AMATEURS',
    author='S.Lott',
    author_email='slott56@gmail.com',
    url='http://hamcalc.wikispaces.com',
    download_url="https://github.com/slott56/HamCalc-2.1",
    long_description="""
This project is a "modernization" of HamCalc release 129.
The idea is to preserve the knowledge by converting the code from GW-Basic
to Python. This allows writing unit tests to correct the bugs,
and makes it available for amateur programs to learn from, revise,
extend and improve.
    """,
    packages=[
    'hamcalc',
    'hamcalc.construction',
        'hamcalc.construction.arch',
        'hamcalc.construction.beamdefl',
        'hamcalc.construction.beamsect',
        'hamcalc.construction.beltdriv',
        'hamcalc.construction.binhop',
        'hamcalc.construction.chain',
        'hamcalc.construction.conecalc',
        'hamcalc.construction.cyl',
        'hamcalc.construction.gearing',
        'hamcalc.construction.guywire',
        'hamcalc.construction.shaft',
        'hamcalc.construction.stairs',
        'hamcalc.construction.torque',
        'hamcalc.construction.wirecond',
        'hamcalc.construction.wiremesh',
    'hamcalc.electronics',
        'hamcalc.electronics.awgexact',
        'hamcalc.electronics.decibel',
    'hamcalc.math',
        'hamcalc.math.accelr',
        'hamcalc.math.baromtr',
        'hamcalc.math.binary',
        'hamcalc.math.centrif',
        'hamcalc.math.curvefit',
        'hamcalc.math.deciconv',
        'hamcalc.math.decifrac',
        'hamcalc.math.equiv',
        'hamcalc.math.fibon',
        'hamcalc.math.involute',
        'hamcalc.math.binary',
        'hamcalc.math.metrics',
        'hamcalc.math.polygon',
        'hamcalc.math.primenos',
        'hamcalc.math.propcirc',
        'hamcalc.math.quadrat',
        'hamcalc.math.rotaplot',
        'hamcalc.math.solutri',
        'hamcalc.math.speedtd',
        'hamcalc.math.trig',
    'hamcalc.navigation',
        'hamcalc.navigation.distance',
        'hamcalc.navigation.gridsq',
        'hamcalc.navigation.lunar',
        'hamcalc.navigation.satorbit',
        'hamcalc.navigation.solar',
    'hamcalc.stdio',
    ],
    data_files=[('LATLONG', ['../HCALC_129/HamCalc/LATLONG/LATLONG.DAT']),]

)
