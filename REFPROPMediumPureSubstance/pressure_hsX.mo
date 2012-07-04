within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function pressure_hsX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_hsX("+String(h)+","+String(s)+",X)");
  end if;
    p :=getProp_REFPROP_check("p", "hs",h,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_phX(p,h,X,phase),
                                     h=specificEnthalpy_psX(p,s,X,phase)));
end pressure_hsX;
