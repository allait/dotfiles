""" User configuration file for IPython

See http://ipython.scipy.org/moin/IpythonExtensionApi for detailed
description on what you could do here.
"""
import IPython.ipapi
ip = IPython.ipapi.get()

import os

def main():

    o = ip.options
    o.system_verbose = 0

    import_all("os sys")

    # Load current virtualenv environment
    execf('~/.ipython/virtualenv.py')

# some config helper functions you can use
def import_all(modules):
    """ Usage: import_all("os sys") """
    for m in modules.split():
        ip.ex("from %s import *" % m)

def execf(fname):
    """ Execute a file in user namespace """
    ip.ex('execfile("%s")' % os.path.expanduser(fname))

main()
