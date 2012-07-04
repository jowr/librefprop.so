within MediaTwoPhaseMixture.REFPROPMedium;
function density_pqX "calls REFPROP-Wrapper, returns specific density"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Real q;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Density d;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running density_pqX("+String(p)+","+String(q)+",X)");
  end if;
  d :=getProp_REFPROP_check("d", "pq",p,q,X,phase);
/*  annotation(LateInline=true,inverse(p=pressure_dqX(d,q,X,phase),
                                     q=quality_pdX(p,d,X,phase)));*/
end density_pqX;
