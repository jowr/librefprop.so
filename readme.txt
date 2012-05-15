1. After downloading and unzipping rename folder containing these files to "MediaTwoPhaseMixture".
2. Copy \_REFPROP-Wrapper\Version x.x\REFPROP_WRAPPER.LIB to %DYMOLADIR%\\BIN\\LIB\ (%DYMOLADIR% is DYMOLA's program directory)
3. Copy \_REFPROP-Wrapper\Version x.x\REFPROP_WRAPPER.H to %DYMOLADIR%\\SOURCE\\
4. Set the path to the REFPROP program directory with the constant String REFPROP_PATH (at the beginning of the package).
   Make sure you mask the backslashes. It should look something like
   <pre>constant String REFPROP_PATH = "C:\\Program Files\\REFPROP\\\";
