within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function temperature_pqX
extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input MassFraction q;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Temperature T;
//  annotation(LateInline=true,inverse(p = pressure_TqX(T,q,X,phase),q=quality_pTX(p,T,X,phase));
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running temperature_pqX("+String(p)+","+String(q)+",X)");
  end if;
    T :=getProp_REFPROP_check("T", "pq",p,q,X,phase);
end temperature_pqX;
