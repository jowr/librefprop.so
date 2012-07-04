within MediaTwoPhaseMixture.REFPROPMedium;
function temperature_dsX "calls REFPROP-Wrapper, returns temperature"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Density d;
    input Modelica.SIunits.SpecificEntropy s;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Temperature T;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running temperature_dsX("+String(d)+","+String(s)+",X)");
  end if;
  T :=getProp_REFPROP_check("T", "ds",d,s,X,phase);
  annotation(LateInline=true,inverse(s=specificEntropy_dTX(d,T,X,phase),
                                     d=density_TsX(T,s,X,phase)));
end temperature_dsX;
