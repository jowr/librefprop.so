within MediaTwoPhaseMixture.REFPROPMedium;
function density_hsX "calls REFPROP-Wrapper, returns density"
extends Modelica.Icons.Function;
    input Modelica.SIunits.SpecificEnthalpy h;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Density d;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running density_hsX("+String(h)+","+String(s)+",X)");
  end if;
    d :=getProp_REFPROP_check("d", "hs",h,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_hdX(h,d,X,phase),
                                     h=specificEnthalpy_dsX(d,s,X,phase)));
end density_hsX;
