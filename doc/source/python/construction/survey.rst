survey -- Surveyor's Calculator
----------------------------------------

Introduction

::

    SURVEYOR'S CALCULATOR                                   by George Murphy VE3ERP

    Ref. Thomas L. Glover, Pocket Ref, 2nd edition, Sequoia Publishing, pp.373-382

Analysis
~~~~~~~~~~

There are three **Solver** classes here.

1.  Slope/Gradient/Grade Calculator

2.  Stadia Calculator

3.  Apparent Dip Calculator

The Slope/Gradient/Grade Calculator is a **Solver** that
works in Horizontal distance, *H*, Vertical rise, *V*,
Slope in degrees, *D*, Grade in %, *G*, or Gradient as a ratio, *X*.

Compute *D*, given *V* and *H*, :math:`D = \arctan \dfrac{V}{H}`.

Compute *V*, given *D* and *H*, :math:`V = H \tan D`.

Compute *H*, given *D* and *V*, :math:`H = \dfrac{V}{\tan D}`.

Compute *G*, given *D*, :math:`G = 100 \tan D`.

Compute *D*, given *G*, :math:`D = \arctan \dfrac{G}{100}`.

Compute *X*, given *V* and *H*, :math:`X = \dfrac{H}{V}`.

Compute *H*, given *X* and *V*, :math:`H = X \times V`.

Compute *V*, given *H* and *X*, :math:`V = \dfrac{H}{X}`.

The Stadia Calculator is a **Solver** that works in
Slope angle (degrees), *A*, Slope distance, *S*,
Vertical distance, *V*, and Horizontal distance, *H*.

Compute *V* and *H*, given *R* and *S*, :math:`V = S \sin R, H = \sqrt{S^2-V^2}`

Compute *S* and *H*, given *R* and *V*, :math:`S = \dfrac{V}{\sin R}, H = \sqrt{S^2-V^2}`

Compute *S* and *V*, given *R* and *H*, :math:`S = \dfrac{H}{\cos R}, V = \sqrt{S^2-H^2}`

Compute *R* and *H*, given *S* and *V*, :math:`R = \arcsin \dfrac{V}{S}, H = \sqrt{S^2-V^2}`

Compute *R* and *V*, given *S* and *H*, :math:`R = \arccos \dfrac{H}{S}, V = \sqrt{S^2-H^2}`

Compute *R* and *S*, given *V* and *H*, :math:`R = \arctan \dfrac{V}{H}, S = \sqrt{V^2+H^2}`


The Apparent Dip Calculator is a **Solver**
that works in Apparent Dip, *D_A*, True dip, *D_T* and
"Angle between", *A*, which refers to angle between Strike and direction of Cross Section.

Compute *A*, given *D_A* and *D_T*, :math:`A= \arcsin \dfrac{\tan D_A}{\tan D_T}`.

Compute *D_T*, given *D_A* and *A*, :math:`D_T = \arctan \dfrac{\tan D_A}{\sin A}`.

Compute *D_A*, given *D_T* and *A*, :math:`D_A = \arctan (\tan{D_T} \sin A)`.

Legacy Quirks
~~~~~~~~~~~~~~

Here's one definition of arcsine. This has a slightly less quirky API ``X=V/S:AB=FNASN``.

::

    1510 DEF FNASN=ATN(X/SQR(-X^2+1))  :REM'arcsine

Here's another definition of arcsine. In the same program.  This has a quirky API. ``X=V/S:GOSUB 1050:R=ASN``.

::

    1050 :REM'.....inverse sin and cos
    1060 ASN=ATN(X/SQR(-X^2+1))       :REM'arcsin
    1070 ACS=-ASN+PI/2                :REM'arcsin
    1080 RETURN

