within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function temperature_hsX "calls REFPROP-Wrapper, returns temperature"
extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Temperature T;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running temperature_hsX("+String(h)+","+String(s)+",X)");
  end if;
  T :=getProp_REFPROP_check("T", "hs", fluidnames,h,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_ThX(T,h,X,phase),
                                     h=specificEnthalpy_TsX(T,s,X,phase)));
end temperature_hsX;
