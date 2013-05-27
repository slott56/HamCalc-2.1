"""Satellite Orbit Parameters

"ORBIT CALCULATOR",", satellite","","SATORBIT"
"SATELLITE ORBIT CALCULATOR","","","SATORBIT"
"""
import hamcalc.navigation.satorbit as satorbit
from hamcalc.math.equiv import MILE, KILOMETRE

def orbit( unit_dist, unit_speed_1, unit_speed_2 ):
    period= None
    while period is None:
        try:
            pd_raw= input( " ENTER: Period (time for single orbit) (87-157 min.) ? " )
            period= float(pd_raw)
        except ValueError:
            pass
    fq_up = fq_down = None
    while fq_up  is None or fq_down is None:
        try:
            fq_up_raw= input( " ENTER: UPLINK frequency (MHz).......................? " )
            fq_up= float( fq_up_raw )
            fq_dn_raw= input( " ENTER: DOWNLINK frequency (MHz).....................? " )
            fq_down= float( fq_dn_raw )
        except ValueError:
            pass
    details= satorbit.orbit( period, fq_up, fq_down )
    altitude= MILE.to_std(details.altitude)
    print( "    Satellite altitude........................... {0:7.0f} {1}".
        format( unit_dist.from_std( altitude ), unit_dist.__doc__ ) )
    horizon= MILE.to_std(details.radio_horizon)
    print( "    Satellite signal map range (radio horizon)... {0:7.0f} {1}".
        format( unit_dist.from_std( horizon ), unit_dist.__doc__ ) )
    print( "    Apex angle of satellite signal cone.......... {0:7.0f}°".
        format( details.apex_angle) )
    diameter= MILE.to_std(details.cone_diameter)
    print( "    Diameter of area covered by signal cone...... {0:7.0f} {1}".
        format( unit_dist.from_std( diameter ), unit_dist.__doc__ ) )
    print( "    Period (time for single orbit)............... {0:7.0f} minutes".
        format( details.period) )
    speed= satorbit.MPM.to_std( details.speed_mpm )
    print( "    Satellite orbital speed...................... {0:7.0f} {1}".
        format( unit_speed_1.from_std( speed ), unit_speed_1.__doc__ ) )
    print( "                                                = {0:7.0f} {1}".
        format( unit_speed_2.from_std( speed ), unit_speed_2.__doc__ ) )
    print()
    print( "    Up-and-Back signal time ..................... {0:7.4f} seconds".
        format( details.signal_time) )
    print( "    UPLINK frequency............................. {0:7.4f} MHz".
        format( details.fq_up) )
    print( "    DOWNLINK frequency........................... {0:7.4f} MHz".
        format( details.fq_down) )
    print( "    Approximate maximum Doppler shift............ {0:7.0f} KHz".
        format( details.doppler_shift) )
    print()

units= None
while units != '0':
    print("   < 1 >  Metric")
    print("   < 2 >  U.S.A./Imperial")
    print()
    print("     or Press < 0 > to EXIT.....")
    units= input( "CHOICE? " )
    if units == '1':
        orbit( KILOMETRE, satorbit.KPH, satorbit.MPS )
    elif units == '2':
        orbit( MILE, satorbit.MPH, satorbit.FPS )

