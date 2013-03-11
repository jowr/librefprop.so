"""
pyrp - Python and Refprop interface
=====

readme.md       - General instructions and copyright information / credits.
refpropClass.py - Python wrapper for most Refprop functions, partly available in SI units

"""

if __name__ == "__main__":
    from refpropClass import RefpropSI 
    RP = RefpropSI()
    print 'You are using version %s of the NIST Refprop library.'%(RP.RPVERSION())
    print 
