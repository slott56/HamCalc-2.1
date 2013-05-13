rotaplot -- Cartesian/Polar Plot Rotator
----------------------------------------

Analysis
~~~~~~~~~~~~

From the introduction::

    CARTESIAN/POLAR PLOT ROTATOR                            by George Murphy VE3ERP

                  Y «0°
              -x  │  +x
              +y  │  +y
     270°» X───── * ─────X «90°
              -x  │  +x
              -y  │  -y
                  Y «180°

     This program rotates a plotted point or pattern of plotted points about the
     junction * of the x and y axis of the plot. The new locations are indicated in
     both cartesian and polar coordinates.

     Coordinates may be entered in any unit of measure. All entries must be in the
     same units.

This is a set of common transformations.

1.  Input conversion.

    -   Polar :math:`(r, \theta)` to Cartesian :math:`(x,y)`

        ..  math::

            x = r \cos \theta

            y = r \sin \theta

    -   Cartesian to Polar

        ..  math::

            \theta = \arctan \frac{y}{x}

            r = \sqrt{ x^2 + y^2 }

2.  Rotation through angle, *a*.

    ..  math::

        x \prime = r \cos { \theta + a }

        y \prime = r \sin { \theta + a }

3.  Display Cartesian and Polar.

Output format::

     ┌─────────────── Cartesion Plot ───────────────┐│┌──────── Polar Plot ────────┐
     ┌───── rotate from ────┐ ┌───── rotate to ─────┐│            ┌─ rotate angle ─┐
          -x-          -y-        -x-          -y-   │    Vector  ┌ from ┐  ┌─ to ─┐
     ───────────────────────────────────────────────────────────────────────────────┼

The display includes proper :math:`(\theta + a) \mod 360` of the resulting angle.

Implementation
~~~~~~~~~~~~~~~~

Note that polar to Cartesian and Cartersian to polar conversions are
part of :mod:`cmath`. These apply to the complex plane.

..  automodule:: hamcalc.math.rotaplot
    :members:

Legacy Quirks
~~~~~~~~~~~~~~

Consider this line::

    1100 W=ATN(ABS(X)/ABS(Y))

That appears to be completely incorrect.

See http://en.wikipedia.org/wiki/Inverse_trigonometric_functions#Application:_finding_the_angle_of_a_right_triangle

The general approach is "opposite"/"adjacent", :math:`y/x`.

Lines 1180 and 1190 recompute the input values X, and Y. Not really necessary, but there it is.

Finally, there's a bunch of clever repositioning of the cursor to fill in the nice tabular display of points. Not easy to do with simple stdio functions.
