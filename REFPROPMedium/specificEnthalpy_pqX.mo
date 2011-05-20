within MediaTwoPhaseMixture.REFPROPMedium;
function specificEnthalpy_pqX
  "calls REFPROP-Wrapper, returns specific enthalpy"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Real q;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEnthalpy h;
//  annotation(LateInline=true,inverse(p = pressure_hqX(h,q,X,phase),quality_phX(p,h,X,phase)));
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEnthalpy_pqX("+String(p)+","+String(q)+",X)");
  end if;
  h :=getProp_REFPROP_check("h", "pq", fluidnames,p,q,X,phase);
end specificEnthalpy_pqX;
