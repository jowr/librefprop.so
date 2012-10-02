
#Welcome to REFPROP2Modelica!
This piece of software enables the user to access the Refprop fluid property database from within Modelica. The aim is to develop wrapper classes and integrate them with the "Media" framework inside Modelica. It has only been tested with Dymola sofar. 

Please be aware that you might need a copy of the Poco C++ framework to compile the wrapper files yourself. You can find it at: http://pocoproject.org/. The general idea is to use this framework to implement platform independent library loading and caching, but it is still a long way to go. 

## Installation Instructions

### Windows
For Windows, please follow these instructions

1.  After downloading and unzipping rename folder containing these files to "MediaTwoPhaseMixture".
2.  Copy \_REFPROP-Wrapper\Version x.x\REFPROP_WRAPPER.LIB to %DYMOLADIR%\\BIN\\LIB\ (%DYMOLADIR% is DYMOLA's program directory)
3.  Copy \_REFPROP-Wrapper\Version x.x\REFPROP_WRAPPER.H to %DYMOLADIR%\\SOURCE\\
4.  Set the path to the REFPROP program directory with the constant String REFPROP_PATH (at the beginning of the package). Make sure you mask the backslashes. It should look something like: constant String REFPROP_PATH = "C:\\Program Files\\REFPROP\\";

### Linux
For installing on a Linux machine, please follow the instructions in the Makefile provided in the directory containing the Linux version of the wrapper class. You only have to type in the right directories and install all the compilers / libraries required. 

1.  After downloading and unzipping rename folder containing these files to "MediaTwoPhaseMixture".
2.  Change the paths in _REFPROP-Wrapper/Version x.x_linux/Makefile to your needs.
3.  Call "make libheader library" and "sudo make installlib" to compile and install refprop.
4.  Call "make wrapheader wrapper" and "sudo make installwrap" as well as "sudo make fixit" to compile and install the wrapper.
5.  Set the path to the REFPROP program directory with the constant String REFPROP_PATH (at the beginning of the package). It should look something like: constant String REFPROP_PATH = "/home/user/Refprop/"; 

## General Remarks
Please note that you need a working and licensed copy of Refprop in order to use the software provided here. This is not a replacement for Refprop.