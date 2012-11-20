#ifndef REFPROP_NAMES_H
#define REFPROP_NAMES_H
// The idea here is to have a common header for Windows 
// and Linux systems. The Windows branch should cover the
// functions provided by the .dll and the Linux part covers
// the compiled .so file. Name changes caused by gfortran 
// are repsected and should be accounted for. 
// 
// Do some manual changes to the function names
// if needed.
#if defined(WIN32) || defined(_WIN32)
// Define compiler specific calling conventions
// for the shared library.
#  define LIBRARY_API __stdcall // __declspec(dllexport)
// Do not define function names for the shared library,
// in this case it is the REFPROP.dll and no special
// names are needed.
#  define RPVersion  RPVersion
#  define SETPATHdll SETPATHdll
#  define ABFL1dll ABFL1dll
#  define ABFL2dll ABFL2dll
#  define ACTVYdll ACTVYdll
#  define AGdll AGdll
#  define CCRITdll CCRITdll
#  define CP0dll CP0dll
#  define CRITPdll CRITPdll
#  define CSATKdll CSATKdll
#  define CV2PKdll CV2PKdll
#  define CVCPKdll CVCPKdll
#  define CVCPdll CVCPdll
#  define DBDTdll DBDTdll
#  define DBFL1dll DBFL1dll
#  define DBFL2dll DBFL2dll
#  define DDDPdll DDDPdll
#  define DDDTdll DDDTdll
#  define DEFLSHdll DEFLSHdll
#  define DHD1dll DHD1dll
#  define DHFL1dll DHFL1dll
#  define DHFL2dll DHFL2dll
#  define DHFLSHdll DHFLSHdll
#  define DIELECdll DIELECdll
#  define DOTFILLdll DOTFILLdll
#  define DPDD2dll DPDD2dll
#  define DPDDKdll DPDDKdll
#  define DPDDdll DPDDdll
#  define DPDTKdll DPDTKdll
#  define DPDTdll DPDTdll
#  define DPTSATKdll DPTSATKdll
#  define DSFLSHdll DSFLSHdll
#  define DSFL1dll DSFL1dll
#  define DSFL2dll DSFL2dll
#  define ENTHALdll ENTHALdll
#  define ENTROdll ENTROdll
#  define ESFLSHdll ESFLSHdll
#  define FGCTYdll FGCTYdll
#  define FPVdll FPVdll
#  define GERG04dll GERG04dll
#  define GETFIJdll GETFIJdll
#  define GETKTVdll GETKTVdll
#  define GIBBSdll GIBBSdll
#  define HSFLSHdll HSFLSHdll
#  define INFOdll INFOdll
#  define LIMITKdll LIMITKdll
#  define LIMITSdll LIMITSdll
#  define LIMITXdll LIMITXdll
#  define MELTPdll MELTPdll
#  define MELTTdll MELTTdll
#  define MLTH2Odll MLTH2Odll
#  define NAMEdll NAMEdll
#  define PDFL1dll PDFL1dll
#  define PDFLSHdll PDFLSHdll
#  define PEFLSHdll PEFLSHdll
#  define PHFL1dll PHFL1dll
#  define PHFLSHdll PHFLSHdll
#  define PQFLSHdll PQFLSHdll
#  define PREOSdll PREOSdll
#  define PRESSdll PRESSdll
#  define PSFL1dll PSFL1dll
#  define PSFLSHdll PSFLSHdll
#  define PUREFLDdll PUREFLDdll
#  define QMASSdll QMASSdll
#  define QMOLEdll QMOLEdll
#  define SATDdll SATDdll
#  define SATEdll SATEdll
#  define SATHdll SATHdll
#  define SATPdll SATPdll
#  define SATSdll SATSdll
#  define SATTdll SATTdll
#  define SETAGAdll SETAGAdll
#  define SETKTVdll SETKTVdll
#  define SETMIXdll SETMIXdll
#  define SETMODdll SETMODdll
#  define SETREFdll SETREFdll
#  define SETUPdll SETUPdll
//#  define SPECGRdll SPECGRdll // not found in library
#  define SUBLPdll SUBLPdll
#  define SUBLTdll SUBLTdll
#  define SURFTdll SURFTdll
#  define SURTENdll SURTENdll
#  define TDFLSHdll TDFLSHdll
#  define TEFLSHdll TEFLSHdll
#  define THERM0dll THERM0dll
#  define THERM2dll THERM2dll
#  define THERM3dll THERM3dll
#  define THERMdll THERMdll
#  define THFLSHdll THFLSHdll
#  define TPFLSHdll TPFLSHdll
#  define TPFL2dll TPFL2dll
#  define TPRHOdll TPRHOdll
#  define TQFLSHdll TQFLSHdll
#  define TRNPRPdll TRNPRPdll
#  define TSFLSHdll TSFLSHdll
#  define VIRBdll VIRBdll
#  define VIRCdll VIRCdll
#  define WMOLdll WMOLdll
#  define XMASSdll XMASSdll
#  define XMOLEdll XMOLEdll
#else // defined(WIN32) || defined(_WIN32)
// Define compiler specific calling conventions
// for the shared library.
#  define LIBRARY_API
// Define function names for the shared library,
// in this case it is the librefprop.so and the
// names might change on some systems during
// the compilation of the Fortran files. 
// Possible other branches for this code could be:
// #    if !defined(_AIX) 
// #    if !defined(__hpux) 
// #    ifdef _CRAY
// However, I cannot test that and therefore do not include it.
#  define RPVersion  rpversion_
#  define SETPATHdll setpathdll_
#  define ABFL1dll abfl1dll_
#  define ABFL2dll abfl2dll_
#  define ACTVYdll actvydll_
#  define AGdll agdll_
#  define CCRITdll ccritdll_
#  define CP0dll cp0dll_
#  define CRITPdll critpdll_
#  define CSATKdll csatkdll_
#  define CV2PKdll cv2pkdll_
#  define CVCPKdll cvcpkdll_
#  define CVCPdll cvcpdll_
#  define DBDTdll dbdtdll_
#  define DBFL1dll dbfl1dll_
#  define DBFL2dll dbfl2dll_
#  define DDDPdll dddpdll_
#  define DDDTdll dddtdll_
#  define DEFLSHdll deflshdll_
#  define DHD1dll dhd1dll_
#  define DHFL1dll dhfl1dll_
#  define DHFL2dll dhfl2dll_
#  define DHFLSHdll dhflshdll_
#  define DIELECdll dielecdll_
#  define DOTFILLdll dotfilldll_
#  define DPDD2dll dpdd2dll_
#  define DPDDKdll dpddkdll_
#  define DPDDdll dpdddll_
#  define DPDTKdll dpdtkdll_
#  define DPDTdll dpdtdll_
#  define DPTSATKdll dptsatkdll_
#  define DSFLSHdll dsflshdll_
#  define DSFL1dll dsfl1dll_
#  define DSFL2dll dsfl2dll_
#  define ENTHALdll enthaldll_
#  define ENTROdll entrodll_
#  define ESFLSHdll esflshdll_
#  define FGCTYdll fgctydll_
#  define FPVdll fpvdll_
#  define GERG04dll gerg04dll_
#  define GETFIJdll getfijdll_
#  define GETKTVdll getktvdll_
#  define GIBBSdll gibbsdll_
#  define HSFLSHdll hsflshdll_
#  define INFOdll infodll_
#  define LIMITKdll limitkdll_
#  define LIMITSdll limitsdll_
#  define LIMITXdll limitxdll_
#  define MELTPdll meltpdll_
#  define MELTTdll melttdll_
#  define MLTH2Odll mlth2odll_
#  define NAMEdll namedll_
#  define PDFL1dll pdfl1dll_
#  define PDFLSHdll pdflshdll_
#  define PEFLSHdll peflshdll_
#  define PHFL1dll phfl1dll_
#  define PHFLSHdll phflshdll_
#  define PQFLSHdll pqflshdll_
#  define PREOSdll preosdll_
#  define PRESSdll pressdll_
#  define PSFL1dll psfl1dll_
#  define PSFLSHdll psflshdll_
#  define PUREFLDdll pureflddll_
#  define QMASSdll qmassdll_
#  define QMOLEdll qmoledll_
#  define SATDdll satddll_
#  define SATEdll satedll_
#  define SATHdll sathdll_
#  define SATPdll satpdll_
#  define SATSdll satsdll_
#  define SATTdll sattdll_
#  define SETAGAdll setagadll_
#  define SETKTVdll setktvdll_
#  define SETMIXdll setmixdll_
#  define SETMODdll setmoddll_
#  define SETREFdll setrefdll_
#  define SETUPdll setupdll_
//#  define SPECGRdll specgrdll_ // not found in library
#  define SUBLPdll sublpdll_
#  define SUBLTdll subltdll_
#  define SURFTdll surftdll_
#  define SURTENdll surtendll_
#  define TDFLSHdll tdflshdll_
#  define TEFLSHdll teflshdll_
#  define THERM0dll therm0dll_
#  define THERM2dll therm2dll_
#  define THERM3dll therm3dll_
#  define THERMdll thermdll_
#  define THFLSHdll thflshdll_
#  define TPFLSHdll tpflshdll_
#  define TPFL2dll tpfl2dll_
#  define TPRHOdll tprhodll_
#  define TQFLSHdll tqflshdll_
#  define TRNPRPdll trnprpdll_
#  define TSFLSHdll tsflshdll_
#  define VIRBdll virbdll_
#  define VIRCdll vircdll_
#  define WMOLdll wmoldll_
#  define XMASSdll xmassdll_
#  define XMOLEdll xmoledll_
#endif // defined(WIN32) || defined(_WIN32), else branch
//
//
// define new macros for function names
// http://stackoverflow.com/questions/195975/how-to-make-a-char-string-from-a-c-macros-value
#include <string.h>
#define STR_VALUE(arg)      #arg
#define FUNCTION_NAME(name) STR_VALUE(name)
//
// Prepare the strings to be used by the functions that
// handle the library later on. 
#define RPVersion_NAME FUNCTION_NAME(RPVersion)
#define SETPATHdll_NAME FUNCTION_NAME(SETPATHdll)
#define ABFL1dll_NAME FUNCTION_NAME(ABFL1dll)
#define ABFL2dll_NAME FUNCTION_NAME(ABFL2dll)
#define ACTVYdll_NAME FUNCTION_NAME(ACTVYdll)
#define AGdll_NAME FUNCTION_NAME(AGdll)
#define CCRITdll_NAME FUNCTION_NAME(CCRITdll)
#define CP0dll_NAME FUNCTION_NAME(CP0dll)
#define CRITPdll_NAME FUNCTION_NAME(CRITPdll)
#define CSATKdll_NAME FUNCTION_NAME(CSATKdll)
#define CV2PKdll_NAME FUNCTION_NAME(CV2PKdll)
#define CVCPKdll_NAME FUNCTION_NAME(CVCPKdll)
#define CVCPdll_NAME FUNCTION_NAME(CVCPdll)
#define DBDTdll_NAME FUNCTION_NAME(DBDTdll)
#define DBFL1dll_NAME FUNCTION_NAME(DBFL1dll)
#define DBFL2dll_NAME FUNCTION_NAME(DBFL2dll)
#define DDDPdll_NAME FUNCTION_NAME(DDDPdll)
#define DDDTdll_NAME FUNCTION_NAME(DDDTdll)
#define DEFLSHdll_NAME FUNCTION_NAME(DEFLSHdll)
#define DHD1dll_NAME FUNCTION_NAME(DHD1dll)
#define DHFL1dll_NAME FUNCTION_NAME(DHFL1dll)
#define DHFL2dll_NAME FUNCTION_NAME(DHFL2dll)
#define DHFLSHdll_NAME FUNCTION_NAME(DHFLSHdll)
#define DIELECdll_NAME FUNCTION_NAME(DIELECdll)
#define DOTFILLdll_NAME FUNCTION_NAME(DOTFILLdll)
#define DPDD2dll_NAME FUNCTION_NAME(DPDD2dll)
#define DPDDKdll_NAME FUNCTION_NAME(DPDDKdll)
#define DPDDdll_NAME FUNCTION_NAME(DPDDdll)
#define DPDTKdll_NAME FUNCTION_NAME(DPDTKdll)
#define DPDTdll_NAME FUNCTION_NAME(DPDTdll)
#define DPTSATKdll_NAME FUNCTION_NAME(DPTSATKdll)
#define DSFLSHdll_NAME FUNCTION_NAME(DSFLSHdll)
#define DSFL1dll_NAME FUNCTION_NAME(DSFL1dll)
#define DSFL2dll_NAME FUNCTION_NAME(DSFL2dll)
#define ENTHALdll_NAME FUNCTION_NAME(ENTHALdll)
#define ENTROdll_NAME FUNCTION_NAME(ENTROdll)
#define ESFLSHdll_NAME FUNCTION_NAME(ESFLSHdll)
#define FGCTYdll_NAME FUNCTION_NAME(FGCTYdll)
#define FPVdll_NAME FUNCTION_NAME(FPVdll)
#define GERG04dll_NAME FUNCTION_NAME(GERG04dll)
#define GETFIJdll_NAME FUNCTION_NAME(GETFIJdll)
#define GETKTVdll_NAME FUNCTION_NAME(GETKTVdll)
#define GIBBSdll_NAME FUNCTION_NAME(GIBBSdll)
#define HSFLSHdll_NAME FUNCTION_NAME(HSFLSHdll)
#define INFOdll_NAME FUNCTION_NAME(INFOdll)
#define LIMITKdll_NAME FUNCTION_NAME(LIMITKdll)
#define LIMITSdll_NAME FUNCTION_NAME(LIMITSdll)
#define LIMITXdll_NAME FUNCTION_NAME(LIMITXdll)
#define MELTPdll_NAME FUNCTION_NAME(MELTPdll)
#define MELTTdll_NAME FUNCTION_NAME(MELTTdll)
#define MLTH2Odll_NAME FUNCTION_NAME(MLTH2Odll)
#define NAMEdll_NAME FUNCTION_NAME(NAMEdll)
#define PDFL1dll_NAME FUNCTION_NAME(PDFL1dll)
#define PDFLSHdll_NAME FUNCTION_NAME(PDFLSHdll)
#define PEFLSHdll_NAME FUNCTION_NAME(PEFLSHdll)
#define PHFL1dll_NAME FUNCTION_NAME(PHFL1dll)
#define PHFLSHdll_NAME FUNCTION_NAME(PHFLSHdll)
#define PQFLSHdll_NAME FUNCTION_NAME(PQFLSHdll)
#define PREOSdll_NAME FUNCTION_NAME(PREOSdll)
#define PRESSdll_NAME FUNCTION_NAME(PRESSdll)
#define PSFL1dll_NAME FUNCTION_NAME(PSFL1dll)
#define PSFLSHdll_NAME FUNCTION_NAME(PSFLSHdll)
#define PUREFLDdll_NAME FUNCTION_NAME(PUREFLDdll)
#define QMASSdll_NAME FUNCTION_NAME(QMASSdll)
#define QMOLEdll_NAME FUNCTION_NAME(QMOLEdll)
#define SATDdll_NAME FUNCTION_NAME(SATDdll)
#define SATEdll_NAME FUNCTION_NAME(SATEdll)
#define SATHdll_NAME FUNCTION_NAME(SATHdll)
#define SATPdll_NAME FUNCTION_NAME(SATPdll)
#define SATSdll_NAME FUNCTION_NAME(SATSdll)
#define SATTdll_NAME FUNCTION_NAME(SATTdll)
#define SETAGAdll_NAME FUNCTION_NAME(SETAGAdll)
#define SETKTVdll_NAME FUNCTION_NAME(SETKTVdll)
#define SETMIXdll_NAME FUNCTION_NAME(SETMIXdll)
#define SETMODdll_NAME FUNCTION_NAME(SETMODdll)
#define SETREFdll_NAME FUNCTION_NAME(SETREFdll)
#define SETUPdll_NAME FUNCTION_NAME(SETUPdll)
//#define SPECGRdll_NAME FUNCTION_NAME(SPECGRdll) // not found in library
#define SUBLPdll_NAME FUNCTION_NAME(SUBLPdll)
#define SUBLTdll_NAME FUNCTION_NAME(SUBLTdll)
#define SURFTdll_NAME FUNCTION_NAME(SURFTdll)
#define SURTENdll_NAME FUNCTION_NAME(SURTENdll)
#define TDFLSHdll_NAME FUNCTION_NAME(TDFLSHdll)
#define TEFLSHdll_NAME FUNCTION_NAME(TEFLSHdll)
#define THERM0dll_NAME FUNCTION_NAME(THERM0dll)
#define THERM2dll_NAME FUNCTION_NAME(THERM2dll)
#define THERM3dll_NAME FUNCTION_NAME(THERM3dll)
#define THERMdll_NAME FUNCTION_NAME(THERMdll)
#define THFLSHdll_NAME FUNCTION_NAME(THFLSHdll)
#define TPFLSHdll_NAME FUNCTION_NAME(TPFLSHdll)
#define TPFL2dll_NAME FUNCTION_NAME(TPFL2dll)
#define TPRHOdll_NAME FUNCTION_NAME(TPRHOdll)
#define TQFLSHdll_NAME FUNCTION_NAME(TQFLSHdll)
#define TRNPRPdll_NAME FUNCTION_NAME(TRNPRPdll)
#define TSFLSHdll_NAME FUNCTION_NAME(TSFLSHdll)
#define VIRBdll_NAME FUNCTION_NAME(VIRBdll)
#define VIRCdll_NAME FUNCTION_NAME(VIRCdll)
#define WMOLdll_NAME FUNCTION_NAME(WMOLdll)
#define XMASSdll_NAME FUNCTION_NAME(XMASSdll)
#define XMOLEdll_NAME FUNCTION_NAME(XMOLEdll)
// 
// Define data types that match the Fortran definitions. This is also
// a possible starting point to introduce platform independence.
// Partly taken from: http://arnholm.org/software/cppf77/cppf77.htm#Section5
// An issue with characters still needs to be solved.
//#include <f77char.h>
// The other data types can be handled:
typedef long    INTEGER;
typedef float   REAL;
typedef double  DOUBLE_PRECISION;
typedef int     LOGICAL;
//
#endif // REFPROP_NAMES_H
