within MediaTwoPhaseMixture.REFPROPMedium;
function getProp_REFPROP
  "calls C function with property identifier & returns single property"
    input String what2calc;
    input String statevars;
    input String fluidnames;
    input Real[:] props;
    input Real statevar1;
    input Real statevar2;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    input String errormsg;
    output Real val;

/*  //  external "C" rho=density(fluidnames, p,T, "d:\\Programme\\REFPROP\\");
 //    external "C" rho = density(fluidnames, p,T, X, "d:\\Programme\\REFPROP\\");

 /*  Modelica.SIunits.MoleFraction[:] Y=MassFraction2MoleFraction(X,MM);* /
 external "C" d = density(fluidnames, p,T, X, REFPROP_PATH);
  annotation (Include="#include <refprop_density_mix.h>", Library="REFPROP_density_mix");
*/
   external "C" val = props_REFPROP(what2calc, statevars, fluidnames, props, statevar1, statevar2, X, phase, REFPROP_PATH, errormsg);

annotation (Include="#include <refprop_wrapper.h>", Library="REFPROP_wrapper");
end getProp_REFPROP;
