#ifndef REFPROP_H
#define REFPROP_H
//
#include <string.h>
#ifdef _CRAY
#  include <fortran.h>
#  define RPVersion  RPVERSION
#  define SETPATHdll SETPATHDLL
#  define ABFL1dll ABFL1DLL
#  define ABFL2dll ABFL2DLL
#  define ACTVYdll ACTVYDLL
#  define AGdll AGDLL
#  define CCRITdll CCRITDLL
#  define CP0dll CP0DLL
#  define CRITPdll CRITPDLL
#  define CSATKdll CSATKDLL
#  define CV2PKdll CV2PKDLL
#  define CVCPKdll CVCPKDLL
#  define CVCPdll CVCPDLL
#  define DBDTdll DBDTDLL
#  define DBFL1dll DBFL1DLL
#  define DBFL2dll DBFL2DLL
#  define DDDPdll DDDPDLL
#  define DDDTdll DDDTDLL
#  define DEFLSHdll DEFLSHDLL
#  define DHD1dll DHD1DLL
#  define DHFL1dll DHFL1DLL
#  define DHFL2dll DHFL2DLL
#  define DHFLSHdll DHFLSHDLL
#  define DIELECdll DIELECDLL
#  define DOTFILLdll DOTFILLDLL
#  define DPDD2dll DPDD2DLL
#  define DPDDKdll DPDDKDLL
#  define DPDDdll DPDDDLL
#  define DPDTKdll DPDTKDLL
#  define DPDTdll DPDTDLL
#  define DPTSATKdll DPTSATKDLL
#  define DSFLSHdll DSFLSHDLL
#  define DSFL1dll DSFL1DLL
#  define DSFL2dll DSFL2DLL
#  define ENTHALdll ENTHALDLL
#  define ENTROdll ENTRODLL
#  define ESFLSHdll ESFLSHDLL
#  define FGCTYdll FGCTYDLL
#  define FPVdll FPVDLL
#  define GERG04dll GERG04DLL
#  define GETFIJdll GETFIJDLL
#  define GETKTVdll GETKTVDLL
#  define GIBBSdll GIBBSDLL
#  define HSFLSHdll HSFLSHDLL
#  define INFOdll INFODLL
#  define LIMITKdll LIMITKDLL
#  define LIMITSdll LIMITSDLL
#  define LIMITXdll LIMITXDLL
#  define MELTPdll MELTPDLL
#  define MELTTdll MELTTDLL
#  define MLTH2Odll MLTH2ODLL
#  define NAMEdll NAMEDLL
#  define PDFL1dll PDFL1DLL
#  define PDFLSHdll PDFLSHDLL
#  define PEFLSHdll PEFLSHDLL
#  define PHFL1dll PHFL1DLL
#  define PHFLSHdll PHFLSHDLL
#  define PQFLSHdll PQFLSHDLL
#  define PREOSdll PREOSDLL
#  define PRESSdll PRESSDLL
#  define PSFL1dll PSFL1DLL
#  define PSFLSHdll PSFLSHDLL
#  define PUREFLDdll PUREFLDDLL
#  define QMASSdll QMASSDLL
#  define QMOLEdll QMOLEDLL
#  define SATDdll SATDDLL
#  define SATEdll SATEDLL
#  define SATHdll SATHDLL
#  define SATPdll SATPDLL
#  define SATSdll SATSDLL
#  define SATTdll SATTDLL
#  define SETAGAdll SETAGADLL
#  define SETKTVdll SETKTVDLL
#  define SETMIXdll SETMIXDLL
#  define SETMODdll SETMODDLL
#  define SETREFdll SETREFDLL
#  define SETUPdll SETUPDLL
#  define SPECGRdll SPECGRDLL
#  define SUBLPdll SUBLPDLL
#  define SUBLTdll SUBLTDLL
#  define SURFTdll SURFTDLL
#  define SURTENdll SURTENDLL
#  define TDFLSHdll TDFLSHDLL
#  define TEFLSHdll TEFLSHDLL
#  define THERM0dll THERM0DLL
#  define THERM2dll THERM2DLL
#  define THERM3dll THERM3DLL
#  define THERMdll THERMDLL
#  define THFLSHdll THFLSHDLL
#  define TPFLSHdll TPFLSHDLL
#  define TPFL2dll TPFL2DLL
#  define TPRHOdll TPRHODLL
#  define TQFLSHdll TQFLSHDLL
#  define TRNPRPdll TRNPRPDLL
#  define TSFLSHdll TSFLSHDLL
#  define VIRBdll VIRBDLL
#  define VIRCdll VIRCDLL
#  define WMOLdll WMOLDLL
#  define XMASSdll XMASSDLL
#  define XMOLEdll XMOLEdll
#else
#  if !defined(_AIX) && !defined(__hpux)
#    define RPVersion  rpversion_
#    define SETPATHdll setpathdll_
#    define ABFL1dll abfl1dll_
#    define ABFL2dll abfl2dll_
#    define ACTVYdll actvydll_
#    define AGdll agdll_
#    define CCRITdll ccritdll_
#    define CP0dll cp0dll_
#    define CRITPdll critpdll_
#    define CSATKdll csatkdll_
#    define CV2PKdll cv2pkdll_
#    define CVCPKdll cvcpkdll_
#    define CVCPdll cvcpdll_
#    define DBDTdll dbdtdll_
#    define DBFL1dll dbfl1dll_
#    define DBFL2dll dbfl2dll_
#    define DDDPdll dddpdll_
#    define DDDTdll dddtdll_
#    define DEFLSHdll deflshdll_
#    define DHD1dll dhd1dll_
#    define DHFL1dll dhfl1dll_
#    define DHFL2dll dhfl2dll_
#    define DHFLSHdll dhflshdll_
#    define DIELECdll dielecdll_
#    define DOTFILLdll dotfilldll_
#    define DPDD2dll dpdd2dll_
#    define DPDDKdll dpddkdll_
#    define DPDDdll dpdddll_
#    define DPDTKdll dpdtkdll_
#    define DPDTdll dpdtdll_
#    define DPTSATKdll dptsatkdll_
#    define DSFLSHdll dsflshdll_
#    define DSFL1dll dsfl1dll_
#    define DSFL2dll dsfl2dll_
#    define ENTHALdll enthaldll_
#    define ENTROdll entrodll_
#    define ESFLSHdll esflshdll_
#    define FGCTYdll fgctydll_
#    define FPVdll fpvdll_
#    define GERG04dll gerg04dll_
#    define GETFIJdll getfijdll_
#    define GETKTVdll getktvdll_
#    define GIBBSdll gibbsdll_
#    define HSFLSHdll hsflshdll_
#    define INFOdll infodll_
#    define LIMITKdll limitkdll_
#    define LIMITSdll limitsdll_
#    define LIMITXdll limitxdll_
#    define MELTPdll meltpdll_
#    define MELTTdll melttdll_
#    define MLTH2Odll mlth2odll_
#    define NAMEdll namedll_
#    define PDFL1dll pdfl1dll_
#    define PDFLSHdll pdflshdll_
#    define PEFLSHdll peflshdll_
#    define PHFL1dll phfl1dll_
#    define PHFLSHdll phflshdll_
#    define PQFLSHdll pqflshdll_
#    define PREOSdll preosdll_
#    define PRESSdll pressdll_
#    define PSFL1dll psfl1dll_
#    define PSFLSHdll psflshdll_
#    define PUREFLDdll pureflddll_
#    define QMASSdll qmassdll_
#    define QMOLEdll qmoledll_
#    define SATDdll satddll_
#    define SATEdll satedll_
#    define SATHdll sathdll_
#    define SATPdll satpdll_
#    define SATSdll satsdll_
#    define SATTdll sattdll_
#    define SETAGAdll setagadll_
#    define SETKTVdll setktvdll_
#    define SETMIXdll setmixdll_
#    define SETMODdll setmoddll_
#    define SETREFdll setrefdll_
#    define SETUPdll setupdll_
#    define SPECGRdll specgrdll_
#    define SUBLPdll sublpdll_
#    define SUBLTdll subltdll_
#    define SURFTdll surftdll_
#    define SURTENdll surtendll_
#    define TDFLSHdll tdflshdll_
#    define TEFLSHdll teflshdll_
#    define THERM0dll therm0dll_
#    define THERM2dll therm2dll_
#    define THERM3dll therm3dll_
#    define THERMdll thermdll_
#    define THFLSHdll thflshdll_
#    define TPFLSHdll tpflshdll_
#    define TPFL2dll tpfl2dll_
#    define TPRHOdll tprhodll_
#    define TQFLSHdll tqflshdll_
#    define TRNPRPdll trnprpdll_
#    define TSFLSHdll tsflshdll_
#    define VIRBdll virbdll_
#    define VIRCdll vircdll_
#    define WMOLdll wmoldll_
#    define XMASSdll xmassdll_
#    define XMOLEdll xmoledll_
#  endif
#  define _fcd          char *
#  define _cptofcd(a,b) (a)
#  define _fcdlen(a)    strlen(a)
#endif


#ifdef __cplusplus
extern "C" {
#endif
	// extra function for setup
	void RPVersion ( char* );
	void SETPATHdll( const char* );
	//
	void ABFL1dll(double &,double &,double *,long &,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void ABFL2dll(double &,double &,double *,long &,long &,double &,double &,double &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double *,double *,double &,long &,char*,long );
	void ACTVYdll(double &,double &,double *,double &);
	void AGdll(double &,double &,double *,double &,double &);
	void CCRITdll(double &,double &,double &,double *,double &,double &,double &,double &,double &,long &,char*,long );
	void CP0dll(double &,double *,double &);
	void CRITPdll(double *,double &,double &,double &,long &,char*,long );
	void CSATKdll(long &,double &,long &,double &,double &,double &,long &,char*,long );
	void CV2PKdll(long &,double &,double &,double &,double &,long &,char*,long );
	void CVCPKdll(long &,double &,double &,double &,double &);
	void CVCPdll(double &,double &,double *,double &,double &);
	void DBDTdll(double &,double *,double &);
	void DBFL1dll(double &,double &,double *,double &,double &,double &,long &,char*,long );
	void DBFL2dll(double &,double &,double *,long &,double &,double &,double &,double &,double &,double *,double *,double &,long &,char*,long );
	void DDDPdll(double &,double &,double *,double &);
	void DDDTdll(double &,double &,double *,double &);
	void DEFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void DHD1dll(double &,double &,double *,double &,double &,double &,double &,double &,double &);
	void DHFL1dll(double &,double &,double *,double &,long &,char*,long );//added by henning francke
	void DHFL2dll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,long &,char*,long );//added by henning francke
	void DHFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void DIELECdll(double &,double &,double *,double &);
	void DOTFILLdll(long &,double *,double &,double &,long &,char*,long );
	void DPDD2dll(double &,double &,double *,double &);
	void DPDDKdll(long &,double &,double &,double &);
	void DPDDdll(double &,double &,double *,double &);
	void DPDTKdll(long &,double &,double &,double &);
	void DPDTdll(double &,double &,double *,double &);
	void DPTSATKdll(long &,double &,long &,double &,double &,double &,double &,long &,char*,long );
	void DSFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void DSFL1dll(double &,double &,double *,double &,long &,char*,long );//added by henning francke
	void DSFL2dll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,long &,char*,long );//added by henning francke
	void ENTHALdll(double &,double &,double *,double &);
	void ENTROdll(double &,double &,double *,double &);
	void ESFLSHdll(double &,double &,double *,double &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,long &,char*,long );
	void FGCTYdll(double &,double &,double *,double *);
	void FPVdll(double &,double &,double &,double *,double &);
	void GERG04dll(long &,long &,long &,char*,long );
	void GETFIJdll(char*,double *,char*,char*,long ,long ,long );
	void GETKTVdll(long &,long &,char*,double *,char*,char*,char*,char*,long ,long ,long ,long ,long );
	void GIBBSdll(double &,double &,double *,double &,double &);
	void HSFLSHdll(double &,double &,double *,double &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,long &,char*,long );
	void INFOdll(long &,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &);
	void LIMITKdll(char*,long &,double &,double &,double &,double &,double &,double &,double &,long &,char*,long ,long );
	void LIMITSdll(char*,double *,double &,double &,double &,double &,long );
	void LIMITXdll(char*,double &,double &,double &,double *,double &,double &,double &,double &,long &,char*,long ,long );
	void MELTPdll(double &,double *,double &,long &,char*,long );
	void MELTTdll(double &,double *,double &,long &,char*,long );
	void MLTH2Odll(double &,double &,double &);
	void NAMEdll(long &,char*,char*,char*,long ,long ,long );
	void PDFL1dll(double &,double &,double *,double &,long &,char*,long );
	void PDFLSHdll(double &,double &,double *,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void PEFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void PHFL1dll(double &,double &,double *,long &,double &,double &,long &,char*,long );
	void PHFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void PQFLSHdll(double &,double &,double *,long &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void PREOSdll(long &);
	void PRESSdll(double &,double &,double *,double &);
	void PSFL1dll(double &,double &,double *,long &,double &,double &,long &,char*,long );
	void PSFLSHdll(double &,double &,double *,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void PUREFLDdll(long &);
	void QMASSdll(double &,double *,double *,double &,double *,double *,double &,double &,long &,char*,long );
	void QMOLEdll(double &,double *,double *,double &,double *,double *,double &,double &,long &,char*,long );
	void SATDdll(double &,double *,long &,long &,double &,double &,double &,double &,double *,double *,long &,char*,long );
	void SATEdll(double &,double *,long &,long &,long &,double &,double &,double &,long &,double &,double &,double &,long &,char*,long );
	void SATHdll(double &,double *,long &,long &,long &,double &,double &,double &,long &,double &,double &,double &,long &,char*,long );
	void SATPdll(double &,double *,long &,double &,double &,double &,double *,double *,long &,char*,long );
	void SATSdll(double &,double *,long &,long &,long &,double &,double &,double &,long &,double &,double &,double &,long &,double &,double &,double &,long &,char*,long );
	void SATTdll(double &,double *,long &,double &,double &,double &,double *,double *,long &,char*,long );
	void SETAGAdll(long &,char*,long );
	void SETKTVdll(long &,long &,char*,double *,char*,long &,char*,long ,long ,long );
	void SETMIXdll(char*,char*,char*,long &,char*,double *,long &,char*,long ,long ,long ,long ,long );
	void SETMODdll(long &,char*,char*,char*,long &,char*,long ,long ,long ,long );
	void SETREFdll(char*,long &,double *,double &,double &,double &,double &,long &,char*,long ,long );
	//void SETUPdll(long &,char*,char*,char*,long &,char*,long ,long ,long ,long );
	void SETUPdll(long &,char*,char*,char*,long &,char*);
	void SPECGRdll(double &,double &,double &,double &);
	void SUBLPdll(double &,double *,double &,long &,char*,long );
	void SUBLTdll(double &,double *,double &,long &,char*,long );
	void SURFTdll(double &,double &,double *,double &,long &,char*,long );
	void SURTENdll(double &,double &,double &,double *,double *,double &,long &,char*,long );
	void TDFLSHdll(double &,double &,double *,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void TEFLSHdll(double &,double &,double *,long &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void THERM0dll(double &,double &,double *,double &,double &,double &,double &,double &,double &,double &,double &,double &);
	void THERM2dll(double &,double &,double *,double &,double &,double &,double &,double &,double &,double &,double *,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &);
	void THERM3dll(double &,double &,double *,double &,double &,double &,double &,double &,double &,double &,double &,double &,double &);
	void THERMdll(double &,double &,double *,double &,double &,double &,double &,double &,double &,double &,double &);
	void THFLSHdll(double &,double &,double *,long &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void TPFLSHdll(double &,double &,double *,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void TPFL2dll(double &,double &,double *,double &,double &,double *,double *,double &,long &,char*,long );//added by henning francke
	void TPRHOdll(double &,double &,double *,long &,long &,double &,long &,char*,long );
	void TQFLSHdll(double &,double &,double *,long &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void TRNPRPdll(double &,double &,double *,double &,double &,long &,char*,long );
	void TSFLSHdll(double &,double &,double *,long &,double &,double &,double &,double &,double *,double *,double &,double &,double &,double &,double &,double &,long &,char*,long );
	void VIRBdll(double &,double *,double &);
	void VIRCdll(double &,double *,double &);
	void WMOLdll(double *,double &);
	void XMASSdll(double *,double *,double &);
	void XMOLEdll(double *,double *,double &);
#ifdef __cplusplus
} // extern "C"
#endif
// REFPROP_H
#endif
// routines used in henning francke's wrapper
// setup, wmol, tpflsh, phflsh, PDFL1, PDFLSH, PSFLSH, PQFLSH, THFLSH,
// TDFLSH, TSFLSH, TQFLSH, DHFLSH, HSFLSH, DSFLSH, TRNPRP, SATT, SATP, SATD
// TPFL2, DHFL1, DHFL2, DSFL1, DSFL2
//
