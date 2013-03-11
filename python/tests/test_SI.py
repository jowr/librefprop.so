
import sys
err = sys.stderr

import unittest
import collections
import itertools
class Sentinel(object): pass

# ---------------------------------------------
# Refprop test cases
# ---------------------------------------------
from pyrp.refpropClasses import RefpropSI

TEST_FLUIDS       = ['PENTANE', 'WATER.FLD', 'CO2']
TEST_DENSITIES    = [  15.137 ,    0.4846,  801.62  ] # kg/m3
TEST_TEMPERATURES = [ 600.    ,  450.    ,  300.    ] # K
TEST_PRESSURES    = [  10.0e5 ,    1.0e5 ,  100.0e5 ] # Pa
TEST_ENTHALPIES   = [1029.80e3, 2829.70e3, 261.80e3 ] # J/kg

# ---------------------------------------------
# Refprop test cases
# ---------------------------------------------

class TestRefprop(unittest.TestCase):
    
    # Constructor and setup routines.
    
    #def __init__(self):
    #    self.is_setup = False
    is_setup = False
    maxDiff = 0.01 / 100 # relative error in per cent
    
    def setUp(self):
        #err.write("setUp() called\n")
        assert not self.is_setup
        self.is_setup = True
        self.RP = RefpropSI()
        #err.write("Running Refprop " + self.RP.RPVERSION()+"\n")

    def tearDown(self):
        #err.write("tearDown() called\n")
        assert self.is_setup
        self.is_setup = False
        
    # Check lists and values for equality 
    def assertEqualFlex(self, first, second, *args, **kwargs):
        # http://stackoverflow.com/questions/3022952/test-assertions-for-tuples-with-floats/3124155#3124155 
        if (isinstance(first, collections.Iterable)
          and isinstance(second, collections.Iterable)):
            for a, b in itertools.izip_longest(first, second, fillvalue=Sentinel()):
                self.assertEqualFlex(a, b, *args, **kwargs)
        else:
            # Ignore nans. (which have the strange property that nan != nan)
            if first == first and second == second:
                # Added ability to handle relative differences...
                deltaRel = 0.
                if 'deltaRel' in kwargs:
                    deltaRel = float(kwargs.pop('deltaRel', ''))
                    #del kwargs['deltaRel']
                try:
                    self.assertEqual(first,second,*args,**kwargs)
                except self.failureException:  
                    if deltaRel > 0.:
                        kwargs['delta'] = deltaRel * first   
                    self.assertAlmostEqual(first, second, *args, **kwargs)
        
        
    # The actual test cases
    
    def test_path(self):
        #self.assertRaises(AssertionError, self.RP.SETPATH("/wrong/path"))            
        self.assertIsNone(self.RP.SETPATH(self.RP.fpath))
        
        
    def test_setup(self):
        self.assertTrue(None == self.RP.SETUP(FluidName="R134A.FLD"))


    def test_setup_mix(self):
        self.assertIsNone(self.RP.SETMIX(FluidName="R404A.MIX"))
        
        
    def test_setup_flex(self):
        self.assertEqual(0,self.RP.SETUPFLEX(xkg=[0.5,0.5], FluidNames="R134A.FLD|R22.FLD"))
        self.assertEqual(101,self.RP.SETUPFLEX(xkg=[0.5,0.5], FluidNames="R134A.FLD|R2"))
        self.assertEqual(0,self.RP.SETUPFLEX(xkg=[0.5,0.5], FluidNames="R134A|R22"))
    
    
    def test_sat(self):
        # prepare library
        fluid = "R134A.FLD"
        self.RP.SETUP(FluidName=fluid)
        #
        p_in  = 115610.000
        t_in  =    250.000
        Dl_in =   1367.900 # self.RP.D_RP2SI(13493. / 1000.0)
        Dv_in =      5.955 # self.RP.D_RP2SI(51.533 / 1000.0)        
        # Test SATP
        t,p,Dl,Dv = self.RP.SATP(p_in,kph=2)
        self.assertEqualFlex(p_in , p , deltaRel=self.maxDiff)
        self.assertEqualFlex(t_in , t , deltaRel=self.maxDiff)
        self.assertEqualFlex(Dl_in, Dl, deltaRel=self.maxDiff)
        self.assertEqualFlex(Dv_in, Dv, deltaRel=self.maxDiff)
        # Test SATT
        t,p,Dl,Dv = self.RP.SATT(t_in,kph=2)
        self.assertEqualFlex(p_in , p , deltaRel=self.maxDiff)
        self.assertEqualFlex(t_in , t , deltaRel=self.maxDiff)
        self.assertEqualFlex(Dl_in, Dl, deltaRel=self.maxDiff)
        self.assertEqualFlex(Dv_in, Dv, deltaRel=self.maxDiff)
    
    
    def test_mixtures(self):
        p_in = 100000.0 # one atmosphere
        t_in =    250.0
        d_in =      3.5843
        #
        self.assertEqual(0,self.RP.SETUPFLEX(xkg=[0.5,0.5], FluidNames="R32|R125"))
        self.RP.SETXMOLE(xin=[0.697615,0.302385]) # Define as R410a
        T_a,p_a,D_a,Dl_a,Dv_a,q_a,e_a,h_a,s_a,cv_a,cp_a,w_a = self.RP.PDFLSH(p_in,d_in)
        T_b,p_b,D_b,Dl_b,Dv_b,q_b,e_b,h_b,s_b,cv_b,cp_b,w_b = self.RP.TDFLSH(t_in,d_in)
        a = (T_a,p_a,D_a,Dl_a,Dv_a,e_a,h_a,s_a,cv_a,cp_a,w_a)
        b = (T_b,p_b,D_b,Dl_b,Dv_b,e_b,h_b,s_b,cv_b,cp_b,w_b)
        self.assertEqualFlex(a, b, deltaRel=self.maxDiff)
        self.assertEqualFlex(t_in, T_a, deltaRel=self.maxDiff)
        self.assertEqualFlex(d_in, D_a, deltaRel=self.maxDiff)
        #
        self.assertIsNone(self.RP.SETMIX(FluidName="R410A.mix"))
        T_a,p_a,D_a,Dl_a,Dv_a,q_a,e_a,h_a,s_a,cv_a,cp_a,w_a = self.RP.PDFLSH(p_in,d_in)
        T_c,p_c,D_c,Dl_c,Dv_c,q_c,e_c,h_c,s_c,cv_c,cp_c,w_c = self.RP.TDFLSH(t_in,d_in)
        a = (T_a,p_a,D_a,Dl_a,Dv_a,e_a,h_a,s_a,cv_a,cp_a,w_a)
        c = (T_c,p_c,D_c,Dl_c,Dv_c,e_c,h_c,s_c,cv_c,cp_c,w_c)
        self.assertEqualFlex(a, c, deltaRel=self.maxDiff)
        self.assertEqualFlex(t_in, T_c, deltaRel=self.maxDiff)
        self.assertEqualFlex(d_in, D_c, deltaRel=self.maxDiff)
        # Cross checking
        self.assertEqualFlex(b, c, deltaRel=self.maxDiff)
        
    def test_case(self):
        #from pyrp.refprop import *
        for (counter, fluid) in enumerate(TEST_FLUIDS): 
            err.write("..."+repr(counter)+"... ")
            self.RP.SETUP(FluidName=fluid)
            T_a,p_a,D_a,Dl_a,Dv_a,q_a,e_a,h_a,s_a,cv_a,cp_a,w_a = self.RP.TDFLSH(TEST_TEMPERATURES[counter], TEST_DENSITIES[counter])
            T_b,p_b,D_b,Dl_b,Dv_b,q_b,e_b,h_b,s_b,cv_b,cp_b,w_b = self.RP.PHFLSH(TEST_PRESSURES[counter], TEST_ENTHALPIES[counter])
            a = (T_a,p_a,D_a,Dl_a,Dv_a,e_a,h_a,s_a,cv_a,cp_a,w_a)
            b = (T_b,p_b,D_b,Dl_b,Dv_b,e_b,h_b,s_b,cv_b,cp_b,w_b)
            #err.write("\n"+repr(a)+"\n"+repr(b))
            self.assertEqualFlex(a, b, deltaRel=self.maxDiff)
            
            
