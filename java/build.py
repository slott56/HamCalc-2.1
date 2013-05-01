#!/usr/bin/env python
"""Build hamcalc pages.

1.  Apply the ham.tmpl template to each *.page calculator.

2.  Copy the graphics.

3.  Compile and jar the applets themselves.

Notes
=====

In order to support arbitrary RST, the .page files are individually
parsed and processed by docutils.  A customized ``applet`` directive
is defined in this program.  This applet generates an <embed> tag.
"""
import jinja2 as jinja
import os
import glob
import subprocess
import shutil
import datetime

from docutils.core import publish_parts
from docutils import nodes
from docutils.parsers.rst import directives
from docutils.parsers.rst import Directive

meta="""<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="keywords" content="Lott Java" />
<meta name="description" content="Steven F. Lott" />
<meta name="generator" content="Docutils + Jinja + Customized directives" />"""

style="""<link rel="stylesheet" type="text/css" href="../slott.css" />"""

javascript=""""""

class embed( nodes.Special, nodes.Inline, nodes.TextElement ):
    """Our <embed> tag definition."""
    def astext( self ):
        return self.emptytag()

def align(argument):
    """Conversion function for the "align" option."""
    return directives.choice(argument, ('left', 'center', 'right'))

class Applet(Directive):
    """Extend RST with an applet directive that creates an embed tag wrapped
    in a raw HTML parent.
    """
    required_arguments = 0
    optional_arguments = 0
    final_argument_whitespace = True
    option_spec = {'code': directives.unchanged,
                   'codebase': directives.uri,
                   'height': directives.nonnegative_int,
                   'width': directives.nonnegative_int,
                   'models': directives.unchanged,
                   }
    has_content = False

    def run(self):
        # Constants
        self.options['type']="application/x-java-applet;version=1.5.0"
        self.options['pluginspage']="http://java.sun.com/j2se/1.5.0/download.html"
        # parse 'models' to create additional options for embed tag
        models= self.options.pop('models').split()
        self.options['numModels']= len(models)
        for i, m in enumerate(models):
            self.options['model%d'%(i,)]= m
        embed_node= embed( '', '', **self.options )
        raw_node = nodes.raw('', '', embed_node, format='html', )
        print raw_node
        return [raw_node]
        # Alternate is to create 'applet' tag
        # with children param tags for numModels and modelxx.

def buildTemplates(template="source/ham.tmpl",page_glob="source/*.page"):
    """Build all of the *.page pages using the ham.tmpl template."""
    directives.register_directive('applet', Applet)

    base_args = {
        'metaTags':meta,
        'stylesheetTags':style,
        'javascriptTags':javascript,
        'currentYr':'2005, 2009',
        'siteCopyrightName':'Steven F. Lott',
        'siteDomainName':'http://www.me.com/s_lott',
        'siteCredits':'Designed by Steven F. Lott, Powered by Python',
    }

    load_from, template_name = os.path.split( template )
    env= jinja.Environment()
    env.loader= jinja.FileSystemLoader(load_from)
    template= env.get_template(template_name)
    for page in glob.glob(page_glob):
        print "render", page
        source= open(page,"r").read()
        args = base_args.copy()
        parts= publish_parts( source=source, writer_name='html' )
        args['name']= parts['title']
        args['text']= parts['html_body']
        args['now']= str(datetime.datetime.now())
        args['source']= page
        html= template.render( args )
        #print html
        # write page to build directory
        page_name, _ = os.path.splitext(os.path.basename(page))
        dest= open(os.path.join("build",page_name+".html"),"w")
        dest.write( html )
        dest.write( '\n' )
        dest.close()

def buildJava():
    source= "source/RadioCalc.java"
    javac= subprocess.Popen( ["javac", "-d", "build", source] )
    javac.wait()
    print "javac status", javac.returncode
    jar= subprocess.Popen( ["jar","cvf","build/ham.jar","-C","build","."] )
    jar.wait()
    print "jar status", jar.returncode

def buildImages():
    for image in glob.glob("source/*.gif") + glob.glob("source/*.png"):
        print "copy", image
        shutil.copy2( image, "build" )

if __name__ == "__main__":
    buildTemplates()
    buildImages()
    buildJava()
