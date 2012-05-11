#include <windows.h>
#include <stdio.h>
//#include "refprop_density_fixgas.h"
#include "refprop_wrapper.h"

//double density(char* fluidname_in, double p, double t, double* x, char* REFPROP_PATH);
//double density(char* fluidname_in, double p, double t);
//double density(double p, double t);
//char *str_replace(char *str, char *search, char *replace, long *count);

void main(int argc, char* argv[]){
	double p,t,d;
	char fluidname[255];
	char errormsg[255+1024];
	double* x;
	double *props;
	double sumx;
	int i;
	int nX = argc-5;
	
	if (argc<5){
		printf("usage: refpropwrappertest.exe statevars fluidname1|fluidname2|... statevar1 statevar2 REFPROPdir massfractionComponent1 \nexample: refpropwrappertest \"pT\" \"isobutan|propane\" 1e5 293 \"d:\\Programme\\REFPROP\\\" .1");
		return;
	}

	x = (double*) calloc(nX,sizeof(double));
	props=(double*) calloc(16+2*nX,sizeof(double));

	
	sumx = 0;
	for (i=0;i<nX-1;i++){
		x[i] = atof(argv[6+i]);
		sumx += x[i];
	}
	x[nX-1] = 1-sumx;
	
	
	//strcpy(fluidname,argv[1]);//water;
	/*p=atof(argv[2]);//2000;
	t=atof(argv[3]);//300.0;	*/
	//d = density(fluidname, p, t, x, ""); //d:\\Programme\REFPROP\\	
	//d = density(fluidname, p, t);	
	//d = density(p, t);	
	//props_REFPROP("", "pT", "isobutan|propane", props, 1e5, 293.0, x, 0, "d:\\Programme\\REFPROP\\", errormsg);
	props_REFPROP("", argv[1], argv[2], props, atof(argv[3]), atof(argv[4]), x, 0, argv[5], errormsg);
	printf("Errormessage: %s\n",errormsg);
	printf("%c,%c,D                 %10.4f,%10.4f,%10.4f\n",argv[1][0],argv[1][1],atof(argv[3]),atof(argv[4]),props[5]);
	/*	props[0] = ierr;//error code
	props[1] = p;//pressure in Pa
	props[2] = T;	//Temperature in K
	props[3] = wm;	//molecular weight
	props[4] = d;	//density
	props[5] = dl;	//density of liquid phase 
	props[6] = dv;	//density of liquid phase 
	props[7] = q;	//vapor quality on a mass basis [mass vapor/total mass] (q=0 indicates saturated liquid, q=1 indicates saturated vapor)
	props[8] = e;	//inner energy*/
	printf("h=%f J/kg\n",props[9]);	//specific enthalpy
	printf("MM=%f J/kg\n",props[3]);	//specific enthalpy
	/*props[10] = s;//specific entropy
	props[11] = cv;
	props[12] = cp;
	props[13] = w; //speed of sound
	props[14] = wmliq;
	props[15] = wmvap;*/
	for (int ii=0;ii<nX;ii++){
		printf("Xliq[%i]=%f\t",ii+1, props[16+ii]);
		printf("Xvap[%i]=%f\n",ii+1, props[16+nX+ii]);
	}
	return;
}