"""hamcalc.math.baromtr -- Barometer Reading Equivalents

This is, essentially, a collection of unit conversions for various
ways to measure atmospheric presssure.

The units include:

-   MB Millibars
-   ATM Standard Atmospheres, sometimes abbreviated S.A.
-   CM_Hg cm of Mercury
-   IN_Hg inches of Mercury
-   M_W meters of Water
-   IN_W inches of Water
-   FT_W feet of Water
-   PSI pounds per square inch, lb/in²
-   PSF pounds per square foot, lb/ft²
-   BAR kilograms per square cm, kg/cm²
-   KPA kilo Pascals

These units are wrapped in two functions to provide features for the application.

Ths includes is a **Table** of values, and all unit **Equivalents** for a given value.

Here are some test cases.

>>> import hamcalc.math.baromtr as baromtr
>>> t= list(baromtr.table())
>>> t[0]
(95.5, 28.200893165556376, 13.85115223291389, 973.6146064643474, 0.9425117197137922)
>>> t[-1]
(106.0, 31.301514927214406, 15.374053787318035, 1080.6612385886997, 1.0461386627189735)
>>> len(t)
22
>>> baromtr.equivalent( 1033, baromtr.MB )
(1033.0, 1.0, 76.0, 29.921, 10.3322, 406.782, 33.899, 14.696, 2116.2, 1.0332, 101.325)


"""
__version__ = "2.1"

introduction = """\
 BAROMETER READING EQUIVALENTS                           by George Murphy VE3ERP """

from hamcalc.lib import Unit, Standard_Unit, convert

class Error( Exception ):
    pass

def intro():
    """Returns the text from the introductory page."""
    return introduction

class ATM( Standard_Unit ):
    """Standard atmospheres"""
    name= 'atm'

class MB( Unit ):
    """Millibars"""
    standard= ATM
    name= 'mb'
    factor= 1033

class CM_Hg( Unit ):
    """Centimetres of mercury"""
    standard= ATM
    name= 'cm.Hg'
    factor= 76

class IN_Hg( Unit ):
    """Inches of mercury"""
    standard= ATM
    name= 'in.Hg'
    factor= 29.921

class M_W( Unit ):
    """Metres of water"""
    standard= ATM
    name= 'm.w'
    factor= 10.3322

class IN_W( Unit ):
    """Inches of water"""
    standard= ATM
    name= 'in.w'
    factor= 406.782

class FT_W( Unit ):
    """Feet of water"""
    standard= ATM
    name= 'ft.w'
    factor= 33.899

class PSI( Unit ):
    """Pounds per square inch"""
    standard= ATM
    name= 'lb/in²'
    factor= 14.696

class PSF( Unit ):
    """Pounds per square foot"""
    standard= ATM
    name= 'lb/ft²'
    factor= 2116.2

class BAR( Unit ):
    """Kilograms per square centimetre"""
    standard= ATM
    name= 'kg/cm²'
    factor= 1.0332

class KPA( Unit ):
    """Kilopascals"""
    standard= ATM
    name= 'kPa'
    factor= 101.325

class MPA( Unit ):
    """Megapascals"""
    standard= ATM
    name= 'mPa'
    factor= 0.101325

class KG_SQ_M( Unit ):
    """Kilograms per square metre"""
    standard= ATM
    name= 'kg/m²'
    factor= 10332.274

def table( kpa_start=95.5, kpa_stop=106.5, kpa_step=0.5 ):
    """Yields a sequence of values from 95.5 kPa to 106 kPa in .5 kPa steps.

    :return: tuple of kPa, in.hg, lb/in², mb, atm
    """
    for i in range( int((kpa_stop-kpa_start)/kpa_step) ):
        v_kpa= i*kpa_step+kpa_start
        v_in_hg, v_psi, v_mb, v_atm= convert( v_kpa, KPA, IN_Hg, PSI, MB, ATM )
        yield v_kpa, v_in_hg, v_psi, v_mb, v_atm

def equivalent( value, unit ):
    """Converts a value in the given units to a series of other units.

    :param value: Measurement
    :param unit: Source unit class.
    :return: Tuple with pressure in mb, atm, cm_hg, in_hg, m_w, in_w, ft_w, psi, psf, bar, kpa.
    """
    return convert( value, unit, MB, ATM, CM_Hg, IN_Hg, M_W, IN_W, FT_W, PSI, PSF, BAR, KPA )

units= (MB, ATM, CM_Hg, IN_Hg, M_W, IN_W, FT_W, PSI, PSF, BAR, KPA)
