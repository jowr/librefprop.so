REM has to be run from Visual Express command line
cl /c REFPROP_wrapper.cpp
lib REFPROP_wrapper.obj
copy REFPROP_wrapper.lib "d:\Program Files (x86)\Dymola 7.4 FD01\bin\lib\"
copy refprop_wrapper.h "d:\Program Files (x86)\Dymola 7.4 FD01\Source\"