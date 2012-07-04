within MediaTwoPhaseMixture.REFPROPMedium;
function getProp_REFPROP_check
  "wrapper for getProp_REFPROP returning 1 property value with error check"
  extends partialREFPROP;
    input String what2calc;
    input String statevars;
//    input String fluidnames;
    input Real statevar1;
    input Real statevar2;
    input MassFraction X[:] "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
    output Real val;
algorithm
   assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");

//   Modelica.Utilities.Streams.print("Calc "+what2calc);
   val :=getProp_REFPROP(what2calc,statevars,fluidnames,props,statevar1,statevar2,X,phase,errormsg)
    "just passing through";

//   Modelica.Utilities.Streams.print("ERR("+String(props[1])+"):"+errormsg);
   assert(props[1]==0,"Errorcode "+String(props[1])+" in REFPROP wrapper function:\n"+errormsg +"\n");

end getProp_REFPROP_check;
