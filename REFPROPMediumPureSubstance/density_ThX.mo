within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function density_ThX "calls REFPROP-Wrapper, returns density"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEnthalpy h;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Density d;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running density_ThX("+String(T)+","+String(h)+",X)");
  end if;
    d :=getProp_REFPROP_check("d", "Th",T,h,X,phase);
  annotation(LateInline=true,inverse(h=specificEnthalpy_dTX(d,T,X,phase),
                                     T=temperature_hdX(h,d,X,phase)));
end density_ThX;
