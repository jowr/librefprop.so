within MediaTwoPhaseMixture.REFPROPMedium;
function specificEnthalpy_pdX
  "calls REFPROP-Wrapper, returns specific enthalpy"
  //does not extend existing function from PartialMedium because there the algorithm is already defined
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Pressure p;
  input Modelica.SIunits.Density d;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEnthalpy h;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEnthalpy_pdX("+String(p)+","+String(d)+",X)...");
  end if;
  h :=getProp_REFPROP_check("h", "pd", fluidnames,p,d,X,phase);
  annotation(LateInline=true,inverse(d = density_phX(p,h,X,phase),
                                     p=pressure_hdX(h,d,X,phase)));
end specificEnthalpy_pdX;
