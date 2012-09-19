# ============================================================================
# Name        : Makefile
# Author      : Jorrit Wronski (jowr@mek.dtu.dk) 
# Version     : 0.2
# Copyright   : Use and modify at your own risk.
# Description : Makefile for Refprop from Fortran and C++ tests.
# ============================================================================
# The installation procedure should be as follows:
# 1) make libheader library
# 2) sudo make installlib
# 3) make wrapheader wrapper
# 4) sudo make installwrap
# 5) sudo make fixit
# ============================================================================

# used for the output
THENAME    =refprop
THEWRAPPER =refprop_wrapper
THETEST    =refpropwrappertest

###########################################################
#  Setting the directories for library, header and 
#  binary files created in this makefile. 
###########################################################
LIBDIR     =/home/jowr/Documents/Fluids/refprop/v9.0
DYMDIR     =/opt/dymola
LIBINST    =$(DYMDIR)/bin/lib
HEADINST   =$(DYMDIR)/source
BINDIR     =.

###########################################################
#  Change these lines if you are using a different Fortran 
#  compiler or if you would like to use other flags. 
###########################################################
FC         =gfortran
FFLAGS     =-Wall -ff2c -pedantic -ffloat-store# -fbounds-check
FLINKFLAGS =$(FFLAGS)

###########################################################
#  Change these lines if you are using a different C++ 
#  compiler or if you would like to use other flags. 
###########################################################
CPPC       =g++
CPPFLAGS   =-O2 -Wall -pedantic -fbounds-check -ansi -Wpadded -Wpacked -malign-double -mpreferred-stack-boundary=8 

###########################################################
#  Change these lines if you have other needs regarding
#  the library file.  
###########################################################
LIBFLAGS   =-rdynamic -fPIC -shared
LIBRARY    =lib$(THENAME)
LIBFILE    =PASS_FTN_LIN
DYNAMICLIBRARYEXTENSION =.so
STATICLIBRARYEXTENSION  =.a
#ar -cvq $(LIBRARY)$(STATICLIBRARYEXTENSION) $(OBJECTFILES)
HEADERFILE              =lib$(THENAME)
HEADEREXTENSION         =.h
### List of files to compile
LIBOBJECTFILES = \
	$(LIBDIR)/fortran/SETUP.o \
	$(LIBDIR)/fortran/CORE_ANC.o \
	$(LIBDIR)/fortran/CORE_BWR.o \
	$(LIBDIR)/fortran/CORE_CPP.o \
	$(LIBDIR)/fortran/CORE_DE.o \
	$(LIBDIR)/fortran/CORE_ECS.o \
	$(LIBDIR)/fortran/CORE_FEQ.o \
	$(LIBDIR)/fortran/CORE_MLT.o \
	$(LIBDIR)/fortran/CORE_PH0.o \
	$(LIBDIR)/fortran/CORE_QUI.o \
	$(LIBDIR)/fortran/CORE_STN.o \
	$(LIBDIR)/fortran/CORE_PR.o \
	$(LIBDIR)/fortran/FLASH2.o \
	$(LIBDIR)/fortran/FLSH_SUB.o \
	$(LIBDIR)/fortran/IDEALGAS.o \
	$(LIBDIR)/fortran/MIX_AGA8.o \
	$(LIBDIR)/fortran/MIX_HMX.o \
	$(LIBDIR)/fortran/PROP_SUB.o \
	$(LIBDIR)/fortran/REALGAS.o \
	$(LIBDIR)/fortran/SAT_SUB.o \
	$(LIBDIR)/fortran/SETUP2.o \
	$(LIBDIR)/fortran/TRNS_ECS.o \
	$(LIBDIR)/fortran/TRNS_TCX.o \
	$(LIBDIR)/fortran/TRNS_VIS.o \
	$(LIBDIR)/fortran/TRNSP.o \
	$(LIBDIR)/fortran/UTILITY.o
	
###########################################################
#  Link all files to places recognised by the system.
###########################################################
.PHONY     : install
install    : installlib installwrap 
	
.PHONY     : installlib
installlib : libheader library
	ln -sf $(LIBDIR)/$(HEADERFILE)$(HEADEREXTENSION) $(HEADINST)/$(HEADERFILE)$(HEADEREXTENSION)
	ln -sf $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) $(LIBINST)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	ln -sf $(LIBDIR)/$(HEADERFILE)$(HEADEREXTENSION) /usr/include/$(HEADERFILE)$(HEADEREXTENSION)
	ln -sf $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) /usr/lib/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	
.PHONY     : installwrap
installwrap: wrapheader wrapper
	ln -sf $(LIBDIR)/$(THEWRAPPER)$(HEADEREXTENSION) $(HEADINST)/$(THEWRAPPER)$(HEADEREXTENSION)
	ln -sf $(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) $(LIBINST)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION)
	ln -sf $(LIBDIR)/$(THEWRAPPER)$(HEADEREXTENSION) /usr/include/$(THEWRAPPER)$(HEADEREXTENSION)
	ln -sf $(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) /usr/lib/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION)
	
.PHONY     : uninstall
uninstall  : 
	$(RM) $(HEADINST)/$(HEADERFILE)$(HEADEREXTENSION)
	$(RM) $(LIBINST)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	$(RM) /usr/include/$(HEADERFILE)$(HEADEREXTENSION)
	$(RM) /usr/lib/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	$(RM) $(HEADINST)/$(THEWRAPPER)$(HEADEREXTENSION)
	$(RM) $(LIBINST)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION)
	$(RM) /usr/include/$(THEWRAPPER)$(HEADEREXTENSION)
	$(RM) /usr/lib/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION)
	
.PHONY     : purge
purge      : 
	$(RM) $(LIBDIR)/$(HEADERFILE)$(HEADEREXTENSION)
	$(RM) $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	$(RM) $(LIBDIR)/$(THEWRAPPER)$(HEADEREXTENSION) 
	$(RM) $(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION)
	
.PHONY     : fixit
fixit      : install
	ln -sf $(LIBINST)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) $(LIBINST)/libREFPROP_wrapper$(DYNAMICLIBRARYEXTENSION)
	ln -sf /usr/lib/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) /usr/lib/libREFPROP_wrapper$(DYNAMICLIBRARYEXTENSION)

.PHONY     : unfixit
unfixit    : 
	$(RM) $(LIBINST)/libREFPROP_wrapper$(DYNAMICLIBRARYEXTENSION)
	$(RM) /usr/lib/libREFPROP_wrapper$(DYNAMICLIBRARYEXTENSION)

.PHONY     : removeall
removeall  : uninstall purge unfixit

#.PHONY     : all
#all        : install fixit

###########################################################
#  Compile the wrapper class and its tests.
###########################################################
.PHONY     : wrapheader
wrapheader : $(LIBDIR)/$(THEWRAPPER)$(HEADEREXTENSION)
$(LIBDIR)/$(THEWRAPPER)$(HEADEREXTENSION): $(THEWRAPPER)$(HEADEREXTENSION)
	cp $(THEWRAPPER)$(HEADEREXTENSION) $(LIBDIR)
	
.PHONY     : wrapper
wrapper    : $(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) 
$(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION): $(THEWRAPPER).o wrapheader libheader library
	$(FC) $(LIBFLAGS) $(FLINKFLAGS) -o $(LIBDIR)/lib$(THEWRAPPER)$(DYNAMICLIBRARYEXTENSION) $(THEWRAPPER).o -l$(THENAME)
	
.PHONY     : test
test       : $(THETEST)
$(THETEST) : $(THETEST).o wrapheader wrapper 
	$(FC) $(FLINKFLAGS) -o $(THETEST) $(THETEST).o -l$(THEWRAPPER)

###########################################################
#  Compile the Fortran sources into a library file that can 
#  be used as a shared object.
###########################################################
.PHONY     : libheader
libheader  : $(LIBDIR)/$(HEADERFILE)$(HEADEREXTENSION)
$(LIBDIR)/$(HEADERFILE)$(HEADEREXTENSION): src/$(HEADERFILE)$(HEADEREXTENSION)
	cp src/$(HEADERFILE)$(HEADEREXTENSION) $(LIBDIR)

.PHONY     : library
library    : $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) 
$(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION): src/$(LIBFILE).o $(LIBOBJECTFILES)
	$(FC) $(LIBFLAGS) $(FLINKFLAGS) -o $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION) src/$(LIBFILE).o $(LIBOBJECTFILES)
	
src/$(LIBFILE).FOR: $(LIBDIR)/fortran/PASS_FTN.FOR
	sed 's/dll_export/!dll_export/g' $(LIBDIR)/fortran/PASS_FTN.FOR > src/$(LIBFILE).FOR
	cat src/$(LIBFILE).FOR.tpl >> src/$(LIBFILE).FOR
	
#	sed -i 's/*10000/(10000)/g' src/$(LIBFILE).FOR
#	sed -i 's/*255/(255)/g' src/$(LIBFILE).FOR

$(LIBDIR)/fortran/%.o: $(LIBDIR)/fortran/%.FOR
	$(FC) $(FFLAGS) -o $(LIBDIR)/fortran/$*.o -c $<

###########################################################
#  General rulesets for compilation.
###########################################################
src/%.o    : src/%.FOR
	$(FC) $(FFLAGS) -o src/$*.o -c $<
	
src/%.o    : src/%.cpp
	$(CPPC) $(CPPFLAGS) -o src/$*.o -c $<

%.o        : %.FOR
	$(FC) $(FFLAGS) -o $*.o -c $<
	
%.o        : %.cpp
	$(CPPC) $(CPPFLAGS) -o $*.o -c $<

.PHONY: clean
clean:
	$(RM) **.o **.so **.mod $(BINDIR)/RP-ftn src/$(LIBFILE).FOR $(THETEST)

###########################################################
#  Compile a simple example to illustrate the connection
#  between C++ and Fortran as well as the usage of the 
#  created library with Fortran sources.
###########################################################
.PHONY     : RP-ftn
RP-ftn     : $(BINDIR)/RP-ftn
$(BINDIR)/RP-ftn : src/refprop-ftn.cpp libheader library 
	$(CPPC) $(CPPFLAGS) -o src/refprop-ftn.o -c src/refprop-ftn.cpp
	$(FC) $(FLINKFLAGS) -o $(BINDIR)/RP-ftn src/refprop-ftn.o -l$(THENAME)

.PHONY     : f2f
f2f        : $(BINDIR)/f2f
$(BINDIR)/f2f    : example/ex-mix.for $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)
	$(FC) $(FFLAGS) -o example/ex-mix.o -c example/ex-mix.for
	$(FC) $(FLINKFLAGS) -o $(BINDIR)/f2f example/ex-mix.o $(LIBDIR)/$(LIBRARY)$(DYNAMICLIBRARYEXTENSION)

.PHONY     : cpp2f
cpp2f      : $(BINDIR)/cpp2f
$(BINDIR)/cpp2f  : example/cpp2f.cpp example/easy_f.for
	$(FC) $(FFLAGS) -o example/easy_f.o -c example/easy_f.for
	$(CPPC) $(CPPFLAGS) -o example/cpp2f.o -c example/cpp2f.cpp
	$(FC) $(FLINKFLAGS) -o $(BINDIR)/cpp2f example/cpp2f.o example/easy_f.o
	
###########################################################
#  Create the documentation from annotations in the source
#  files with DOXYGEN, a configuration file is needed.
###########################################################
.PHONY     : doc
doc        : doc/Doxyfile
	doxygen doc/Doxyfile
	cd doc/latex ; \
	make all 
	