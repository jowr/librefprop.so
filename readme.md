
#Welcome to librefprop.so!
These files allow you to access the Refprop fluid property database from Linux software. It anables you to create a shared library from the Fortran sources provided by NIST. This project provides an alternative to the refprop.dll that comes with the software.

Please be aware that you might need a copy of the Poco C++ framework to compile the C++ test files yourself. You can find it at: http://pocoproject.org/. However, you do not need Poco to compile your own version of the refprop library. 

## Installation Instructions
For installing on a Linux machine, please follow the two simple step described below. By default the library and the header file are placed in system directories. Please change the paths if you do not have write access to this part of your system. 

0.  Change the paths in the Makefile, if needed.
1.  Call "make header library" to prepare the files and finally 
2.  call "sudo make install" to copy the files to the right directories. 

## General Remarks
Please note that you need a working and licensed copy of Refprop in order to use the software provided here. This is not a replacement for Refprop. You can purchase Refprop at http://www.nist.gov/srd/nist23.cfm

