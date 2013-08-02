
#Welcome to librefprop.so!
These files allow you to compile the Refprop fluid property database as a shared library for Linux and MacOS systems. This enables you to use the Fortran sources developed by NIST providing an alternative to the refprop.dll for Windows. 

*Be careful, the library does not run reliably on OSX and should not be used for real work!*

## Installation Instructions
For installation on a Linux or OSX machine, please follow the steps described below. By default, the library and the header file are placed in system directories. Please change the paths if you do not have write access to this part of your file system. 

0.  Make sure that you have gcc, for OSX use [HPC](http://hpc.sourceforge.net/) and install the [OSX command line tools](https://developer.apple.com/downloads).
1.  Change the paths in the Makefile, if needed.
2.  Copy the Refprop Fortran code to the *fortran* directory.
3.  Put the *fluids* and *mixtures* folders from Refprop into the *files* folder.
4.  Call `make header library` to prepare the files. 
5.  Use `make install` (as root user) to copy the files to the destination directories.

You can remove the files again by calling `make uninstall` (as root user). 

## Testing the Installation
Please be aware that you need a copy of the *Poco* framework to compile the C++ test files yourself. You can find it at: http://pocoproject.org/ or check the software package manager of your distribution for it. Afterwards you can call `make cpptest` and run the executable with `./bin/ex_mix_cpp </path/to/fluid/files>`

## Python Integration
There is a basic python package based on the examples from
[NIST](http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.htm#PythonApplications "NIST homepage")
in the `pyrp` folder. 

Please note that there is a much more mature Python interface available at https://github.com/BenThelen/python-refprop. Thank you Ben for sharing it!

## General Remarks
Please note that you need a working and licensed copy of Refprop in order to use the software provided here. This is not a replacement for Refprop. You can purchase Refprop at http://www.nist.gov/srd/nist23.cfm
