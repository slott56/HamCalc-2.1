cyl -- Cylinders, Air & Hydraulic
----------------------------------

Legacy Output
~~~~~~~~~~~~~~~

TBD

Analysis
~~~~~~~~~

This is a **Solver** for a number of features of
a cylinder.

:P: PSI

:A: Cylinder Area, based on diameter, *C*.

    :math:`A = \pi \left(\frac{C}{2}\right)^2`

:O: Lbs. Push

:D: Rod Area, based on diameter, *R*.

    :math:`D = \pi \left(\frac{R}{2}\right)^2`

:I: Lbs. Pull

:B: The cylinder outside the rod.

Rule 1 :math:`A = B + D` in all three forms.

::

    480 IF A*D THEN B=A-D
    540 IF A*B THEN D=A-B
    550 IF B*D THEN A=B+D

Rule 2 :math:`O = AP`, :math:`P=O/A` and :math:`A=O/P`.

::

    560 IF A*P THEN O=A*P
    570 IF A*O THEN P=O/A
    580 IF A=0 AND (P*O>0) THEN A=O/P

Rule 3 :math:`I = BP`, :math:`P=I/B` and :math:`B=I/P`.

::

    590 IF B*P THEN I=B*P
    600 IF B*I THEN P=I/B
    610 IF B=0 AND (P*I>0) THEN B=I/P

Rule 4: Diameter, *C*.

Once *A*, *P* and *O* are known, then a cylinder diameter, *Z*,
can be computed.

..  math::

    Z = 2 \sqrt{\dfrac{A}{\pi}}

This next part is quirky. *W* is initially zero. After the
user is prompted, the calculation is rerun with *A* set and
all other variables not set.

If the computed diameter *Z* is not equal to *W*, then.

    The user is prompted for *W*.

    :W: Next standard dia.

    Then *A*, *B*, *D* and *I* are all computed from *W*.

    ..  math::

        A &= \pi\left(\frac{W}{2}\right)^2 \\
        B &= 0 \\
        D &= 0 \\
        I &= 0

    The calculation is rerun, prompting user for values
    of B, D and I.

If :math:`W = Z`, then the user has been already been prompted once,
*W* is a standard diameter and so is *Z*.  *C* is set to the computed diameter, *Z*.

If *B* is not known yet and the user wants to set pull pounds,
then, *I* is set to 1e-06 and the rules are re-evaluated.

Final Display:

If the user wants displacement, their prompted for stroke length.

:S: Stroke (in.)
:V: Displacement Volume, :math:`V = SA`.

Implementation
~~~~~~~~~~~~~~~~

..  automodule:: hamcalc.construction.cyl
    :members:

Quirks
~~~~~~~~

As with other solvers, this makes multiple passes through
the rules. In this case, it's just two passes.

Also, there's comparisons against the value of ``W``, before
it's set by an **INPUT** statement.
