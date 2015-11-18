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
CD :=cd
CMF:=664
CMG:=775
CH :=chmod
MK :=mkdir -p
LD :=ldconfig
LN :=ln -sf
SE :=sed
CU :=curl
MV :=mv
CA :=cat

# used for the output
MAJORVERSION:=9
MINORVERSION:=12
THENAME     :=refprop
USERNAME    :=$(shell whoami)
USERHOME    :=$(HOME)
UNAME       :=$(shell uname -s)
ARCH        :=$(shell getconf LONG_BIT)

# Fix architecture for msys builds 
ifeq ($(ARCH), )
  ARCH      :=32
endif
ifeq ($(ARCH), 64)
  ARCHFLAG  :=-m64
else
  ARCHFLAG  :=-m32
endif

###########################################################
#  Setting the directories for library, header and 
#  binary files created in this makefile. 
###########################################################
HEADIR     :=./externals/REFPROP-headers
LIBDIR     :=./fortran
FILDIR     :=./files
SRCDIR     :=./src
BINDIR     :=./bin
MATDIR     :=./matlab

ifeq ($(USERNAME),root)
  LIBINST  :=/usr/local/lib
  HEADINST :=/usr/local/include
  FILINST  :=/opt/refprop
else 
  LIBINST  :=$(USERHOME)/.refprop/lib
  HEADINST :=$(USERHOME)/.refprop/include
  FILINST  :=$(USERHOME)/.refprop
endif

USEOPENMP  :=TRUE # TRUE or FALSE


###########################################################
# ============================================================================
# No more customisation should be needed below this line
# ============================================================================
###########################################################

LIBS       =-l$(THENAME)# -lPocoFoundation
# Disable optimisation for now, this should be removed again
OPTFLAGS   =-O3 -ffast-math# -ffloat-store # optimisation, remove for debugging
###########################################################
#  Change these lines if you are using a different Fortran 
#  compiler or if you would like to use other flags. 
###########################################################
FEXT       =.f
FC         =gfortran
ifeq ($(USEOPENMP), TRUE)
FFLAGS     =$(ARCHFLAG) $(OPTFLAGS) -fPIC -fopenmp# -Wall -pedantic# -fno-underscoring
else
FFLAGS     =$(ARCHFLAG) $(OPTFLAGS) -fPIC #-fopenmp# -Wall -pedantic# -fno-underscoring
endif

###########################################################
#  Change these lines if you are using a different C++ 
#  compiler or if you would like to use other flags. 
###########################################################
CPPC       =g++
CPPFLAGS   =$(ARCHFLAG) $(OPTFLAGS) -Wall -pedantic -fbounds-check -ansi -Wpadded -Wpacked -mpreferred-stack-boundary=8

###########################################################
#  Change these lines if you are using a different C
#  compiler or if you would like to use other flags. 
###########################################################
CC         =gcc
CFLAGS     =$(ARCHFLAG) $(CPPFLAGS)

###########################################################
#  Change these lines if you have other needs regarding
#  the library file.  
###########################################################
LIBFILE   =PASS_FTN_ALT
ifeq ($(UNAME), Linux)
  LIBRARY   =lib$(THENAME)
  DYNAMICLIBRARYEXTENSION =.so
  LIBFLAGS                =-rdynamic -lc -shared -Wl,-soname,$(LIBRARY)$(DYNAMICLIBRARYEXTENSION).$(MAJORVERSION)
else ifeq ($(UNAME), Darwin)
  LIBRARY   =lib$(THENAME)
  DYNAMICLIBRARYEXTENSION =.dylib
  LIBFLAGS                =-dynamiclib -static -o $(BINDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) -Wl,-headerpad_max_install_names,-undefined,dynamic_lookup,-compatibility_version,$(MAJORVERSION).$(MINORVERSION),-current_version,$(MAJORVERSION).$(MINORVERSION),-install_name,$(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(DYNAMICLIBRARYEXTENSION) -lgfortran -lm -lgomp
  #LIBFLAGS                =-static -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) -install_name $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) -current_version $(MAJORVERSION) -compatibility_version $(MAJORVERSION) $(FLINKFLAGS)
  #LIBFLAGS                =-dynamic -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) -install_name $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION) -current_version $(MAJORVERSION) -compatibility_version $(MAJORVERSION) $(FLINKFLAGS)
  #LINKCOMM                = libtool $(LIBFLAGS) $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
else 
  LIBRARY   =$(THENAME)
  DYNAMICLIBRARYEXTENSION =.dll
  LIBFLAGS                =-shared -Wl,-soname,$(LIBRARY)$(DYNAMICLIBRARYEXTENSION).$(MAJORVERSION)
endif
LIBRARYEXTENSION =$(DYNAMICLIBRARYEXTENSION)
LINKCOMM         =$(FC) $(LIBFLAGS) $(FFLAGS) -o $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
HEADEREXTENSION  =.h
HEADERFILE       =$(THENAME)_lib$(HEADEREXTENSION)
SRCHEADERFILE    =$(HEADIR)/REFPROP_lib.h
BINHEADERFILE    =$(BINDIR)/$(HEADERFILE)
INSTHEADERFILE   =$(HEADINST)/$(HEADERFILE)
#
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
#  Set the default goal.
###########################################################
.DEFAULT_GOAL := all
.PHONY        : all
all           : header library

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
	$(MV) $(BINHEADERFILE) $(INSTHEADERFILE)
	$(CP) $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(CH) $(CMF) $(INSTHEADERFILE) 
	$(CH) $(CMF) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION).$(MINORVERSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION).$(MAJORVERSION)                 $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)                                 $(FILINST)/$(LIBRARY)$(LIBRARYEXTENSION)
ifeq ($(USERNAME),root)
	$(LD)
else 
	@echo "------------------ IMPORTANT NOTICE ------------------"
	@echo "You are not root:"
	# This code exports the path for the next command: 
	export LD_LIBRARY_PATH=$(LIBINST)
	# Remember to preceed all your commands with it to use the locally installed library.
endif

.PHONY        : install-mac
install-mac   : header library install-fluids
	install -d -m $(CMG) -o root -g admin $(HEADINST) $(LIBINST)
	install -m $(CMF) -o root -g admin $(BINHEADERFILE) $(INSTHEADERFILE)
	install -m $(CMF) -o root -g admin $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION)      $(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY).$(MAJORVERSION).$(MINORVERSION)$(LIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	$(LN) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)                                 $(FILINST)/$(LIBRARY)$(LIBRARYEXTENSION)
	
.PHONY       : install-fluids
install-fluids :
	$(MK) $(FILINST)
	$(CP) -r $(FILDIR)/* $(FILINST)
	$(CH) $(CMD) $(FILINST) $(FILINST)/fluids $(FILINST)/mixtures
	$(CH) $(CMF) $(FILINST)/fluids/* $(FILINST)/mixtures/*

.PHONY       : uninstall
uninstall    : 
	$(RM) $(INSTHEADERFILE)
	$(RM) $(LIBINST)/$(LIBRARY)$(LIBRARYEXTENSION)*
	$(RM) -r $(FILINST)

###########################################################
#  Compile the Fortran sources into a library file that can 
#  be used as a shared object.
###########################################################
.PHONY     : header
header     : $(BINHEADERFILE)

.PHONY     : library
library    : $(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) 

$(BINDIR)/$(LIBRARY)$(LIBRARYEXTENSION) : $(SRCDIR)/$(LIBFILE).o $(LIBOBJECTFILES)
	$(MK) $(BINDIR)
	$(LINKCOMM)

$(SRCDIR)/$(LIBFILE)$(FEXT): $(LIBDIR)/PASS_FTN.FOR $(LIBDIR)/COMMONS$(FEXT) $(LIBDIR)/COMTRN$(FEXT)
	$(SE) 's/dll_export/!dll_export/g' $(LIBDIR)/PASS_FTN.FOR > $(SRCDIR)/$(LIBFILE)$(FEXT)
	$(CA) $(SRCDIR)/$(LIBFILE).FOR.tpl >> $(SRCDIR)/$(LIBFILE)$(FEXT)
	$(SE) -i.du "s/'commons.for'/'COMMONS$(FEXT)'/" $(SRCDIR)/$(LIBFILE)$(FEXT)
	$(SE) -i.du "s/'comtrn.for'/'COMTRN$(FEXT)'/" $(SRCDIR)/$(LIBFILE)$(FEXT)

###########################################################
#  Automate the integration with Matlab. This is a work in 
#  progress and there are still some pitfalls...
#  However, contributions from nkampy and speredenn helped
#  a lot!
###########################################################
URL_NIST :=http://www.boulder.nist.gov/div838/theory/refprop/LINKING
FIL_RPMM :=refpropm.m
FIL_PR32 :=rp_proto.m
FIL_PR64 :=rp_proto64.m

.PHONY     : matlab
ifeq ($(ARCH), 32)
matlab     : header $(MATDIR)/refpropm.m $(MATDIR)/rp_proto.m
else
  ifeq ($(ARCH), 64)
matlab     : header $(MATDIR)/refpropm.m $(MATDIR)/rp_proto64.m
  endif
endif
	($(CD) $(MATDIR); ./fixfiles.sh)


.PHONY     : matlab-install
ifeq ($(ARCH), 32)
matlab-install   : matlab-install32 
else
  ifeq ($(ARCH), 64)
matlab-install   : matlab-install64
  endif
endif
ifeq ($(UNAME), Linux)
	$(CH) $(FILINST)/*.m $(FILINST)/*.so
endif
ifeq ($(UNAME), Darwin)
	$(CH) $(FILINST)/*.m $(FILINST)/*.dylib
endif
	@echo " "
	@echo " "
	@echo "Remember to run something like 'addpath('$(FILINST)')';"
	@echo "from within Matlab to complete the Matlab integration."


.PHONY           : matlab-install32
matlab-install32 : header library $(MATDIR)/refpropm.m $(MATDIR)/rp_proto.m
	$(MV) $(MATDIR)/refpropm.m $(MATDIR)/rp_proto.m $(FILINST)

.PHONY           : matlab-install64
matlab-install64 : header library $(MATDIR)/refpropm.m $(MATDIR)/rp_proto64.m
	$(MV) $(MATDIR)/refpropm.m $(MATDIR)/rp_proto64.m $(FILINST)
ifeq ($(UNAME), Linux)
	$(MV) $(MATDIR)/librefprop_thunk_glnxa64.so $(FILINST)
endif
ifeq ($(UNAME), Darwin)
	$(MV) $(MATDIR)/librefprop_thunk_maci64.dylib $(FILINST)
endif

$(MATDIR)/%.m: $(MATDIR)/%.m.org
	$(CP) $(MATDIR)/$*.m.org $(MATDIR)/$*.m

$(MATDIR)/%.m.org: 
	$(CU) $(URL_NIST)/$*.m > $(MATDIR)/$*.m.org


###########################################################
#  General rulesets for compilation.
###########################################################
#$(BINDIR)/%$(HEADEREXTENSION): $(SRCDIR)/%$(HEADEREXTENSION)
#	$(MK) $(BINDIR)
#	$(CP) $< $@

$(BINHEADERFILE): $(SRCHEADERFILE)
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
	$(RM) **.o **.so **.a **.dylib **.mod $(BINDIR)/* $(SRCDIR)/*.o $(LIBDIR)/*$(FEXT) $(LIBDIR)/*$(FEXT).du $(LIBDIR)/*.o $(SRCDIR)/$(LIBFILE)$(FEXT) $(SRCDIR)/$(LIBFILE)$(FEXT).du $(MATDIR)/r*.m* $(MATDIR)/*.so

###########################################################
#  Compile a simple example to illustrate the connection
#  between C++ and Fortran as well as the usage of the 
#  created library.
###########################################################
.PHONY            : test
test              : cpptest fortest

.PHONY            : cpptest
cpptest           : $(BINDIR)/cpptest
$(BINDIR)/cpptest : $(HEADIR)/main.cpp
	$(CPPC) $(CPPFLAGS) -g -o $<.o -c $<
	$(CPPC) $(CPPFLAGS) -g -o $@ $<.o -L$(BINDIR) $(LIBS) -lgfortran

.PHONY            : fortest
fortest           : $(BINDIR)/fortest
$(BINDIR)/fortest : $(SRCDIR)/ex_mix.for
	$(FC) $(FFLAGS)     -g -o $<.o -c $<
	$(FC) $(FLINKFLAGS) -g -o $@ $<.o -L$(BINDIR) $(LIBS)
	
.PHONY           : print-flags
print-flags      :
	@echo "LINKCOMM: $(LINKCOMM)\n"
	@echo "LIB     : $(SRCDIR)/$(LIBFILE)$(FEXT)\n"
	@echo "USERNAME: $(USERNAME)\n"
	@echo "USERHOME: $(USERHOME)\n"
	@echo "ARCH    : $(ARCH)\n"
