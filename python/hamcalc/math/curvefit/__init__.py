"""hamcalc.math.curvefit -- Curve Fit program

This is linear least squares curve fitting.

There are several important features.

-   `Data Collection`_

-   `Transformation`_

-   `Polynomial Curve Fitting`_

-   `Gaussian Elimination`_

Data Collection
--------------------

A simple list-of-tuple structure is used to contain the sample data points.
The client application will probably have fancy input and output features
to gather the collection of data points.

Transformation
---------------

There are four transformation functions that can be applied to the X values
for the data points.

-   NUL: X_i -> X_i does nothing

-   POW(K,P): X_i -> (X_i+K)**P

-   LOG(K): X_i -> log(X_i+K)

-   EXP(K): X_i -> exp(K*X_i)

Currently, the function is provided as a string name, to make
the interface simpler for RESTful web services and JSON encoding
the arguments.

Polynomial Curve Fitting
-------------------------

The polynomial degree (0 to 5) must be provided.

Additionally, there's a specific function to be minimized.

-   Absolute Error.

-   Relative Error -- undefined if Y is ever zero.

Gaussian Elimination
--------------------

From Wikipedia

http://en.wikipedia.org/wiki/Gaussian_elimination

Pseudo-Code

::

    for k = 1 ... m:
      #Find pivot for column k:
      i_max := argmax (i = k ... m, abs(A[i, k]))
      if A[i_max, k] = 0
        error "Matrix is singular!"
      swap rows(k, i_max)
      #Do for all rows below pivot:
      for i = k + 1 ... m:
        #Do for all remaining elements in current row:
        for j = k + 1 ... n:
          A[i, j] := A[i, j] - A[k, j] * (A[i, k] / A[k, k])
        #Fill lower triangular matrix with zeros:
        A[i, k] := 0

Overall Test Cases
-------------------

See http://en.wikipedia.org/wiki/Linear_least_squares_(mathematics)#Motivational_example

>>> import hamcalc.math.curvefit as curvefit
>>> DATA = [ (1,6), (2,5), (3,7), (4,10) ]
>>> C = curvefit.fit( DATA )
>>> [ round(x,3) for x in C ]
[3.5, 1.4]
>>> for x,y in DATA:
...     y_f= sum( (c*x**i for i, c in enumerate(C)) )
...     err = float("NaN") if y == 0 else (y-y_f)/y
...     print( x, y, round(y_f,3), round(y-y_f,3), round(err,3) )
...
1 6 4.9 1.1 0.183
2 5 6.3 -1.3 -0.26
3 7 7.7 -0.7 -0.1
4 10 9.1 0.9 0.09

The output vector has the following interpretation.

..  math::

    y= 3.5 + 1.4x

For higher-order polynomials there will be more terms.

Sum of absolute error is 0, sum of relative error is -0.142.

Another test case, using the relative error instead of the default
absolute error.

>>> import hamcalc.math.curvefit as curvefit
>>> DATA = [ (1,6), (2,5), (3,7), (4,10) ]
>>> D = curvefit.fit( DATA, minimize='rel' )
>>> [ round(x,3) for x in D ]
[3.803, 1.13]
>>> for x,y in DATA:
...     y_f= sum( (c*x**i for i, c in enumerate(D)) )
...     err = float("NaN") if y == 0 else (y-y_f)/y
...     print( x, y, round(y_f,3), round(y-y_f,3), round(err,3) )
...
1 6 4.933 1.067 0.178
2 5 6.063 -1.063 -0.213
3 7 7.192 -0.192 -0.027
4 10 8.322 1.678 0.168

Sum of absolute error is 1.49, sum of relative error is .106.

"""
__version__ = "2.1"

import math

introduction="""\
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
"""
def intro():
    return introduction

def argmax( indices, A, column, f=abs ):
    """Locate the argument for which the function of A[i,column]
    is maximized for i in indices.

    >>> import hamcalc.math.curvefit as curvefit
    >>> A = [
    ...     [ 2, 1,-1,  8],
    ...     [-3,-1, 2,-11],
    ...     [-2, 1, 2, -3],
    ... ]
    >>> curvefit.argmax( range(1,3), A, column=3 )
    1

    :param indices: index values for rows to examine
    :param A: Matrix
    :param column: column to examine.
    :param f: Function to use, default is :func:`abs`.
    """
    i_max= indices[0]
    for i in indices[1:]:
        if f(A[i][column]) > f(A[i_max][column]):
            i_max= i
    return i_max

def gauss( M ):
    """Gaussian Elimination on an m row by n column matrix A.
    n is expected to be m+1 when solving simultaneous linear equations.

    :param M: is a "list-of-lists" matrix with m rows.  Each row
        is an n-element list.
    :returns: New matrix in reduced echelon form.

    >>> import hamcalc.math.curvefit as curvefit
    >>> A = [
    ...     [ 2, 1,-1,  8],
    ...     [-3,-1, 2,-11],
    ...     [-2, 1, 2, -3],
    ... ]
    >>> B= curvefit.gauss( A )
    >>> [ [ round(x) for x in row ] for row in B ]
    [[1, 0, 0, 2], [0, 1, 0, 3], [0, 0, 1, -1]]

    >>> C = [
    ...     [ 1, 3, 1, 9],
    ...     [ 1, 1,-1, 1],
    ...     [ 3,11, 5, 35],
    ...     ]
    >>> D = curvefit.gauss( C ) #doctest: +IGNORE_EXCEPTION_DETAIL
    Traceback (most recent call last):
      File "/Library/Frameworks/Python.framework/Versions/3.2/lib/python3.2/doctest.py", line 1288, in __run
        compileflags, 1), test.globs)
      File "<doctest default[1]>", line 1, in <module>
        D = curvefit.gauss( C )
      File "/Users/slott/github/local/HamCalc-2.1/python/hamcalc/math/curvefit/__init__.py", line 124, in gauss
        raise ValueError( "Matrix is singular!" )
    ValueError: Matrix is singular!

    >>> E = [ [1, -3, 1, 4], [2, -8, 8, -2], [-6, 3, -15, 9] ]
    >>> F = curvefit.gauss( E )
    >>> [ [round(v,6) for v in row] for row in F ]
    [[1.0, -0.0, -0.0, 3.0], [0.0, 1.0, -0.0, -1.0], [0.0, 0.0, 1.0, -2.0]]
    """
    A= M[:] # Clone it.

    # Phase 1: Echelon Form.
    for k in range(len(A)):
        # Find pivot for column k:
        i_max= argmax( range(k,len(A)), A, k )
        if A[i_max][k] == 0:
            raise ValueError( "Matrix is singular!" )
        A[k], A[i_max] = A[i_max], A[k]
        # Do for all rows below pivot:
        for i in range(k+1,len(A)):
            # Do for all remaining elements in current row:
            for j in range(k+1,len(A[i])):
                A[i][j] = A[i][j] - A[k][j] * (A[i][k]/A[k][k])
            # Fill lower triangular matrix with zeros:
            A[i][k]= 0.0

    # Phase 2: Reduced Echelon Form.
    for k in range(len(A)):
        r= len(A)-k-1
        f= 1/A[r][r]
        for j in range(r,len(A[r])):
            A[r][j]= A[r][j]*f
        for i in range(0,r):
            f= A[i][r]
            for j in range(0,len(A[i])):
                A[i][j]= A[i][j] - A[r][j]*f
    return A

def min_relative( points, order ):
    """Minimize Relative Error; requires Y != 0.

    >>> import hamcalc.math.curvefit as curvefit
    >>> DATA = [ (1,6), (2,5), (3,7), (4,10) ]
    >>> curvefit.min_relative( DATA, 4 )
    [[0.09818594104308388, 0.20900226757369614, 0.5314512471655329, 1.538798185941043, 0.6095238095238095], [0.20900226757369614, 0.5314512471655329, 1.538798185941043, 4.8808390022675745, 1.3952380952380952], [0.5314512471655329, 1.538798185941043, 4.8808390022675745, 16.506961451247165, 3.8523809523809525], [1.538798185941043, 4.8808390022675745, 16.506961451247165, 58.425328798185944, 12.023809523809526]]
    """
    sums_A = [ sum( x**k/y**2 for x,y in points ) for k in range(0,2*order-1) ]
    sums_W = [ sum( x**k/y for x,y in points ) for k in range(order) ]
    matrix= [ sums_A[i:i+order] + [ sums_W[i] ] for i in range(order) ]
    return matrix

def min_absolute( points, order ):
    """Minimize Absolute Error.

    >>> import hamcalc.math.curvefit as curvefit
    >>> DATA = [ (1,6), (2,5), (3,7), (4,10) ]
    >>> curvefit.min_absolute( DATA, 4 )
    [[4, 10, 30, 100, 28], [10, 30, 100, 354, 77], [30, 100, 354, 1300, 249], [100, 354, 1300, 4890, 875]]
    """
    sums_A = [ sum( x**k for x,y in points ) for k in range(0,2*order-1) ]
    sums_W = [ sum( y*x**k for x,y in points ) for k in range(order) ]
    matrix= [ sums_A[i:i+order] + [ sums_W[i] ] for i in range(order) ]
    return matrix

def data_transform( points_raw, name, args=None ):
    """Various transformation functions.

    :param points_raw: Sequence of (x,y) pairs.
    :param name: Name of transformation: NULL, POW, LOG, EXP.
    :param args: dictionary of arguments, 'k' and 'p'.
    :returns: Sequence of (f(x),y) pairs.

    >>> import hamcalc.math.curvefit as curvefit
    >>> DATA = [ (1,6), (2,5), (3,7), (4,10) ]
    >>> curvefit.data_transform( DATA, "NULL" )
    [(1, 6), (2, 5), (3, 7), (4, 10)]
    >>> curvefit.data_transform( DATA, "POW", { 'k': 3, 'p': 2 } )
    [(16, 6), (25, 5), (36, 7), (49, 10)]
    >>> curvefit.data_transform( DATA, "LOG", { 'k': 5 } )
    [(1.791759469228055, 6), (1.9459101490553132, 5), (2.0794415416798357, 7), (2.1972245773362196, 10)]
    >>> curvefit.data_transform( DATA, "EXP", { 'k': 1 } )
    [(2.718281828459045, 6), (7.38905609893065, 5), (20.085536923187668, 7), (54.598150033144236, 10)]

    """
    functions = {
        'NULL': lambda x, args: x,
        'POW': lambda x, args: (x+args['k'])**args['p'],
        'LOG': lambda x, args: math.log( x+args['k'] ),
        'EXP': lambda x, args: math.exp( x*args['k'] ),
        }
    if args is None: args= dict()
    func= functions[name]
    points= [ (func(x,args),y) for x,y in points_raw ]
    return points

def fit( points_raw, transform="NULL", args=None, order=2, minimize='absolute' ):
    """Curve Fit.

    :param points: is a sequence of (x,y) tuples
    :param transform: is the name of the transform function.
        "NULL", "POW", "LOG", "EXP" are the defined functions.
        The "POW" function requires both "k" and "p".
        The "LOG" and "EXP" functions require "k".
    :param args: is a dictionary with values of "k" or "p" or both
        for the transformation function.
    :param order: Polynomial order (0 to 5).
    :param minmize: is either "absolute" or "relative".

    :returns: Coefficients for the polynomial that fits the points.
    """
    # Transform.
    points= data_transform( points_raw, transform, args )

    # Build Vandermonde Matrix.
    if minimize.lower().startswith('abs'):
        A_W= min_absolute( points, order )
    elif minimize.lower().startswith('rel'):
        A_W= min_relative( points, order )

    # Solve.
    C = gauss( A_W )
    return [ row[-1] for row in C ]
