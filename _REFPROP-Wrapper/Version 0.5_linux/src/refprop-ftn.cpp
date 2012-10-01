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

// define new macros for function names
// http://stackoverflow.com/questions/195975/how-to-make-a-char-string-from-a-c-macros-value
#define STR_VALUE(arg)      #arg
#define FUNCTION_NAME(name) STR_VALUE(name)

//#define TEST_FUNC      test_func
//#define TEST_FUNC_NAME FUNCTION_NAME(TEST_FUNC)

//#define TEST_FUNC      test_func // done in header
#define RPVersion_NAME FUNCTION_NAME(RPVersion)


void newline() {
	printf("%s","\n");
}

#include "Poco/SharedLibrary.h"
using Poco::SharedLibrary;

int main(int argc, char* argv[]) {
	static long i,ierr,info_index;
	static double wm,ttp,tnbp,tc,pc,dc,zc,acf,dip,rgas;
	static char hfld[maxstringlength+1],hrf[lengthofreference+1],herr[errormessagelength+1],hfm[refpropcharlength+1];
	static char v[refpropcharlength+1],hpth[filepathlength+1];

	static double x[ncmax],xliq[ncmax],xvap[ncmax],f[ncmax];

	double t=100.0;
	double p,dl,dv;

	newline();

//    HINSTANCE dll = LoadLibrary("mydll.dll");
//
//    func_t * f = (func_t *)GetProcAddress(dll, "func");
//
//    f(1, 1.2f);

//	std::string path("/usr/lib/librefprop");
	std::string path("librefprop");
	path.append(SharedLibrary::suffix()); // adds ".dll" or ".so"
	SharedLibrary library(path); // will also load the library
	//RPVersion_t * func = (RPVersion_t *) library.getSymbol("rpversion_");
	RPVersion_t * func = (RPVersion_t *) library.getSymbol(RPVersion_NAME);
	func(v);
	printf("func(v) returned v = %s\n", v);
	library.unload();

	newline();

	RPVersion(v);
	printf("RPVersion(v) returned v = %s\n", v);

	strcpy(hpth,"/home/jowr/Documents/Fluids/refprop/v9.0/");
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


return EXIT_SUCCESS;
}

