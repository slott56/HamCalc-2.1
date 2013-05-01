"""RESTful web services technology spike.

This shows an implementation using :mod:`wsgiref.simple_server`.

"""
#from hamcalc import fibon_count_iter, intro

class Fibonacci:
    """Generates the *n*\ th Fibonacci number."""
    def __init__( self, f_0=1, f_1=1 ):
        self._memo= { 0: f_0, 1: f_1, 2: f_1+f_0 }
    def __call__( self, n ):
        if n not in self._memo:
            f_n = self.__call__( n-1 ) + self.__call__( n-2 )
            self._memo[n]= f_n
        return self._memo[n]

def fibon_count_iter( f_0=1, f_1=1, count=22 ):
    fibon=Fibonacci(f_0, f_1)
    for i in range(count):
        yield fibon(i)

def intro():
    return """Fibonacci Numbers..."""

from wsgiref.simple_server import make_server
import urllib.parse
import json

def fibonacci_app(environ, start_response):
    if len(environ['QUERY_STRING']) == 0:
        status = '200 OK'
        headers = [('Content-type', 'text/plain')]
        start_response(status, headers)
        return [intro().encode('UTF-8')]

    args= urllib.parse.parse_qs( environ['QUERY_STRING']  )
    assert set(args.keys()) < {"f_0","f_1","last","count"}
    if 'count' in args:
        req= {}
        if 'f_0' in args:
            req['f_0']= int(args['f_0'][0])
        if 'f_1' in args:
            req['f_1']= int(args['f_1'][0])
        if 'count' in args:
            req['count']= int(args['count'][0])
        result= list(fibon_count_iter(**req))
    # elif 'last' in args: etc.
    document= {
        'request': args,
        'response': result,
        }

    status = '200 OK'
    headers = [('Content-type', 'application/json')]
    start_response(status, headers)
    return [json.dumps( document ).encode('UTF-8')]

httpd = make_server('', 8080, fibonacci_app)
print( "Serving on port 8080..." )
# Serve until process is killed
httpd.serve_forever()
