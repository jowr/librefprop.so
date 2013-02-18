#!/usr/bin/python
"""
Example calculations in Python with Refprop data.
"""
__author__  = "Jorrit Wronski"
__version__ = "2013-02-17"


from pyrp.refprop import * 

print 'You are using version %s of the NIST Refprop library.'%(RPVERSION())
print 

print 'Example using R22 as fluid:'
# setup for single fluid
SETUP(FluidName='R22.FLD')

print 'wm=%0.3f g/mol'%(wm.value)

tc,pc,Dc=CRITP() # get critical point
print u'Critical point properties: tc=%0.2f\xb0C pc=%0.0fkPa Dc=%0.1fkg/m3'%(tc-k0,pc,Dc*wm.value)
