beamsect -- BEAMS, Properties of (Start new beam design here)
---------------------------------------------------------------

This program could provide data (i.e., cross-section) information
by chaining to :program:`beamdefl`.

Legacy Output
~~~~~~~~~~~~~~

Introduction::

     PROPERTIES OF COMMON SECTIONS OF BEAMS                  by George Murphy VE3ERP

       Ref: Machinery's Handbook, 21st Edition

Output::

         Hollow Tubular Beam    ( NOTE: ENTER ALL DIMENSIONS IN INCHES )

 ENTER: Outside diameter of section.....? 13
 ENTER: Inside diameter of section......? 12
         Outside diameter of section...........     13.000 in.
         Inside diameter of section............     12.000 in.
         Cross section area of section.........     19.635 in²
         Moment of Inertia....(in inches^4)....    384.109
         Section Modulus......(in inches^3)....     59.094
         Radius of Gyration....................      4.423 in.

Analysis
~~~~~~~~~

These are 10 sets of formulae for computing the four interesting factors:
cross section, Moment of Inertia, Section Modulus and Radius of Gyration.

:A: Area
:Y: "Radius"
:I: Moment of Inertia (in inches^4)
:Z: Section Modulus (in inches^3) :math:`\dfrac{I}{Y}`
:K: Radius of Gyration :math:`\sqrt{\dfrac{I}{A}}`

Solid Rectangular Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width
    :D: Height

    ..  math::

        A &= B \times D \\
        Y &= D/2 \\
        I &= B \times D^3/12 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

Solid Triangular Beam (flat bottom)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width
    :D: Height

    ..  math::

        A &= B \times D/2 \\
        Y &= 2 \times D/3 \\
        I &= B \times D^3/36 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

Hollow Rectangular Box Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width
    :D: Height
    :T_1: Thickness of sidewalls
    :T_2: Thickness of top & bottom walls

    ..  math::

        H &= B-2 \times T_1 \\
        k^\prime &= D-2 \times T_2 \\
        A &= B \times D-H \times k^\prime \\
        Y &= D/2 \\
        I &= (B \times D^3-H \times k^{\prime3})/12 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

Note the :math:`k^\prime` is a quirky use of ``K`` as an intermediate
variable as well as an output.

Solid Cylindrical Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :D: Diameter

    ..  math::

        A &= \pi \times D^2/4 \\
        Y &= D/2 \\
        I &= \pi \times D^4/64 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

Hollow Tubular Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :D: Outside diameter of section
    :D_1: Inside diameter of section

    ..  math::

        A &= \pi \times (D^2-D_1^2)/4 \\
        Y &= D/2 \\
        I &= \pi \times (D^4-D_1^4)/64 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}


I-Section Built-Up Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width of top & bottom flanges
    :D: Height of section
    :S: Thickness of top & bottom flanges
    :T: Thickness of vertical web

    ..  math::

        H &= D-2 \times S \\
        A &= B \times D - H \times (B-T) \\
        Y &= H/2 \\
        I &= (B \times D^3 - H^3 \times (B-T))/12 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

H-Section Built-Up Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :D: Width across outside of vertical legs
    :B: Height of vertical legs
    :S: Thickness of vertical legs
    :T: Thickness of horizontal web

    ..  math::

        H &= D-2 \times S \\
        A &= B \times D-H \times (B-T) \\
        Y &= B/2 \\
        I &= (2 \times S \times B^3+H \times T^3)/12 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

[-Section Built-Up Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width of horizontal legs
    :D: Vertical height of section
    :S: Thickness of horizontal legs
    :T: Thickness of vertical web

    ..  math::

        H &= D-2 \times S \\
        A &= B \times D-H \times (B-T) \\
        Y &= D/2 \\
        I &= (B \times D^3-H^3 \times (B-T))/12 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

U-Section Built-Up Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :D: Width of base of section
    :B: Height of section
    :T: Thickness of base web
    :S: Thickness of vertical legs

    ..  math::

        H &= D-2 \times S \\
        A &= B \times D-H \times (B-T) \\
        Q_1 &= 2 \times B^2 \times S+H \times T^2 \\
        Q_2 &= 2 \times B \times D-2 \times H \times (B-T) \\
        Y &= B-Q_1/Q_2 \\
        I &= (2 \times S \times B^3+H \times T^3)/3-A \times (B-Y)^2 \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

T-Section Built-Up Beam
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    :B: Width of horizontal flange
    :D: Height of section
    :S: Thickness of horizontal flange
    :T: Thickness of vertical web

    ..  math::

        H &= D-S \\
        A &= B \times S+H \times T \\
        Q_1 &= D^2 \times T+S^2 \times (B-T) \\
        Q_2 &= 2 \times (B \times S+H \times T) \\
        Y &= D-Q_1/Q_2 \\
        I &= \dfrac{T \times Y^3+B \times (D-Y)^3 - (B-T) \times (D-Y-S)^3}{3} \\
        Z &= \dfrac{I}{Y} \\
        K &= \sqrt{\dfrac{I}{A}}

Implementation
~~~~~~~~~~~~~~~~~

This imports :program:`beamdefl` to handle deflection
calculations based on beam design.

..  automodule:: hamcalc.construction.beamsect
    :members:
