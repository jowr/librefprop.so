within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function specificEntropy_dTX
  extends Modelica.Icons.Function;
  input Modelica.SIunits.Density d;
  input Modelica.SIunits.Temperature T;
  input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
//  input String fluidnames;
  input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.SpecificEntropy s;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running specificEntropy_dTX("+String(d)+","+String(T)+",X)");
  end if;
    s:=getProp_REFPROP_check("s", "dT", fluidnames,d,T,X,phase);
  annotation(LateInline=true,inverse(d = density_TsX(T,s,X,phase),
                                     T=temperature_dsX(d,s,X,phase)));
end specificEntropy_dTX;
