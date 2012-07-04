within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function temperature_pdX "calls REFPROP-Wrapper, returns temperature"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Pressure p;
    input Modelica.SIunits.Density d;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Temperature T;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running temperature_psX("+String(p)+","+String(d)+",X)...");
  end if;
    T :=getProp_REFPROP_check("T", "pd",p,d,X,phase);
  annotation(LateInline=true,inverse(d=density_pTX(p,T,X,phase),
                                     p=pressure_dTX(d,T,X,phase)));
end temperature_pdX;
