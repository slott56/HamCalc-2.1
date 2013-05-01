"""Decibel Calculator

"CURRENT",", dB gain/loss","","DECIBEL"
"DECIBEL",", power, voltage and current gain/loss calculator","","DECIBEL"
"POWER",", dB gain/loss","","DECIBEL"
"VOLTAGE",", dB gain/loss","","DECIBEL"
"""

import hamcalc.electronics.decibel as decibel

def solve_2():
    args = dict()
    print( """\
   Press number in < > to select factor you want to FIND :

   POWER                      VOLTAGE                    CURRENT
   ─────                      ───────                    ───────
   <1> WATTS in (source)      <4> VOLTS in (source)      <7> CURRENT in (source)

   <2> WATTS out (load)       <5> VOLTS out (load)       <8> CURRENT out (load)
   <3> dB gain/loss           <6> dB gain/loss           <9> dB gain/loss

   <0> EXIT""")

    option= input("FIND? " )
    if option == '0': return
    print( """\
    Input and Output values are expressed in the same unit of measurement.""")
    if option in ( '1', '2', '3' ):
        solver= decibel.power
        domain= "Power"
        solve_for = {'1': 'f_1', '2': 'f_2', '3': 'db'}[option]
    elif option in ( '4', '5', '6' ):
        solver= decibel.voltage
        domain= "Voltage"
        solve_for = {'3': 'f_1', '5': 'f_2', '6': 'db'}[option]
    elif option in ( '7', '8', '9' ):
        solver= decibel.current
        domain= "Current"
        solve_for = {'7': 'f_1', '8': 'f_2', '9': 'db'}[option]
    if solve_for != 'f_1':
        args['f_1'] = float( input( "{0} in (source)".format(domain) ) )
    if solve_for != 'f_2':
        args['f_2'] = float( input( "{0} out (load)".format(domain) ) )
    if solve_for != 'db':
        args['db'] = float( input( "{0} db gain/loss".format(domain) ) )

    args= solver( **args )

    print( "{0:20s} in (source): {1.f_1:8.3f}".format( domain, args ) )
    print( "{0:20s} out (load):  {1.f_2:8.3f}".format( domain, args ) )
    print( "{0:20s} gain/loss:   {1.db:8.3f}".format( domain, args ) )

unit_map= { '1': decibel.VOLT, '2': decibel.MILLIVOLT, '3': decibel.MICROVOLT,
    '4': decibel.AMP, '5': decibel.MILLIAMP, '6': decibel.MICROAMP,
    '7': decibel.WATT, '8': decibel.MILLIWATT, '9': decibel.MICROWATT }

def step():
    print( """\
DECIBEL CALCULATOR                                         by Erik Madsen OZ8EM
 Edited for HAMCALC by George Murphy VE3ERP

 This program gives the level in dBm with 1 mW/50Ω as reference (= 0 dBm). It
 also gives the ratio in dB of consecutive voltage, current or power levels.""" )


    print( """\
 Press number in < > to select:

 VOLTAGE:   <1> V
   (RMS)    <2> mV
            <3> µV

 CURRENT:   <4> A
   (RMS)    <5> mA
            <6> µA

 POWER:     <7> W
            <8> mW
            <9> µW

 EXIT       <0>""" )

    choice= input( "Units? " )
    if choice == '0': return
    unit= unit_map[choice]
    raw= input( "ENTER: First value ({0})? ".format( unit.name ) )
    if len(raw) == 0: return
    value= float(raw)
    if value == 0.0: return
    dbm= unit.standard.dBm( unit.to_std( value ) )
    print( "    {0:8.3f} {1:s} = {2:8.3f} dBm".format( value, unit.name, dbm ) )
    prev_value, prev_dbm= value, dbm
    raw= input( "ENTER: Next value ({0})...(or 0 to Quit)? ".format( unit.name ) )
    while len(raw) != 0:
        value= float(raw)
        if value == 0.0: break
        dbm= unit.standard.dBm( unit.to_std( value ) )
        print( "    {0:8.3f} {1:s} = {2:8.3f} dBm: {3:8.3f} {1:s} to {0:8.3f} {1:s} = {4:8.3f} dBm".format( value, unit.name, dbm, prev_value, dbm-prev_dbm ) )
        prev_value, prev_dbm= value, dbm
        raw= input( "ENTER: Next value ({0})...(or 0 to Quit)? ".format( unit.name ) )


print( decibel.intro() )

z= None
while z != '0':
    print()
    print( """\
   <1>  Calculate unknown factor from two known factors.
        (factors: input value, output value, dB).""" )
    print( """\
   <2>  Calculate dBm for any given value and dB change between a consecutive
        series of values.""")
    print( """\
   <0>  EXIT""")
    z= input( "? " )
    if z == '1':
        solve_2()
    elif z == '2':
        step()

