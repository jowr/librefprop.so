within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function specificEnthalpy_dTX
  "calls REFPROP-Wrapper, returns specific enthalpy"
  //does not extend existing function from PartialMedium because there the algorithm is already defined
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Density d;
  input Modelica.SIunits.Temperature T;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
//  input String fluidnames;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEnthalpy h;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEnthalpy_dTX("+String(d)+","+String(T)+",X)");
  end if;
    h :=getProp_REFPROP_check("h", "dT", fluidnames,d,T,X,phase);
  annotation(LateInline=true,inverse(d=density_ThX(T,h,X,phase),
                                     T=temperature_hdX(h,d,X,phase)));
end specificEnthalpy_dTX;
