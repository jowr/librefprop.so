within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function density_TsX "calls REFPROP-Wrapper, returns density"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Density d;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running density_TsX("+String(T)+","+String(s)+",X)");
  end if;
  d :=getProp_REFPROP_check("d", "Ts", fluidnames,T,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_dTX(d,T,X,phase),
                                     T=temperature_dsX(d,s,X,phase)));
end density_TsX;
