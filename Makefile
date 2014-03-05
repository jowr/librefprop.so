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
RM :=rm -f
CP :=cp 
CH :=chmod 0644 
MK :=mkdir -p 
LD :=ldconfig 	
LN :=ln -sf 
SE :=sed

# used for the output
MAJORVERSION     :=9
MINORVERSION     :=1
THENAME          :=refprop

###########################################################
#  Setting the directories for library, header and 
#  binary files created in this makefile. 
###########################################################
LIBDIR     :=./fortran
FILDIR     :=./files
SRCDIR     :=./src
LIBINST    :=/usr/local/lib
HEADINST   :=/usr/local/include
FILINST    :=/opt/refprop
BINDIR     :=./bin

LIBS       :=-l$(THENAME)# -lPocoFoundation
# Disable optimisation for now, this should be removed again
OPTFLAGS   :=-O3 -ffast-math# -ffloat-store # optimisation, remove for debugging
###########################################################
#  Change these lines if you are using a different Fortran 
#  compiler or if you would like to use other flags. 
###########################################################
FEXT       :=.for_
FC         :=gfortran
FFLAGS     :=$(OPTFLAGS) -Wall -pedantic -fopenmp -fPIC# -fno-underscoring

###########################################################
#  Change these lines if you are using a different C++ 
#  compiler or if you would like to use other flags. 
###########################################################
CPPC       :=g++
CPPFLAGS   :=$(OPTFLAGS) -Wall -pedantic -fbounds-check -ansi -Wpadded -Wpacked -mpreferred-stack-boundary=8

###########################################################
#  Change these lines if you are using a different C
#  compiler or if you would like to use other flags. 
###########################################################
CC         :=gcc
CFLAGS     :=$(CPPFLAGS)

###########################################################
#  Change these lines if you have other needs regarding
#  the library file.  
###########################################################
LIBFILE                 :=PASS_FTN_ALT
LIBRARY                 :=lib$(THENAME)
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
  DYNAMICLIBRARYEXTENSION :=.so
  LIBFLAGS                :=-rdynamic -lc -shared -Wl,-soname,$(LIBRARY)$(DYNAMICLIBRARYEXTENSION).$(MAJORVERSION)
endif
ifeq ($(UNAME), Darwin)
  DYNAMICLIBRARYEXTENSION :=.dylib
  LIBFLAGS                :=-dynamiclib -o $(BINDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) -Wl,-headerpad_max_install_names,-undefined,dynamic_lookup,-compatibility_version,$(MAJORVERSION).$(MINORVERSION),-current_version,$(MAJORVERSION).$(MINORVERSION),-install_name,$(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(DYNAMICLIBRARYEXTENSION) -lgfortran -lm -lgomp
  #LIBFLAGS                =-static -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) -install_name $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) -current_version $(MAJORVERSION) -compatibility_version $(MAJORVERSION) $(FLINKFLAGS)
  #LIBFLAGS                =-dynamic -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) -install_name $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) -current_version $(MAJORVERSION) -compatibility_version $(MAJORVERSION) $(FLINKFLAGS)
  #LINKCOMM                = libtool $(LIBFLAGS) $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
endif
LIBRARYEXTENSION        :=$(DYNAMICLIBRARYEXTENSION)
LINKCOMM                := $(FC) $(LIBFLAGS) $(FFLAGS) -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
HEADERFILE              :=$(THENAME)_lib
HEADEREXTENSION         :=.h
HEADERFILES             :=$(THENAME)_lib.h $(THENAME)_constants.h $(THENAME)_names.h $(THENAME)_types_c.h $(THENAME)_types_cpp.h $(THENAME)_types.h
SRCHEADERFILES          :=$(SRCDIR)/$(THENAME)_lib.h $(SRCDIR)/$(THENAME)_constants.h $(SRCDIR)/$(THENAME)_names.h $(SRCDIR)/$(THENAME)_types_c.h $(SRCDIR)/$(THENAME)_types_cpp.h $(SRCDIR)/$(THENAME)_types.h
BINHEADERFILES          :=$(BINDIR)/$(THENAME)_lib.h $(BINDIR)/$(THENAME)_constants.h $(BINDIR)/$(THENAME)_names.h $(BINDIR)/$(THENAME)_types_c.h $(BINDIR)/$(THENAME)_types_cpp.h $(BINDIR)/$(THENAME)_types.h
INSTHEADERFILES         :=$(HEADINST)/$(THENAME)_lib.h $(HEADINST)/$(THENAME)_constants.h $(HEADINST)/$(THENAME)_names.h $(HEADINST)/$(THENAME)_types_c.h $(HEADINST)/$(THENAME)_types_cpp.h $(HEADINST)/$(THENAME)_types.h
#
### List of files to compile
LIBOBJECTFILES := \
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
.PHONY  : install 
ifeq ($(UNAME), Linux)
  install : install-linux
endif
ifeq ($(UNAME), Darwin)
  install : install-mac
endif

.PHONY        : install-linux
install-linux : header library install-fluids
	$(MK) $(HEADINST) $(LIBINST)
	$(CP) $(BINHEADERFILES) $(HEADINST)
	$(CP) $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(CH) $(INSTHEADERFILES) 
	$(CH) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(LD) -l $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) $(FILINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LD) 

.PHONY        : install-mac
install-mac   : header library install-fluids
	install -d -m 755 -o root -g wheel $(HEADINST) $(LIBINST)
	install -m 644 -o root -g wheel $(BINHEADERFILES) $(HEADINST)
	install -m 644 -o root -g wheel $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) $(FILINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	
.PHONY       : install-fluids
install-fluids :
	$(MK) $(FILINST)
	$(CP) -r $(FILDIR)/* $(FILINST)
	chmod 755 $(FILINST) $(FILINST)/fluids $(FILINST)/mixtures
	$(CH) $(FILINST)/fluids/* $(FILINST)/mixtures/*

.PHONY       : uninstall
uninstall    : 
	$(RM) $(INSTHEADERFILES)
	$(RM) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)*
	$(RM) -r $(FILINST)

.PHONY       : all
all          : header library

###########################################################
#  Compile the Fortran sources into a library file that can 
#  be used as a shared object.
###########################################################
.PHONY     : header
header     : $(BINHEADERFILES)

.PHONY     : library
library    : $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) 

$(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) : $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
	$(MK) $(BINDIR)
	$(LINKCOMM)

$(SRCDIR)/$(LIBFILE)$(FEXT): $(LIBDIR)/PASS_FTN.FOR  $(LIBDIR)/COMMONS$(FEXT) $(LIBDIR)/COMTRN$(FEXT)
	$(SE) 's/dll_export/!dll_export/g' $(LIBDIR)/PASS_FTN.FOR > $(SRCDIR)/$(LIBFILE)$(FEXT)
	cat $(SRCDIR)/$(LIBFILE).FOR.tpl >> $(SRCDIR)/$(LIBFILE)$(FEXT)
	$(SE) -i.du "s/'commons.for'/'COMMONS$(FEXT)'/" $(SRCDIR)/$(LIBFILE)$(FEXT)
	$(SE) -i.du "s/'comtrn$.for'/'COMTRN$(FEXT)'/" $(SRCDIR)/$(LIBFILE)$(FEXT)

###########################################################
#  General rulesets for compilation.
###########################################################
$(BINDIR)/%$(HEADEREXTENSION): $(SRCDIR)/%$(HEADEREXTENSION)
	$(MK) $(BINDIR)
	$(CP) $< $@

$(SRCDIR)/%.o : $(SRCDIR)/%$(FEXT)
	$(FC) $(FFLAGS) -I $(LIBDIR)/ -o $(SRCDIR)/$*.o -c $<
	
$(SRCDIR)/%.o : $(SRCDIR)/%.cpp
	$(CPPC) $(CPPFLAGS) -o $(SRCDIR)/$*.o -c $<

$(SRCDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -o $(SRCDIR)/$*.o -c $<

$(LIBDIR)/%.o : $(LIBDIR)/%$(FEXT)
	$(FC) $(FFLAGS) -o $(LIBDIR)/$*.o -c $<

$(LIBDIR)/%$(FEXT) : $(LIBDIR)/%.FOR
	$(CP) $(LIBDIR)/$*.FOR $(LIBDIR)/$*$(FEXT)
	$(SE) -i.du "s/'commons.for'/'COMMONS$(FEXT)'/" $(LIBDIR)/$*$(FEXT)
	$(SE) -i.du "s/'comtrn.for'/'COMTRN$(FEXT)'/" $(LIBDIR)/$*$(FEXT)
	
.PHONY: clean
clean:
	$(RM) **.o **.so **.a **.dylib **.mod $(BINDIR)/* $(SRCDIR)/*.o $(LIBDIR)/*$(FEXT) $(LIBDIR)/*$(FEXT).du $(LIBDIR)/*.o $(SRCDIR)/$(LIBFILE)$(FEXT) $(SRCDIR)/$(LIBFILE)$(FEXT).du

###########################################################
#  Compile a simple example to illustrate the connection
#  between C++, C and Fortran as well as the usage of the 
#  created library.
###########################################################
.PHONY               : ctest
ctest                : $(BINDIR)/ex_mix_c
$(BINDIR)/ex_mix_c   : $(SRCDIR)/ex_mix.c
	$(CC) $(CFLAGS) -g -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.c
	$(CC) $(FLINKFLAGS) -g -o $(BINDIR)/ex_mix_c $(SRCDIR)/ex_mix.o $(LIBS)

.PHONY               : cpptest
cpptest              : $(BINDIR)/ex_mix_cpp
$(BINDIR)/ex_mix_cpp : $(SRCDIR)/ex_mix.cpp
	$(CPPC) $(CPPFLAGS) -g -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.cpp
	$(CPPC) $(CPPFLAGS) -g -o $(BINDIR)/ex_mix_cpp $(SRCDIR)/ex_mix.o $(LIBS) -lPocoFoundation

.PHONY               : fortest
fortest              : $(BINDIR)/ex_mix_for
$(BINDIR)/ex_mix_for : $(SRCDIR)/ex_mix.for
	$(FC) $(FFLAGS) -g -o $(SRCDIR)/ex_mix.o -c $(SRCDIR)/ex_mix.for
	$(FC) $(FLINKFLAGS) -g -o $(BINDIR)/ex_mix_for $(SRCDIR)/ex_mix.o $(LIBS) -lgfortran
	
