curvefit -- Curve Fit program
------------------------------

From the introduction:

    This program uses a least squares procedure to find the constants in an
    equation in the form Y=A+B*Z+C*Z^2+D*Z^3+E*Z^4 where Z=f(X) and X and Y
    are data pairs. You are first asked to input the data pairs. A data pair
    number is used so changes and corrections can be made. If an error is made
    when entering the data pair number, enter <D> at the X prompt. After all the
    data is entered, you are asked to select f(X). If, for instance, X covers
    many more decades than Y, you might try Z=log(X). You are next asked what
    degree of equation you want--for instance if you want Y=A+B*Z+C*Z^2, enter
    <2>. Finally, you are asked to choose between procedures that minimize
    relative or absolute error. If the Y data covers many orders of magnitude,
    small errors at large Y will cause large errors at small Y when using the
    absolute routine. If the Y data contains 0, the relative routine cannot
    be used.

From the comments:

    Adapted from Bob Dehoney's "FITCURVE" program

Also from the comments:

    Miller's prog, p74 in "Basic Prog for S & E"

    Presumably this:
    http://www.amazon.com/Basic-Programs-Scientists-Engineers-Miller/dp/0895880733

Therefore, the HamCalc program is a revision of Bob Dehoney's "FITCURVE" program which is, in turn, a rewrite of a program in Miller's book.
It doesn't seem valuable to attempt to preserve this revision of a revision.
It seems that it would be more valuable to create the Gaussian Elimination from scratch.

See `Linear least squares <http://en.wikipedia.org/wiki/Linear_least_squares_(mathematics)>`_ in Wikipedia.

This is relatively simple using :mod:`numpy`. See
http://pingswept.org/2009/01/24/least-squares-polynomial-fitting-in-python/

Analysis
~~~~~~~~~~~

This program contains a rather complex matrix manipulation.  There are several major sections to the code base.

1.  The `overall processing`_. Acquire Data. Build Polynomial Fit Matrices. Solve Matrices. Display results.

2.  `Build Matrices`_.

3.  `Solve Matrices`_, also known as the "Gauss-Jordan routine".

4.  The `graphics display`_.

Overall Processing
^^^^^^^^^^^^^^^^^^^

390-530: Accumulate X-Y pairs: :math:`\lbrace \langle x_i, y_i \rangle \vert 1 \leq i \leq n_{max} \rbrace`.

540: Assert that :math:`n_{max} \geq 2`.

550-570: Get the relation. (1) :math:`Z=X`  (2) :math:`Z=(X+K)^P`  (3) :math:`Z=\log(X+K)`  (4) :math:`Z=e^{XK}`.
Each of these involves some additional processing to create :math:`Z = f(X)`.

1.  :math:`z = \lbrace x_n  \vert 1 \leq n \leq n_{max} \rbrace`

    ::

        1250 FOR N=1 TO NMAX :Z(N)=X(N) :NEXT N :RETURN

2.  Input K and P; :math:`z = \lbrace (x_n+K)^P \vert 1 \leq n \leq n_{max} \rbrace`

    ::

        1260 INPUT "Enter K,P ",DD,PP :FOR N=1 TO NMAX :Z(N)=(X(N)+DD)^PP :NEXT N :RETURN

3.  Input K; :math:`z = \lbrace \log(x_n+K) \vert 1 \leq n \leq n_{max} \rbrace`

    ::

        1270 INPUT "Enter K ",DD :FOR N=1 TO NMAX :Z(N)=LOG(X(N)+DD) :NEXT N :RETURN

4.  Input K; :math:`z = \lbrace e^{Kx_n} \vert 1 \leq n \leq n_{max} \rbrace`

    ::

        1280 INPUT "Enter K ",DD :FOR N=1 TO NMAX :Z(N)=EXP(X(N)*DD) :NEXT N :RETURN

580-590: Get the order of the polynomial, :math:`n_x`. Set :math:`n_s \gets n_x+1`.

600: Assert that :math:`n_s \leq n_{max}`.

610-630: Get optimization goal: minimum relative error vs. minimum absolute error.

It appears that the next steps build Vandermonde Matrices. There are two variants.

-   Minimize Relative Error: lines 1290 - 1470 builds the A and W matrices.

-   Minimize Absolute Error: Lines 1480 - 1699 builds the A and W matrices.

640-650: Find A,B,& C using Miller's prog, p74 in "Basic Prog for S & E". This is lines 820-1210, the "Gauss-Jordan routine". See `Gaussian Elimination`_.

660-790: Print X, Y, computed Y, error, and the five values in the C vector.

800: Final option to edit data, or plot the curve. Plotting is lines 1610-1770.
See `Graphics Display`_.

Build Matrices
^^^^^^^^^^^^^^^^^

See http://en.wikipedia.org/wiki/Vandermonde_matrix

-   Minimum Relative Error: lines 1290 - 1470 builds the A and W matrices.

    ..  math::

        A = \begin{Bmatrix}
        \sum{\frac{Z_n^0}{Y_n^2}}&    \sum{\frac{Z_n}{Y_n^2}}& \sum{\frac{Z_n^2}{Y_n^2}}& \sum{\frac{Z_n^3}{Y_n^2}}& \sum{\frac{Z_n^4}{Y_n^2}} \\
        \sum{\frac{Z_n}{Y_n^2}}& \sum{\frac{Z_n^2}{Y_n^2}}& \sum{\frac{Z_n^3}{Y_n^2}}& \sum{\frac{Z_n^4}{Y_n^2}}& \sum{\frac{Z_n^5}{Y_n^2}} \\
        \sum{\frac{Z_n^2}{Y_n^2}}& \sum{\frac{Z_n^3}{Y_n^2}}& \sum{\frac{Z_n^4}{Y_n^2}}& \sum{\frac{Z_n^5}{Y_n^2}}& \sum{\frac{Z_n^6}{Y_n^2}} \\
        \sum{\frac{Z_n^3}{Y_n^2}}& \sum{\frac{Z_n^4}{Y_n^2}}& \sum{\frac{Z_n^5}{Y_n^2}}& \sum{\frac{Z_n^6}{Y_n^2}}& \sum{\frac{Z_n^7}{Y_n^2}} \\
        \sum{\frac{Z_n^4}{Y_n^2}}& \sum{\frac{Z_n^5}{Y_n^2}}& \sum{\frac{Z_n^6}{Y_n^2}}& \sum{\frac{Z_n^7}{Y_n^2}}& \sum{\frac{Z_n^8}{Y_n^2}}
        \end{Bmatrix}

    ..  math::

        W = \begin{Bmatrix}
        \sum{\frac{Z_n^0}{Y_n}} \\
        \sum{\frac{Z_n^1}{Y_n}} \\
        \sum{\frac{Z_n^2}{Y_n}} \\
        \sum{\frac{Z_n^3}{Y_n}} \\
        \sum{\frac{Z_n^4}{Y_n}}
        \end{Bmatrix}

-   Minimize Absolute Error: Lines 1480 - 1699 builds the A and W matrices.

    ..  math::

        A = \begin{Bmatrix}
        \sum{Z_n^0}=n_{max}& \sum{Z_n}& \sum{Z_n^2}& \sum{Z_n^3}& \sum{Z_n^4} \\
        \sum{Z_n}&     \sum{Z_n^2}& \sum{Z_n^3}& \sum{Z_n^4}& \sum{Z_n^5} \\
        \sum{Z_n^2}&     \sum{Z_n^3}& \sum{Z_n^4}& \sum{Z_n^5}& \sum{Z_n^6} \\
        \sum{Z_n^3}&     \sum{Z_n^4}& \sum{Z_n^5}& \sum{Z_n^6}& \sum{Z_n^7} \\
        \sum{Z_n^4}&     \sum{Z_n^5}& \sum{Z_n^6}& \sum{Z_n^7}& \sum{Z_n^8}
        \end{Bmatrix}

    ..  math::

        W = \begin{Bmatrix}
        \sum{Y_n Z_n^0} \\
        \sum{Y_n Z_n^1} \\
        \sum{Y_n Z_n^2} \\
        \sum{Y_n Z_n^3} \\
        \sum{Y_n Z_n^4}
        \end{Bmatrix}

See http://en.wikipedia.org/wiki/Least_squares_regression


Solve Matrices
^^^^^^^^^^^^^^^^^^^^^^

This is the Gauss-Jorden, or Gaussian Elimination algorithm.

Here's the ``numpy`` solution.

http://pingswept.org/2009/01/24/least-squares-polynomial-fitting-in-python/

Here's the Gaussian Elimination algorithm.

See http://en.wikipedia.org/wiki/Gaussian_elimination

There are three types of elementary row operations which may be performed on the rows of a matrix:

    Type 1: Swap the positions of two rows.

    Type 2: Multiply a row by a nonzero scalar.

    Type 3: Add to one row a scalar multiple of another.

**Phase 1**. Get to Echelon Form.

    For each row in a matrix, if the row does not consist of only zeros, then the left-most non-zero entry is called the leading coefficient (or pivot) of that row. So if two leading coefficients are in the same column, then a row operation of type 3 (see above) could be used to make one of those coefficients zero. Then by using the row swapping operation, one can always order the rows so that for every non-zero row, the leading coefficient is to the right of the leading coefficient of the row above. If this is the case, then matrix is said to be in row echelon form. So the lower left part of the matrix contains only zeros, and all of the zero rows are below the non-zero rows. The word "echelon" is used here because one can roughly think of the rows being ranked by their size, with the largest being at the top and the smallest being at the bottom.

    ..  math::
        \begin{bmatrix}
             2&  1& -1& \vert & 8 \\
            -3& -1&  2& \vert & -11 \\
            -2&  1&  2& \vert & -3 \\
        \end{bmatrix}

    ..  math::
        \begin{bmatrix}
             2&  1& -1&   \vert & 8 \\
             0& 1/2& 1/2& \vert & 1 \\
             0&  0&  -1&  \vert & 1 \\
        \end{bmatrix}

**Phase 2**. Get to Reduced Echelon Form.

    A matrix is said to be in reduced row echelon form if furthermore all of the leading coefficients are equal to 1 (which can be achieved by using the elementary row operation of type 2), and in every column containing a leading coefficient, all of the other entries in that column are zero (which can be achieved by using elementary row operations of type 3).

    ..  math::
        \begin{bmatrix}
             1&  0& 0& \vert & 2 \\
             0&  1& 0& \vert & 3 \\
             0&  0& 1& \vert & -1 \\
        \end{bmatrix}

Graphics Display
^^^^^^^^^^^^^^^^^^

TBD.  This may involve ``matplotlib``.


Implementation
~~~~~~~~~~~~~~~~

There appears to be little value is scrupulously analyzing the GW Basic programming.

It seems simpler to make ``numpy`` a dependency and use it. The variant Vandermonde matrices for minimum relative error vs. minimum absolute error seem to be of some value.

However.

:mod:`numpy` for Python 3.2 is not the easiest thing to install. And we only want a small piece of :mod:`numpy`: the Gaussian Elimination algorithm.
It does make a small amount of sense to provide a streamlined Gaussian Elimination.

..  automodule:: hamcalc.math.curvefit
    :members:

Quirks
~~~~~~~~

Because GW-Basic variables have a default value of zero, sums are reset **after** they're used.

Look, for example at lines 1290 to 1470. Also look at lines 1480 to 1600.
In both cases, sums are accumulated assuming an initial value of zero. After the sums are used, the variables are reset back to zero.
