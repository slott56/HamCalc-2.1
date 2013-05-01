"""RESTful web services technology spike.

This shows an implementation using :mod:`http.server`.

"""
#from hamcalc import fibon_count_iter

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

import http.server
import urllib.parse
import json

class REST_Fibonacci( http.server.BaseHTTPRequestHandler ):
    def do_GET( self ):
        self.log_message( self.path )
        try:
            assert self.path.startswith( "/fibonacci/" )
            _, _, qs= self.path.partition("?")
            args= urllib.parse.parse_qs( qs )
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
            self.log_message( str(document) )
            self.send_response( 200 )
            self.send_header( 'Content-Type', 'application/json' )
            self.send_header( 'Content-Encoding', 'UTF-8' )
            self.end_headers()
            self.wfile.write( json.dumps( document ).encode("UTF-8") )
            self.wfile.flush()
        except Exception as e:
            self.send_error( 501, str(e) )

httpd= http.server.HTTPServer( ("", 8080), REST_Fibonacci )
httpd.handle_request() # serve_forever()
