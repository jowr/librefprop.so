#ifndef REFPROP_LIB_H
#define REFPROP_LIB_H
// The idea here is to have a common header for Windows 
// and Linux systems. The Windows branch should cover the
// functions provided by the .dll and the Linux part covers
// the compiled .so file. Name changes caused by gfortran 
// are repsected and should be accounted for. 
//
#include "refprop_names.h"
#include "refprop_constants.h"
#ifdef __cplusplus
#include "refprop_types_cpp.h"
#else
#include "refprop_types_c.h"
#endif
#include "refprop_types.h"
// REFPROP_LIB_H
#endif