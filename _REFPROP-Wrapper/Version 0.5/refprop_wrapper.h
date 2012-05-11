/*
	header file for REFPROP_wrapper.cpp
	
	This file is released under the Modelica License 2.
	
	Coded in 2010 by
	Henning Francke
	francke@gfz-potsdam.de
	
	Helmholtz Centre Potsdam
	GFZ German Research Centre for Geosciences
	Telegrafenberg, D-14473 Potsdam

*/


#ifndef REFPROP_WRAPPER
#define REFPROP_WRAPPER


//wenn die Datei .c heiﬂt
//extern double density(double p, double T); //declaration


//wenn dies eine .cpp ist
// Define export
#ifdef __cplusplus
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif // __cplusplus

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus
	EXPORT double props_REFPROP(char* what, char* statevars, char* fluidnames, double *props, double statevar1, double statevar2, double* x, int phase, char* REFPROP_PATH, char* errormsg, int DEBUGMODE); //declaration;
	EXPORT double satprops_REFPROP(char* what, char* statevar, char* fluidnames, double *props, double statevarval, double* x, char* REFPROP_PATH, char* errormsg, int DEBUGMODE); //declaration;

#ifdef __cplusplus
}
#endif // __cplusplus
#endif /*REFPROP_WRAPPER*/
