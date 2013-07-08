..  _construction.shaft:

shaft -- Shafts and Shafting
-----------------------------

See :ref:`construction.beltdriv`,
:ref:`construction.chain`,
:ref:`construction.gearing`,
and :ref:`construction.torque`.

Legacy Output
~~~~~~~~~~~~~~~

This is output from option 2, Shaft with pulleys.

::

    SHAFTING DESIGN                                         by George Murphy VE3ERP

                               Press number in ( ) to describe shaft

                              (1)  Main shaft
                              (2)  Shaft with pulleys
                              (3)  Stub shaft

                              (0)  EXIT
    SHAFTING SPECIFICATIONS:

    Shaft R.P.M. .................? 3500
    ( Press [ENTER] if you want to determine shaft dia. from other data )
    Shaft diameter (in) ..........?


    ( Press [ENTER] if you want to determine horsepower from other data )
    Horsepower ...................? 80
    SHAFTING SPECIFICATIONS

    Minimum shaft diameter (in.)..     1.069
    Shaft R.P.M. .................  3500.000
    Maximum horsepower ...........    80.000
    Max. inches between bearings..    65.253

Analysis
~~~~~~~~~~~

This is a **Solver** for Diameter, *D*, RPM, *N*, and maximum
horsepower, *H*.

It also computes "Max. inches between bearings", *L*,
for main shaft and shaft with pulleys.

There are three shaft configurations

-  Main shaft: Y=80, Z=107.4
-  Shaft with pulleys: Y=53.5, Z=62.4
-  Stub shaft: Y=38.  Do not show bearings.

..  math::

    H &= \dfrac{D^3 N}{Y} \\
    D &= \sqrt[3]{\dfrac{HY}{N}} \\
    N &= \dfrac{HY}{D^3}

The bearing calculation:

..  math::

    L = Z\sqrt[3]{D^2} = ZD^{\frac{2}{3}}


Implementation
~~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.shaft
    :members:

Quirks
~~~~~~~~~

::

    440 X=(D^2)^(1/3)

Could have been ``X=D^(2/3)``. But it wasn't.

