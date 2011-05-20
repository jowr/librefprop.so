within MediaTwoPhaseMixture.REFPROPMedium;
function specificEntropy_pdX
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.Density d;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEntropy_pdX("+String(p)+","+String(d)+",X)");
  end if;
    s:=getProp_REFPROP_check("s", "pd", fluidnames,p,d,X,phase);
  annotation(LateInline=true,inverse(d = density_psX(p,s,X,phase),
                                     p=pressure_dsX(d,s,X,phase)));
end specificEntropy_pdX;
