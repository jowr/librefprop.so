within MediaTwoPhaseMixture.REFPROPMedium;
function pressure_TsX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_TsX("+String(T)+","+String(s)+",X)...");
  end if;
  p :=getProp_REFPROP_check("p", "Ts",T,s,X,phase);
  annotation(LateInline=true,inverse(s = specificEntropy_pTX(p,T,X,phase),
                                     T=temperature_psX(p,s,X,phase)));
end pressure_TsX;
