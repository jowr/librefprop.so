
#Welcome to librefprop.so!
These files allow you to compile the Refprop fluid property database as a shared library for Linux systems. This enables you to use the Fortran sources developed by NIST providing an alternative to the refprop.dll. 

## Installation Instructions
For installation on a Linux machine, please follow the steps described below. By default, the library and the header file are placed in system directories. Please change the paths if you do not have write access to this part of your file system. 

1.  Change the paths in the Makefile, if needed.
2.  Copy the Refprop Fortran code to the *fortran* directory.
3.  Call `make header library` to prepare the files. 
4.  Use `make install` (as root user) to copy the files to the destination directories.

You can remove the files again by calling `make uninstall` (as root user). 

## Testing the Installation
Please be aware that you need a copy of the *Poco* framework to compile the C++ test files yourself. You can find it at: http://pocoproject.org/ or check the software package manager of your distribution for it. Afterwards you can call `make cpptest` and run the executable with `./bin/ex_mix_cpp </path/to/fluid/files>`

## General Remarks
Please note that you need a working and licensed copy of Refprop in order to use the software provided here. This is not a replacement for Refprop. You can purchase Refprop at http://www.nist.gov/srd/nist23.cfm
