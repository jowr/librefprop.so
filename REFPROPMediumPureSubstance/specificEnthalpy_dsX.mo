within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function specificEnthalpy_dsX
  "calls REFPROP-Wrapper, returns specific enthalpy"
  //does not extend existing function from PartialMedium because there the algorithm is already defined
  extends Modelica.Icons.Function;
    input Modelica.SIunits.Density d;
    input Modelica.SIunits.SpecificEntropy s;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
//  input String fluidnames;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEnthalpy h;
/*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEnthalpy_dsX("+String(d)+","+String(s)+",X)");
  end if;
    h :=getProp_REFPROP_check("h", "ds", fluidnames,d,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_hdX(h,d,X,phase),
                                     d=density_hsX(h,s,X,phase)));
end specificEnthalpy_dsX;
