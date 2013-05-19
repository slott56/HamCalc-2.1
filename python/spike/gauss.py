#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
"""Gaussian Elimination.

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

>>> A = [
...     [ 2, 1,-1,  8],
...     [-3,-1, 2,-11],
...     [-2, 1, 2, -3],
... ]
>>> argmax( range(1,3), A, column=3 )
1
>>> B= gauss( A )
>>> [ [ round(x) for x in row ] for row in B ]
[[1, 0, 0, 2], [0, 1, 0, 3], [0, 0, 1, -1]]
"""

def argmax( indices, A, column, f=abs ):
    i_max= indices[0]
    for i in indices[1:]:
        if f(A[i][column]) > f(A[i_max][column]):
            i_max= i
    return i_max

def gauss( A ):
    """Gaussian Elimination on an m row by n column matrix A.
    n is expected to be m+1 when solving simultaneous linear equations.

    :param A: is a "list-of-lists" matrix with m rows.  Each row
    is an n-element list.
    :returns: New matrix in reduced echelon form.
    """
    A= A[:] # Clone it.

    # Phase 1: Echelon Form.
    for k in range(len(A)):
        # Find pivot for column k:
        i_max= argmax( range(k,len(A)), A, k )
        if A[i_max][k] == 0:
            raise TypeError( "Matrix is singular!" )
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
        for j in range(i,len(A[i])):
            A[i][j]= A[i][j]*f
        for i in range(0,r):
            f= A[i][r]
            for j in range(0,len(A[i])):
                A[i][j]= A[i][j] - A[r][j]*f
    return A

if __name__ == "__main__":
    import doctest
    doctest.testmod()
