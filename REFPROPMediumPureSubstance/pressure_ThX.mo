within MediaTwoPhaseMixture.REFPROPMediumPureSubstance;
function pressure_ThX "calls REFPROP-Wrapper, returns pressure"
extends Modelica.Icons.Function;
    input Modelica.SIunits.Temperature T;
    input Modelica.SIunits.SpecificEnthalpy h;
    input MassFraction X[:]=reference_X "mass fraction m_NaCl/m_Sol";
    input FixedPhase phase=0 "2 for two-phase, 1 for one-phase, 0 if not known";
  output Modelica.SIunits.Pressure p;
algorithm
  if debugmode then
    Modelica.Utilities.Streams.print("Running pressure_ThX("+String(T)+","+String(h)+",X)...");
  end if;
  p :=getProp_REFPROP_check("p", "Th", fluidnames,T,h,X,phase);
  annotation(LateInline=true,inverse(h=specificEnthalpy_pTX(p,T,X,phase),
                                     T=temperature_phX(p,h,X,phase)));
end pressure_ThX;
