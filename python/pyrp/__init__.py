"""
pyrp - Python and Refprop interface
=====

readme.md       - General instructions and copyright information / credits.
refprop.py      - Python wrapper for most Refprop functions
refpropTests.py - Basic unit tests for the Refprop functions

"""

# Path to the fluid and mixture definition files
#RPpath = '/opt/refprop'


if __name__ == "__main__":
    from refprop import * 
    print 'You are using version %s of the NIST Refprop library.'%(RPVERSION())
    print 
    
    print 'Running test created by Bruce Wernick:'
    
    # setup for single fluid
    #SETUP('R22.FLD')

    # setup for mixture
    SETMIX('R407C.MIX')

    H = GETMIXHEADER('R407C.MIX')
    print H

    print 'wm=%0.3f g/mol'%(wm.value)

    tf,dl,dv=SATP(0,3) # get freezing point
    tc,pc,Dc=CRITP() # get critical point
    print u'tc=%0.2f\xb0C pc=%0.0fkPa Dc=%0.1fkg/m3'%(tc-k0,pc,Dc*wm.value)

    tl=0.0+k0
    p,dl,dv=SATT(tl,1)
    hl=ENTHAL(tl,dl)
    sl=ENTRO(tl,dl)
    print u'tl=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg sl=%0.3fkJ/kg-K'%(tl-k0,dl*wm.value,hl/wm.value,sl/wm.value)

    p=1100.0
    tv,dl,dv=SATP(p,2)
    hv=ENTHAL(tv,dv)
    tl,dl,dv=SATP(p,1)
    hl=ENTHAL(tl,dl)
    print u'tl=%0.2f\xb0C tv=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg hv=%0.2fkJ/kg'%(tl-k0,tv-k0,dl*wm.value,hl/wm.value,hv/wm.value)
