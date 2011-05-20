within MediaTwoPhaseMixture.REFPROPMedium;
function getSatProp_REFPROP
  "calls C function with property identifier & returns single property"
   input String what2calc;
   input String statevar;
   input String fluidnames;
   input Real[:] props;
   input Real statevarval;
   input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
   input String errormsg;
   output Real val;

 external "C" val = satprops_REFPROP(what2calc, statevar, fluidnames, props, statevarval, X, REFPROP_PATH, errormsg);

 annotation (Include="#include <refprop_wrapper.h>", Library="REFPROP_wrapper");
end getSatProp_REFPROP;
