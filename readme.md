#Welcome to librefprop.so!
These files allow you to compile the Refprop fluid property database as a shared library for Linux and MacOS systems. This enables you to use the Fortran sources developed by NIST providing an alternative to the refprop.dll for Windows. 

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
There is a simple Fortran file to test the library. You can call `make fortest` and run the executable with `./bin/ex_mix_for` to display some R410 two-phase properties:

| Temperature | Pressure  | Density, liquid | Density, vapour |
|-------------|-----------|-----------------|-----------------|
| 300.0000    | 1740.5894 |   14.4550       |   0.9628        |
| 300.0000    | 1735.1589 |   14.2345       |   0.9603        |


## Python Integration
There is a basic python package based on the examples from
[NIST](http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.htm#PythonApplications "NIST homepage")
in the `pyrp` folder. 

Please note that there is a much more mature Python interface available at https://github.com/BenThelen/python-refprop. Thank you Ben for sharing it!

## Matlab Integration
There is a Matlab prototype file available from
[NIST](http://www.boulder.nist.gov/div838/theory/refprop/Frequently_asked_questions.htm#MatLabApplications "NIST homepage"). Unfortunately, you have to change a few things in order to use the 
library on MacOS and Linux. There is a shell script in the `matlab` folder that can do all the foot work for you. You only have
to put the files `refpropm.m`, `rp_proto64.m` and `rp_proto.m` into the `matlab` folder and run `fixfiles.sh`. Enjoy your new libray.

### MATLAB 64 bit Integration

Once you have ran fixfiles.sh on refpropm.m header.h and rp_proto64.m you need to make a few changes. First copy thunk.m and header.h to the install folder where the symbolic link to the dynamically shared library is and the fluid files are. This should be /opt/refprop if you didn't change the location. Next you need to use the chown command to change the owner of the folder refprop (or what ever folder your using if you didn't use opt/refprop). Now here is the hard part, you need to have matlab up and running with the MEX capablity for your platform and your version of matlab along with the correct version of gcc. If you have gotten this far, you need to run thunk.m which will take the header.h and the dynamically shared library and create a thunk library interface and a new rp_proto64 file. If this worked successfully (IE no matlab errors), view the open rp_proto64.m file and copy the file name of the thunk library found around line 10. close and delete /opt/refprop/rp_proto64.m or it will cause problems. Now go back to the renamed rp_proto64.m file in the matlab folder in this install package (IE librefprop.so-master/matlab/rp_proto64.m). Open it and change the name of the thunk file reference to the correct one that you copied before deleting the one in opt/refprop. Now you can move the files to your prefered location on the matlab path so that refprop can be called (or for simplicity just run from librefprop.so-master/matlab folder for now) The test.m is a simple code you can use to check if the intergration works. Congrats! Problems are likely to be encountered in setting up matlab with gcc to use the built in MEX functionality which is required for the load library command in the thunk.m file. I hope the user community comments help that I and others have left at the mathworks website.

## No root user access
It is possible to use the shared libraries without root access. However, you need to make sure that the libraries get found and it is recommended to add something like `export LD_LIBRARY_PATH=/scratch/USERNAME/lib:/scratch/USERNAME/refprop:$LD_LIBRARY_PATH` to the calls to executables that need Refprop. The makfile will print more instructions when running `make install` as a non-root user.



## General Remarks
Please note that you need a working and licensed copy of Refprop in order to use the software provided here. This is not a replacement for Refprop. You can purchase Refprop at http://www.nist.gov/srd/nist23.cfm
