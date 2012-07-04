within MediaTwoPhaseMixture.REFPROPMedium;
function getSatProp_REFPROP_check
  "wrapper for getSatProp_REFPROP returning 1 property value with error check"
  extends partialREFPROP;
   input String what2calc;
   input String statevar;
//   input String fluidnames;
   input Real statevarval;
   input MassFraction X[:] "mass fraction m_NaCl/m_Sol";
   output Real val;
algorithm
   assert(size(X,1)>0,"The mass fraction vector must have at least 1 element.");
   val :=getSatProp_REFPROP(what2calc,statevar,fluidnames,props,statevarval,X,errormsg)
    "just passing through";
//Error string decoding in wrapper-c-function
   assert(props[1]==0 or props[1]==141,"Errorcode "+String(props[1])+" in REFPROP wrapper function:\n"+errormsg +"\n");
  if props[1]==141 then
    Modelica.Utilities.Streams.print("Saturation properties cannot be calculated, because P > p_crit!...");
    val :=-999;
  end if;
end getSatProp_REFPROP_check;
