#!/bin/bash
#
function fixdll {
  sed -i.du 's/RPVersion/rpversion_/g' "$1"
  sed -i.du 's/SETPATHdll/setpathdll_/g' "$1"
  sed -i.du 's/ABFL1dll/abfl1dll_/g' "$1"
  sed -i.du 's/ABFL2dll/abfl2dll_/g' "$1"
  sed -i.du 's/ACTVYdll/actvydll_/g' "$1"
  sed -i.du 's/AGdll/agdll_/g' "$1"
  sed -i.du 's/CCRITdll/ccritdll_/g' "$1"
  sed -i.du 's/CP0dll/cp0dll_/g' "$1"
  sed -i.du 's/CRITPdll/critpdll_/g' "$1"
  sed -i.du 's/CSATKdll/csatkdll_/g' "$1"
  sed -i.du 's/CV2PKdll/cv2pkdll_/g' "$1"
  sed -i.du 's/CVCPKdll/cvcpkdll_/g' "$1"
  sed -i.du 's/CVCPdll/cvcpdll_/g' "$1"
  sed -i.du 's/DBDTdll/dbdtdll_/g' "$1"
  sed -i.du 's/DBFL1dll/dbfl1dll_/g' "$1"
  sed -i.du 's/DBFL2dll/dbfl2dll_/g' "$1"
  sed -i.du 's/DDDPdll/dddpdll_/g' "$1"
  sed -i.du 's/DDDTdll/dddtdll_/g' "$1"
  sed -i.du 's/DEFLSHdll/deflshdll_/g' "$1"
  sed -i.du 's/DHD1dll/dhd1dll_/g' "$1"
  sed -i.du 's/DHFL1dll/dhfl1dll_/g' "$1"
  sed -i.du 's/DHFL2dll/dhfl2dll_/g' "$1"
  sed -i.du 's/DHFLSHdll/dhflshdll_/g' "$1"
  sed -i.du 's/DIELECdll/dielecdll_/g' "$1"
  sed -i.du 's/DOTFILLdll/dotfilldll_/g' "$1"
  sed -i.du 's/DPDD2dll/dpdd2dll_/g' "$1"
  sed -i.du 's/DPDDKdll/dpddkdll_/g' "$1"
  sed -i.du 's/DPDDdll/dpdddll_/g' "$1"
  sed -i.du 's/DPDTKdll/dpdtkdll_/g' "$1"
  sed -i.du 's/DPDTdll/dpdtdll_/g' "$1"
  sed -i.du 's/DPTSATKdll/dptsatkdll_/g' "$1"
  sed -i.du 's/DSFLSHdll/dsflshdll_/g' "$1"
  sed -i.du 's/DSFL1dll/dsfl1dll_/g' "$1"
  sed -i.du 's/DSFL2dll/dsfl2dll_/g' "$1"
  sed -i.du 's/ENTHALdll/enthaldll_/g' "$1"
  sed -i.du 's/ENTROdll/entrodll_/g' "$1"
  sed -i.du 's/ESFLSHdll/esflshdll_/g' "$1"
  sed -i.du 's/FGCTYdll/fgctydll_/g' "$1"
  sed -i.du 's/FPVdll/fpvdll_/g' "$1"
  sed -i.du 's/GERG04dll/gerg04dll_/g' "$1"
  sed -i.du 's/GETFIJdll/getfijdll_/g' "$1"
  sed -i.du 's/GETKTVdll/getktvdll_/g' "$1"
  sed -i.du 's/GIBBSdll/gibbsdll_/g' "$1"
  sed -i.du 's/HSFLSHdll/hsflshdll_/g' "$1"
  sed -i.du 's/INFOdll/infodll_/g' "$1"
  sed -i.du 's/LIMITKdll/limitkdll_/g' "$1"
  sed -i.du 's/LIMITSdll/limitsdll_/g' "$1"
  sed -i.du 's/LIMITXdll/limitxdll_/g' "$1"
  sed -i.du 's/MELTPdll/meltpdll_/g' "$1"
  sed -i.du 's/MELTTdll/melttdll_/g' "$1"
  sed -i.du 's/MLTH2Odll/mlth2odll_/g' "$1"
  sed -i.du 's/NAMEdll/namedll_/g' "$1"
  sed -i.du 's/PDFL1dll/pdfl1dll_/g' "$1"
  sed -i.du 's/PDFLSHdll/pdflshdll_/g' "$1"
  sed -i.du 's/PEFLSHdll/peflshdll_/g' "$1"
  sed -i.du 's/PHFL1dll/phfl1dll_/g' "$1"
  sed -i.du 's/PHFLSHdll/phflshdll_/g' "$1"
  sed -i.du 's/PQFLSHdll/pqflshdll_/g' "$1"
  sed -i.du 's/PREOSdll/preosdll_/g' "$1"
  sed -i.du 's/PRESSdll/pressdll_/g' "$1"
  sed -i.du 's/PSFL1dll/psfl1dll_/g' "$1"
  sed -i.du 's/PSFLSHdll/psflshdll_/g' "$1"
  sed -i.du 's/PUREFLDdll/pureflddll_/g' "$1"
  sed -i.du 's/QMASSdll/qmassdll_/g' "$1"
  sed -i.du 's/QMOLEdll/qmoledll_/g' "$1"
  sed -i.du 's/SATDdll/satddll_/g' "$1"
  sed -i.du 's/SATEdll/satedll_/g' "$1"
  sed -i.du 's/SATHdll/sathdll_/g' "$1"
  sed -i.du 's/SATPdll/satpdll_/g' "$1"
  sed -i.du 's/SATSdll/satsdll_/g' "$1"
  sed -i.du 's/SATSPLNdll/satsplndll_/g' "$1"
  sed -i.du 's/SATTdll/sattdll_/g' "$1"
  sed -i.du 's/SETAGAdll/setagadll_/g' "$1"
  sed -i.du 's/SETKTVdll/setktvdll_/g' "$1"
  sed -i.du 's/SETMIXdll/setmixdll_/g' "$1"
  sed -i.du 's/SETMODdll/setmoddll_/g' "$1"
  sed -i.du 's/SETREFdll/setrefdll_/g' "$1"
  sed -i.du 's/SETUPdll/setupdll_/g' "$1"
  sed -i.du 's/SUBLPdll/sublpdll_/g' "$1"
  sed -i.du 's/SUBLTdll/subltdll_/g' "$1"
  sed -i.du 's/SURFTdll/surftdll_/g' "$1"
  sed -i.du 's/SURTENdll/surtendll_/g' "$1"
  sed -i.du 's/TDFLSHdll/tdflshdll_/g' "$1"
  sed -i.du 's/TEFLSHdll/teflshdll_/g' "$1"
  sed -i.du 's/THERM0dll/therm0dll_/g' "$1"
  sed -i.du 's/THERM2dll/therm2dll_/g' "$1"
  sed -i.du 's/THERM3dll/therm3dll_/g' "$1"
  sed -i.du 's/THERMdll/thermdll_/g' "$1"
  sed -i.du 's/THFLSHdll/thflshdll_/g' "$1"
  sed -i.du 's/TPFLSHdll/tpflshdll_/g' "$1"
  sed -i.du 's/TPFL2dll/tpfl2dll_/g' "$1"
  sed -i.du 's/TPRHOdll/tprhodll_/g' "$1"
  sed -i.du 's/TQFLSHdll/tqflshdll_/g' "$1"
  sed -i.du 's/TRNPRPdll/trnprpdll_/g' "$1"
  sed -i.du 's/TSFLSHdll/tsflshdll_/g' "$1"
  sed -i.du 's/VIRBdll/virbdll_/g' "$1"
  sed -i.du 's/VIRCdll/vircdll_/g' "$1"
  sed -i.du 's/WMOLdll/wmoldll_/g' "$1"
  sed -i.du 's/XMASSdll/xmassdll_/g' "$1"
  sed -i.du 's/XMOLEdll/xmoledll_/g' "$1" 
  rm "$1.du"
}
#
function fixcall {
  sed -i.du 's/stdcall/cdecl/g' "$1" 
  rm "$1.du"
}
function fixcall2 {
  sed -i.du 's/\ __cdecl\ /\ /g' "$1"
  rm "$1.du"
}
#
function fixlast {
  sed -i.du 's/UNsetagadll_/unsetagadll_/g' "$1"
  sed -i.du 's/SETNCdll/setncdll_/g' "$1"
  sed -i.du 's/RESIDUALdll/residualdll_/g' "$1"
  sed -i.du 's/VIRBAdll/virbadll_/g' "$1"
  sed -i.du 's/VIRCAdll/vircadll_/g' "$1"
  sed -i.du 's/B12dll/b12dll_/g' "$1"
  sed -i.du 's/FGCTY2dll/fgcty2dll_/g' "$1"
  sed -i.du 's/FUGCOFdll/fugcofdll_/g' "$1"
  sed -i.du 's/CHEMPOTdll/chempotdll_/g' "$1"
  sed -i.du 's/EXCESSdll/excessdll_/g' "$1"
  sed -i.du 's/SATTPdll/sattpdll_/g' "$1"
  sed -i.du 's/PSATKdll/psatkdll_/g' "$1"
  sed -i.du 's/DLSATKdll/dlsatkdll_/g' "$1"
  sed -i.du 's/DVSATKdll/dvsatkdll_/g' "$1"
  sed -i.du 's/HEATdll/heatdll_/g' "$1"
  sed -i.du 's/CSTARdll/cstardll_/g' "$1"
  rm "$1.du"
}
#
function fixpath {
  #sed -i.du 's/\/usr\/local\/REFPROP\//\/opt\/refprop\//g' "$1"
  #sed -i.du 's/FLUIDS\//fluids\//g' "$1"
  #rm "$1.du"
  #sed -i.du '/\/usr\/local\/REFPROP\//c\This line is removed by the admin.' "$1"
  #rm "$1.du"
  echo "################################################"
  echo "Integrating Matlab and Refprop"
  echo "################################################"
  echo "Unfortunately, there is still some manual work "
  echo "to be done. Please follow the intructions below "
  echo "to complete the installation."
  echo " "
  echo " "
  echo " 1) Find the line (around line 194): "
  echo "    case {'GLNXA64', 'GLNX86', 'MACI', 'MACI64', 'SOL64'}"
  echo "    in $1 and replace the whole case statement (3 lines) with:"
  echo " "
  echo "        case {'GLNX86', 'MACI'}"
  echo "            dllName = 'librefprop.so';"
  echo "            BasePath = '/opt/refprop';"
  echo "            FluidDir = 'fluids/';"
  echo "        case {'GLNXA64', 'MACI64', 'SOL64'}"
  echo "            dllName = 'librefprop.so';"
  echo "            BasePath = '/opt/refprop';"
  echo "            FluidDir = 'fluids/';"
  echo "            prototype = @() rp_proto64(BasePath);"
  echo " "
  echo "    save the file and proceed by pressing ENTER."
  read dummy 
}

function fixpath64 {
  cp rp_proto64.m rp_proto64.m.tmp
  echo " "
  echo " "
  echo " 2) Open Matlab, change to the 'matlab' directory and run \"run('thunk.m');\", "
  echo "    proceed to step 3 by pressing ENTER."
  read dummy 
  mv rp_proto64.m rp_proto64.m.thunk
  mv rp_proto64.m.tmp rp_proto64.m
  sed -i.du 's/REFPRP64_thunk_pcwin64/librefprop_thunk_glnxa64/g' rp_proto64.m
}

#
# Test if the files have been added to the current folder
function test_if_file_exists {
  if [ ! -f $1 ]; then
    echo "The file '$1' needs to be copied in the current directory. Please copy it first."
    exit 0
  fi
}

function backup_file {
  if [ ! -f $1.org ]; then
    test_if_file_exists $1
    cp $1 $1.org
  else
    cp $1.org $1
  fi
}

FILE="refpropm.m"
backup_file "$FILE"
fixdll "$FILE" 
fixpath "$FILE" 
#
case $(getconf LONG_BIT) in
  "32" )
    FILE="rp_proto.m"
    backup_file "$FILE"
    fixdll "$FILE" 
    fixcall "$FILE" 
    fixlast "$FILE"
    ;;
  "64" )
    FILE="rp_proto64.m"
    backup_file "$FILE"
    fixdll "$FILE"
    fixcall "$FILE"
    fixcall2 "$FILE"
    fixlast "$FILE" 
    # Rename functions in Header file
    # header file is used with thunk.m to generate the thunk dynamically shared library
    # file needed for 64 bit systems.
    FILE="header.h"
    fixdll "$FILE"
    fixcall "$FILE"
    fixcall2 "$FILE"
    fixlast "$FILE"
    # Finish the file changing
    fixpath64
    ;;
  * )
    echo "Your platform is not supported yet. Please report the issue."
    exit 0
esac
