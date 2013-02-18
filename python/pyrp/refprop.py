'''Based on Bruce Wernick's REFPROP8 library and http://code.google.com/p/pyref/. 

Created on 15 Feb 2013
author: Jorrit Wronski
'''

from ctypes import CDLL,create_string_buffer,c_long,c_double,byref

#rp=cdll.LoadLibrary("librefprop.so")
#libc = CDLL("librefprop.so")         
 
rp = None
try:
    #refprop = windll.refprop
    rp = CDLL("librefprop.so")
    assert rp != None
#except WindowsError:
except IOError:
    #print "ERROR: DLL not found. Make sure Refprop DLL is in your path."
    print "ERROR: Library not found. Make sure Refprop is in your path."
    exit()

    
# -- FUNCTION ALIASES --

RPVersion  = rp.rpversion_
SETPATHdll = rp.setpathdll_
ABFL1dll   = rp.abfl1dll_
ABFL2dll   = rp.abfl2dll_
ACTVYdll   = rp.actvydll_
AGdll      = rp.agdll_
CCRITdll   = rp.ccritdll_
CP0dll     = rp.cp0dll_
CRITPdll   = rp.critpdll_
CSATKdll   = rp.csatkdll_
CV2PKdll   = rp.cv2pkdll_
CVCPKdll   = rp.cvcpkdll_
CVCPdll    = rp.cvcpdll_
DBDTdll    = rp.dbdtdll_
DBFL1dll   = rp.dbfl1dll_
DBFL2dll   = rp.dbfl2dll_
DDDPdll    = rp.dddpdll_
DDDTdll    = rp.dddtdll_
DEFLSHdll  = rp.deflshdll_
DHD1dll    = rp.dhd1dll_
DHFL1dll   = rp.dhfl1dll_
DHFL2dll   = rp.dhfl2dll_
DHFLSHdll  = rp.dhflshdll_
DIELECdll  = rp.dielecdll_
DOTFILLdll = rp.dotfilldll_
DPDD2dll   = rp.dpdd2dll_
DPDDKdll   = rp.dpddkdll_
DPDDdll    = rp.dpdddll_
DPDTKdll   = rp.dpdtkdll_
DPDTdll    = rp.dpdtdll_
DPTSATKdll = rp.dptsatkdll_
DSFLSHdll  = rp.dsflshdll_
DSFL1dll   = rp.dsfl1dll_
DSFL2dll   = rp.dsfl2dll_
ENTHALdll  = rp.enthaldll_
ENTROdll   = rp.entrodll_
ESFLSHdll  = rp.esflshdll_
FGCTYdll   = rp.fgctydll_
FPVdll     = rp.fpvdll_
GERG04dll  = rp.gerg04dll_
GETFIJdll  = rp.getfijdll_
GETKTVdll  = rp.getktvdll_
GIBBSdll   = rp.gibbsdll_
HSFLSHdll  = rp.hsflshdll_
INFOdll    = rp.infodll_
LIMITKdll  = rp.limitkdll_
LIMITSdll  = rp.limitsdll_
LIMITXdll  = rp.limitxdll_
MELTPdll   = rp.meltpdll_
MELTTdll   = rp.melttdll_
MLTH2Odll  = rp.mlth2odll_
NAMEdll    = rp.namedll_
PDFL1dll   = rp.pdfl1dll_
PDFLSHdll  = rp.pdflshdll_
PEFLSHdll  = rp.peflshdll_
PHFL1dll   = rp.phfl1dll_
PHFLSHdll  = rp.phflshdll_
PQFLSHdll  = rp.pqflshdll_
PREOSdll   = rp.preosdll_
PRESSdll   = rp.pressdll_
PSFL1dll   = rp.psfl1dll_
PSFLSHdll  = rp.psflshdll_
PUREFLDdll = rp.pureflddll_
QMASSdll   = rp.qmassdll_
QMOLEdll   = rp.qmoledll_
SATDdll    = rp.satddll_
SATEdll    = rp.satedll_
SATHdll    = rp.sathdll_
SATPdll    = rp.satpdll_
SATSdll    = rp.satsdll_
SATTdll    = rp.sattdll_
SETAGAdll  = rp.setagadll_
SETKTVdll  = rp.setktvdll_
SETMIXdll  = rp.setmixdll_
SETMODdll  = rp.setmoddll_
SETREFdll  = rp.setrefdll_
SETUPdll   = rp.setupdll_
#SPECGRdll = rp.specgrdll_ = rp.// = rp.not = rp.found = rp.in = rp.library
SUBLPdll   = rp.sublpdll_
SUBLTdll   = rp.subltdll_
SURFTdll   = rp.surftdll_
SURTENdll  = rp.surtendll_
TDFLSHdll  = rp.tdflshdll_
TEFLSHdll  = rp.teflshdll_
THERM0dll  = rp.therm0dll_
THERM2dll  = rp.therm2dll_
THERM3dll  = rp.therm3dll_
THERMdll   = rp.thermdll_
THFLSHdll  = rp.thflshdll_
TPFLSHdll  = rp.tpflshdll_
TPFL2dll   = rp.tpfl2dll_
TPRHOdll   = rp.tprhodll_
TQFLSHdll  = rp.tqflshdll_
TRNPRPdll  = rp.trnprpdll_
TSFLSHdll  = rp.tsflshdll_
VIRBdll    = rp.virbdll_
VIRCdll    = rp.vircdll_
WMOLdll    = rp.wmoldll_
XMASSdll   = rp.xmassdll_
XMOLEdll   = rp.xmoledll_
    

# -- CONSTANTS AND SETTINGS --

k0=273.15

MaxComps=20
fpath='/opt/refprop/'
fldpath=fpath+'fluids/'
mixpath=fpath+'mixtures/'
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

# -- Convenience functions from [PyRef](http://code.google.com/p/pyref/) --

def wrapX(x):
    _x = dblarray()
    copy(x, _x)
    return _x

def copy(src, dst):
    #assert len(src) == len(dst), "Copying " + str(len(src)) + " into " + str(len(dst))
    for i in range(0, len(src)):
        dst[i] = src[i]

def to_list(a):
    return [x for x in a]

def dblarray():
    return (c_double * MaxComps)()


# -- New convenience functions --

def SETXMASS(xin=[1.0]):
    xkg = wrapX(xin)
    XMOLEdll(xkg,byref(x),byref(wm))
    return to_list(x),wm.value
    
def SETXMOLE(xin=[1.0]):
    x = wrapX(xin)
    XMASSdll(x,byref(xkg),byref(wm))
    return to_list(xkg),wm.value
  
def GETXMASS():
    return to_list(xkg)
    
def GETXMOLE():
    return to_list(x)

def SETUPFLEX(ncin=1,xkg=[1.0],FluidNames='R22.FLD', FluidRef='DEF'):
    '''define current fluid including mass fractions'''
    global ierr,herr
    global nc,hfld,hfm,hrf,wm
    nc.value=ncin
    hfld.value=FluidNames
    hrf.value=FluidRef
    SETUPdll(byref(nc),byref(hfld),byref(hfm),byref(hrf),byref(ierr),byref(herr),c_long(10000),c_long(255),c_long(3),c_long(255))
    if ierr.value==0:
        SETXMASS(xkg)
        ixflag=c_long(1)
        h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
        SETREFdll(byref(hrf),byref(ixflag),x,byref(h0),byref(s0),byref(t0),byref(p0),byref(ierr),byref(herr),c_long(3),c_long(255))
        if ierr.value==0:
            WMOLdll(x,byref(wm))
    return ierr.value

# -- BASIC INFORMATION --

def RPVERSION():
    '''print current version number'''
    v = create_string_buffer(255)
    RPVersion(byref(v))
    return v.value.strip()


# -- INITIALIZATION SUBROUTINES --

def SETPATH(value='/opt/refprop/'):
    '''set path to refprop root containing fluids and mixtures'''
    global fpath, fldpath, mixpath
    fpath=value
    fldpath=fpath+'fluids/'
    mixpath=fpath+'mixtures/'

def SETUP(FluidName='R22.FLD', FluidRef='DEF'):
    '''define models and initialize arrays'''
    global ierr,herr
    global nc,hfld,hfm,hrf,wm
    nc.value=1
    hfld.value=fldpath+FluidName
    hrf.value=FluidRef
    SETUPdll(byref(nc),byref(hfld),byref(hfm),byref(hrf),byref(ierr),byref(herr),c_long(10000),c_long(255),c_long(3),c_long(255))
    if ierr.value==0:
        ixflag=c_long(1)
        h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
        SETREFdll(byref(hrf),byref(ixflag),x,byref(h0),byref(s0),byref(t0),byref(p0),byref(ierr),byref(herr),c_long(3),c_long(255))
        if ierr.value==0:
            WMOLdll(x,byref(wm))
    return

def SETMIX(FluidName='R404A.MIX', FluidRef='DEF'):
    '''open a mixture file and read constituents and mole fractions'''
    global ierr,herr
    global x,nc,hfld,hfm,hrf,hfile
    hfld.value=mixpath+FluidName
    hrf.value=FluidRef
    SETMIXdll(byref(hfld),byref(hfm),byref(hrf),byref(nc),byref(hfile),x,byref(ierr),byref(herr),c_long(255),c_long(255),c_long(3),c_long(10000),c_long(255))
    if ierr.value==0:
        ixflag=c_long(0)
        h0,s0,t0,p0=c_double(0),c_double(0),c_double(0),c_double(0)
        SETREFdll(byref(hrf),byref(ixflag),x,byref(h0),byref(s0),byref(t0),byref(p0),byref(ierr),byref(herr),c_long(3),c_long(255))
        if ierr.value==0:
            WMOLdll(x,byref(wm))
    return

def SETREF(FluidRef='DEF', ixflag=1, h0=0, s0=0, t0=0, p0=0):
    '''set reference state enthalpy and entropy'''
    global ierr,herr
    global hrf
    hrf.value=FluidRef
    ixflag=c_long(ixflag)
    h0,s0,t0,p0=c_double(h0),c_double(s0),c_double(t0),c_double(p0)
    SETREFdll(byref(hrf),byref(ixflag),x,byref(h0),byref(s0),byref(t0),byref(p0),byref(ierr),byref(herr),c_long(3),c_long(255))
    return

def SETMOD(ncomps=1, EqnModel='NBS', MixModel='NBS', CompModel='NBS'):
    '''set model(s) other than the NIST-recommended (NBS) ones'''
    global ierr,herr
    global nc,htype,hmix,hcomp
    nc.value=ncomps
    htype.value=EqnModel
    hmix.value=MixModel
    hcomp.value=CompModel
    SETMODdll(byref(nc),byref(htype),byref(hmix),byref(hcomp),byref(ierr),byref(herr),c_long(3),c_long(3),c_long(3),c_long(255))
    return

def PUREFLD(icomp=0):
    '''Change the standard mixture setup so that the properties of one fluid can
    be calculated as if SETUP had been called for a pure fluid'''
    icomp=c_long(icomp)
    PUREFLDdll(byref(icomp))
    return

def CRITP():
    '''critical parameters'''
    global ierr,herr
    tcrit=c_double()
    pcrit=c_double()
    Dcrit=c_double()
    CRITPdll(x,byref(tcrit),byref(pcrit),byref(Dcrit),byref(ierr),byref(herr),c_long(255))
    return tcrit.value,pcrit.value,Dcrit.value

def THERM(t,D):
    '''thermal quantities as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    p=c_double()
    e,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    hjt=c_double()
    THERMdll(byref(t),byref(D),x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(hjt))
    return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,hjt.value

def THERM0(t,D):
    '''ideal gas thermal quantities as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    p=c_double()
    e,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    a,g=c_double(),c_double()
    THERM0dll(byref(t),byref(D),x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(a),byref(g))
    return p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,a.value,g.value

def THERM2(t,D):
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
    xkappa,beta=c_double(),c_double()
    dPdD,d2PdD2=c_double(),c_double()
    dPdT,dDdT,dDdP=c_double(),c_double(),c_double()
    THERM2dll(byref(t),byref(D),x,byref(p),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(Z),byref(hjt),byref(A),byref(G),byref(xkappa),byref(beta),byref(dPdD),byref(d2PdD2),byref(dPdT),byref(dDdT),byref(dDdP),byref(spare1),byref(spare2),byref(spare3),byref(spare4))
    return t.value,D.value,p.value,e.value,h.value,s.value,cv.value,cp.value,w.value,Z.value,hjt.value,A.value,G.value,xkappa.value,beta.value,dPdD.value,d2PdD2.value,dPdT.value,dDdT.value,dDdP.value

def THERM3(t,D):
    '''miscellaneous thermodynamic properties'''
    t=c_double(t)
    D=c_double(D)
    xkappa=c_double()
    beta=c_double()
    xisenk=c_double()
    xkt=c_double()
    betas=c_double()
    bs=c_double()
    xkkt=c_double()
    thrott=c_double()
    pint=c_double()
    spht=c_double()
    THERM3dll(byref(t),byref(D),x,byref(xkappa),byref(beta),byref(xisenk),byref(xkt),byref(betas),byref(bs),byref(xkkt),byref(thrott),byref(pint),byref(spht))
    return xkappa,beta,xisenk,xkt,betas,bs,xkkt,thrott,pint,spht

def ENTRO(t,D):
    '''entropy as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    s=c_double()
    ENTROdll(byref(t),byref(D),x,byref(s))
    return s.value

def ENTHAL(t,D):
    '''enthalpy as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    h=c_double()
    ENTHALdll(byref(t),byref(D),x,byref(h))
    return h.value

def CVCP(t,D):
    '''isochoric (constant volume) and isobaric (constant pressure) heat
    capacity as functions of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    cv,cp=c_double(),c_double()
    CVCPdll(byref(t),byref(D),x,byref(cv),byref(cp))
    return cv.value,cp.value

def CVCPK(icomp,t,D):
    '''isochoric (constant volume) and isobaric (constant pressure) heat
    capacity as functions of temperature and density for a given component'''
    icomp=c_long(icomp)
    t=c_double(t)
    D=c_double(D)
    cv,cp=c_double(),c_double()
    CVCPKdll(byref(icomp),byref(t),byref(D),byref(cv),byref(cp))
    return cv.value,cp.value

def GIBBS(t,D):
    '''residual Helmholtz and Gibbs free energy as a function of
    temperature and density'''
    t=c_double(t)
    D=c_double(D)
    Ar,Gr=c_double(),c_double()
    GIBBSdll(byref(t),byref(D),x,byref(Ar),byref(Gr))
    return Ar.value,Gr.value

def AG(t,D):
    '''Helmholtz and Gibbs energies as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    a,g=c_double(),c_double()
    AGdll(byref(t),byref(D),x,byref(a),byref(g))
    return a.value,g.value

def PRESS(t,D):
    '''pressure as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    p=c_double()
    PRESSdll(byref(t),byref(D),x,byref(p))
    return p.value

def DPDD(t,D):
    '''partial derivative of pressure w.r.t. density at constant temperature as a
    function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    dpdD=c_double()
    DPDDdll(byref(t),byref(D),x,byref(dpdD))
    return dpdD.value

def DPDDK(icomp,t,D):
    '''partial derivative of pressure w.r.t. density at constant temperature as a
    function of temperature and density for a specified component'''
    icomp=c_long(icomp)
    t=c_double(t)
    D=c_double(D)
    dpdD=c_double()
    DPDDKdll(byref(icomp),byref(t),byref(D),byref(dpdD))
    return dpdD.value

def DPDD2(t,D):
    '''second partial derivative of pressure w.r.t. density at const temperature
    as a function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    d2PdD2=c_double()
    DPDD2dll(byref(t),byref(D),x,byref(d2PdD2))
    return d2PdD2.value

def DPDT(t,D):
    '''partial derivative of pressure w.r.t. temperature at constant density as a
    function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    dpt=c_double()
    DPDTdll(byref(t),byref(D),x,byref(dpt))
    return dpt.value

def DPDTK(icomp,t,D):
    '''partial derivative of pressure w.r.t. temperature at constant density as a
    function of temperature and density for a specified component'''
    icomp=c_long(icomp)
    t=c_double(t)
    D=c_double(D)
    dpt=c_double()
    DPDTKdll(byref(icomp),byref(t),byref(D),byref(dpt))
    return dpt.value

def DDDP(t,D):
    '''partial derivative of density w.r.t. pressure at constant temperature as a
    function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    dDdp=c_double()
    DDDPdll(byref(t),byref(D),x,byref(dDdp))
    return dDdp.value

def DDDT(t,D):
    '''partial derivative of density w.r.t. temperature at constant pressure as a
    function of temperature and density'''
    t=c_double(t)
    D=c_double(D)
    dDdt=c_double()
    DDDTdll(byref(t),byref(D),x,byref(dDdt))
    return dDdt.value

def DHD1(t,D):
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
    DHD1dll(byref(t),byref(D),x,byref(dhdt_d),byref(dhdt_p),byref(dhdd_t),byref(dhdd_p),byref(dhdp_t),byref(dhdp_d))
    return dhdt_d.value,dhdt_p.value,dhdd_t.value,dhdd_p.value,dhdp_t.value,dhdp_d.value

def FGCTY(t,D):
    '''fugacity for each of the nc components of a mixture by numerical
    differentiation (using central differences) of the dimensionless residual
    Helmholtz energy'''
    t=c_double(t)
    D=c_double(D)
    f=(c_double*MaxComps)()
    FGCTYdll(byref(t),byref(D),x,f)
    return f

def VIRB(t):
    '''second virial coefficient as a function of temperature'''
    t=c_double(t)
    b=c_double()
    VIRBdll(byref(t),x,byref(b))
    return b.value

def DBDT(t):
    '''2nd derivative of B (B is the second virial coefficient) with respect to T
    as a function of temperature'''
    t=c_double(t)
    b=c_double()
    DBDTdll(byref(t),x,byref(b))
    return b.value

def VIRC(t):
    '''third virial coefficient as a function of temperature'''
    t=c_double(t)
    c=c_double()
    VIRCdll(byref(t),x,byref(c))
    return c.value

def SATT(t,kph=2):
    '''iterate for saturated liquid and vapor states given temperature
     kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
    global ierr,herr
    global xl,xv
    t=c_double(t)
    kph=c_long(kph)
    p=c_double()
    Dl,Dv=c_double(),c_double()
    SATTdll(byref(t),x,byref(kph),byref(p),byref(Dl),byref(Dv),xl,xv,byref(ierr),byref(herr),c_long(255))
    return p.value,Dl.value,Dv.value

def SATP(p,kph=2):
    '''saturation temperature from pressure
     kph--phase flag: 1=bubblepoint, 2=dewpoint, 3=freezingpoint, 4=sublimationpoint'''
    global ierr,herr
    global xl,xv
    p=c_double(p)
    kph=c_long(kph)
    t=c_double()
    Dl,Dv=c_double(),c_double()
    SATPdll(byref(p),x,byref(kph),byref(t),byref(Dl),byref(Dv),xl,xv,byref(ierr),byref(herr),c_long(255))
    return t.value,Dl.value,Dv.value

def SATD(D,kph=1):
    '''iterate for temperature and pressure given a density along the saturation boundary.
    kph--flag specifying desired root for multi-valued inputs
    (has meaning only for water at temperatures close to its triple point)
        -1=middle root (between 0 and 4C), 1=return highest temperature root (above 4C), 3=lowest temperature root (along freezing line)'''
    global ierr,herr
    global xl,xv
    D=c_double(D)
    kph=c_long(kph)
    kr=c_long()
    p=c_double()
    t=c_double()
    Dl,Dv=c_double(),c_double()
    SATDdll(byref(D),x,byref(kph),byref(kr),byref(t),byref(p),byref(Dl),byref(Dv),xl,xv,byref(ierr),byref(herr),c_long(255))
    return kr.value,t.value,Dl.value,Dv.value

def SATH(h,kph=2):
    '''iterate for temperature, pressure, and density given enthalpy along the saturation boundary
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
    global ierr,herr
    h=c_double(h)
    kph=c_long(kph)
    nroot=c_long()
    k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
    k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
    SATHdll(byref(h),x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(ierr),byref(herr),c_long(255))
    return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value

def SATE(e,kph=2):
    '''iterate for temperature, pressure, and density given energy along the saturation boundary
         kph--flag specifying desired root
             0 = all roots along the liquid-vapor line
             1 = only liquid VLE root
             2 = only vapor VLE roots
             3 = liquid SLE root (melting line)
             4 = vapor SVE root (sublimation line)'''
    global ierr,herr
    e=c_double(e)
    kph=c_long(kph)
    nroot=c_long()
    k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
    k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
    SATEdll(byref(e),x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(ierr),byref(herr),c_long(255))
    return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value

def SATS(s,kph=2):
    '''iterate for temperature, pressure, and density given an entropy along the saturation boundary
     kph--flag specifying desired root
         0 = all roots along the liquid-vapor line
         1 = only liquid VLE root
         2 = only vapor VLE roots
         3 = liquid SLE root (melting line)
         4 = vapor SVE root (sublimation line)'''
    global ierr,herr
    s=c_double(s)
    kph=c_long(kph)
    nroot=c_long()
    k1,t1,p1,d1=c_double(),c_double(),c_double(),c_double()
    k2,t2,p2,d2=c_double(),c_double(),c_double(),c_double()
    k3,t3,p3,d3=c_double(),c_double(),c_double(),c_double()
    SATSdll(byref(s),x,byref(kph),byref(nroot),byref(k1),byref(t1),byref(p1),byref(d1),byref(k2),byref(t2),byref(p2),byref(d2),byref(k3),byref(t3),byref(p3),byref(d3),byref(ierr),byref(herr),c_long(255))
    return nroot.value,k1.value,t1.value,p1.value,d1.value,k2.value,t2.value,p2.value,d2.value,k3.value,t3.value,p3.value,d3.value

def CSATK(icomp,t,kph=2):
    '''heat capacity along the saturation line as a function of temperature for a given component
     kph--flag specifying desired root
         0 = all roots along the liquid-vapor line
         1 = only liquid VLE root
         2 = only vapor VLE roots
         3 = liquid SLE root (melting line)
         4 = vapor SVE root (sublimation line)'''
    global ierr,herr
    icomp=c_long(icomp)
    t=c_double(t)
    kph=c_long(kph)
    p=c_double()
    D=c_double()
    csat=c_double()
    CSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(ierr),byref(herr),c_long(255))
    return p.value,D.value,csat.value

def DPTSATK(icomp,t,kph=2):
    '''heat capacity and dP/dT along the saturation line as a function of temperature for a given component
     kph--flag specifying desired root
         0 = all roots along the liquid-vapor line
         1 = only liquid VLE root
         2 = only vapor VLE roots
         3 = liquid SLE root (melting line)
         4 = vapor SVE root (sublimation line)'''
    global ierr,herr
    icomp=c_long(icomp)
    t=c_double(t)
    kph=c_long(kph)
    p=c_double()
    D=c_double()
    csat=c_double()
    dpt=c_double()
    DPTSATKdll(byref(icomp),byref(t),byref(kph),byref(p),byref(D),byref(csat),byref(dpt),byref(ierr),byref(herr),c_long(255))
    return p.value,D.value,csat.value,dpt.value

def CV2PK(icomp,t,D):
    '''isochoric heat capacity in the two phase (liquid+vapor) region'''
    global ierr,herr
    icomp=c_long(icomp)
    t=c_double(t)
    D=c_double(D)
    cv2p,csat=c_double(),c_double()
    CV2PKdll(byref(icomp),byref(t),byref(D),byref(cv2p),byref(csat),byref(ierr),byref(herr),c_long(255))
    return cv2p.value,csat.value

def TPRHO(t,p,kph=2,kguess=0,D=0):
    '''iterate for density as a function of temperature, pressure, and composition for a specified phase
     kph--phase flag: 1=liquid 2=vapor
     NB: 0 = stable phase--NOT ALLOWED (use TPFLSH) (unless an initial guess is supplied for D)
        -1 = force the search in the liquid phase
        -2 = force the search in the vapor phase
     kguess--input flag:
         1 = first guess for D provided
         0 = no first guess provided
     D--first guess for molar density [mol/L], only if kguess=1'''
    global ierr,herr
    t=c_double(t)
    p=c_double(p)
    kph=c_long(kph)
    kguess=c_long(kguess)
    D=c_double(D)
    TPRHOdll(byref(t),byref(p),x,byref(kph),byref(kguess),byref(D),byref(ierr),byref(herr),c_long(255))
    return D.value

# -- GENERAL FLASH SUBROUTINES --

def TPFLSH(t,p):
    '''flash calculation given temperature and pressure'''
    global ierr,herr
    global xl,xv
    t=c_double(t)
    p=c_double(p)
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e,h,s=c_double(),c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    TPFLSHdll(byref(t),byref(p),x,byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return D.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value

def TDFLSH(t,D):
    '''flash calculation given temperature and density'''
    global ierr,herr
    global xl,xv
    t=c_double(t)
    D=c_double(D)
    p=c_double()
    Dl,Dv=c_double(),c_double()
    q,e,h,s=c_double(),c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    TDFLSHdll(byref(t),byref(D),x,byref(p),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return p.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value

def PDFLSH(p,D):
    '''flash calculation given pressure and density'''
    global ierr,herr
    global xl,xv
    p=c_double(p)
    D=c_double(D)
    t=c_double()
    Dl,Dv=c_double(),c_double()
    q,e,h,s=c_double(),c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    PDFLSHdll(byref(p),byref(D),x,byref(t),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,Dl.value,Dv.value,q.value,e.value,h.value,s.value,cv.value,cp.value,w.value

def PHFLSH(p,h):
    '''flash calculation given pressure and enthalpy'''
    global ierr,herr
    global xl,xv
    p=c_double(p)
    h=c_double(h)
    t=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    PHFLSHdll(byref(p),byref(h),x,byref(t),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,D.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value

def PSFLSH(p,s):
    '''flash calculation given pressure and entropy'''
    global ierr,herr
    p=c_double(p)
    s=c_double(s)
    t=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e,h=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    PSFLSHdll(byref(p),byref(s),x,byref(t),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,D.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value

def PEFLSH(p,e):
    '''flash calculation given pressure and energy'''
    global ierr,herr
    p=c_double(p)
    e=c_double(e)
    t=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,s,h=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    PEFLSHdll(byref(p),byref(e),x,byref(t),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,D.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value

def THFLSH(t,h,kr=1):
    '''flash calculation given temperature and enthalpy'''
    global ierr,herr
    kr=c_long(kr)
    t=c_double(t)
    h=c_double(h)
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    THFLSHdll(byref(t),byref(h),x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return p.value,D.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value

def TSFLSH(t,s,kr=1):
    '''flash calculation given temperature and entropy
     kr--phase flag:
        1=liquid,
        2=vapor in equilibrium with liq,
        3=liquid in equilibrium with solid,
        4=vapor in equilibrium with solid'''
    global ierr,herr
    global xl,xv
    t=c_double(t)
    s=c_double(s)
    kr=c_long(kr)
    p=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e,h=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    TSFLSHdll(byref(t),byref(s),x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return p.value,D.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value

def TEFLSH(t,e,kr=1):
    '''flash calculation given temperature and energy'''
    global ierr,herr
    t=c_double(t)
    e=c_double(e)
    kr=c_long(kr)
    p=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    TEFLSHdll(byref(t),byref(e),x,byref(kr),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return kr.value,p.value,D.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value

def DHFLSH(D,h):
    '''flash calculation given density and enthalpy'''
    global ierr,herr
    D=c_double(D)
    h=c_double(h)
    t,p=c_double(),c_double()
    Dl,Dv=c_double(),c_double()
    q,e,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    DHFLSHdll(byref(D),byref(h),x,byref(t),byref(p),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,p.value,Dl.value,Dv.value,q.value,e.value,s.value,cv.value,cp.value,w.value

def DSFLSH(D,s):
    '''flash calculation given density and entropy'''
    global ierr,herr
    D=c_double(D)
    s=c_double(s)
    t,p=c_double(),c_double()
    Dl,Dv=c_double(),c_double(),c_double()
    q,e,h=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    DSFLSHdll(byref(D),byref(s),x,byref(t),byref(p),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(h),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,p.value,Dl.value,Dv.value,q.value,e.value,h.value,cv.value,cp.value,w.value

def DEFLSH(D,e):
    '''flash calculation given density and energy'''
    global ierr,herr
    D=c_double(D)
    e=c_double(e)
    t,p=c_double(),c_double()
    Dl,Dv=c_double(),c_double()
    q,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    DEFLSHdll(byref(D),byref(e),x,byref(t),byref(p),byref(Dl),byref(Dv),xl,xv,byref(q),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,p.value,Dl.value,Dv.value,q.value,h.value,s.value,cv.value,cp.value,w.value

def HSFLSH(h,s):
    '''flash calculation given enthalpy and entropy'''
    global ierr,herr
    h=c_double(h)
    s=c_double(s)
    t,p=c_double(),c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,e=c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    HSFLSHdll(byref(h),byref(s),x,byref(t),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(e),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,p.value,D.value,Dl.value,Dv.value,q.value,e.value,cv.value,cp.value,w.value

def ESFLSH(e,s):
    '''flash calculation given energy and entropy'''
    global ierr,herr
    e=c_double(e)
    s=c_double(s)
    t,p=c_double(),c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    q,h=c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    ESFLSHdll(byref(e),byref(s),x,byref(t),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(q),byref(h),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return t.value,p.value,D.value,Dl.value,Dv.value,q.value,h.value,cv.value,cp.value,w.value

def TQFLSH(t,q):
    '''flash calculation given temperature and quality'''
    global ierr,herr
    t=c_double(t)
    q=c_double(q)
    kq=c_long()
    p=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    e,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    TQFLSHdll(byref(t),byref(q),x,byref(kq),byref(p),byref(D),byref(Dl),byref(Dv),xl,xv,byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return kq.value,p.value,D.value,Dl.value,Dv.value,e.value,h.value,s.value,cv.value,cp.value,w.value

def PQFLSH(p,q,kq):
    '''flash calculation given pressure and quality'''
    global ierr,herr
    p=c_double(p)
    q=c_double(q)
    kq=c_long(kq)
    t=c_double()
    D,Dl,Dv=c_double(),c_double(),c_double()
    e,h,s=c_double(),c_double(),c_double()
    cv,cp=c_double(),c_double()
    w=c_double()
    PQFLSHdll(byref(p),byref(q),x,byref(kq),byref(t),byref(D),byref(Dl),byref(Dv),xl,xv,byref(e),byref(h),byref(s),byref(cv),byref(cp),byref(w),byref(ierr),byref(herr),c_long(255))
    return kq.value,t.value,D.value,Dl.value,Dv.value,e.value,h.value,s.value,cv.value,cp.value,w.value

def CCRIT(t,p,v):
    '''critical flow factor, C*, for nozzle flow of a gas'''
    global ierr,herr
    t=c_double(t)
    p=c_double(p)
    v=c_double(v)
    cs,ts,Ds,ps,ws=c_double(),c_double(),c_double(),c_double(),c_double()
    CCRITdll(byref(t),byref(p),byref(v),x,byref(cs),byref(ts),byref(Ds),byref(ps),byref(ws),byref(ierr),byref(herr),c_long(255))
    return cs.value,ts.value,Ds.value,ps.value,ws.value

def FPV(t,D,p):
    '''supercompressibility factor, Fpv'''
    t=c_double(t)
    D=c_double(D)
    p=c_double(p)
    f=c_double()
    FPVdll(byref(t),byref(D),byref(p),x,byref(f))
    return f.value

def CP0(t):
    '''mixture Cp0 calculated by appropriate core CP0xxx routine(s)'''
    t=c_double(t)
    cp=c_double()
    CP0dll(byref(t),x,byref(cp))
    return cp.value

def TRNPRP(t,D):
    '''transport properties of thermal conductivity and
     viscosity as functions of temperature and density
     eta--viscosity (uPa.s)
     tcx--thermal conductivity (W/m.K)'''
    global ierr,herr
    t=c_double(t)
    D=c_double(D)
    eta,tcx=c_double(),c_double()
    TRNPRPdll(byref(t),byref(D),x,byref(eta),byref(tcx),byref(ierr),byref(herr),c_long(255))
    return eta.value,tcx.value

def INFO(icomp=1):
    'provides fluid constants for specified component'
    icomp=c_long(icomp)
    wmm=c_double()
    ttrp,tnbpt,tc=c_double(),c_double(),c_double()
    pc=c_double()
    Dc=c_double()
    Zc,acf,dip=c_double(),c_double(),c_double()
    Rgas=c_double()
    INFOdll(byref(icomp),byref(wmm),byref(ttrp),byref(tnbpt),byref(tc),byref(pc),byref(Dc),byref(Zc),byref(acf),byref(dip),byref(Rgas))
    return wmm.value,ttvalue,tnbpt.value,tc.value,pc.value,Dc.value,Zc.value,acf.value,dip.value,Rgas.value

def GETHEADER(fluid):
    '''read and interpret text at head of FLD file'''
    def gets():
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
    f=open(fldpath+fluid+'.fld', 'r')
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

def GETMIXHEADER(mix):
    H={}
    f=open(mixpath+mix, 'r')
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
    nc=int(f.readline().strip())
    H['comps']=nc
    # read component names
    chemform=[]
    for i in range(nc):
        lhs,rhs=f.readline().strip().split('.')
        chemform.append(lhs)
    H['chemform']=chemform
    # read proportions
    for i in range(nc):
        s=f.readline().strip()
    f.close()
    return H

def NAME(icomp):
    global hname, hn80, hcas
    icomp=c_long(icomp)
    NAMEdll(byref(icomp),byref(hname),byref(hn80),byref(hcas),c_long(12),c_long(80),c_long(12))
    lhs,rhs=hn80.value.split('!')
    lhs=lhs.strip()
    return hname.value.strip(),lhs,hcas.value.strip()

def XMASS(xmol):
    XMASSdll(xmol,xkg,byref(wmix))
    return wmix.value

def XMOLE(xkg):
    XMOLEdll(xkg,xmol,byref(wmix))
    return wmix.value

def LIMITX(htyp='EOS',t=0,D=0,p=0):
    global ierr,herr
    htyp=create_string_buffer(htyp, 3)
    t=c_double(t)
    D=c_double(D)
    p=c_double(p)
    tmin,tmax,Dmax,pmax=c_double(),c_double(),c_double(),c_double()
    LIMITXdll(byref(htyp),byref(t),byref(D),byref(p),x,byref(tmin),byref(tmax),byref(Dmax),byref(pmax),byref(ierr),byref(herr),c_long(3),c_long(255))
    return tmin.value,tmax.value,Dmax.value,pmax.value

def LIMITK(htyp='EOS',icomp=1,t=0,D=0,p=0):
    global ierr,herr
    htyp=create_string_buffer(htyp, 3)
    icomp=c_long(icomp)
    t=c_double(t)
    D=c_double(D)
    p=c_double(p)
    tmin,tmax,Dmax,pmax=c_double(),c_double(),c_double(),c_double()
    LIMITKdll(byref(htyp),byref(icomp),byref(t),byref(D),byref(p),byref(tmin),byref(tmax),byref(Dmax),byref(pmax),byref(ierr),byref(herr),c_long(3),c_long(255))
    return tmin.value,tmax.value,Dmax.value,pmax.value

def LIMITS(htyp='EOS'):
    'limits of Model'
    htyp=create_string_buffer(htyp, 3)
    tmin, tmax, Dmax, pmax=c_double(),c_double(),c_double(),c_double()
    LIMITSdll(byref(htyp),x,byref(tmin),byref(tmax),byref(Dmax),byref(pmax),c_long(3))
    return tmin.value,tmax.value,Dmax.value,pmax.value

def QMASS(qmol):
    global ierr,herr
    global xlkg,xvkg
    qmol=c_double(qmol)
    qkg=c_double()
    wl,wv=c_double(),c_double()
    QMASSdll(byref(qmol),xl,xv,byref(qkg),xlkg,xvkg,byref(wl),byref(wv),byref(ierr),byref(herr),c_long(255))
    return qkg.value,wl.value,wv.value

def QMOLE(qkg):
    global ierr,herr
    global xlkg,xvkg
    qkg=c_double(qkg)
    qmol=c_double()
    wl,wv=c_double(),c_double()
    QMOLEdll(byref(qkg),xlkg,xvkg,byref(qmol),xl,xv,byref(wl),byref(wv),byref(ierr),byref(herr),c_long(255))
    return qmol.value,wl.value,wv.value

def WMOL():
    'molecular weight of mixture'
    global wm
    WMOLdll(x,byref(wm))
    return wm.value

def DIELEC(t,D):
    '''dielectric constant as a function of temperature, density'''
    t=c_double(t)
    D=c_double(D)
    DIELECdll(byref(t),byref(D),x,byref(de))
    return de.value

def SURFT(t,D):
    '''surface tension'''
    global ierr,herr
    t=c_double(t)
    D=c_double(D)
    sigma=c_double()
    SURFTdll(byref(t),byref(D),x,byref(sigma),byref(ierr),byref(herr),c_long(255))
    return sigma.value

def SURTEN(t):
    '''surface tension'''
    global ierr,herr
    t=c_double(t)
    sigma=c_double()
    Dl,Dv=c_double(),c_double()
    SURTENdll(byref(t),byref(Dl),byref(Dv),xl,xv,byref(sigma),byref(ierr),byref(herr),c_long(255))
    return sigma.value

# single phase flash routines

def PDFL1(p,D):
    '''from pressure and density'''
    global ierr,herr
    p=c_double(p)
    D=c_double(D)
    t=c_double()
    PDFL1dll(byref(p),byref(D),x,byref(t),byref(ierr),byref(herr),c_long(255))
    return t.value

def PHFL1(p,h,kph=2):
    '''from pressure and enthalpy'''
    global ierr,herr
    p=c_double(p)
    h=c_double(h)
    kph=c_long(kph)
    t,D=c_double(),c_double()
    PHFL1dll(byref(p),byref(h),x,byref(kph),byref(t),byref(D),byref(ierr),byref(herr),c_long(255))
    return t.value,D.value

def PSFL1(p,s,kph=2):
    '''from pressure and entropy'''
    global ierr,herr
    p=c_double(p)
    s=c_double(s)
    kph=c_long(kph)
    t,D=c_double(),c_double()
    PSFL1dll(byref(p),byref(s),x,byref(kph),byref(t),byref(D),byref(ierr),byref(herr),c_long(255))
    return t.value,D.value

def SETKTV(icomp,jcomp):
    '''set mixture model and/or parameters'''
    global ierr,herr
    global hmodij, hfmix
    icomp=c_long(icomp)
    jcomp=c_long(jcomp)
    fij=c_double()
    SETKTVdll(byref(icomp),byref(jcomp),byref(hmodij),byref(fij),byref(hfmix),byref(ierr),byref(herr),c_long(3),c_long(255),c_long(255))
    return fij.value

def GETKTV(icomp,jcomp):
    '''retrieve mixture model and parameter info for a specified binary'''
    global hmodij,hfmix,hfij2,hbinp,hmxrul
    icomp=c_long(icomp)
    jcomp=c_long(jcomp)
    fij=c_double()
    GETKTVdll(byref(icomp),byref(jcomp),byref(hmodij),byref(fij),byref(hfmix),byref(hfij2),byref(hbinp),byref(hmxrul),c_long(3),c_long(255),c_long(48),c_long(255),c_long(255))
    return fij.value

def GETFIJ(hmodij):
    '''retrieve parameter info for a specified mixing rule'''
    global hmxrul
    fij,hfij2=c_double(),c_double()
    GETFIJdll(byref(hmodij),byref(fij),byref(hfij2),byref(hmxrul),c_long(255))
    return fij.value,hfij2.value

def MELTT(t):
    '''melting line pressure as a function of temperature'''
    global ierr,herr
    t=c_double(t)
    p=c_double()
    MELTTdll(byref(t),x,byref(p),byref(ierr),byref(herr),c_long(255))
    return p.value

def MLTH2O(t):
    '''melting pressure of water'''
    t=c_double(t)
    p1,p2=c_double(),c_double()
    MLTH2Odll(byref(t),byref(p1),byref(p2))
    return p1.value,p2.value

def MELTP(p):
    '''melting line temperature as a function of pressure'''
    global ierr,herr
    p=c_double(p)
    t=c_double()
    MELTPdll(byref(p),x,byref(t),byref(ierr),byref(herr),c_long(255))
    return t.value

def SUBLT(t):
    '''sublimation line pressure as a function of temperature'''
    global ierr,herr
    t=c_double(t)
    p=c_double()
    SUBLTdll(byref(t),x,byref(p),byref(ierr),byref(herr),c_long(255))
    return p.value

def SUBLP(p):
    '''sublimation line temperature as a function of pressure'''
    global ierr,herr
    p=c_double(p)
    t=c_double()
    SUBLPdll(byref(p),x,byref(t),byref(ierr),byref(herr),c_long(255))
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

