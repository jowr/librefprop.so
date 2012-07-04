within MediaTwoPhaseMixture.REFPROPMedium;
function specificEntropy_ThX
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Temperature T;
  input Modelica.SIunits.SpecificEnthalpy h;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
//  input String fluidnames;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
/*protected 
   Real[14+2*nX] props;
   String errormsg=StrJoin(fill("xxxx",10),"");*/
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEntropy_ThX("+String(T)+","+String(h)+",X)");
  end if;
    s:=getProp_REFPROP_check("s", "Th",T,h,X,phase);
  annotation(LateInline=true,inverse(h = specificEnthalpy_TsX(T,s,X,phase),
                                     T=temperature_hsX(h,s,X,phase)));
end specificEntropy_ThX;
