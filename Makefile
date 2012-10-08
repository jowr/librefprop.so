# ============================================================================
# Name        : Makefile
# Author      : Jorrit Wronski (jowr@mek.dtu.dk) 
# Copyright   : Use and modify at your own risk.
# Description : Makefile for Refprop library from Fortran sources.
# ============================================================================
# The installation procedure should be as follows:
# 1) make header library
# 2) sudo make install
# ============================================================================
# general commands:
RM = rm -f
CP = cp 
CH = chmod 0644 
MK = mkdir -p 
LD = ldconfig 
LN = ln -sf 

# used for the output
MAJORVERSION     =9
MINORVERSION     =0
THENAME          =refprop
LIBRARYEXTENSION =$(DYNAMICLIBRARYEXTENSION)

###########################################################
#  Setting the directories for library, header and 
#  binary files created in this makefile. 
###########################################################
LIBDIR     =./fortran
SRCDIR     =./src
LIBINST    =/usr/local/lib
HEADINST   =/usr/local/include
BINDIR     =./bin

LIBS       =-l$(THENAME) -lPocoFoundation
OPTFLAGS   =-O3 -ffast-math# -ffloat-store # optimisation, remove for debugging
###########################################################
#  Change these lines if you are using a different Fortran 
#  compiler or if you would like to use other flags. 
###########################################################
FC         =gfortran
FFLAGS     =$(OPTFLAGS) -Wall -pedantic# -ff2c  -fbounds-check
FLINKFLAGS =$(FFLAGS) $(LIBS)

###########################################################
#  Change these lines if you are using a different C++ 
#  compiler or if you would like to use other flags. 
###########################################################
CPPC       =g++
CPPFLAGS   =$(OPTFLAGS) -Wall -pedantic -fbounds-check -ansi -Wpadded -Wpacked -malign-double -mpreferred-stack-boundary=8 

###########################################################
#  Change these lines if you are using a different C
#  compiler or if you would like to use other flags. 
###########################################################
CC         =gcc
CFLAGS     =$(OPTFLAGS) -Wall -pedantic -fbounds-check -ansi -Wpadded -Wpacked -malign-double -mpreferred-stack-boundary=8 

###########################################################
#  Change these lines if you have other needs regarding
#  the library file.  
###########################################################
LIBRARY                 =lib$(THENAME)
LIBFLAGS                =-rdynamic -fPIC -shared -Wl,-soname,$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION)
LIBFILE                 =PASS_FTN_LIN
DYNAMICLIBRARYEXTENSION =.so
STATICLIBRARYEXTENSION  =.a
#ar -cvq $(LIBRARY)$(STATICLIBRARYEXTENSION) $(OBJECTFILES)
HEADERFILE              =$(THENAME)_lib
HEADEREXTENSION         =.h
### List of files to compile
LIBOBJECTFILES = \
	$(LIBDIR)/SETUP.o \
	$(LIBDIR)/CORE_ANC.o \
	$(LIBDIR)/CORE_BWR.o \
	$(LIBDIR)/CORE_CPP.o \
	$(LIBDIR)/CORE_DE.o \
	$(LIBDIR)/CORE_ECS.o \
	$(LIBDIR)/CORE_FEQ.o \
	$(LIBDIR)/CORE_MLT.o \
	$(LIBDIR)/CORE_PH0.o \
	$(LIBDIR)/CORE_QUI.o \
	$(LIBDIR)/CORE_STN.o \
	$(LIBDIR)/CORE_PR.o \
	$(LIBDIR)/FLASH2.o \
	$(LIBDIR)/FLSH_SUB.o \
	$(LIBDIR)/IDEALGAS.o \
	$(LIBDIR)/MIX_AGA8.o \
	$(LIBDIR)/MIX_HMX.o \
	$(LIBDIR)/PROP_SUB.o \
	$(LIBDIR)/REALGAS.o \
	$(LIBDIR)/SAT_SUB.o \
	$(LIBDIR)/SETUP2.o \
	$(LIBDIR)/TRNS_ECS.o \
	$(LIBDIR)/TRNS_TCX.o \
	$(LIBDIR)/TRNS_VIS.o \
	$(LIBDIR)/TRNSP.o \
	$(LIBDIR)/UTILITY.o
	
###########################################################
#  Copy files to places recognised by the system.
###########################################################
.PHONY     : install
install    : header library
	$(CP) $(BINDIR)/$(HEADERFILE)$(HEADEREXTENSION) $(HEADINST)/$(HEADERFILE)$(HEADEREXTENSION)
	$(CP) $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(MK) $(HEADINST) $(LIBINST)
	$(CH) $(HEADINST)/$(HEADERFILE)$(HEADEREXTENSION)
	$(CH) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(LD) -l $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LD) 

.PHONY     : uninstall
uninstall  : 
	$(RM) $(HEADINST)/$(HEADERFILE)$(HEADEREXTENSION)
	$(RM) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)*

.PHONY     : all
all        : header library

###########################################################
#  Compile the Fortran sources into a library file that can 
#  be used as a shared object.
###########################################################
.PHONY     : header
header     : $(BINDIR)/$(HEADERFILE)$(HEADEREXTENSION)
$(BINDIR)/$(HEADERFILE)$(HEADEREXTENSION): $(SRCDIR)/$(HEADERFILE)$(HEADEREXTENSION)
	$(CP) $(SRCDIR)/$(HEADERFILE)$(HEADEREXTENSION) $(BINDIR)

.PHONY     : library
library    : $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) 

$(BINDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION): $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
	$(FC) $(LIBFLAGS) $(FFLAGS) -o $(BINDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
	
$(SRCDIR)/$(LIBFILE).FOR: $(LIBDIR)/PASS_FTN.FOR
	sed 's/dll_export/!dll_export/g' $(LIBDIR)/PASS_FTN.FOR > $(SRCDIR)/$(LIBFILE).FOR
	cat $(SRCDIR)/$(LIBFILE).FOR.tpl >> $(SRCDIR)/$(LIBFILE).FOR

###########################################################
#  General rulesets for compilation.
###########################################################
$(SRCDIR)/%.o : $(SRCDIR)/%.FOR
	$(FC) $(FFLAGS) -o $(SRCDIR)/$*.o -c $<
	
$(SRCDIR)/%.o : $(SRCDIR)/%.cpp
	$(CPPC) $(CPPFLAGS) -o $(SRCDIR)/$*.o -c $<

$(SRCDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -o $(SRCDIR)/$*.o -c $<

$(LIBDIR)/%.o : $(LIBDIR)/%.FOR
	$(FC) $(FFLAGS) -o $(LIBDIR)/$*.o -c $<

.PHONY: clean
clean:
	$(RM) **.o **.so **.mod $(BINDIR)/* $(SRCDIR)/*.o $(LIBDIR)/*.o $(SRCDIR)/$(LIBFILE).FOR

###########################################################
#  Compile a simple example to illustrate the connection
#  between C++, C and Fortran as well as the usage of the 
#  created library.
###########################################################
.PHONY               : ctest
ctest                : $(BINDIR)/ex_mix_c
$(BINDIR)/ex_mix_c   : $(SRCDIR)/ex_mix.c
	$(CC) $(CFLAGS) -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.c
	$(CC) $(FLINKFLAGS) -o $(BINDIR)/ex_mix_c $(SRCDIR)/ex_mix.o $(LIBS)

.PHONY               : cpptest
cpptest              : $(BINDIR)/ex_mix_cpp
$(BINDIR)/ex_mix_cpp : $(SRCDIR)/ex_mix.cpp
	$(CPPC) $(CPPFLAGS) -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.cpp
	$(CPPC) $(CPPFLAGS) -o $(BINDIR)/ex_mix_cpp $(SRCDIR)/ex_mix.o $(LIBS)

.PHONY               : fortest
fortest              : $(BINDIR)/ex_mix_for
$(BINDIR)/ex_mix_for : $(SRCDIR)/ex_mix.for
	$(FC) $(FFLAGS) -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.for
	$(FC) $(FLINKFLAGS) -o $(BINDIR)/ex_mix_for $(SRCDIR)/ex_mix.o 
	