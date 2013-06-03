"""hamcalc.navigation.satorbit -- satellite orbit

Some satellite orbit information.

Test Cases for Orbital Details

>>> import hamcalc.navigation.satorbit as satorbit
>>> satorbit.orbit( 88, 10.1, 10.2 )
{'cone_diameter': 1762.2173168121756, 'fq_up': 10.1, 'speed_mph': 17407.307854142113, 'fq_down': 10.2, 'altitude': 100.0, 'doppler_shift': 0.004999999999999982, 'speed_mpm': 290.1217975690352, 'period': 88, 'radio_horizon': 881.1086584060878, 'signal_time': 0.001075268817204301, 'radius': 4063.34, 'apex_angle': 154.5246143812527}
>>> satorbit.orbit( 144, 10.1, 10.2 )
{'cone_diameter': 6306.827741575378, 'fq_up': 10.1, 'speed_mph': 14826.58944898434, 'fq_down': 10.2, 'altitude': 1699.9999999999957, 'doppler_shift': 0.004999999999999982, 'speed_mpm': 247.10982414973898, 'period': 144, 'radio_horizon': 3153.413870787689, 'signal_time': 0.01827956989247307, 'radius': 5663.339999999996, 'apex_angle': 88.82573493359294}

Test Cases for Units

>>> import hamcalc.navigation.satorbit as satorbit
>>> speed= satorbit.MPM.to_std( 7 ) # 7 miles per minute
>>> satorbit.MPM.from_std( speed )
7
>>> satorbit.MPH.from_std( speed )
420
>>> round(satorbit.FPS.from_std( speed ),4)
616.0
>>> satorbit.KPH.from_std( speed )
675.92448
>>> satorbit.KPM.from_std( speed )
11.265408
>>> satorbit.MPS.from_std( speed )
187.7568
"""
__version__ = "2.1"

import math
from hamcalc.lib import AttrDict, Unit, Standard_Unit

note_text= """\
The calculations used in this program were interpolated from
graphs appearing on page 111 of the Electronics Data Book
publication No. 27 of the ARRL. The results of these calculations
are sufficiently accurate for fast reference purposes but may not
be suitable for very accurate satellite tracking.
"""

def note():
    return note_text

class MPM( Standard_Unit ):
    """miles per minute"""
    name="mpm"

class MPH( Unit ):
    """miles per hour"""
    name= "mph"
    standard= MPM
    factor= 60

class FPS( Unit ):
    """feet per second"""
    name= "fps"
    standard= MPM
    factor= 60*1.4666667

class KPM( Unit ):
    """kilometres per minute"""
    name= "kpm"
    standard= MPM
    factor= 1.609344

class KPH( Unit ):
    """kilometres per hour"""
    name= "kph"
    standard= MPM
    factor= 60*1.609344

class MPS( Unit ):
    """metres per second"""
    name= "kph"
    standard= MPM
    factor= 1609.344/60

def orbit( minutes, fq_up, fq_down ):
    """Given an orbital period in minutes, return the calculated
    values as a dict-like object.

    :param minutes: orbit time in minutes 88 <= time <= 157
    :param fq_up: uplink frequency
    :parma fq_down: downlink frequency

    :returns: :class:`hamcalc.lib.AttrDict` with the following
        attributes

        -   altitude
        -   period
        -   radius
        -   radio_horizon
        -   cone_diameter
        -   apex_angle
        -   speed_mpm
        -   speed_mph
        -   signal_time
    """
    R= 3963.34 # Earth's Radius (miles)
    c= 186000 # Speed of light (miles per hour)
    Y= (144/88)**(1/16)
    z = (math.log(minutes)-math.log(88))/math.log(Y) + 1
    altitude = z*100
    horizon= math.acos( R/(R+altitude) )*R
    apex_angle= 2*(90-math.degrees( math.acos( R/(R+altitude) ) ) )
    speed_mpm= 2*math.pi*(R+altitude)/minutes
    signal_time= 2*altitude/c
    doppler_shift= abs( fq_up - fq_down ) /20
    return AttrDict(
        altitude=altitude, period=minutes, radius=R+altitude,
        radio_horizon=horizon, apex_angle=apex_angle,
        cone_diameter=2*horizon,
        speed_mpm= speed_mpm,  speed_mph=speed_mpm*60,
        signal_time= signal_time,
        fq_up= fq_up, fq_down= fq_down,
        doppler_shift= doppler_shift,
        )
