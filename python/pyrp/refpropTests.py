
import unittest
import logging
import inspect

import pyrp 
import pyrp.refprop
from pyrp.refprop import *



class TestCase(unittest.TestCase):
    
    global path 
    path = '/opt/refprop/fluids/'

    def setUp(self):
        unittest.TestCase.setUp(self)

    def testSetup(self):
        self.assertTrue(None == SETUP(FluidName="R134A.FLD"))

    def testSetup2(self):
        self.assertFalse(0 != SETUPFLEX(ncin=2, xkg=[0.5,0.5], FluidNames=path+"R134A.FLD|"+path+"R22.FLD"))


    def setupOneFluid(self):
        return SETUP(FluidName="R134A.FLD")
    
    def setupMixFluid(self):
        return SETUPFLEX(ncin=2, xkg=[0.5,0.5], FluidNames=path+"R134A.FLD|"+path+"R22.FLD")
    

    def testSatp(self):
        self.setupOneFluid()

        x = [1.0]
        rhof = 0.0
        rhog = 0.0
        t = 0.0
        xliq = [-1.0]
        xvap = [-1.0]
        
        r=[]
        t,rhof,rhog = SATP(101.325, kph=2)#, t, rhof, rhog, xliq, xvap)
        self.assertEquals(247.08, round(t, 2))
        self.assertEquals(13493 / 1000.0, round(rhof, 3))
        self.assertEquals(51.533 / 1000.0, round(rhog, 6))
        #self.assertEquals(0, r['ierr'])
        print inspect.stack()[0][3]
        print t,rhof,rhog
        print 

    def testEnthal(self):
        self.setupOneFluid()
        h = ENTHAL(100,10)
        self.assertTrue(float("2.2248194e24") - h < 0.001)
        print inspect.stack()[0][3]
        print h
        print 

    def testTpflsh(self):
        rs = self.setupOneFluid()
        print rs
        t = 257.0
        p = 1221.0
        #z =  [ 1.0 ]
        r = TPFLSH(t,p)
        print inspect.stack()[0][3]
        print r
        print 

    def testTpflsh2(self):
        rs = self.setupMixFluid()
        print rs
        t = 257.0
        p = 1221.0
        xin =  [ 0.22, 0.78 ]
        #pyrp.refprop.x = wrapX([ 0.22, 0.78 ])
        SETXMASS(xin)
        r = TPFLSH(t, p)
        print inspect.stack()[0][3]
        print r
        print 

    def testSatp2(self):
        self.setupMixFluid()

        t = 0.0
        xin = [0.5,0.5]
        xliq = [-1.0,-1]
        xvap = [-1.0,1]
        rhof = 0.0
        rhog = 0.0
        
        SETXMASS(xin)
        t,rhof,rhog = SATP(101.325,2)#, t, rhof, rhog, xliq, xvap)
        #self.assertEquals(0, r['ierr'])
        print inspect.stack()[0][3]
        print t,rhof,rhog
        print 

    def testWmol(self):
        self.setupOneFluid()
        wm = WMOL()
        self.assertEquals(102.032,wm)
        print inspect.stack()[0][3]
        print wm
        print 

    def testCritp(self):
        self.setupOneFluid()
        tcrit, pcrit, Dcrit = CRITP()
        #self.assertEqual(0,r['ierr'])
        self.assertEqual(4059.28,pcrit)
        print inspect.stack()[0][3]
        print tcrit, pcrit, Dcrit 
        print 
        
        
#        
### test routines
#if __name__ == '__main__':
#
#    # setup for single fluid
#    #SETUP('R22.FLD')
#
#    # setup for mixture
#    SETMIX('R407C.MIX')
#
#    H = GETMIXHEADER('R407C.MIX')
#    print H
#
#
#    print 'wm=%0.3f g/mol'%(wm.value)
#
#    tf,dl,dv=SATP(0,3) # get freezing point
#    tc,pc,Dc=CRITP() # get critical point
#    print 'tc=%0.2f\xb0C pc=%0.0fkPa Dc=%0.1fkg/m3'%(tc-k0,pc,Dc*wm.value)
#
#    tl=0.0+k0
#    p,dl,dv=SATT(tl,1)
#    hl=ENTHAL(tl,dl)
#    sl=ENTRO(tl,dl)
#    print 'tl=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg sl=%0.3fkJ/kg-K'%(tl-k0,dl*wm.value,hl/wm.value,sl/wm.value)
#
#    p=1100.0
#    tv,dl,dv=SATP(p,2)
#    hv=ENTHAL(tv,dv)
#    tl,dl,dv=SATP(p,1)
#    hl=ENTHAL(tl,dl)
#    print 'tl=%0.2f\xb0C tv=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg hv=%0.2fkJ/kg'%(tl-k0,tv-k0,dl*wm.value,hl/wm.value,hv/wm.value)       
#        
        

