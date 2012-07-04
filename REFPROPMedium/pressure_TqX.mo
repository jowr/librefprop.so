within MediaTwoPhaseMixture.REFPROPMedium;
function pressure_TqX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Real q;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
  //T=quality_pTX(p,T,X,phase)
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_TqX("+String(T)+","+String(q)+",X)");
  end if;
    p :=getProp_REFPROP_check("p", "Tq",T,q,X,phase);
  annotation(LateInline=true,inverse(T=temperature_pqX(p,q,X,phase)));
end pressure_TqX;
