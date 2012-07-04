within MediaTwoPhaseMixture.REFPROPMedium;
function pressure_dTX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Density d;
    input Modelica.SIunits.Temperature T;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_dTX("+String(d)+","+String(T)+",X)");
  end if;
  p :=getProp_REFPROP_check("p", "dT",d,T,X,phase);
  annotation(LateInline=true,inverse(d = density_pTX(p,T,X,phase),
                                     T=temperature_pdX(p,d,X,phase)));
end pressure_dTX;
