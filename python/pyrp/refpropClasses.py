'''Based on Bruce Wernick's REFPROP8 library and http://code.google.com/p/pyref/. 

Created on 15 Feb 2013
author: Jorrit Wronski
'''
import ctypes
from ctypes import create_string_buffer,c_long,c_double,byref
import sys, os, string 

class Refprop(object):
    
    # -- CONSTANTS AND SETTINGS --
    k0=273.15
    
    MaxComps=20
    fpath=''
    fldpath=fpath+''
    mixpath=fpath+''
    hfld=create_string_buffer('', 10000)
    hfm=create_string_buffer(fpath+'fluids/hmx.bnc', 255)
    hrf=create_string_buffer('DEF', 3)
    hfile=create_string_buffer('', 10000)
    htype=create_string_buffer('NBS', 3)
    hmix=create_string_buffer('NBS', 3)
    hcomp=create_string_buffer('NBS', 3)
    ierr=c_long(0)
    herr=create_string_buffer('', 255)
    hname=create_string_buffer('', 12)
    hn80=create_string_buffer('', 80)
    hcas=create_string_buffer('', 12)
    nc=c_long(1)
    wm=c_double()
    x=(c_double*MaxComps)(1)
    xl=(c_double*MaxComps)()
    xv=(c_double*MaxComps)()
    xlkg=(c_double*MaxComps)()
    xvkg=(c_double*MaxComps)()
    
    xkg=(c_double*MaxComps)(1)
    
    rp = None
    
    RPVersion  = None
    SETPATHdll = None
    ABFL1dll   = None
    ABFL2dll   = None
    ACTVYdll   = None
    AGdll      = None
    CCRITdll   = None
    CP0dll     = None
    CRITPdll   = None
    CSATKdll   = None
    CV2PKdll   = None
    CVCPKdll   = None
    CVCPdll    = None
    DBDTdll    = None
    DBFL1dll   = None
    DBFL2dll   = None
    DDDPdll    = None
    DDDTdll    = None
    DEFLSHdll  = None
    DHD1dll    = None
    DHFL1dll   = None
    DHFL2dll   = None
    DHFLSHdll  = None
    DIELECdll  = None
    DOTFILLdll = None
    DPDD2dll   = None
    DPDDKdll   = None
    DPDDdll    = None
    DPDTKdll   = None
    DPDTdll    = None
    DPTSATKdll = None
    DSFLSHdll  = None
    DSFL1dll   = None
    DSFL2dll   = None
    ENTHALdll  = None
    ENTROdll   = None
    ESFLSHdll  = None
    FGCTYdll   = None
    FPVdll     = None
    GERG04dll  = None
    GETFIJdll  = None
    GETKTVdll  = None
    GIBBSdll   = None
    HSFLSHdll  = None
    INFOdll    = None
    LIMITKdll  = None
    LIMITSdll  = None
    LIMITXdll  = None
    MELTPdll   = None
    MELTTdll   = None
    MLTH2Odll  = None
    NAMEdll    = None
    PDFL1dll   = None
    PDFLSHdll  = None
    PEFLSHdll  = None
    PHFL1dll   = None
    PHFLSHdll  = None
    PQFLSHdll  = None
    PREOSdll   = None
    PRESSdll   = None
    PSFL1dll   = None
    PSFLSHdll  = None
    PUREFLDdll = None
    QMASSdll   = None
    QMOLEdll   = None
    SATDdll    = None
    SATEdll    = None
    SATHdll    = None
    SATPdll    = None
    SATSdll    = None
    SATTdll    = None
    SETAGAdll  = None
    SETKTVdll  = None
    SETMIXdll  = None
    SETMODdll  = None
    SETREFdll  = None
    SETUPdll   = None
    SPECGRdll  = None 
    SUBLPdll   = None
    SUBLTdll   = None
    SURFTdll   = None
    SURTENdll  = None
    TDFLSHdll  = None
    TEFLSHdll  = None
    THERM0dll  = None
    THERM2dll  = None
    THERM3dll  = None
    THERMdll   = None
    THFLSHdll  = None
    TPFLSHdll  = None
    TPFL2dll   = None
    TPRHOdll   = None
    TQFLSHdll  = None
    TRNPRPdll  = None
    TSFLSHdll  = None
    VIRBdll    = None
    VIRCdll    = None
    WMOLdll    = None
    XMASSdll   = None
    XMOLEdll   = None

    # -- FUNCTION ALIASES AND PLATFORM --
    def gccFunctions(self, rp):
        self.RPVersion  = rp.rpversion_
        self.SETPATHdll = rp.setpathdll_
        self.ABFL1dll   = rp.abfl1dll_
        self.ABFL2dll   = rp.abfl2dll_
        self.ACTVYdll   = rp.actvydll_
        self.AGdll      = rp.agdll_
        self.CCRITdll   = rp.ccritdll_
        self.CP0dll     = rp.cp0dll_
        self.CRITPdll   = rp.critpdll_
        self.CSATKdll   = rp.csatkdll_
        self.CV2PKdll   = rp.cv2pkdll_
        self.CVCPKdll   = rp.cvcpkdll_
        self.CVCPdll    = rp.cvcpdll_
        self.DBDTdll    = rp.dbdtdll_
        self.DBFL1dll   = rp.dbfl1dll_
        self.DBFL2dll   = rp.dbfl2dll_
        self.DDDPdll    = rp.dddpdll_
        self.DDDTdll    = rp.dddtdll_
        self.DEFLSHdll  = rp.deflshdll_
        self.DHD1dll    = rp.dhd1dll_
        self.DHFL1dll   = rp.dhfl1dll_
        self.DHFL2dll   = rp.dhfl2dll_
        self.DHFLSHdll  = rp.dhflshdll_
        self.DIELECdll  = rp.dielecdll_
        self.DOTFILLdll = rp.dotfilldll_
        self.DPDD2dll   = rp.dpdd2dll_
        self.DPDDKdll   = rp.dpddkdll_
        self.DPDDdll    = rp.dpdddll_
        self.DPDTKdll   = rp.dpdtkdll_
        self.DPDTdll    = rp.dpdtdll_
        self.DPTSATKdll = rp.dptsatkdll_
        self.DSFLSHdll  = rp.dsflshdll_
        self.DSFL1dll   = rp.dsfl1dll_
        self.DSFL2dll   = rp.dsfl2dll_
        self.ENTHALdll  = rp.enthaldll_
        self.ENTROdll   = rp.entrodll_
        self.ESFLSHdll  = rp.esflshdll_
        self.FGCTYdll   = rp.fgctydll_
        self.FPVdll     = rp.fpvdll_
        self.GERG04dll  = rp.gerg04dll_
        self.GETFIJdll  = rp.getfijdll_
        self.GETKTVdll  = rp.getktvdll_
        self.GIBBSdll   = rp.gibbsdll_
        self.HSFLSHdll  = rp.hsflshdll_
        self.INFOdll    = rp.infodll_
        self.LIMITKdll  = rp.limitkdll_
        self.LIMITSdll  = rp.limitsdll_
        self.LIMITXdll  = rp.limitxdll_
        self.MELTPdll   = rp.meltpdll_
        self.MELTTdll   = rp.melttdll_
        self.MLTH2Odll  = rp.mlth2odll_
        self.NAMEdll    = rp.namedll_
        self.PDFL1dll   = rp.pdfl1dll_
        self.PDFLSHdll  = rp.pdflshdll_
        self.PEFLSHdll  = rp.peflshdll_
        self.PHFL1dll   = rp.phfl1dll_
        self.PHFLSHdll  = rp.phflshdll_
        self.PQFLSHdll  = rp.pqflshdll_
        self.PREOSdll   = rp.preosdll_
        self.PRESSdll   = rp.pressdll_
        self.PSFL1dll   = rp.psfl1dll_
        self.PSFLSHdll  = rp.psflshdll_
        self.PUREFLDdll = rp.pureflddll_
        self.QMASSdll   = rp.qmassdll_
        self.QMOLEdll   = rp.qmoledll_
        self.SATDdll    = rp.satddll_
        self.SATEdll    = rp.satedll_
        self.SATHdll    = rp.sathdll_
        self.SATPdll    = rp.satpdll_
        self.SATSdll    = rp.satsdll_
        self.SATTdll    = rp.sattdll_
        self.SETAGAdll  = rp.setagadll_
        self.SETKTVdll  = rp.setktvdll_
        self.SETMIXdll  = rp.setmixdll_
        self.SETMODdll  = rp.setmoddll_
        self.SETREFdll  = rp.setrefdll_
        self.SETUPdll   = rp.setupdll_
        #self.SPECGRdll = rp.specgrdll_ 
        self.SUBLPdll   = rp.sublpdll_
        self.SUBLTdll   = rp.subltdll_
        self.SURFTdll   = rp.surftdll_
        self.SURTENdll  = rp.surtendll_
        self.TDFLSHdll  = rp.tdflshdll_
        self.TEFLSHdll  = rp.teflshdll_
        self.THERM0dll  = rp.therm0dll_
        self.THERM2dll  = rp.therm2dll_
        self.THERM3dll  = rp.therm3dll_
        self.THERMdll   = rp.thermdll_
        self.THFLSHdll  = rp.thflshdll_
        self.TPFLSHdll  = rp.tpflshdll_
        self.TPFL2dll   = rp.tpfl2dll_
        self.TPRHOdll   = rp.tprhodll_
        self.TQFLSHdll  = rp.tqflshdll_
        self.TRNPRPdll  = rp.trnprpdll_
        self.TSFLSHdll  = rp.tsflshdll_
        self.VIRBdll    = rp.virbdll_
        self.VIRCdll    = rp.vircdll_
        self.WMOLdll    = rp.wmoldll_
        self.XMASSdll   = rp.xmassdll_
        self.XMOLEdll   = rp.xmoledll_
    
    def winFunctions(self, rp):
        self.RPVersion  = "WinDLL"
        self.SETPATHdll = rp.SETPATHdll
        self.ABFL1dll   = rp.ABFL1dll
        self.ABFL2dll   = rp.ABFL2dll
        self.ACTVYdll   = rp.ACTVYdll
        self.AGdll      = rp.AGdll
        self.CCRITdll   = rp.CCRITdll
        self.CP0dll     = rp.CP0dll
        self.CRITPdll   = rp.CRITPdll
        self.CSATKdll   = rp.CSATKdll
        self.CV2PKdll   = rp.CV2PKdll
        self.CVCPKdll   = rp.CVCPKdll
        self.CVCPdll    = rp.CVCPdll
        self.DBDTdll    = rp.DBDTdll
        self.DBFL1dll   = rp.DBFL1dll
        self.DBFL2dll   = rp.DBFL2dll
        self.DDDPdll    = rp.DDDPdll
        self.DDDTdll    = rp.DDDTdll
        self.DEFLSHdll  = rp.DEFLSHdll
        self.DHD1dll    = rp.DHD1dll
        #self.DHFL1dll   = rp.DHFL1dll
        #self.DHFL2dll   = rp.DHFL2dll
        self.DHFLSHdll  = rp.DHFLSHdll
        self.DIELECdll  = rp.DIELECdll
        self.DOTFILLdll = rp.DOTFILLdll
        self.DPDD2dll   = rp.DPDD2dll
        self.DPDDKdll   = rp.DPDDKdll
        self.DPDDdll    = rp.DPDDdll
        self.DPDTKdll   = rp.DPDTKdll
        self.DPDTdll    = rp.DPDTdll
        self.DPTSATKdll = rp.DPTSATKdll
        self.DSFLSHdll  = rp.DSFLSHdll
        #self.DSFL1dll   = rp.DSFL1dll
        #self.DSFL2dll   = rp.DSFL2dll
        self.ENTHALdll  = rp.ENTHALdll
        self.ENTROdll   = rp.ENTROdll
        self.ESFLSHdll  = rp.ESFLSHdll
        self.FGCTYdll   = rp.FGCTYdll
        self.FPVdll     = rp.FPVdll
        self.GERG04dll  = rp.GERG04dll
        self.GETFIJdll  = rp.GETFIJdll
        self.GETKTVdll  = rp.GETKTVdll
        self.GIBBSdll   = rp.GIBBSdll
        self.HSFLSHdll  = rp.HSFLSHdll
        self.INFOdll    = rp.INFOdll
        self.LIMITKdll  = rp.LIMITKdll
        self.LIMITSdll  = rp.LIMITSdll
        self.LIMITXdll  = rp.LIMITXdll
        self.MELTPdll   = rp.MELTPdll
        self.MELTTdll   = rp.MELTTdll
        self.MLTH2Odll  = rp.MLTH2Odll
        self.NAMEdll    = rp.NAMEdll
        self.PDFL1dll   = rp.PDFL1dll
        self.PDFLSHdll  = rp.PDFLSHdll
        self.PEFLSHdll  = rp.PEFLSHdll
        self.PHFL1dll   = rp.PHFL1dll
        self.PHFLSHdll  = rp.PHFLSHdll
        self.PQFLSHdll  = rp.PQFLSHdll
        self.PREOSdll   = rp.PREOSdll
        self.PRESSdll   = rp.PRESSdll
        self.PSFL1dll   = rp.PSFL1dll
        self.PSFLSHdll  = rp.PSFLSHdll
        self.PUREFLDdll = rp.PUREFLDdll
        self.QMASSdll   = rp.QMASSdll
        self.QMOLEdll   = rp.QMOLEdll
        self.SATDdll    = rp.SATDdll
        self.SATEdll    = rp.SATEdll
        self.SATHdll    = rp.SATHdll
        self.SATPdll    = rp.SATPdll
        self.SATSdll    = rp.SATSdll
        self.SATTdll    = rp.SATTdll
        self.SETAGAdll  = rp.SETAGAdll
        self.SETKTVdll  = rp.SETKTVdll
        self.SETMIXdll  = rp.SETMIXdll
        self.SETMODdll  = rp.SETMODdll
        self.SETREFdll  = rp.SETREFdll
        self.SETUPdll   = rp.SETUPdll
        #self.SPECGRdll = rp.SPECGRdll
        self.SUBLPdll   = rp.SUBLPdll
        self.SUBLTdll   = rp.SUBLTdll
        self.SURFTdll   = rp.SURFTdll
        self.SURTENdll  = rp.SURTENdll
        self.TDFLSHdll  = rp.TDFLSHdll
        self.TEFLSHdll  = rp.TEFLSHdll
        self.THERM0dll  = rp.THERM0dll
        self.THERM2dll  = rp.THERM2dll
        self.THERM3dll  = rp.THERM3dll
        self.THERMdll   = rp.THERMdll
        self.THFLSHdll  = rp.THFLSHdll
        self.TPFLSHdll  = rp.TPFLSHdll
        #self.TPFL2dll   = rp.TPFL2dll
        self.TPRHOdll   = rp.TPRHOdll
        self.TQFLSHdll  = rp.TQFLSHdll
        self.TRNPRPdll  = rp.TRNPRPdll
        self.TSFLSHdll  = rp.TSFLSHdll
        self.VIRBdll    = rp.VIRBdll
        self.VIRCdll    = rp.VIRCdll
        self.WMOLdll    = rp.WMOLdll
        self.XMASSdll   = rp.XMASSdll
        self.XMOLEdll   = rp.XMOLEdll        

    
    
    def __init__(self):
        self.rp   = None
        functions = ''
        library   = ''
        if sys.platform.startswith('win32'):
            functions = 'win'
            library   = 'refprop.dll'
            self.rp   = ctypes.windll.LoadLibrary(library)    
            self.fpath= "C:\\Program Files (x86)\\REFPROP\\"         
        elif sys.platform.startswith('darwin'):
            functions = 'gcc'
            library   = 'librefprop.dym'
            self.rp   = ctypes.cdll.LoadLibrary(library)
        elif sys.platform.startswith('linux'):
            functions = 'gcc'
            library   = 'librefprop.so'
            self.rp   = ctypes.cdll.LoadLibrary(library)
            self.fpath= "/opt/refprop/"
        else:
            print "ERROR: Operating system cannot be determined."
            exit()
            
        assert self.rp != None, "ERROR: Library not found. Make sure Refprop is in your path."
        #print self.rp    
            
        self.SETPATH(self.fpath)
    
        if functions == 'win':
            self.winFunctions(self.rp)
        elif functions == 'gcc':
            self.gccFunctions(self.rp)
        else:
            print "ERROR: Function aliases not defined."
            exit()
            
        
    def cpy(self, src, dst):
        #assert len(src) == len(dst), "Copying " + str(len(src)) + " into " + str(len(dst))
        for i in range(0, len(src)):
            dst[i] = src[i]

    # -- Convenience functions from [PyRef](http://code.google.com/p/pyref/) --    
    def wrapX(self, x):
        _x = self.dblarray()
        self.cpy(x, _x)
        return _x
    
    
    def to_list(self, a):
        return [x for x in a]
    
    def dblarray(self, ):
        return (c_double * self.MaxComps)()
    
    
    # -- Construct a path for fluid files
    
    def get_fluidString(self, names):
        fluids = []        
        for name in string.split(names, "|", self.MaxComps):
            # remove directories if present
            a,name = os.path.split(name)
            # check for mix, fld or ppf
            if name.lower().endswith(".mix"):
                fluids.append(os.path.join(self.mixpath,name))
            elif (name.lower().endswith(".fld")|name.lower().endswith(".ppf")):
                fluids.append(os.path.join(self.fldpath,name))
            else: # assume it is a normal fluid
                fluids.append(os.path.join(self.fldpath,name+".fld"))
        return len(fluids),"|".join(str(fluid) for fluid in fluids)
        #return len(fluids),string.join(fluids, "|")
        
    
    
    # -- New convenience functions --
    
    def SETXMASS(self, xin=[1.0]):
        self.xkg = self.wrapX(xin)
        self.XMOLEdll(self.xkg,byref(self.x),byref(self.wm))
        return self.to_list(self.x),self.wm.value
        
    def SETXMOLE(self, xin=[1.0]):
        self.x = self.wrapX(xin)
        self.XMASSdll(self.x,byref(self.xkg),byref(self.wm))
        return self.to_list(self.xkg),self.wm.value
      
    def GETXMASS(self, ):
        return self.to_list(self.xkg)
        
    def GETXMOLE(self, ):
        return self.to_list(self.x)
    
    def SETUPFLEX(self, xkg=[1.0],FluidNames='/opt/refprop/fluids/R22.FLD', FluidRef='DEF'):
        '''define current fluid including mass fractions'''
        self.nc.value,self.hfld.value=self.get_fluidString(FluidNames)
        assert self.nc.value==len(xkg), "Please supply mass fractions for all components."
        self.hrf.value=FluidRef
        self.SETUPdll(byref(self.nc),byref(self.hfld),byref(self.hfm),byref(self.hrf),byref(self.ierr),byref(self.herr),c_long(10000),c_long(255),c_long(3),c_long(255))
        if self.ierr.value==0:
            self.SETXMASS(xin=xkg)
            ixflag=c_long(1)
            h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
            self.SETREFdll(byref(self.hrf),byref(ixflag),self.x,byref(h0),byref(s0),byref(t0),byref(p0),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
            if self.ierr.value==0:
                self.WMOLdll(self.x,byref(self.wm))
        else:
            print repr(self.ierr.value) + ": SETUP failed with " + self.herr.value
            
        return self.ierr.value
    
    # -- BASIC INFORMATION --
    
    def RPVERSION(self):
        '''print current version number'''
        v = create_string_buffer(255)
        self.RPVersion(byref(v))
        return v.value.strip()
    
    
    # -- INITIALIZATION SUBROUTINES --
    
    def SETPATH(self, value='/opt/refprop/'):
        '''set path to refprop root containing fluids and mixtures'''
        self.fpath = value.strip()
        if (len(self.fpath)>0):
            assert os.path.exists(self.fpath), "The specified path " + self.fpath + "does not exist."
            self.fldpath = os.path.join(self.fpath, "fluids")
            self.mixpath = os.path.join(self.fpath, "mixtures")
        else:
            self.fldpath = "fluids"
            self.mixpath = "mixtures"
        
        self.hfm  = create_string_buffer(os.path.join(self.fldpath,'hmx.bnc'), 255)

    
    def SETUP(self, FluidName='/opt/refprop/fluids/R22.FLD', FluidRef='DEF'):
        '''define models and initialize arrays'''
        self.nc.value,self.hfld.value=self.get_fluidString(FluidName)
        self.hrf.value=FluidRef
        self.SETUPdll(byref(self.nc),byref(self.hfld),byref(self.hfm),byref(self.hrf),byref(self.ierr),byref(self.herr),c_long(10000),c_long(255),c_long(3),c_long(255))
        if self.ierr.value==0:
            ixflag=c_long(1)
            h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
            self.SETREFdll(byref(self.hrf),byref(ixflag),self.x,byref(h0),byref(s0),byref(t0),byref(p0),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
            if self.ierr.value==0:
                self.WMOLdll(self.x,byref(self.wm))
        return
    
    def SETMIX(self, FluidName='/opt/refprop/mixtures/R404A.MIX', FluidRef='DEF'):
        '''open a mixture file and read constituents and mole fractions'''
        self.nc.value,self.hfld.value=self.get_fluidString(FluidName)
        assert self.nc.value==1, "Please supply only one mixture file."
        self.hrf.value=FluidRef
        self.SETMIXdll(byref(self.hfld),byref(self.hfm),byref(self.hrf),byref(self.nc),byref(self.hfile),self.x,byref(self.ierr),byref(self.herr),c_long(255),c_long(255),c_long(3),c_long(10000),c_long(255))
        if self.ierr.value==0:
            ixflag=c_long(0)
            h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
            self.SETREFdll(byref(self.hrf),byref(ixflag),self.x,byref(h0),byref(s0),byref(t0),byref(p0),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
            if self.ierr.value==0:
                self.WMOLdll(self.x,byref(self.wm))
        return
    
    def SETREF(self, FluidRef='DEF', ixflag=1, h0=0, s0=0, t0=0, p0=0):
        '''set reference state enthalpy and entropy'''
        self.hrf.value=FluidRef
        ixflag=c_long(ixflag)
        h0,s0,t0,p0=c_double(h0),c_double(s0),c_double(t0),c_double(p0)
        self.SETREFdll(byref(self.hrf),byref(ixflag),self.x,byref(h0),byref(s0),byref(t0),byref(p0),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
        return
    
    def SETMOD(self, ncomps=1, EqnModel='NBS', MixModel='NBS', CompModel='NBS'):
        '''set model(s) other than the NIST-recommended (NBS) ones'''
        self.nc.value=ncomps
        self.htype.value=EqnModel
        self.hmix.value=MixModel
        self.hcomp.value=CompModel
        self.SETMODdll(byref(self.nc),byref(self.htype),byref(self.hmix),byref(self.hcomp),byref(self.ierr),byref(self.herr),c_long(3),c_long(3),c_long(3),c_long(255))
        return
    
    def PUREFLD(self, icomp=0):
        '''Change the standard mixture setup so that the properties of one fluid can
        be calculated as if SETUP had been called for a pure fluid'''
        icomp=c_long(icomp)
        self.PUREFLDdll(byref(icomp))
        return
    
    def CRITP(self, ):
        '''critical parameters'''
        tcrit=c_double()
        pcrit=c_double()
        Dcrit=c_double()
        self.CRITPdll(self.x,byref(tcrit),byref(pcrit),byref(Dcrit),byref(self.ierr),byref(self.herr),c_long(255))
        return tcrit.value,pcrit.value,Dcrit.value
    
    def THERM(self, t,D):
        '''thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        hjt=c_double()
        self.THERMdll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(hjt))
        return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,hjt.value
    
    def THERM0(self, t,D):
        '''ideal gas thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        a,g=c_double(),c_double()
        self.THERM0dll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(a),byref(g))
        return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,a.value,g.value
    
    def THERM2(self, t,D):
        '''thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w,Z,hjt=c_double(),c_double(),c_double()
        A,G=c_double(),c_double()
        spare1,spare2=c_double(),c_double()
        spare3,spare4=c_double(),c_double()
        self.xkappa,beta=c_double(),c_double()
        dPdD,d2PdD2=c_double(),c_double()
        dPdT,dDdT,dDdP=c_double(),c_double(),c_double()
        self.THERM2dll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(Z),byref(hjt),byref(A),byref(G),byref(self.xkappa),byref(beta),byref(dPdD),byref(d2PdD2),byref(dPdT),byref(dDdT),byref(dDdP),byref(spare1),byref(spare2),byref(spare3),byref(spare4))
        return t.value,D.value,p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,Z.value,hjt.value,A.value,G.value,self.xkappa.value,beta.value,dPdD.value,d2PdD2.value,dPdT.value,dDdT.value,dDdP.value
    
    def THERM3(self, t,D):
        '''miscellaneous thermodynamic properties'''
        t=c_double(t)
        D=c_double(D)
        self.xkappa=c_double()
        beta=c_double()
        self.xisenk=c_double()
        self.xkt=c_double()
        betas=c_double()
        bs=c_double()
        self.xkkt=c_double()
        thrott=c_double()
        pint=c_double()
        spht=c_double()
        self.THERM3dll(byref(t),byref(D),self.x,byref(self.xkappa),byref(beta),byref(self.xisenk),byref(self.xkt),byref(betas),byref(bs),byref(self.xkkt),byref(thrott),byref(pint),byref(spht))
        return self.xkappa,beta,self.xisenk,self.xkt,betas,bs,self.xkkt,thrott,pint,spht
    
    def ENTRO(self, t,D):
        '''entropy as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        s=c_double()
        self.ENTROdll(byref(t),byref(D),self.x,byref(s))
        return s.value
    
    def ENTHAL(self, t,D):
        '''enthalpy as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        h=c_double()
        self.ENTHALdll(byref(t),byref(D),self.x,byref(h))
        return h.value
    
    def CVCP(self, t,D):
        '''isochoric (constant volume) and isobaric (constant pressure) heat
        capacity as functions of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        cv,cp=c_double(),c_double()
        self.CVCPdll(byref(t),byref(D),self.x,byref(cv),byref(cp))
        return cv.value,cp.value
    
    def CVCPK(self, icomp,t,D):
        '''isochoric (constant volume) and isobaric (constant pressure) heat
        capacity as functions of temperature and density for a given component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        cv,cp=c_double(),c_double()
        self.CVCPKdll(byref(icomp),byref(t),byref(D),byref(cv),byref(cp))
        return cv.value,cp.value
    
    def GIBBS(self, t,D):
        '''residual Helmholtz and Gibbs free energy as a function of
        temperature and density'''
        t=c_double(t)
        D=c_double(D)
        Ar,Gr=c_double(),c_double()
        self.GIBBSdll(byref(t),byref(D),self.x,byref(Ar),byref(Gr))
        return Ar.value,Gr.value
    
    def AG(self, t,D):
        '''Helmholtz and Gibbs energies as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        a,g=c_double(),c_double()
        self.AGdll(byref(t),byref(D),self.x,byref(a),byref(g))
        return a.value,g.value
    
    def PRESS(self, t,D):
        '''pressure as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        self.PRESSdll(byref(t),byref(D),self.x,byref(p))
        return p.value
    
    def DPDD(self, t,D):
        '''partial derivative of pressure w.r.t. density at constant temperature as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dpdD=c_double()
        self.DPDDdll(byref(t),byref(D),self.x,byref(dpdD))
        return dpdD.value
    
    def DPDDK(self, icomp,t,D):
        '''partial derivative of pressure w.r.t. density at constant temperature as a
        function of temperature and density for a specified component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        dpdD=c_double()
        self.DPDDKdll(byref(icomp),byref(t),byref(D),byref(dpdD))
        return dpdD.value
    
    def DPDD2(self, t,D):
        '''second partial derivative of pressure w.r.t. density at const temperature
        as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        d2PdD2=c_double()
        self.DPDD2dll(byref(t),byref(D),self.x,byref(d2PdD2))
        return d2PdD2.value
    
    def DPDT(self, t,D):
        '''partial derivative of pressure w.r.t. temperature at constant density as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dpt=c_double()
        self.DPDTdll(byref(t),byref(D),self.x,byref(dpt))
        return dpt.value
    
    def DPDTK(self, icomp,t,D):
        '''partial derivative of pressure w.r.t. temperature at constant density as a
        function of temperature and density for a specified component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        dpt=c_double()
        self.DPDTKdll(byref(icomp),byref(t),byref(D),byref(dpt))
        return dpt.value
    
    def DDDP(self, t,D):
        '''partial derivative of density w.r.t. pressure at constant temperature as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dDdp=c_double()
        self.DDDPdll(byref(t),byref(D),self.x,byref(dDdp))
        return dDdp.value
    
    def DDDT(self, t,D):
        '''partial derivative of density w.r.t. temperature at constant pressure as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dDdt=c_double()
        self.DDDTdll(byref(t),byref(D),self.x,byref(dDdt))
        return dDdt.value
    
    def DHD1(self, t,D):
        '''partial derivatives of enthalpy w.r.t. t, p, or D at constant t, p, or D as
        a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dhdt_d=c_double()
        dhdt_p=c_double()
        dhdd_t=c_double()
        dhdd_p=c_double()
        dhdp_t=c_double()
        dhdp_d=c_double()
        self.DHD1dll(byref(t),byref(D),self.x,byref(dhdt_d),byref(dhdt_p),byref(dhdd_t),byref(dhdd_p),byref(dhdp_t),byref(dhdp_d))
        return dhdt_d.value,dhdt_p.value,dhdd_t.value,dhdd_p.value,dhdp_t.value,dhdp_d.value
    
    def FGCTY(self, t,D):
        '''fugacity for each of the nc components of a mixture by numerical
        differentiation (using central differences) of the dimensionless residual
        Helmholtz energy'''
        t=c_double(t)
        D=c_double(D)
        f=(c_double*self.self.MaxComps)()
        self.FGCTYdll(byref(t),byref(D),self.x,f)
        return f
    
    def VIRB(self, t):
        '''second virial coefficient as a function of temperature'''
        t=c_double(t)
        b=c_double()
        self.VIRBdll(byref(t),self.x,byref(b))
        return b.value
    
    def DBDT(self, t):
        '''2nd derivative of B (B is the second virial coefficient) with respect to T
        as a function of temperature'''
        t=c_double(t)
        b=c_double()
        self.DBDTdll(byref(t),self.x,byref(b))
        return b.value
    
    def VIRC(self, t):
        '''third virial coefficient as a function of temperature'''
        t=c_double(t)
        c=c_double()
        self.VIRCdll(byref(t),self.x,byref(c))
        return c.value
    
    def SATT(self, t,kph=2):
        '''iterate for saturated liquid and vapor states given temperature
         kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
        t=c_double(t)
        kph=c_long(kph)
        p=c_double()
        Dl,Dv=c_double(),c_double()
        self.SATTdll(byref(t),self.x,byref(kph),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,Dl.value,Dv.value
    
    def SATP(self, p,kph=2):
        '''saturation temperature from pressure
         kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
        p=c_double(p)
        kph=c_long(kph)
        t=c_double()
        Dl,Dv=c_double(),c_double()
        self.SATPdll(byref(p),self.x,byref(kph),byref(t),byref(Dl),byref(Dv),self.xl,self.xv,byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,Dl.value,Dv.value
    
    def SATD(self, D,kph=1):
        '''iterate for temperature and pressure given a density along the saturation boundary.
        kph--flag specifying desired root for multi-valued inputs
        (has meaning only for water at temperatures close to its triple point)
            -1=middle root (between 0 and 4C), 1=return highest temperature root (above 4C), 3=lowest temperature root (along freezing line)'''
        D=c_double(D)
        kph=c_long(kph)
        kr=c_long()
        p=c_double()
        t=c_double()
        Dl,Dv=c_double(),c_double()
        self.SATDdll(byref(D),self.x,byref(kph),byref(kr),byref(t),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(self.ierr),byref(self.herr),c_long(255))
        return kr.value,t.value,Dl.value,Dv.value
    
    def SATH(self, h,kph=2):
        '''iterate for temperature, pressure, and density given enthalpy along the saturation boundary
             kph--flag specifying desired root
                 0 = all roots along the liquid-vapor line
                 1 = only liquid VLE root
                 2 = only vapor VLE roots
                 3 = liquid SLE root (melting line)
                 4 = vapor SVE root (sublimation line)'''
        h=c_double(h)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        self.SATHdll(byref(h),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value
    
    def SATE(self, e,kph=2):
        '''iterate for temperature, pressure, and density given energy along the saturation boundary
             kph--flag specifying desired root
                 0 = all roots along the liquid-vapor line
                 1 = only liquid VLE root
                 2 = only vapor VLE roots
                 3 = liquid SLE root (melting line)
                 4 = vapor SVE root (sublimation line)'''
        e=c_double(e)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        self.SATEdll(byref(e),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value
    
    def SATS(self, s,kph=2):
        '''iterate for temperature, pressure, and density given an entropy along the saturation boundary
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        s=c_double(s)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        k3,t3,p3,d3=c_double(),c_double(),c_double(),c_double()
        self.SATSdll(byref(s),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(k3),byref(t3),byref(p3),byref(d3),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value,k3.value,t3.value,p3.value,d3.value
    
    def CSATK(self, icomp,t,kph=2):
        '''heat capacity along the saturation line as a function of temperature for a given component
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        icomp=c_long(icomp)
        t=c_double(t)
        kph=c_long(kph)
        p=c_double()
        D=c_double()
        csat=c_double()
        self.CSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,csat.value
    
    def DPTSATK(self, icomp,t,kph=2):
        '''heat capacity and dP/dT along the saturation line as a function of temperature for a given component
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        icomp=c_long(icomp)
        t=c_double(t)
        kph=c_long(kph)
        p=c_double()
        D=c_double()
        csat=c_double()
        dpt=c_double()
        self.DPTSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(dpt),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,csat.value,dpt.value
    
    def CV2PK(self, icomp,t,D):
        '''isochoric heat capacity in the two phase (liquid+vapor) region'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        cv2p,csat=c_double(),c_double()
        self.CV2PKdll(byref(icomp),byref(t),byref(D),byref(cv2p),byref(csat),byref(self.ierr),byref(self.herr),c_long(255))
        return cv2p.value,csat.value
    
    def TPRHO(self, t,p,kph=2,kguess=0,D=0):
        '''iterate for density as a function of temperature, pressure, and composition for a specified phase
         kph--phase flag: 1=liquid 2=vapor
         NB: 0 = stable phase--NOT ALLOWED (use TPFLSH) (unless an initial guess is supplied for D)
            -1 = force the search in the liquid phase
            -2 = force the search in the vapor phase
         kguess--input flag:
             1 = first guess for D provided
             0 = no first guess provided
         D--first guess for molar density [mol/L], only if kguess=1'''
        t=c_double(t)
        p=c_double(p)
        kph=c_long(kph)
        kguess=c_long(kguess)
        D=c_double(D)
        self.TPRHOdll(byref(t),byref(p),self.x,byref(kph),byref(kguess),byref(D),byref(self.ierr),byref(self.herr),c_long(255))
        return D.value
    
    # -- GENERAL FLASH SUBROUTINES --
    
    def TPFLSH(self, t,p):
        '''flash calculation given temperature and pressure'''
        t=c_double(t)
        p=c_double(p)
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e,h,s=c_double(),c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.TPFLSHdll(byref(t),byref(p),self.x,byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return D.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value
    
    def TDFLSH(self, t,D):
        '''flash calculation given temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        Dl,Dv=c_double(),c_double()
        q,e,h,s=c_double(),c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.TDFLSHdll(byref(t),byref(D),self.x,byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value
    
    def PDFLSH(self, p,D):
        '''flash calculation given pressure and density'''
        p=c_double(p)
        D=c_double(D)
        t=c_double()
        Dl,Dv=c_double(),c_double()
        q,e,h,s=c_double(),c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.PDFLSHdll(byref(p),byref(D),self.x,byref(t),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value
    
    def PHFLSH(self, p,h):
        '''flash calculation given pressure and enthalpy'''
        p=c_double(p)
        h=c_double(h)
        t=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.PHFLSHdll(byref(p),byref(h),self.x,byref(t),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,D.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value
    
    def PSFLSH(self, p,s):
        '''flash calculation given pressure and entropy'''
        p=c_double(p)
        s=c_double(s)
        t=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e,h=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.PSFLSHdll(byref(p),byref(s),self.x,byref(t),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,D.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value
    
    def PEFLSH(self, p,e):
        '''flash calculation given pressure and energy'''
        p=c_double(p)
        e=c_double(e)
        t=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,s,h=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.PEFLSHdll(byref(p),byref(e),self.x,byref(t),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,D.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value
    
    def THFLSH(self, t,h,kr=1):
        '''flash calculation given temperature and enthalpy'''
        kr=c_long(kr)
        t=c_double(t)
        h=c_double(h)
        p=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.THFLSHdll(byref(t),byref(h),self.x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value
    
    def TSFLSH(self, t,s,kr=1):
        '''flash calculation given temperature and entropy
         kr--phase flag:
            1=liquid,
            2=vapor in equilibrium with liq,
            3=liquid in equilibrium with solid,
            4=vapor in equilibrium with solid'''
        t=c_double(t)
        s=c_double(s)
        kr=c_long(kr)
        p=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e,h=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.TSFLSHdll(byref(t),byref(s),self.x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value
    
    def TEFLSH(self, t,e,kr=1):
        '''flash calculation given temperature and energy'''
        t=c_double(t)
        e=c_double(e)
        kr=c_long(kr)
        p=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.TEFLSHdll(byref(t),byref(e),self.x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return kr.value,p.value,D.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value
    
    def DHFLSH(self, D,h):
        '''flash calculation given density and enthalpy'''
        D=c_double(D)
        h=c_double(h)
        t,p=c_double(),c_double()
        Dl,Dv=c_double(),c_double()
        q,e,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.DHFLSHdll(byref(D),byref(h),self.x,byref(t),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,p.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value
    
    def DSFLSH(self, D,s):
        '''flash calculation given density and entropy'''
        D=c_double(D)
        s=c_double(s)
        t,p=c_double(),c_double()
        Dl,Dv=c_double(),c_double()
        q,e,h=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.DSFLSHdll(byref(D),byref(s),self.x,byref(t),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,p.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value
    
    def DEFLSH(self, D,e):
        '''flash calculation given density and energy'''
        D=c_double(D)
        e=c_double(e)
        t,p=c_double(),c_double()
        Dl,Dv=c_double(),c_double()
        q,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.DEFLSHdll(byref(D),byref(e),self.x,byref(t),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,p.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value
    
    def HSFLSH(self, h,s):
        '''flash calculation given enthalpy and entropy'''
        h=c_double(h)
        s=c_double(s)
        t,p=c_double(),c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,e=c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.HSFLSHdll(byref(h),byref(s),self.x,byref(t),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(e),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,p.value,D.value,Dl.value,Dv.value,q.value,e.value,cv.value,cp.value,w.value
    
    def ESFLSH(self, e,s):
        '''flash calculation given energy and entropy'''
        e=c_double(e)
        s=c_double(s)
        t,p=c_double(),c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        q,h=c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.ESFLSHdll(byref(e),byref(s),self.x,byref(t),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(q),byref(h),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,p.value,D.value,Dl.value,Dv.value,q.value,h.value,cv.value,cp.value,w.value
    
    def TQFLSH(self, t,q,kq=1):
        '''flash calculation given temperature and quality
         kq--flag specifying units for input quality
         kq = 1 quality on MOLAR basis [moles vapor/total moles]
         kq = 2 quality on MASS basis [mass vapor/total mass]
        '''
        t=c_double(t)
        q=c_double(q)
        kq=c_long()
        p=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.TQFLSHdll(byref(t),byref(q),self.x,byref(kq),byref(p),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return kq.value,p.value,D.value,Dl.value,Dv.value,e.value,h.value,s.value,cv.value,cp.value,w.value
    
    def PQFLSH(self, p,q,kq=1):
        '''flash calculation given pressure and quality
         kq--flag specifying units for input quality
         kq = 1 quality on MOLAR basis [moles vapor/total moles]
         kq = 2 quality on MASS basis [mass vapor/total mass]
        '''
        p=c_double(p)
        q=c_double(q)
        kq=c_long(kq)
        t=c_double()
        D,Dl,Dv=c_double(),c_double(),c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        self.PQFLSHdll(byref(p),byref(q),self.x,byref(kq),byref(t),byref(D),byref(Dl),byref(Dv),self.xl,self.xv,byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(self.ierr),byref(self.herr),c_long(255))
        return kq.value,t.value,D.value,Dl.value,Dv.value,e.value,h.value,s.value,cv.value,cp.value,w.value
    
    def CCRIT(self, t,p,v):
        '''critical flow factor, C*, for nozzle flow of a gas'''
        t=c_double(t)
        p=c_double(p)
        v=c_double(v)
        cs,ts,Ds,ps,ws=c_double(),c_double(),c_double(),c_double(),c_double()
        self.CCRITdll(byref(t),byref(p),byref(v),self.x,byref(cs),byref(ts),byref(Ds),byref(ps),byref(ws),byref(self.ierr),byref(self.herr),c_long(255))
        return cs.value,ts.value,Ds.value,ps.value,ws.value
    
    def FPV(self, t,D,p):
        '''supercompressibility factor, Fpv'''
        t=c_double(t)
        D=c_double(D)
        p=c_double(p)
        f=c_double()
        self.FPVdll(byref(t),byref(D),byref(p),self.x,byref(f))
        return f.value
    
    def CP0(self, t):
        '''mixture Cp0 calculated by appropriate core CP0xxx routine(s)'''
        t=c_double(t)
        cp=c_double()
        self.CP0dll(byref(t),self.x,byref(cp))
        return cp.value
    
    def TRNPRP(self, t,D):
        '''transport properties of thermal conductivity and
         viscosity as functions of temperature and density
         eta--viscosity (uPa.s)
         tcx--thermal conductivity (W/m.K)'''
        t=c_double(t)
        D=c_double(D)
        eta,tcx=c_double(),c_double()
        self.TRNPRPdll(byref(t),byref(D),self.x,byref(eta),byref(tcx),byref(self.ierr),byref(self.herr),c_long(255))
        return eta.value,tcx.value
    
    def INFO(self, icomp=1):
        'provides fluid constants for specified component'
        icomp=c_long(icomp)
        self.wm=c_double()
        ttrp,tnbpt,tc=c_double(),c_double(),c_double()
        pc=c_double()
        Dc=c_double()
        Zc,acf,dip=c_double(),c_double(),c_double()
        Rgas=c_double()
        self.INFOdll(byref(icomp),byref(self.wm),byref(ttrp),byref(tnbpt),byref(tc),byref(pc),byref(Dc),byref(Zc),byref(acf),byref(dip),byref(Rgas))
        return self.wm.value,ttrp.value,tnbpt.value,tc.value,pc.value,Dc.value,Zc.value,acf.value,dip.value,Rgas.value
    
    def GETHEADER(self, fluid):
        '''read and interpret text at head of FLD file'''
        def gets(self, ):
            s=f.readline()
            if '!' in s:
                lhs,rhs=s.split('!')
                lhs=lhs.strip()
                rhs=rhs.strip()
            else:
                lhs=s.strip()
                rhs=''
            return lhs,rhs
    
        H={}
        f=open(self.fldpath+fluid+'.fld', 'r')
        H['shortname'],rhs=gets()
        H['casnum'],rhs=gets()
        H['fullname'],rhs=gets()
        H['chemform'],rhs=gets()
        H['synonym'],rhs=gets() # R-Number
        H['mw'],rhs=gets()
        H['ttp'],rhs=gets()
        H['tnbp'],rhs=gets()
        H['tc'],rhs=gets()
        H['pc'],rhs=gets()
        H['dc'],rhs=gets()
        H['accen'],rhs=gets()
        H['dip'],rhs=gets()
        lhs,rhs=gets()
        H['ref']=lhs
        if lhs[0:2].lower()=='ot':
            H['ref']='OTH' ## not sure why some fluids have OT0
        lhs,rhs=gets()
        a=lhs.split()
        H['tphs']=a[0]+','+a[1]+','+a[2]+','+a[3]
        H['ver'],rhs=gets()
        lhs,rhs=gets()
        if rhs[0:2].lower()=='un':
            H['unnum']=lhs
            lhs,rhs=gets()
        else:
            H['unnum']=''
        H['family']=lhs
        H['comps']=1
        f.close()
        return H
    
    def GETMIXHEADER(self, mix):
        H={}
        f=open(self.mixpath+mix, 'r')
        s=f.readline().strip()
        H['shortname']=s
        H['casnum']=''
        H['fullname']=s
        H['synonym']=s
        H['ref']=''
        H['family']=''
        s=f.readline()
        a=s.split()
        H['mw']=a[0]
        H['tc']=a[1]
        H['pc']=a[2]
        H['dc']=a[3]
        self.nc=int(f.readline().strip())
        H['comps']=self.nc
        # read component names
        chemform=[]
        for i in range(self.nc):
            lhs,rhs=f.readline().strip().split('.')
            chemform.append(lhs)
        H['chemform']=chemform
        # read proportions
        for i in range(self.nc):
            s=f.readline().strip()
        f.close()
        return H
    
    def NAME(self, icomp):
        icomp=c_long(icomp)
        self.NAMEdll(byref(icomp),byref(self.hname),byref(self.hn80),byref(self.hcas),c_long(12),c_long(80),c_long(12))
        lhs,rhs=self.hn80.value.split('!')
        lhs=lhs.strip()
        return self.hname.value.strip(),lhs,self.hcas.value.strip()
    
    def XMASS(self, xmol):
        self.XMASSdll(xmol,self.xkg,byref(self.wmix))
        return self.wmix.value
    
    def XMOLE(self, xkg):
        self.XMOLEdll(xkg,self.xmol,byref(self.wmix))
        return self.wmix.value
    
    def LIMITX(self, htyp='EOS',t=0,D=0,p=0):
        htyp=create_string_buffer(htyp, 3)
        t=c_double(t)
        D=c_double(D)
        p=c_double(p)
        tmin,tmax,Dmax,pmax=c_double(),c_double(),c_double(),c_double()
        self.LIMITXdll(byref(htyp),byref(t),byref(D),byref(p),self.x,byref(tmin),byref(tmax),byref(Dmax),byref(pmax),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
        return tmin.value,tmax.value,Dmax.value,pmax.value
    
    def LIMITK(self, htyp='EOS',icomp=1,t=0,D=0,p=0):
        htyp=create_string_buffer(htyp, 3)
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        p=c_double(p)
        tmin,tmax,Dmax,pmax=c_double(),c_double(),c_double(),c_double()
        self.LIMITKdll(byref(htyp),byref(icomp),byref(t),byref(D),byref(p),byref(tmin),byref(tmax),byref(Dmax),byref(pmax),byref(self.ierr),byref(self.herr),c_long(3),c_long(255))
        return tmin.value,tmax.value,Dmax.value,pmax.value
    
    def LIMITS(self, htyp='EOS'):
        'limits of Model'
        htyp=create_string_buffer(htyp, 3)
        tmin, tmax, Dmax, pmax=c_double(),c_double(),c_double(),c_double()
        self.LIMITSdll(byref(htyp),self.x,byref(tmin),byref(tmax),byref(Dmax),byref(pmax),c_long(3))
        return tmin.value,tmax.value,Dmax.value,pmax.value
    
    def QMASS(self, qmol):
        qmol=c_double(qmol)
        qkg=c_double()
        wl,wv=c_double(),c_double()
        self.QMASSdll(byref(qmol),self.xl,self.xv,byref(qkg),self.xlkg,self.xvkg,byref(wl),byref(wv),byref(self.ierr),byref(self.herr),c_long(255))
        return qkg.value,wl.value,wv.value
    
    def QMOLE(self, qkg):
        qkg=c_double(qkg)
        qmol=c_double()
        wl,wv=c_double(),c_double()
        self.QMOLEdll(byref(qkg),self.xlkg,self.xvkg,byref(qmol),self.xl,self.xv,byref(wl),byref(wv),byref(self.ierr),byref(self.herr),c_long(255))
        return qmol.value,wl.value,wv.value
    
    def WMOL(self, ):
        'molecular weight of mixture'
        self.WMOLdll(self.x,byref(self.wm))
        return self.wm.value
    
    def DIELEC(self, t,D):
        '''dielectric constant as a function of temperature, density'''
        t=c_double(t)
        D=c_double(D)
        de=c_double()
        self.DIELECdll(byref(t),byref(D),self.x,byref(de))
        return de.value
    
    def SURFT(self, t,D):
        '''surface tension'''
        t=c_double(t)
        D=c_double(D)
        sigma=c_double()
        self.SURFTdll(byref(t),byref(D),self.x,byref(sigma),byref(self.ierr),byref(self.herr),c_long(255))
        return sigma.value
    
    def SURTEN(self, t):
        '''surface tension'''
        t=c_double(t)
        sigma=c_double()
        Dl,Dv=c_double(),c_double()
        self.SURTENdll(byref(t),byref(Dl),byref(Dv),self.xl,self.xv,byref(sigma),byref(self.ierr),byref(self.herr),c_long(255))
        return sigma.value
    
    # single phase flash routines
    
    def PDFL1(self, p,D):
        '''from pressure and density'''
        p=c_double(p)
        D=c_double(D)
        t=c_double()
        self.PDFL1dll(byref(p),byref(D),self.x,byref(t),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value
    
    def PHFL1(self, p,h,kph=2):
        '''from pressure and enthalpy'''
        p=c_double(p)
        h=c_double(h)
        kph=c_long(kph)
        t,D=c_double(),c_double()
        self.PHFL1dll(byref(p),byref(h),self.x,byref(kph),byref(t),byref(D),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,D.value
    
    def PSFL1(self, p,s,kph=2):
        '''from pressure and entropy'''
        p=c_double(p)
        s=c_double(s)
        kph=c_long(kph)
        t,D=c_double(),c_double()
        self.PSFL1dll(byref(p),byref(s),self.x,byref(kph),byref(t),byref(D),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value,D.value
    
    def SETKTV(self, icomp,jcomp):
        '''set mixture model and/or parameters'''
        icomp=c_long(icomp)
        jcomp=c_long(jcomp)
        fij=c_double()
        hmodij=c_double()
        self.SETKTVdll(byref(icomp),byref(jcomp),byref(hmodij),byref(fij),byref(self.hfmix),byref(self.ierr),byref(self.herr),c_long(3),c_long(255),c_long(255))
        return fij.value
    
    def GETKTV(self, icomp,jcomp):
        '''retrieve mixture model and parameter info for a specified binary'''
        icomp=c_long(icomp)
        jcomp=c_long(jcomp)
        fij=c_double()
        hmodij=c_double()
        hmxrul=create_string_buffer('', 255)
        hbinp=create_string_buffer('', 255)
        hfij=create_string_buffer('', 255)
        self.GETKTVdll(byref(icomp),byref(jcomp),byref(hmodij),byref(fij),byref(self.hfmix),byref(hfij),byref(hbinp),byref(hmxrul),c_long(3),c_long(255),c_long(48),c_long(255),c_long(255))
        return fij.value
    
    def GETFIJ(self, hmodij):
        '''retrieve parameter info for a specified mixing rule'''
        fij,hfij2=c_double(),c_double()
        hmodij=c_double()
        hmxrul=create_string_buffer('', 255)
        self.GETFIJdll(byref(hmodij),byref(fij),byref(hfij2),byref(hmxrul),c_long(255))
        return fij.value,hfij2.value
    
    def MELTT(self, t):
        '''melting line pressure as a function of temperature'''
        t=c_double(t)
        p=c_double()
        self.MELTTdll(byref(t),self.x,byref(p),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value
    
    def MLTH2O(self, t):
        '''melting pressure of water'''
        t=c_double(t)
        p1,p2=c_double(),c_double()
        self.MLTH2Odll(byref(t),byref(p1),byref(p2))
        return p1.value,p2.value
    
    def MELTP(self, p):
        '''melting line temperature as a function of pressure'''
        p=c_double(p)
        t=c_double()
        self.MELTPdll(byref(p),self.x,byref(t),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value
    
    def SUBLT(self, t):
        '''sublimation line pressure as a function of temperature'''
        t=c_double(t)
        p=c_double()
        self.SUBLTdll(byref(t),self.x,byref(p),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value
    
    def SUBLP(self, p):
        '''sublimation line temperature as a function of pressure'''
        p=c_double(p)
        t=c_double()
        self.SUBLPdll(byref(p),self.x,byref(t),byref(self.ierr),byref(self.herr),c_long(255))
        return t.value
    
    
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
    #    print 'self.wm=%0.3f g/mol'%(self.wm.value)
    #
    #    tf,dl,dv=SATP(0,3) # get freezing point
    #    tc,pc,Dc=CRITP() # get critical point
    #    print 'tc=%0.2f\xb0C pc=%0.0fkPa Dc=%0.1fkg/m3'%(tc-self.self.k0,pc,Dc*self.wm.value)
    #
    #    tl=0.0+self.self.k0
    #    p,dl,dv=SATT(tl,1)
    #    hl=ENTHAL(tl,dl)
    #    sl=ENTRO(tl,dl)
    #    print 'tl=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg sl=%0.3fkJ/kg-K'%(tl-self.self.k0,dl*self.wm.value,hl/self.wm.value,sl/self.wm.value)
    #
    #    p=1100.0
    #    tv,dl,dv=SATP(p,2)
    #    hv=ENTHAL(tv,dv)
    #    tl,dl,dv=SATP(p,1)
    #    hl=ENTHAL(tl,dl)
    #    print 'tl=%0.2f\xb0C tv=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg hv=%0.2fkJ/kg'%(tl-self.self.k0,tv-self.self.k0,dl*self.wm.value,hl/self.wm.value,hv/self.wm.value)


class RefpropSI(Refprop):
    ''' Refprop wrapper with SI units and a mass based qualityt as default. 
    Note that ALL flash routines in this class give the same output parameters: T,p,D,Dl,Dv,q,e,h,s,cv,cp,w
    Saturation calculations also return a unified array: t,p,Dl,Dv'''
    
    #
    # Use mass based quality as default
    #
    def Q_MA2MO(self, q):
        '''Convert mass based quality to molar value'''
        return self.QMOLE(q)[0]
    
    def Q_MO2MA(self, q):
        '''Convert mole based quality to specific value'''
        return self.QMASS(q)[0]
    
    #
    # Convert to Refprop units
    #
    def WM_SI2RP(self, wm):
        '''wm--molar weight [kg/mol]'''
        return wm*1000. # kg/mol * 1000 = g/mol
    
    def T_SI2RP(self, t):
        ''''t--temperature'''
        return t
    
    def P_SI2RP(self, p):
        '''p--pressure [Pa]'''
        return p/1000.0

    def D_SI2RP(self, d):
        '''d--bulk density [kg/m3]'''
        return d/super(RefpropSI, self).WMOL()  # kg/m3 = g/l / g/mol  = mol/l

    def E_SI2RP(self, e):
        '''e--internal energy [J/kg]'''
        return e*self.WMOL() # J/kg * kg/mol = J/mol

    def H_SI2RP(self, h):
        '''h--enthalpy [J/kg]'''
        return h*self.WMOL() # J/kg * kg/mol = J/mol

    def S_SI2RP(self, s):
        '''s--entropy [[J/kg-K]'''
        return s*self.WMOL() # J/(kg.K) * kg/mol = J/(mol.K)

    
    #
    # Convert to SI units
    #
    def WM_RP2SI(self, wm):
        '''wm--molar weight [g/mol]'''
        return wm/1000. # g/mol / 1000 = kg/mol
    
    def T_RP2SI(self, t):
        ''''t--temperature'''
        return t
    
    def P_RP2SI(self, p):
        ''''p--pressure [kPa]'''
        return p*1000.0

    def D_RP2SI(self, d): 
        '''d--bulk molar density [mol/L]'''
        return d*super(RefpropSI, self).WMOL() # mol/l * g/mol = g/l = kg/m3

    def E_RP2SI(self, e): 
        '''e--internal energy [J/mol]'''
        return e/self.WMOL() # J/mol / kg/mol = J/kg

    def H_RP2SI(self, h): 
        '''h--enthalpy [J/mol]'''
        return h/self.WMOL() # J/mol / g/mol * 1000g/kg = J/kg

    def S_RP2SI(self, s): 
        '''s--entropy [[J/mol-K]'''
        return s/self.WMOL() # J/(mol.K) / g/mol * 1000g/kg = J/(kg.K)

    def CV_RP2SI(self, cv): 
        return cv/self.WMOL()

    def CP_RP2SI(self, cp): 
        return cp/self.WMOL()

    def W_RP2SI(self, w): 
        '''speed of sound'''
        return w

    def ETA_RP2SI(self, eta): 
        '''Viscosity eta [mu Pas]'''
        return eta/1e6

    def TCX_RP2SI(self, tcx): 
        return tcx

    def HJT_RP2SI(self, hjt):
        '''isenthalpic Joule-Thompson coefficient [K/kPa]/1000Pa*kPa = K/Pa'''
        return hjt/1000.

    def A_RP2SI(self, a):
        '''Helmholtz energy [J/mol]'''
        return a/self.WMOL() # J/mol / g/mol * 1000g/kg = J/kg
    
    def G_RP2SI(self, g):    
        '''Gibbs free energy [J/mol]'''
        return g/self.WMOL() # J/mol / g/mol * 1000g/kg = J/kg

    def XKAPPA_RP2SI(self, xkappa):
        '''isothermal compressibility (= -1/V dV/dP = 1/rho dD/dP) [1/kPa] /1000Pa*kPa = 1/Pa'''
        return xkappa / 1000. 

    def BETA_RP2SI(self, beta):
        '''volume expansivity (= 1/V dV/dT = -1/rho dD/dT) [1/K]'''
        return beta

#
#    def DPDD_RP2SI(self, ):
#        '''derivative dP/drho [kPa-L/mol] * 1000Pa/kPa * mol/g = Pa.m3 / kg'''
#    return ddpdd * 1000. / dwm;
#}
#    def D2PDD2_RP2SI(self, ):
#        '''derivative d^2P/drho^2 [kPa-L^2/mol^2] * 1000Pa/kPa * mol/g * mol/g = Pa m6 / kg2'''
#    return dd2pdd2 * 1000. / dwm / dwm;
#}
#    def DPDT_RP2SI(self, ):
#        '''derivative dP/dT [kPa/K] * 1000Pa/kPa = Pa/K'''
#    return ddpdt * 1000.;
#}
#    def DDDT_RP2SI(self, ):
#        '''derivative drho/dT [mol/(L-K)] * g/mol = kg/m3 / K'''
#    return ddddt * dwm;
#}
#    def DDDP_RP2SI(self, ):
#        '''derivative drho/dP [mol/(L-kPa)]'''
#    return ddddp*dwm/1000. # mol/(l.kPa) * g/mol * 1kPa/1000Pa = kg/(m3.Pa)
#}
#    def D2PDT2_RP2SI(self, ):
#        '''derivative d2P/dT2 [kPa/K^2] * 1000Pa/kPa = Pa/K2'''
#    return dd2pdt2 * 1000.;
#}
#    def D2PDTD_RP2SI(self, ):
#        '''derivative d2P/dTd(rho) [J/mol-K] / g/mol * 1000g/kg = J/kg.K'''
#    return  dd2pdtd/dwm*1000.;
#}
#
#
#    def _dhdt_d_RP2SI(self, ):
#        '''dH/dT at constant density [J/(mol-K)] / g/mol * 1000g/kg = J/kg.K'''
#    return ddhdt_d/dwm*1000;
#}
#    def _dhdt_p_RP2SI(self, ):
#        '''dH/dT at constant pressure [J/(mol-K)]'''
#    return ddhdt_p/dwm*1000;
#}
#    def _dhdd_t_RP2SI(self, ):
#        '''dH/drho at constant temperature [(J/mol)/(mol/L)] * mol/g * 1000g/kg / g/mol = (J/kg) / (kg/m3)'''
#    return ddhdd_t /dwm*1000. / dwm;
#}
#    def _dhdd_p_RP2SI(self, ):
#        '''dH/drho at constant pressure [(J/mol)/(mol/L)]'''
#    return ddhdd_p /dwm*1000. / dwm;
#}
#    def _dhdp_t_RP2SI(self, ):
#        '''dH/dP at constant temperature [J/(mol-kPa)] /dwm*1000. / (1000Pa/kPa) = J/kg.Pa'''
#    return ddhdp_t / dwm;
#}
#    def _dhdp_d_RP2SI(self, ):
#        '''dH/dP at constant density [J/(mol-kPa)]'''
#    return ddhdp_d / dwm;
#}
#        
#    def _dddh_p_RP2SI(self, ): 
#        '''Derivative of density with respect to enthalpy at constant pressure'''
#    return ddddh_p*dwm*dwm/1000. # (mol/l * mol/J) * g/mol * g/mol * 1kg/1000g = kg/m3 * kg/J
#}
#    def _dddp_h_RP2SI(self, ): 
#        '''Derivative of density with respect to pressure at constant enthalpy'''
#    return ddddp_h*dwm/1000. # mol/(l.kPa) * g/mol * 1kPa/1000Pa = kg/(m3.Pa)
#}
    
    
    
    def SETREF(self, FluidRef='DEF', ixflag=1, h0=0, s0=0, t0=0, p0=0):
        '''set reference state enthalpy and entropy'''
        return super(RefpropSI, self).SETREF(FluidRef=FluidRef, ixflag=ixflag, h0=self.h_SI2RP(h0), s0=self.s_SI2RP(s0), t0=t0, p0=self.p_SI2RP(p0))
    
    def CRITP(self):
        '''critical parameters'''
        tcrit,pcrit,Dcrit = super(RefpropSI, self).CRITP()
        return self.T_RP2SI(tcrit),self.P_RP2SI(pcrit),self.D_RP2SI(Dcrit)
    
    def THERM(self, t,D):
        raise NotImplementedError
        '''thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(self.D_SI2RP(D))
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        hjt=c_double()
        self.THERMdll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(hjt))
        return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,hjt.value
    
    def THERM0(self, t,D):
        raise NotImplementedError
        '''ideal gas thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w=c_double()
        a,g=c_double(),c_double()
        self.THERM0dll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(a),byref(g))
        return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,a.value,g.value
    
    def THERM2(self, t,D):
        raise NotImplementedError
        '''thermal quantities as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        e,h,s=c_double(),c_double(),c_double()
        cv,cp=c_double(),c_double()
        w,Z,hjt=c_double(),c_double(),c_double()
        A,G=c_double(),c_double()
        spare1,spare2=c_double(),c_double()
        spare3,spare4=c_double(),c_double()
        self.xkappa,beta=c_double(),c_double()
        dPdD,d2PdD2=c_double(),c_double()
        dPdT,dDdT,dDdP=c_double(),c_double(),c_double()
        self.THERM2dll(byref(t),byref(D),self.x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(Z),byref(hjt),byref(A),byref(G),byref(self.xkappa),byref(beta),byref(dPdD),byref(d2PdD2),byref(dPdT),byref(dDdT),byref(dDdP),byref(spare1),byref(spare2),byref(spare3),byref(spare4))
        return t.value,D.value,p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,Z.value,hjt.value,A.value,G.value,self.xkappa.value,beta.value,dPdD.value,d2PdD2.value,dPdT.value,dDdT.value,dDdP.value
    
    def THERM3(self, t,D):
        raise NotImplementedError
        '''miscellaneous thermodynamic properties'''
        t=c_double(t)
        D=c_double(D)
        self.xkappa=c_double()
        beta=c_double()
        self.xisenk=c_double()
        self.xkt=c_double()
        betas=c_double()
        bs=c_double()
        self.xkkt=c_double()
        thrott=c_double()
        pint=c_double()
        spht=c_double()
        self.THERM3dll(byref(t),byref(D),self.x,byref(self.xkappa),byref(beta),byref(self.xisenk),byref(self.xkt),byref(betas),byref(bs),byref(self.xkkt),byref(thrott),byref(pint),byref(spht))
        return self.xkappa,beta,self.xisenk,self.xkt,betas,bs,self.xkkt,thrott,pint,spht
    
    def ENTRO(self, t,D):
        raise NotImplementedError
        '''entropy as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        s=c_double()
        self.ENTROdll(byref(t),byref(D),self.x,byref(s))
        return s.value
    
    def ENTHAL(self, t,D):
        raise NotImplementedError
        '''enthalpy as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        h=c_double()
        self.ENTHALdll(byref(t),byref(D),self.x,byref(h))
        return h.value
    
    def CVCP(self, t,D):
        raise NotImplementedError
        '''isochoric (constant volume) and isobaric (constant pressure) heat
        capacity as functions of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        cv,cp=c_double(),c_double()
        self.CVCPdll(byref(t),byref(D),self.x,byref(cv),byref(cp))
        return cv.value,cp.value
    
    def CVCPK(self, icomp,t,D):
        raise NotImplementedError
        '''isochoric (constant volume) and isobaric (constant pressure) heat
        capacity as functions of temperature and density for a given component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        cv,cp=c_double(),c_double()
        self.CVCPKdll(byref(icomp),byref(t),byref(D),byref(cv),byref(cp))
        return cv.value,cp.value
    
    def GIBBS(self, t,D):
        raise NotImplementedError
        '''residual Helmholtz and Gibbs free energy as a function of
        temperature and density'''
        t=c_double(t)
        D=c_double(D)
        Ar,Gr=c_double(),c_double()
        self.GIBBSdll(byref(t),byref(D),self.x,byref(Ar),byref(Gr))
        return Ar.value,Gr.value
    
    def AG(self, t,D):
        raise NotImplementedError
        '''Helmholtz and Gibbs energies as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        a,g=c_double(),c_double()
        self.AGdll(byref(t),byref(D),self.x,byref(a),byref(g))
        return a.value,g.value
    
    def PRESS(self, t,D):
        raise NotImplementedError
        '''pressure as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        p=c_double()
        self.PRESSdll(byref(t),byref(D),self.x,byref(p))
        return p.value
    
    def DPDD(self, t,D):
        raise NotImplementedError
        '''partial derivative of pressure w.r.t. density at constant temperature as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dpdD=c_double()
        self.DPDDdll(byref(t),byref(D),self.x,byref(dpdD))
        return dpdD.value
    
    def DPDDK(self, icomp,t,D):
        raise NotImplementedError
        '''partial derivative of pressure w.r.t. density at constant temperature as a
        function of temperature and density for a specified component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        dpdD=c_double()
        self.DPDDKdll(byref(icomp),byref(t),byref(D),byref(dpdD))
        return dpdD.value
    
    def DPDD2(self, t,D):
        raise NotImplementedError
        '''second partial derivative of pressure w.r.t. density at const temperature
        as a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        d2PdD2=c_double()
        self.DPDD2dll(byref(t),byref(D),self.x,byref(d2PdD2))
        return d2PdD2.value
    
    def DPDT(self, t,D):
        raise NotImplementedError
        '''partial derivative of pressure w.r.t. temperature at constant density as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dpt=c_double()
        self.DPDTdll(byref(t),byref(D),self.x,byref(dpt))
        return dpt.value
    
    def DPDTK(self, icomp,t,D):
        raise NotImplementedError
        '''partial derivative of pressure w.r.t. temperature at constant density as a
        function of temperature and density for a specified component'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        dpt=c_double()
        self.DPDTKdll(byref(icomp),byref(t),byref(D),byref(dpt))
        return dpt.value
    
    def DDDP(self, t,D):
        raise NotImplementedError
        '''partial derivative of density w.r.t. pressure at constant temperature as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dDdp=c_double()
        self.DDDPdll(byref(t),byref(D),self.x,byref(dDdp))
        return dDdp.value
    
    def DDDT(self, t,D):
        raise NotImplementedError
        '''partial derivative of density w.r.t. temperature at constant pressure as a
        function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dDdt=c_double()
        self.DDDTdll(byref(t),byref(D),self.x,byref(dDdt))
        return dDdt.value
    
    def DHD1(self, t,D):
        raise NotImplementedError
        '''partial derivatives of enthalpy w.r.t. t, p, or D at constant t, p, or D as
        a function of temperature and density'''
        t=c_double(t)
        D=c_double(D)
        dhdt_d=c_double()
        dhdt_p=c_double()
        dhdd_t=c_double()
        dhdd_p=c_double()
        dhdp_t=c_double()
        dhdp_d=c_double()
        self.DHD1dll(byref(t),byref(D),self.x,byref(dhdt_d),byref(dhdt_p),byref(dhdd_t),byref(dhdd_p),byref(dhdp_t),byref(dhdp_d))
        return dhdt_d.value,dhdt_p.value,dhdd_t.value,dhdd_p.value,dhdp_t.value,dhdp_d.value
    
    def FGCTY(self, t,D):
        raise NotImplementedError
        '''fugacity for each of the nc components of a mixture by numerical
        differentiation (using central differences) of the dimensionless residual
        Helmholtz energy'''
        t=c_double(t)
        D=c_double(D)
        f=(c_double*self.self.MaxComps)()
        self.FGCTYdll(byref(t),byref(D),self.x,f)
        return f
    
    def VIRB(self, t):
        raise NotImplementedError
        '''second virial coefficient as a function of temperature'''
        t=c_double(t)
        b=c_double()
        self.VIRBdll(byref(t),self.x,byref(b))
        return b.value
    
    def DBDT(self, t):
        raise NotImplementedError
        '''2nd derivative of B (B is the second virial coefficient) with respect to T
        as a function of temperature'''
        t=c_double(t)
        b=c_double()
        self.DBDTdll(byref(t),self.x,byref(b))
        return b.value
    
    def VIRC(self, t):
        raise NotImplementedError
        '''third virial coefficient as a function of temperature'''
        t=c_double(t)
        c=c_double()
        self.VIRCdll(byref(t),self.x,byref(c))
        return c.value
    
    def SATT(self, t,kph=2):
        '''iterate for saturated liquid and vapor states given temperature
         kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
        t = self.T_SI2RP(t)
        p, Dl, Dv = super(RefpropSI, self).SATT(t,kph=kph)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(Dl),self.D_RP2SI(Dv)
    
    def SATP(self,p,kph=2):
        '''saturation temperature from pressure
         kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
        p = self.P_SI2RP(p)
        t,Dl,Dv = super(RefpropSI, self).SATP(p,kph=kph)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(Dl),self.D_RP2SI(Dv)
    
    def SATD(self, D,kph=1):
        raise NotImplementedError
        '''iterate for temperature and pressure given a density along the saturation boundary.
        kph--flag specifying desired root for multi-valued inputs
        (has meaning only for water at temperatures close to its triple point)
            -1=middle root (between 0 and 4C), 1=return highest temperature root (above 4C), 3=lowest temperature root (along freezing line)'''
        D=c_double(D)
        kph=c_long(kph)
        kr=c_long()
        p=c_double()
        t=c_double()
        Dl,Dv=c_double(),c_double()
        self.SATDdll(byref(D),self.x,byref(kph),byref(kr),byref(t),byref(p),byref(Dl),byref(Dv),self.xl,self.xv,byref(self.ierr),byref(self.herr),c_long(255))
        return kr.value,t.value,Dl.value,Dv.value
    
    def SATH(self, h,kph=2):
        raise NotImplementedError
        '''iterate for temperature, pressure, and density given enthalpy along the saturation boundary
             kph--flag specifying desired root
                 0 = all roots along the liquid-vapor line
                 1 = only liquid VLE root
                 2 = only vapor VLE roots
                 3 = liquid SLE root (melting line)
                 4 = vapor SVE root (sublimation line)'''
        h=c_double(h)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        self.SATHdll(byref(h),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value
    
    def SATE(self, e,kph=2):
        raise NotImplementedError
        '''iterate for temperature, pressure, and density given energy along the saturation boundary
             kph--flag specifying desired root
                 0 = all roots along the liquid-vapor line
                 1 = only liquid VLE root
                 2 = only vapor VLE roots
                 3 = liquid SLE root (melting line)
                 4 = vapor SVE root (sublimation line)'''
        e=c_double(e)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        self.SATEdll(byref(e),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value
    
    def SATS(self, s,kph=2):
        raise NotImplementedError
        '''iterate for temperature, pressure, and density given an entropy along the saturation boundary
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        s=c_double(s)
        kph=c_long(kph)
        nroot=c_long()
        k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
        k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
        k3,t3,p3,d3=c_double(),c_double(),c_double(),c_double()
        self.SATSdll(byref(s),self.x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(k3),byref(t3),byref(p3),byref(d3),byref(self.ierr),byref(self.herr),c_long(255))
        return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value,k3.value,t3.value,p3.value,d3.value
    
    def CSATK(self, icomp,t,kph=2):
        raise NotImplementedError
        '''heat capacity along the saturation line as a function of temperature for a given component
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        icomp=c_long(icomp)
        t=c_double(t)
        kph=c_long(kph)
        p=c_double()
        D=c_double()
        csat=c_double()
        self.CSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,csat.value
    
    def DPTSATK(self, icomp,t,kph=2):
        raise NotImplementedError
        '''heat capacity and dP/dT along the saturation line as a function of temperature for a given component
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
        icomp=c_long(icomp)
        t=c_double(t)
        kph=c_long(kph)
        p=c_double()
        D=c_double()
        csat=c_double()
        dpt=c_double()
        self.DPTSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(dpt),byref(self.ierr),byref(self.herr),c_long(255))
        return p.value,D.value,csat.value,dpt.value
    
    def CV2PK(self, icomp,t,D):
        raise NotImplementedError
        '''isochoric heat capacity in the two phase (liquid+vapor) region'''
        icomp=c_long(icomp)
        t=c_double(t)
        D=c_double(D)
        cv2p,csat=c_double(),c_double()
        self.CV2PKdll(byref(icomp),byref(t),byref(D),byref(cv2p),byref(csat),byref(self.ierr),byref(self.herr),c_long(255))
        return cv2p.value,csat.value
    
    def TPRHO(self, t,p,kph=2,kguess=0,D=0):
        raise NotImplementedError
        '''iterate for density as a function of temperature, pressure, and composition for a specified phase
         kph--phase flag: 1=liquid 2=vapor
         NB: 0 = stable phase--NOT ALLOWED (use TPFLSH) (unless an initial guess is supplied for D)
            -1 = force the search in the liquid phase
            -2 = force the search in the vapor phase
         kguess--input flag:
             1 = first guess for D provided
             0 = no first guess provided
         D--first guess for molar density [mol/L], only if kguess=1'''
        t=c_double(t)
        p=c_double(p)
        kph=c_long(kph)
        kguess=c_long(kguess)
        D=c_double(D)
        self.TPRHOdll(byref(t),byref(p),self.x,byref(kph),byref(kguess),byref(D),byref(self.ierr),byref(self.herr),c_long(255))
        return D.value
    
    # -- GENERAL FLASH SUBROUTINES --
    def TPFLSH(self, t,p):
        '''flash calculation given temperature and pressure'''
        t = self.T_SI2RP(t)
        p = self.P_SI2RP(p)
        D,Dl,Dv,q,e,h,s,cv,cp,w = super(RefpropSI, self).TPFLSH(t,p)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def TDFLSH(self, t,D):
        '''flash calculation given temperature and density'''
        t = self.T_SI2RP(t)
        D = self.D_SI2RP(D)
        p,Dl,Dv,q,e,h,s,cv,cp,w = super(RefpropSI, self).TDFLSH(t,D)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def PDFLSH(self, p,D):
        '''flash calculation given pressure and density'''
        p = self.P_SI2RP(p)
        D = self.D_SI2RP(D)        
        t,Dl,Dv,q,e,h,s,cv,cp,w = super(RefpropSI, self).PDFLSH(p,D)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def PHFLSH(self, p,h):
        '''flash calculation given pressure and enthalpy'''
        p = self.P_SI2RP(p)
        h = self.H_SI2RP(h)
        t,D,Dl,Dv,q,e,s,cv,cp,w = super(RefpropSI, self).PHFLSH(p,h)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def PSFLSH(self, p,s):
        '''flash calculation given pressure and entropy'''
        p = self.P_SI2RP(p)
        s = self.S_SI2RP(s)
        t,D,Dl,Dv,q,e,h,cv,cp,w = super(RefpropSI, self).PSFLSH(p,s)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def PEFLSH(self, p,e):
        '''flash calculation given pressure and energy'''
        p = self.P_SI2RP(p)
        e = self.E_SI2RP(e)
        t,D,Dl,Dv,q,h,s,cv,cp,w = super(RefpropSI, self).PEFLSH(p,e)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def THFLSH(self, t,h,kr=1):
        '''flash calculation given temperature and enthalpy'''
        t = self.T_SI2RP(t)
        h = self.H_SI2RP(h)
        p,D,Dl,Dv,q,e,s,cv,cp,w = super(RefpropSI, self).THFLSH(t,h,kr=kr)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def TSFLSH(self, t,s,kr=1):
        '''flash calculation given temperature and entropy
         kr--phase flag:
            1=liquid,
            2=vapor in equilibrium with liq,
            3=liquid in equilibrium with solid,
            4=vapor in equilibrium with solid'''
        t = self.T_SI2RP(t)
        s = self.S_SI2RP(s)
        p,D,Dl,Dv,q,e,h,cv,cp,w = super(RefpropSI, self).TSFLSH(t,s,kr=kr)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def TEFLSH(self, t,e,kr=1):
        '''flash calculation given temperature and energy'''
        t = self.T_SI2RP(t)
        e = self.E_SI2RP(e)
        kr,p,D,Dl,Dv,q,h,s,cv,cp,w = super(RefpropSI, self).TEFLSH(t,e,kr=kr)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def DHFLSH(self, D,h):
        '''flash calculation given density and enthalpy'''
        D = self.D_SI2RP(D)
        h = self.H_SI2RP(h)
        t,p,Dl,Dv,q,e,s,cv,cp,w = super(RefpropSI, self).DHFLSH(D,h)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def DSFLSH(self, D,s):
        '''flash calculation given density and entropy'''
        D = self.D_SI2RP(D)
        s = self.S_SI2RP(s)
        t,p,Dl,Dv,q,e,h,cv,cp,w = super(RefpropSI, self).DSFLSH(D,s)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def DEFLSH(self, D,e):
        '''flash calculation given density and energy'''
        D = self.D_SI2RP(D)
        e = self.E_SI2RP(e)
        t,p,Dl,Dv,q,h,s,cv,cp,w = super(RefpropSI, self).DEFLSH(D,e)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def HSFLSH(self, h,s):
        '''flash calculation given enthalpy and entropy'''
        h = self.H_SI2RP(h)
        s = self.S_SI2RP(s)
        t,p,D,Dl,Dv,q,e,cv,cp,w = super(RefpropSI, self).HSFLSH(h,s)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def ESFLSH(self, e,s):
        '''flash calculation given energy and entropy'''
        e = self.E_SI2RP(e)
        s = self.S_SI2RP(s)
        t,p,D,Dl,Dv,q,h,cv,cp,w = super(RefpropSI, self).ESFLSH(e,s)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),q,self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def TQFLSH(self, t,q):
        '''flash calculation given temperature and quality
         kq--flag specifying units for input quality
         kq = 1 quality on MOLAR basis [moles vapor/total moles]
         kq = 2 quality on MASS basis [mass vapor/total mass]
        '''
        t = self.T_SI2RP(t)
        q = self.Q_MA2MO(q)
        kq,p,D,Dl,Dv,e,h,s,cv,cp,w = super(RefpropSI, self).TQFLSH(t,q,kq=1)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def PQFLSH(self, p,q):
        '''flash calculation given pressure and quality
         kq--flag specifying units for input quality
         kq = 1 quality on MOLAR basis [moles vapor/total moles]
         kq = 2 quality on MASS basis [mass vapor/total mass]
        '''
        p = self.P_SI2RP(p)
        q = self.Q_MA2MO(q)
        kq,t,D,Dl,Dv,e,h,s,cv,cp,w = super(RefpropSI, self).PQFLSH(p,q,kq=1)
        return self.T_RP2SI(t),self.P_RP2SI(p),self.D_RP2SI(D),self.D_RP2SI(Dl),self.D_RP2SI(Dv),self.Q_MO2MA(q),self.E_RP2SI(e),self.H_RP2SI(h),self.S_RP2SI(s),self.CV_RP2SI(cv),self.CP_RP2SI(cp),self.W_RP2SI(w)
    
    def WMOL(self, ):
        'molecular weight of mixture'
        return self.WM_RP2SI(super(RefpropSI, self).WMOL())
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
    #    print 'self.wm=%0.3f g/mol'%(self.wm.value)
    #
    #    tf,dl,dv=SATP(0,3) # get freezing point
    #    tc,pc,Dc=CRITP() # get critical point
    #    print 'tc=%0.2f\xb0C pc=%0.0fkPa Dc=%0.1fkg/m3'%(tc-self.self.k0,pc,Dc*self.wm.value)
    #
    #    tl=0.0+self.self.k0
    #    p,dl,dv=SATT(tl,1)
    #    hl=ENTHAL(tl,dl)
    #    sl=ENTRO(tl,dl)
    #    print 'tl=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg sl=%0.3fkJ/kg-K'%(tl-self.self.k0,dl*self.wm.value,hl/self.wm.value,sl/self.wm.value)
    #
    #    p=1100.0
    #    tv,dl,dv=SATP(p,2)
    #    hv=ENTHAL(tv,dv)
    #    tl,dl,dv=SATP(p,1)
    #    hl=ENTHAL(tl,dl)
    #    print 'tl=%0.2f\xb0C tv=%0.2f\xb0C Dl=%0.1fkg/m3 hl=%0.2fkJ/kg hv=%0.2fkJ/kg'%(tl-self.self.k0,tv-self.self.k0,dl*self.wm.value,hl/self.wm.value,hv/self.wm.value)

