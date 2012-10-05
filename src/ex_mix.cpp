/*
 * ============================================================================
 * Name        : refprop-ftn.cpp
 * Author      : Jorrit Wronski (jowr@mek.dtu.dk)
 * Version     : 0.1
 * Copyright   : Use and modify at your own risk.
 * Description : example for Fortran and CPP interoperation. This file is
 *               based on EX_C1.CPP by Chris Muzny and EX_C2.c by Ian Bell.
 *               The example files can be obtained online from NIST
 *               http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.htm
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>    /* EXIT_SUCCESS */
#include <string.h>    /* strlen, memset, memcpy, memchr */
#include <refprop_lib.h>    /* refprop header file */

#ifndef EXIT_SUCCESS
#define EXIT_SUCCESS 0
#endif

#define refpropcharlength 255
#define filepathlength 255
#define maxstringlength 10000
#define lengthofreference 3
#define errormessagelength 255
#define ncmax 20		// Note: ncmax is the max number of components
#define numparams 72
#define maxcoefs 50


void newline() {
	printf("%s","\n");
}

#include "Poco/SharedLibrary.h"
#include "Poco/Path.h"
#include "Poco/File.h"
#include "Poco/Environment.h"
#include "Poco/String.h"



int main(int argc, char* argv[]) {

	static long i,ierr,info_index;
	static double wm,ttp,tnbp,tc,pc,dc,zc,acf,dip,rgas;
	static char hfld[maxstringlength+1],hrf[lengthofreference+1],herr[errormessagelength+1],hfm[refpropcharlength+1];
	static char v[refpropcharlength+1],hpth[filepathlength+1],errormsg[errormessagelength+1];

	static double x[ncmax],xliq[ncmax],xvap[ncmax],f[ncmax];

	double t=100.0;
	double p,dl,dv;

	char* REFPROP_PATH_CHAR = "/home/jowr/Documents/Fluids/refprop/v9.0";
	char* FLUIDS_CHAR = "fluids";
	char* LIBRARY_PATH_CHAR = ".";
	char* LIBRARY_CHAR;


	Poco::Path REFPROP_PATH(true),FLD_PATH(true),LIB_PATH(true); // all paths will be absolute

	REFPROP_PATH.parse(REFPROP_PATH_CHAR, Poco::Path::PATH_NATIVE);
	if (!REFPROP_PATH.isDirectory()) REFPROP_PATH.append(REFPROP_PATH.separator());
	Poco::File theFile(REFPROP_PATH);
	if ( !theFile.isDirectory() || !theFile.canRead() ){
		printf ("REFPROP_PATH is not a readable directory: %s \n", REFPROP_PATH.toString().c_str());
		return 1;
	}

	FLD_PATH.parse(REFPROP_PATH.toString());
	FLD_PATH.pushDirectory(FLUIDS_CHAR);

// 	LIB_PATH.parse(LIBRARY_PATH_CHAR);
	bool is_linux = ( 0 == Poco::icompare(Poco::Environment::osName(), "linux") );
	if (is_linux){
		LIBRARY_CHAR = "librefprop.so";
	} else {
		LIBRARY_CHAR = "refprop.dll";
	}
// 	LIB_PATH.setFileName(LIBRARY_CHAR);

	printf ("REFPROP_PATH as string: %s \n", REFPROP_PATH.toString().c_str());
	printf ("FLD_PATH as string: %s \n", FLD_PATH.toString().c_str());
	printf ("LIBRARY_CHAR as string: %s \n", LIBRARY_CHAR);
	printf ("Running on: %s \n", Poco::Environment::osName().c_str());

// 	theFile = Poco::File(LIB_PATH);
// 	if ( !theFile.isFile() || !theFile.canRead() ){
// 		printf ("LIB_PATH is not a readable file: %s \n", LIB_PATH.toString().c_str());
// 		return 1;
// 	}

	theFile = Poco::File(FLD_PATH);
	if ( !theFile.isDirectory() || !theFile.canRead() ){
		printf ("FLD_PATH is not a readable directory: %s \n", FLD_PATH.toString().c_str());
		return 1;
	}

//  First we load the library with the POCO foundation
//  classes and then define all the needed functions
//  by their names and a cast to the correct type.
	Poco::SharedLibrary library(LIBRARY_CHAR); // will also load the library

//  Define the functions either by their pointers or type.
	RPVersion_POINTER  RPVersion  = (RPVersion_POINTER) library.getSymbol(RPVersion_NAME);
//	RPVersion_TYPE  * RPVersion  = (RPVersion_TYPE * ) library.getSymbol(RPVersion_NAME);
	SETPATHdll_TYPE * SETPATHdll = (SETPATHdll_TYPE *) library.getSymbol(SETPATHdll_NAME);
	ABFL1dll_TYPE   * ABFL1dll   = (ABFL1dll_TYPE *  ) library.getSymbol(ABFL1dll_NAME);
	ABFL2dll_TYPE   * ABFL2dll   = (ABFL2dll_TYPE *  ) library.getSymbol(ABFL2dll_NAME);
	ACTVYdll_TYPE   * ACTVYdll   = (ACTVYdll_TYPE *  ) library.getSymbol(ACTVYdll_NAME);
	AGdll_TYPE      * AGdll      = (AGdll_TYPE *     ) library.getSymbol(AGdll_NAME);
	CCRITdll_TYPE   * CCRITdll   = (CCRITdll_TYPE *  ) library.getSymbol(CCRITdll_NAME);
	CP0dll_TYPE     * CP0dll     = (CP0dll_TYPE *    ) library.getSymbol(CP0dll_NAME);
	CRITPdll_TYPE   * CRITPdll   = (CRITPdll_TYPE *  ) library.getSymbol(CRITPdll_NAME);
	CSATKdll_TYPE   * CSATKdll   = (CSATKdll_TYPE *  ) library.getSymbol(CSATKdll_NAME);
	CV2PKdll_TYPE   * CV2PKdll   = (CV2PKdll_TYPE *  ) library.getSymbol(CV2PKdll_NAME);
	CVCPKdll_TYPE   * CVCPKdll   = (CVCPKdll_TYPE *  ) library.getSymbol(CVCPKdll_NAME);
	CVCPdll_TYPE    * CVCPdll    = (CVCPdll_TYPE *   ) library.getSymbol(CVCPdll_NAME);
	DBDTdll_TYPE    * DBDTdll    = (DBDTdll_TYPE *   ) library.getSymbol(DBDTdll_NAME);
	DBFL1dll_TYPE   * DBFL1dll   = (DBFL1dll_TYPE *  ) library.getSymbol(DBFL1dll_NAME);
	DBFL2dll_TYPE   * DBFL2dll   = (DBFL2dll_TYPE *  ) library.getSymbol(DBFL2dll_NAME);
	DDDPdll_TYPE    * DDDPdll    = (DDDPdll_TYPE *   ) library.getSymbol(DDDPdll_NAME);
	DDDTdll_TYPE    * DDDTdll    = (DDDTdll_TYPE *   ) library.getSymbol(DDDTdll_NAME);
	DEFLSHdll_TYPE  * DEFLSHdll  = (DEFLSHdll_TYPE * ) library.getSymbol(DEFLSHdll_NAME);
	DHD1dll_TYPE    * DHD1dll    = (DHD1dll_TYPE *   ) library.getSymbol(DHD1dll_NAME);
	DHFLSHdll_TYPE  * DHFLSHdll  = (DHFLSHdll_TYPE * ) library.getSymbol(DHFLSHdll_NAME);
	DHFL1dll_TYPE   * DHFL1dll   = (DHFL1dll_TYPE *  ) library.getSymbol(DHFL1dll_NAME);
	DHFL2dll_TYPE   * DHFL2dll   = (DHFL2dll_TYPE *  ) library.getSymbol(DHFL2dll_NAME);
	DIELECdll_TYPE  * DIELECdll  = (DIELECdll_TYPE * ) library.getSymbol(DIELECdll_NAME);
	DOTFILLdll_TYPE * DOTFILLdll = (DOTFILLdll_TYPE *) library.getSymbol(DOTFILLdll_NAME);
	DPDD2dll_TYPE   * DPDD2dll   = (DPDD2dll_TYPE *  ) library.getSymbol(DPDD2dll_NAME);
	DPDDKdll_TYPE   * DPDDKdll   = (DPDDKdll_TYPE *  ) library.getSymbol(DPDDKdll_NAME);
	DPDDdll_TYPE    * DPDDdll    = (DPDDdll_TYPE *   ) library.getSymbol(DPDDdll_NAME);
	DPDTKdll_TYPE   * DPDTKdll   = (DPDTKdll_TYPE *  ) library.getSymbol(DPDTKdll_NAME);
	DPDTdll_TYPE    * DPDTdll    = (DPDTdll_TYPE *   ) library.getSymbol(DPDTdll_NAME);
	DPTSATKdll_TYPE * DPTSATKdll = (DPTSATKdll_TYPE *) library.getSymbol(DPTSATKdll_NAME);
	DSFLSHdll_TYPE  * DSFLSHdll  = (DSFLSHdll_TYPE * ) library.getSymbol(DSFLSHdll_NAME);
	DSFL1dll_TYPE   * DSFL1dll   = (DSFL1dll_TYPE *  ) library.getSymbol(DSFL1dll_NAME);
	DSFL2dll_TYPE   * DSFL2dll   = (DSFL2dll_TYPE *  ) library.getSymbol(DSFL2dll_NAME);
	ENTHALdll_TYPE  * ENTHALdll  = (ENTHALdll_TYPE * ) library.getSymbol(ENTHALdll_NAME);
	ENTROdll_TYPE   * ENTROdll   = (ENTROdll_TYPE *  ) library.getSymbol(ENTROdll_NAME);
	ESFLSHdll_TYPE  * ESFLSHdll  = (ESFLSHdll_TYPE * ) library.getSymbol(ESFLSHdll_NAME);
	FGCTYdll_TYPE   * FGCTYdll   = (FGCTYdll_TYPE *  ) library.getSymbol(FGCTYdll_NAME);
	FPVdll_TYPE     * FPVdll     = (FPVdll_TYPE *    ) library.getSymbol(FPVdll_NAME);
	GERG04dll_TYPE  * GERG04dll  = (GERG04dll_TYPE * ) library.getSymbol(GERG04dll_NAME);
	GETFIJdll_TYPE  * GETFIJdll  = (GETFIJdll_TYPE * ) library.getSymbol(GETFIJdll_NAME);
	GETKTVdll_TYPE  * GETKTVdll  = (GETKTVdll_TYPE * ) library.getSymbol(GETKTVdll_NAME);
	GIBBSdll_TYPE   * GIBBSdll   = (GIBBSdll_TYPE *  ) library.getSymbol(GIBBSdll_NAME);
	HSFLSHdll_TYPE  * HSFLSHdll  = (HSFLSHdll_TYPE * ) library.getSymbol(HSFLSHdll_NAME);
	INFOdll_TYPE    * INFOdll    = (INFOdll_TYPE *   ) library.getSymbol(INFOdll_NAME);
	LIMITKdll_TYPE  * LIMITKdll  = (LIMITKdll_TYPE * ) library.getSymbol(LIMITKdll_NAME);
	LIMITSdll_TYPE  * LIMITSdll  = (LIMITSdll_TYPE * ) library.getSymbol(LIMITSdll_NAME);
	LIMITXdll_TYPE  * LIMITXdll  = (LIMITXdll_TYPE * ) library.getSymbol(LIMITXdll_NAME);
	MELTPdll_TYPE   * MELTPdll   = (MELTPdll_TYPE *  ) library.getSymbol(MELTPdll_NAME);
	MELTTdll_TYPE   * MELTTdll   = (MELTTdll_TYPE *  ) library.getSymbol(MELTTdll_NAME);
	MLTH2Odll_TYPE  * MLTH2Odll  = (MLTH2Odll_TYPE * ) library.getSymbol(MLTH2Odll_NAME);
	NAMEdll_TYPE    * NAMEdll    = (NAMEdll_TYPE *   ) library.getSymbol(NAMEdll_NAME);
	PDFL1dll_TYPE   * PDFL1dll   = (PDFL1dll_TYPE *  ) library.getSymbol(PDFL1dll_NAME);
	PDFLSHdll_TYPE  * PDFLSHdll  = (PDFLSHdll_TYPE * ) library.getSymbol(PDFLSHdll_NAME);
	PEFLSHdll_TYPE  * PEFLSHdll  = (PEFLSHdll_TYPE * ) library.getSymbol(PEFLSHdll_NAME);
	PHFL1dll_TYPE   * PHFL1dll   = (PHFL1dll_TYPE *  ) library.getSymbol(PHFL1dll_NAME);
	PHFLSHdll_TYPE  * PHFLSHdll  = (PHFLSHdll_TYPE * ) library.getSymbol(PHFLSHdll_NAME);
	PQFLSHdll_TYPE  * PQFLSHdll  = (PQFLSHdll_TYPE * ) library.getSymbol(PQFLSHdll_NAME);
	PREOSdll_TYPE   * PREOSdll   = (PREOSdll_TYPE *  ) library.getSymbol(PREOSdll_NAME);
	PRESSdll_TYPE   * PRESSdll   = (PRESSdll_TYPE *  ) library.getSymbol(PRESSdll_NAME);
	PSFL1dll_TYPE   * PSFL1dll   = (PSFL1dll_TYPE *  ) library.getSymbol(PSFL1dll_NAME);
	PSFLSHdll_TYPE  * PSFLSHdll  = (PSFLSHdll_TYPE * ) library.getSymbol(PSFLSHdll_NAME);
	PUREFLDdll_TYPE * PUREFLDdll = (PUREFLDdll_TYPE *) library.getSymbol(PUREFLDdll_NAME);
	QMASSdll_TYPE   * QMASSdll   = (QMASSdll_TYPE *  ) library.getSymbol(QMASSdll_NAME);
	QMOLEdll_TYPE   * QMOLEdll   = (QMOLEdll_TYPE *  ) library.getSymbol(QMOLEdll_NAME);
	SATDdll_TYPE    * SATDdll    = (SATDdll_TYPE *   ) library.getSymbol(SATDdll_NAME);
	SATEdll_TYPE    * SATEdll    = (SATEdll_TYPE *   ) library.getSymbol(SATEdll_NAME);
	SATHdll_TYPE    * SATHdll    = (SATHdll_TYPE *   ) library.getSymbol(SATHdll_NAME);
	SATPdll_TYPE    * SATPdll    = (SATPdll_TYPE *   ) library.getSymbol(SATPdll_NAME);
	SATSdll_TYPE    * SATSdll    = (SATSdll_TYPE *   ) library.getSymbol(SATSdll_NAME);
	SATTdll_TYPE    * SATTdll    = (SATTdll_TYPE *   ) library.getSymbol(SATTdll_NAME);
	SETAGAdll_TYPE  * SETAGAdll  = (SETAGAdll_TYPE * ) library.getSymbol(SETAGAdll_NAME);
	SETKTVdll_TYPE  * SETKTVdll  = (SETKTVdll_TYPE * ) library.getSymbol(SETKTVdll_NAME);
	SETMIXdll_TYPE  * SETMIXdll  = (SETMIXdll_TYPE * ) library.getSymbol(SETMIXdll_NAME);
	SETMODdll_TYPE  * SETMODdll  = (SETMODdll_TYPE * ) library.getSymbol(SETMODdll_NAME);
	SETREFdll_TYPE  * SETREFdll  = (SETREFdll_TYPE * ) library.getSymbol(SETREFdll_NAME);
	SETUPdll_TYPE   * SETUPdll   = (SETUPdll_TYPE *  ) library.getSymbol(SETUPdll_NAME);
//	SPECGRdll_TYPE  * SPECGRdll  = (SPECGRdll_TYPE * ) library.getSymbol(SPECGRdll_NAME);
	SUBLPdll_TYPE   * SUBLPdll   = (SUBLPdll_TYPE *  ) library.getSymbol(SUBLPdll_NAME);
	SUBLTdll_TYPE   * SUBLTdll   = (SUBLTdll_TYPE *  ) library.getSymbol(SUBLTdll_NAME);
	SURFTdll_TYPE   * SURFTdll   = (SURFTdll_TYPE *  ) library.getSymbol(SURFTdll_NAME);
	SURTENdll_TYPE  * SURTENdll  = (SURTENdll_TYPE * ) library.getSymbol(SURTENdll_NAME);
	TDFLSHdll_TYPE  * TDFLSHdll  = (TDFLSHdll_TYPE * ) library.getSymbol(TDFLSHdll_NAME);
	TEFLSHdll_TYPE  * TEFLSHdll  = (TEFLSHdll_TYPE * ) library.getSymbol(TEFLSHdll_NAME);
	THERM0dll_TYPE  * THERM0dll  = (THERM0dll_TYPE * ) library.getSymbol(THERM0dll_NAME);
	THERM2dll_TYPE  * THERM2dll  = (THERM2dll_TYPE * ) library.getSymbol(THERM2dll_NAME);
	THERM3dll_TYPE  * THERM3dll  = (THERM3dll_TYPE * ) library.getSymbol(THERM3dll_NAME);
	THERMdll_TYPE   * THERMdll   = (THERMdll_TYPE *  ) library.getSymbol(THERMdll_NAME);
	THFLSHdll_TYPE  * THFLSHdll  = (THFLSHdll_TYPE * ) library.getSymbol(THFLSHdll_NAME);
	TPFLSHdll_TYPE  * TPFLSHdll  = (TPFLSHdll_TYPE * ) library.getSymbol(TPFLSHdll_NAME);
	TPFL2dll_TYPE   * TPFL2dll   = (TPFL2dll_TYPE *  ) library.getSymbol(TPFL2dll_NAME);
	TPRHOdll_TYPE   * TPRHOdll   = (TPRHOdll_TYPE *  ) library.getSymbol(TPRHOdll_NAME);
	TQFLSHdll_TYPE  * TQFLSHdll  = (TQFLSHdll_TYPE * ) library.getSymbol(TQFLSHdll_NAME);
	TRNPRPdll_TYPE  * TRNPRPdll  = (TRNPRPdll_TYPE * ) library.getSymbol(TRNPRPdll_NAME);
	TSFLSHdll_TYPE  * TSFLSHdll  = (TSFLSHdll_TYPE * ) library.getSymbol(TSFLSHdll_NAME);
	VIRBdll_TYPE    * VIRBdll    = (VIRBdll_TYPE *   ) library.getSymbol(VIRBdll_NAME);
	VIRCdll_TYPE    * VIRCdll    = (VIRCdll_TYPE *   ) library.getSymbol(VIRCdll_NAME);
	WMOLdll_TYPE    * WMOLdll    = (WMOLdll_TYPE *   ) library.getSymbol(WMOLdll_NAME);
	XMASSdll_TYPE   * XMASSdll   = (XMASSdll_TYPE *  ) library.getSymbol(XMASSdll_NAME);
	XMOLEdll_TYPE   * XMOLEdll   = (XMOLEdll_TYPE *  ) library.getSymbol(XMOLEdll_NAME);


	newline();

	RPVersion(v);
	printf("RPVersion(v) returned v = %s\n", v);

	strcpy(hpth,REFPROP_PATH.toString().c_str());
	SETPATHdll(hpth);
	printf("SETPATHdll(hpth) called with hpth = %s\n", hpth);

	i=1;
	strcpy(hfld,"nitrogen.fld");
	strcpy(hfm,"hmx.bnc");
	strcpy(hrf,"DEF");
	strcpy(herr,"Ok");
	SETUPdll(i,hfld,hfm,hrf,ierr,herr);
	if (ierr != 0) printf("%s\n",herr);
	printf("SETUPdll(i,hfld,hfm,hrf,ierr,herr) called with hfld = %s\n", hfld);

	info_index = 1;
	INFOdll(info_index,wm,ttp,tnbp,tc,pc,dc,zc,acf,dip,rgas);
	printf("INFOdll(info_index,wm,ttp,tnbp,tc,pc,dc,zc,acf,dip,rgas) called with index = %l\n", info_index);
	printf("WM,ACF,DIP,TTP,TNBP   %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",wm,acf,dip,ttp,tnbp);
	printf("TC,PC,DC,RGAS         %10.4f,%10.4f,%10.4f,%10.4f\n",tc,pc,dc,rgas);

	//...For a mixture, use the following setup instead of the lines above.
	// Use "|" as the file name delimiter for mixtures
	i=3;
	strcpy(hfld,"nitrogen.fld");
	strcat(hfld,"|argon.fld");
	strcat(hfld,"|oxygen.fld");
	strcpy(hfm,"hmx.bnc");
	strcpy(hrf,"DEF");
	strcpy(herr,"Ok");
	x[0]=.7812;     //Air composition
	x[1]=.0092;
	x[2]=.2096;
	//...Call SETUP to initialize the program
	SETUPdll(i,hfld,hfm,hrf,ierr,herr);
	newline();
	printf("SETUPdll(i,hfld,hfm,hrf,ierr,herr) called with hfld = %s\n", hfld);

	INFOdll(info_index,wm,ttp,tnbp,tc,pc,dc,zc,acf,dip,rgas);
	printf("WM,ACF,DIP,TTP,TNBP   %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",wm,acf,dip,ttp,tnbp);
	printf("TC,PC,DC,RGAS         %10.4f,%10.4f,%10.4f,%10.4f\n",tc,pc,dc,rgas);

	//...Calculate molecular weight of a mixture
	wm = 0.;
	WMOLdll(x,wm);
	newline();
	printf("wm         %10.4f\n",wm);

	//...Get saturation properties given t,x; for i=1: x is liquid phase
	//.....                                   for i=2: x is vapor phase

	SATTdll(t,x,i,p,dl,dv,xliq,xvap,ierr,herr,errormessagelength);
	printf("P,Dl,Dv,xl[0],xv[0]   %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",p,dl,dv,xliq[0],xvap[0]);
	i=2;
	SATTdll(t,x,i,p,dl,dv,xliq,xvap,ierr,herr,errormessagelength);
	printf("P,Dl,Dv,xl[0],xv[0]   %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",p,dl,dv,xliq[0],xvap[0]);

	//...Calculate saturation properties at a given p. i is same as SATT
	i=2;
	SATPdll(p,x,i,t,dl,dv,xliq,xvap,ierr,herr,errormessagelength);
	printf("T,Dl,Dv,xl(1),xv(1)   %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",t,dl,dv,xliq[0],xvap[0]);

	//...Other saturation routines are given in SAT_SUB.FOR
	      t=300.0;
	      p=20000.0;

	//...Calculate d from t,p,x
	//...If phase is known: (j=1: Liquid, j=2: Vapor)
	      long j=1;
		  double d,q,e,h,s,cv,cp,w,b,c,
			  dpdrho,d2pdd2,dpdt,dhdt_d,dhdt_p,dhdp_t,dhdp_d,
			  sigma,dhdd_t,dhdd_p,eta,tcx,pp,tt,hjt,h1,dd;
		  long tmp_int=0;
	      TPRHOdll(t,p,x,j,tmp_int,d,ierr,herr,errormessagelength);
	      printf("T,P,D                 %10.4f,%10.4f,%10.4f\n",t,p,d);

	//...If phase is not known, call TPFLSH
	//...Calls to TPFLSH are much slower than TPRHO since SATT must be called first.
	//.....(If two phase, quality is returned as q)
	      TPFLSHdll(t,p,x,d,dl,dv,xliq,xvap,q,e,h,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T,P,D,H,CP            %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",t,p,d,h,cp);

	//...Calculate pressure (p), internal energy (e), enthalpy (h), entropy (s),
	//.....isochoric (cv) and isobaric (cp) heat capacities, speed of sound (w),
	//.....and Joule-Thomson coefficient (hjt) from t,d,x
	//.....(subroutines THERM2 and THERM3 contain more properties, see PROP_SUB.FOR)
	      THERMdll(t,d,x,p,e,h,s,cv,cp,w,hjt);

	//...Calculate pressure
	      PRESSdll(t,d,x,p);

	//...Calculate fugacity
	      FGCTYdll(t,d,x,f);

	//...Calculate second and third virial coefficients
	      VIRBdll (t,x,b);
	      VIRCdll (t,x,c);
	      printf("F,B,C                 %10.4f,%10.4f,%10.4f\n",f[0],b,c);

	//...Calculate the derivatives: dP/dD, d^2P/dD^2, dP/dT  (D indicates density)
	//...(dD/dP, dD/dT, and dB/dT are also available, see PROP_SUB.FOR)
	      DPDDdll (t,d,x,dpdrho);
	      DPDD2dll (t,d,x,d2pdd2);
	      DPDTdll (t,d,x,dpdt);
	      printf("dP/dD,d2P/dD2,dP/dT   %10.4f,%10.4f,%10.4f\n",dpdrho,d2pdd2,dpdt);


	//...Calculate derivatives of enthalpy with respect to T, P, and D
	      DHD1dll(t,d,x,dhdt_d,dhdt_p,dhdd_t,dhdd_p,dhdp_t,dhdp_d);
	      printf("Enthalpy derivatives  %10.4f,%10.4f,%10.4f,%10.4f,%10.4f\n",
			       dhdt_d,dhdt_p,dhdd_t,dhdd_p/1000.0,dhdp_t);
	//...Calculate surface tension
	      SURFTdll (t,dl,x,sigma,ierr,herr,errormessagelength);
	      printf("T,SURF. TN.           %10.4f,%10.4f\n",t,sigma);

	//...Calculate viscosity (eta) and thermal conductivity (tcx)
	      TRNPRPdll (t,d,x,eta,tcx,ierr,herr,errormessagelength);
	      printf("VIS.,TH.CND.          %10.4f,%10.4f\n",eta,tcx*1000.0);

	//...General property calculation with inputs of t,d,x
	      TDFLSHdll (t,d,x,pp,dl,dv,xliq,xvap,q,e,h1,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T, D, P from TDFLSH   %10.4f,%10.4f,%10.4f\n",t,d,pp/1000.0);

	//...General property calculation with inputs of p,d,x
	      PDFLSHdll (p,d,x,tt,dl,dv,xliq,xvap,q,e,h1,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T, D, P from PDFLSH   %10.4f,%10.4f,%10.4f\n",tt,d,p/1000.0);

	//...General property calculation with inputs of p,h,x
	      PHFLSHdll (p,h,x,tt,dd,dl,dv,xliq,xvap,q,e,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T, D, P from PHFLSH   %10.4f,%10.4f,%10.4f\n",tt,dd,p/1000.0);

	//...General property calculation with inputs of p,s,x
	      PSFLSHdll (p,s,x,tt,dd,dl,dv,xliq,xvap,q,e,h1,cv,cp,w,ierr,herr,errormessagelength);
		  printf("T, D, P from PSFLSH   %10.4f,%10.4f,%10.4f\n",tt,dd,p/1000.0);

	//...General property calculation with inputs of d,h,x
	      DHFLSHdll (d,h,x,tt,pp,dl,dv,xliq,xvap,q,e,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T, D, P from DHFLSH   %10.4f,%10.4f,%10.4f\n",tt,d,pp/1000.0);

	//...General property calculation with inputs of t,h,x
	//     kr--flag specifying desired root for multi-valued inputs:
	//         1=return lower density root
	//         2=return higher density root
	      long kr=1;
	      THFLSHdll (t,h,x,
	                  kr,pp,dd,dl,dv,xliq,xvap,q,e,s,cv,cp,w,ierr,herr,errormessagelength);
	      printf("T, D, P from THFLSH   %10.4f,%10.4f,%10.4f\n",t,dd,pp/1000.0);

	//...Other general property calculation routines are given in FLSH_SUB.FOR
	//...and FLASH2.FOR

	//...Calculate melting pressure
	      t=100.0;
	      MELTTdll (t,x,p,ierr,herr,errormessagelength);
	      printf("Melting pressure(MPa) %10.4f,%10.4f\n",p/1000.0,t);

	//...Calculate melting temperature
	      MELTPdll (p,x,tt,ierr,herr,errormessagelength);
	      printf("Melting temperature(K)%10.4f,%10.4f\n",tt,p/1000.0);

	//...Calculate sublimation pressure
	      t=200.0;
	      SUBLTdll (t,x,p,ierr,herr,errormessagelength);
	      printf("Sublimation pr.(kPa)  %10.4f,%10.4f\n",p,t);

	//...Calculate sublimation temperature
	      SUBLPdll (p,x,tt,ierr,herr,errormessagelength);
	      printf("Sublimation temp.(K)  %10.4f,%10.4f\n",tt,p);

	//...Get limits of the equations and check if t,d,p is a valid point
	//...Equation of state
	//     call LIMITK ('EOS',1,t,d,p,tmin,tmax,Dmax,pmax,ierr,herr)
	//...Viscosity equation
	//     call LIMITK ('ETA',1,t,d,p,tmin,tmax,Dmax,pmax,ierr,herr)
	//...Thermal conductivity equation
	//     call LIMITK ('TCX',1,t,d,p,tmin,tmax,Dmax,pmax,ierr,herr)

	//...Other routines are given in UTILITY.FOR

	  	library.unload();

return EXIT_SUCCESS;
}

