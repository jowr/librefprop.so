within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function specificEntropy_pqX "calls REFPROP-Wrapper, returns specific entropy"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Real q;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
//  annotation(LateInline=true,inverse(p = pressure_sqX(s,q,X,phase),q=quality_psX(p,s,X,phase));
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEntropy_pqX("+String(p)+","+String(q)+",X)");
  end if;
  s :=getProp_REFPROP_check("s", "pq",p,q,X,phase);
end specificEntropy_pqX;
